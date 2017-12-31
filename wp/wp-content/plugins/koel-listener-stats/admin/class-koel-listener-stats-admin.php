<?php

/**
 * The admin-specific functionality of the plugin.
 *
 * @link       http://
 * @since      1.0.0
 *
 * @package    Koel_Listener_Stats
 * @subpackage Koel_Listener_Stats/admin
 */

/**
 * The admin-specific functionality of the plugin.
 *
 * Defines the plugin name, version, and two examples hooks for how to
 * enqueue the admin-specific stylesheet and JavaScript.
 *
 * @package    Koel_Listener_Stats
 * @subpackage Koel_Listener_Stats/admin
 * @author     Salman Kaleem <email@email.com>
 */
class Koel_Listener_Stats_Admin {

	/**
	 * The ID of this plugin.
	 *
	 * @since    1.0.0
	 * @access   private
	 * @var      string    $plugin_name    The ID of this plugin.
	 */
	private $plugin_name;

	/**
	 * The version of this plugin.
	 *
	 * @since    1.0.0
	 * @access   private
	 * @var      string    $version    The current version of this plugin.
	 */
	private $version;

	/**
	 * Initialize the class and set its properties.
	 *
	 * @since    1.0.0
	 * @param      string    $plugin_name       The name of this plugin.
	 * @param      string    $version    The version of this plugin.
	 */
	public function __construct( $plugin_name, $version ) {

		$this->plugin_name = $plugin_name;
		$this->version = $version;

	}

	/**
	 * Register the stylesheets for the admin area.
	 *
	 * @since    1.0.0
	 */
	public function enqueue_styles() {
		wp_enqueue_style( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'css/koel-listener-stats-admin.css', array(), $this->version, 'all' );
	}

	/**
	 * Register the JavaScript for the admin area.
	 *
	 * @since    1.0.0
	 */
	public function enqueue_scripts() {
		wp_enqueue_script( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'js/koel-listener-stats-admin.js', array( 'jquery' ), $this->version, false );
	}

	public function ks_add_admin_menu(){
		add_menu_page( 'Koel Stats', 'Koel Stats', 'read', 'koel_stats', [$this, 'ks_options_page'] );
	}

	public function ks_settings_init(){ 
		register_setting( 'pluginPage', 'ks_settings' );

		add_settings_section(
			'ks_pluginPage_section', 
			__( 'Your section description', 'wordpress' ), 
			[$this, 'ks_settings_section_callback'], 
			'pluginPage'
		);

		add_settings_field( 
			'ks_text_field_0', 
			__( 'Settings field description', 'wordpress' ), 
			[$this, 'ks_text_field_0_render'], 
			'pluginPage', 
			'ks_pluginPage_section' 
		);
	}

	public function ks_text_field_0_render(  ) { 

		$options = get_option( 'ks_settings' );
		?>
		<input type='text' name='ks_settings[ks_text_field_0]' value='<?php echo $options['ks_text_field_0']; ?>'>
		<?php

	}


	public function ks_settings_section_callback(  ) { 
		//echo __( 'This section description', 'wordpress' );
		echo '';
	}


	public function ks_options_page() {
		$currentUser = wp_get_current_user();
		$user = ['ID' => $currentUser->ID, 'isAdmin' => in_array('administrator', $currentUser->roles) ? TRUE: FALSE];

		if( $user['isAdmin'] !== TRUE ){	// User is not an admin
			$wpid = $user['ID'];
			require 'partials/koel-listener-stats-admin-display-singleuser.php';
		} else {
			$allUsers = get_users();
			require 'partials/koel-listener-stats-admin-display.php';
		}
	}

	// Gets album info, song info since given date
	private function get_data( $wpid, $date ){
		$koelDB = new wpdb('root', '', 'koeldb', 'localhost');

		$query = "
			SELECT pl.*, song_album.song_name, song_album.album_name, song_album.album_id,COUNT(*) as play_count
			FROM play_log as pl
			JOIN ( SELECT so.id, so.title as song_name, alb.name as album_name, alb.id as album_id FROM songs as so JOIN albums as alb ON so.album_id = alb.id ) as song_album
				ON pl.song_id = song_album.id
			JOIN users as u ON pl.user_id = u.id WHERE u.wpid = %d AND pl.created_at >= %s
			GROUP BY pl.song_id
		";

		$results = $koelDB->get_results( $koelDB->prepare( $query, [ $wpid, $date ] ) );		

		return $results;
	}

	private function get_average_listen_times( $userID ){
		$koelDB = new wpdb('root', '', 'koeldb', 'localhost');
		// all songs for this user
		$query = "
			SELECT song_id, listen_time FROM `interactions` WHERE user_id = %d
		";
		$results = $koelDB->get_results( $koelDB->prepare( $query, [$userID] ), OBJECT_K );

		return $results;
	}

	private function get_play_data( $wpid, $date ){
		$results = $this->get_data( $wpid, $date );

		if( empty($results) ){
			return ['album' => [], 'songs' => [], 'songListenTimes' => []];
		}

		$koel_user_id = $results[0]->user_id;
		$listen_times = $this->get_average_listen_times( $koel_user_id );

		$albumData = [];
		
		foreach( $results as $k => $v ){
			$playCount = $v->play_count;
			$albumID = $v->album_id;
			$albumName = $v->album_name;
			$song_id = $v->song_id;

			if( isset($albumData[$albumID]) ){
				$albumData[$albumID]['count'] += $playCount;
				$albumData[$albumID]['averageTime'] = ((float) $albumData[$albumID]['averageTime'] +  (float) $listen_times[$song_id]->listen_time) / 2;

				//array_push($albumData[$albumID]['song_ids'], $v->song_id);
			} else {
				$albumData[$albumID] = [ 'name' => $albumName, 'count' => $playCount ];
				
				$albumData[$albumID]['averageTime'] = $listen_times[$song_id]->listen_time;

				//$albumData[$albumID]['song_ids'] = [ $v->song_id ];
			}
		}

		return ['album' => $albumData, 'songs' => $results, 'songListenTimes' => $listen_times ];
	}
}
