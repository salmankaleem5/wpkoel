<?php

/**
 * Define the internationalization functionality
 *
 * Loads and defines the internationalization files for this plugin
 * so that it is ready for translation.
 *
 * @link       http://
 * @since      1.0.0
 *
 * @package    Koel_Listener_Stats
 * @subpackage Koel_Listener_Stats/includes
 */

/**
 * Define the internationalization functionality.
 *
 * Loads and defines the internationalization files for this plugin
 * so that it is ready for translation.
 *
 * @since      1.0.0
 * @package    Koel_Listener_Stats
 * @subpackage Koel_Listener_Stats/includes
 * @author     Salman Kaleem <email@email.com>
 */
class Koel_Listener_Stats_i18n {


	/**
	 * Load the plugin text domain for translation.
	 *
	 * @since    1.0.0
	 */
	public function load_plugin_textdomain() {

		load_plugin_textdomain(
			'koel-listener-stats',
			false,
			dirname( dirname( plugin_basename( __FILE__ ) ) ) . '/languages/'
		);

	}



}
