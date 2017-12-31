<?php
/**
 * @wordpress-plugin
 * Plugin Name:       WordPress Koel Login
 * Description:       This is a short description of what the plugin does. It's displayed in the WordPress admin area.
 * Version:           1.0.0
 * Author:            Salman Kaleem
 * License:           GPL-2.0+
 * License URI:       http://www.gnu.org/licenses/gpl-2.0.txt
 * Text Domain:       wp-koel-login
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if ( ! defined( 'WPINC' ) ) {
	die;
}

function add_koel_registration_meta(){
	$args = array(
	    'type'         => 'string',
	    // Shown in the schema for the meta key.
	    'description'  => 'User created from Koel',
	    // Return a single value of the type.
	    'single'       => true,
	    // Show in the WP REST API response. Default: false.
	    'show_in_rest' => true,
	);
	register_meta( 'user', 'created_from_koel', $args );

	register_meta( 'user' , 'koel_email', $args );
}

add_action('init', 'add_koel_registration_meta');

function koel_login_modify_login_form(){
	?>
	<p class="forgetmenot">
		<label for="koel_login">
			<input name="koel_login" type="checkbox" id="koel_login"/>
			<?php esc_html_e( 'Login with Koel account (use e-mail address)' ); ?>
		</label>
	</p>
	<?php
}

add_action( 'login_form', 'koel_login_modify_login_form' );

// todo: check
function email_exists_koel( $email_address ){
	$koelDB = new wpdb('root', '', 'koeldb', 'localhost');
	$query = "SELECT COUNT(*)  FROM `users` WHERE `email` LIKE '{$email_address}'";
	$email_exists = $koelDB->get_var($query);

	return $email_exists != NULL && $email_exists > 0;
}

function koel_login_authenticate_koel_account( $user, $user_login, $password ){
	if( isset($_POST['koel_login']) ){
		// Check if email exists in WordPress
		// Check if it's in Koel

		if( !is_email( $user_login ) || !email_exists( $user_login ) || !email_exists_koel( $user_login ) ){
			return new WP_Error();
		}

		$token = get_koel_access_token();

		if( empty($token) ){
			return;
		}

		// Make request
		$url = "http://localhost:8000/wpapi/verify";
		$args = [
			'headers' => [
				'Authorization' => "Bearer {$token}",
				'Accept' => 'application/json'
			],
			'body' => [
				'email' => $user_login,
				'password' => $password
			]
		];

		$response = wp_remote_post( $url, $args );
		$response = json_decode( wp_remote_retrieve_body( $response ) );

		if( is_wp_error($response) ){
			return new WP_Error();
		}

		if( $response->isCredentialsValid === true ){
			$user = new WP_User( $response->wpid );
		} else {
			$user = new WP_Error();
		}

		if ( is_wp_error( $user ) ) {
			if ( $user->get_error_codes() == array( 'empty_username', 'empty_password' ) ) {
				$user = new WP_Error( '', '' );
			}
			return $user;
		}

		wp_set_auth_cookie( $response->wpid, false, is_ssl() );

		do_action( 'wp_login', $user->user_login, $user );
		return $user;
	}
}
add_filter( 'authenticate', 'koel_login_authenticate_koel_account', 10, 3 );


function create_koel_user( $user_id ) {
	$user = get_user_by('ID', $user_id);

	if( $user->user_url == "http://koel.com" ){
		return $user_id;
	}

	// Create corresponding user in Koel
	$apiToken = get_koel_access_token();

	if( empty($apiToken) ){
		return;
	}

	// Make request
	$url = "http://localhost:8000/wpapi/user";
	$args = [
		'headers' => [
			'Authorization' => "Bearer {$apiToken}",
			'Accept' => 'application/json'
		],
		'body' => [
			'email' => $user->user_email,
			'password' => $_POST['pass1'],
			'name' => $user->display_name,
			'wpid' => $user_id
		]
	];

	$response = wp_remote_post( $url, $args );
	$response = json_decode( wp_remote_retrieve_body( $response ) );

	if( is_wp_error($response) ){
		return;
	}
}

add_action( 'user_register', 'create_koel_user', 10, 1 );

function update_koel_user( $user_id, $old_user_data ){
	global $wpdb;
	$user = new WP_User( $user_id );

	$requestBody = [];

	// Did email change
	$userEmail = get_user_meta( $user_id, '_new_email', true );
	$manuallyUpdateEmail = false;
	if( !empty($userEmail) ){
		$requestBody['email'] = esc_html( trim( $userEmail['newemail'] ) );

		$update = $wpdb->update( $wpdb->users, ['user_email' => $userEmail['newemail']], ['ID' => $user_id] );
		if ( $update !== false ) {
			$manuallyUpdateEmail = true;
		}
	} else if( $user->user_email != $old_user_data->user_email ){	// compare old email with new email
		$requestBody['email'] = $user->user_email;
	}

	// Did name change
	if( $user->display_name != $old_user_data->display_name ){
		$requestBody['name'] = $user->display_name;
	}	

	if( !empty($requestBody) ){
		$apiToken = get_koel_access_token();
		
		if( empty($apiToken) ){
			return;
		}

		$url = "http://localhost:8000/wpapi/user/{$user_id}";
		$args = [
			'method' => 'PUT',
			'headers' => [
				'Authorization' => "Bearer {$apiToken}",
				'Accept' => 'application/json'
			],
			'body' => $requestBody	
		];

		$response = wp_remote_request( $url, $args );
		$response = json_decode( wp_remote_retrieve_body( $response ) );

		if( is_wp_error($response) ){
			return;
		} else {
			if( $manuallyUpdateEmail ){
				delete_user_meta( $user_id, '_new_email' );
			}
		}
	}
}
add_action( 'profile_update', 'update_koel_user', 12, 2 );

function delete_koel_user( $user_id ) {
	$apiToken = get_koel_access_token();

	$url = "http://localhost:8000/wpapi/user/{$user_id}";
	$args = [
		'method' => 'DELETE',
		'headers' => [
			'Authorization' => "Bearer {$apiToken}",
			'Accept' => 'application/json'
		]	
	];

	$response = wp_remote_request( $url, $args );
	$response = json_decode( wp_remote_retrieve_body( $response ) );
	
	if( is_wp_error($response) ){
		return;
	}
}
add_action( 'delete_user', 'delete_koel_user' );

function get_koel_access_token(){
	// Get token
	$tokenUrl = "http://localhost:8000/oauth/token";
	$tokenArgs = [
		'body' => [
			'grant_type' => 'client_credentials',
			'client_id' => '3',
			'client_secret' => 'U7d8HSSvsRz8WzL6YIGGdjB1nuhtws7RxWgFycjT'
		]
	];
	$tokenResponse = wp_remote_post( $tokenUrl, $tokenArgs );
	$tokenResponse = json_decode( wp_remote_retrieve_body( $tokenResponse ) );

	if( is_wp_error($tokenResponse) ){
		return new WP_Error();
	}

	if( !isset($tokenResponse->access_token) ){
		return '';
	}

	return $tokenResponse->access_token;
}