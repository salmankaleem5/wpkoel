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

if( current_user_can('manage_options') ){
	$wpid = $_GET['userID'];
} else {
	$wpid = get_current_user_id();
}

if( isset($_GET['date']) ){
	$date = $_GET['date'];
} else {
	$date = new DateTime('+1 day');
	$date = $date->format('Y-m-d');
}

$data = $this->get_play_data($wpid, $date);

$albumData = $data['album'];
$songData = $data['songs'];
$songListenTimes = $data['songListenTimes'];
?>

<!-- This file should primarily consist of HTML with a little bit of PHP. -->
<h2>Koel Stats</h2>

<!-- Album Table -->
<h3>Album Data</h3>
<table class="wp-list-table widefat fixed striped">
	<thead>
		<tr>
			<th>Album Name</th>
			<th>Album Play Count - <?php echo $date ?></th>
			<th>Average Listen Time (Minutes)</th>
		</tr>
	</thead>
	<tbody>
		<?php
			foreach( $albumData as $id => $album ){
				echo "<tr>";
					echo "<td>{$album['name']}</td>";
					echo "<td>{$album['count']}</td>";
					echo "<td>". gmdate('i:s', $album['averageTime']) ."</td>";
				echo "</tr>";
			}
		?>
	</tbody>
</table>

<!-- Song Table -->
<h3>Song Data</h3>
<table class="wp-list-table widefat fixed striped">
	<thead>
		<tr>
			<th>Song Name</th>
			<th>Song Play Count - <?php echo $date ?></th>
			<th>Average Listen Time (Minutes)</th>
		</tr>
	</thead>
	<tbody>
		<?php
			foreach( $songData as $k => $song ){
				echo "<tr>";
					echo "<td>{$song->song_name}</td>";
					echo "<td>{$song->play_count}</td>";
					echo "<td>".gmdate('i:s', $songListenTimes[$song->song_id]->listen_time)."</td>";
				echo "</tr>";
			}
		?>
	</tbody>
</table>

<form method="GET" action="admin.php">
	<input type="hidden" name="page" value="koel_stats">
	<?php
	if( current_user_can('manage_options') ){
		echo "<input type='hidden' name='userID' value='".$wpid."'>";
	}
	?>
	<!-- yyyy-mm-dd -->
	<input id="date" name="date" type="date" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}">
	<button>Change date</button>
</form>