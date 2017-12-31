<?php

/**
 * Provide a admin area view for the plugin
 *
 * This file is used to markup the admin-facing aspects of the plugin.
 *
 * @link       http://
 * @since      1.0.0
 *
 * @package    Koel_Listener_Stats
 * @subpackage Koel_Listener_Stats/admin/partials
 */
?>

<!-- This file should primarily consist of HTML with a little bit of PHP. -->
<?php
if( isset($_GET['userID']) ){
	$wpid = $_GET['userID'];
	require 'koel-listener-stats-admin-display-singleuser.php';
} else {
?>

<h2>Koel Stats</h2>

<!-- User Table -->
<table class="wp-list-table widefat fixed striped">
	<thead>
		<tr>
			<th>User</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<?php
			foreach( $allUsers as $k => $wpuser ){
				$user_id = $wpuser->ID;
				$adminUrl = admin_url("admin.php?page=koel_stats&userID={$user_id}");
				echo "<tr>";
					echo "<td>{$wpuser->display_name}</td>";
					echo "<td><a href='{$adminUrl}'>View Stats</a></td>";
				echo "</tr>";
			}
		?>
	</tbody>
</table>

<?php
}
?>