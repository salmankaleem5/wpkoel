<?php

if ( ! defined( 'ABSPATH' ) ) die( 'restricted access' );

if ( ! class_exists( 'WP_REST_API_Log_Settings_General' ) ) {

	class WP_REST_API_Log_Settings_General extends WP_REST_API_Log_Settings_Base {

		static $settings_key  = 'wp-rest-api-log-settings-general';


		static public function plugins_loaded() {
			add_action( 'admin_init', array( __CLASS__, 'register_general_settings' ) );
			add_filter( 'wp-rest-api-log-settings-tabs', array( __CLASS__, 'add_tab') );
		}


		static public function add_tab( $tabs ) {
			$tabs[ self::$settings_key ] = __( 'General', 'wp-rest-api-log' );
			return $tabs;
		}


		static public function get_default_settings() {
			return array(
				'logging-enabled'   => '1',
			);
		}


		static public function register_general_settings() {
			$key = self::$settings_key;

			register_setting( $key, $key, array( __CLASS__, 'sanitize_settings') );

			$section = 'general';

			add_settings_section( $section, '', null, $key );

			add_settings_field( 'logging-enabled', __( 'Enabled', 'wp-rest-api-log' ), array( __CLASS__, 'settings_yes_no' ), $key, $section,
				array( 'key' => $key, 'name' => 'logging-enabled', 'after' => '' ) );

			$total_count =  absint( count( WP_REST_API_Log_DB::get_all_log_ids() ) );

			// HTML for the purge button.
			if ( 0 === $total_count ) {
				$purge_button_html = '';
			} else {
				$purge_button_html = '<p><a class="button wp-rest-api-log-purge-all" href="#purge-log" class="button">'
					. esc_html( sprintf( __( 'Purge All %1$s Entries Now', 'wp-rest-api-log' ), number_format( $total_count ) ) )
					. '</a></p><span class="spinner hidden wp-rest-api-log-purge-all-spinner"></span>';
			}

			add_settings_field( 'purge-days', __( 'Days to Retain Old Entries', 'wp-rest-api-log' ), array( __CLASS__, 'settings_input' ), $key, $section,
				array(
					'key' => $key,
					'name' => 'purge-days',
					'after' => '<p class="description">' . wp_kses_post(
						sprintf( __( 'Entries older than this will be automatically cleaned up, leave blank to keep all entries. %1$s', 'wp-rest-api-log' ),
							$purge_button_html
							)
						) . '</p>',
					'size' => 3,
					'maxlength' => 3,
					)
				);

			add_settings_field( 'ip-address-display', __( 'IP Address Display', 'wp-rest-api-log' ), array( __CLASS__, 'settings_check_radio_list' ), $key, $section,
				array(
					'key' => $key,
					'name' => 'ip-address-display',
					'type' => 'radio',
					'after' => '<p class="description">' . __( 'Sets the IP address displayed in the list of log entries.', 'wp-rest-api-log' ) . '</p>',
					'items' => array(
						'ip_address'           => __( 'IP Address', 'wp-rest-api-log' ),
						'http_x_forwarded_for' => __( 'HTTP X Forwarded For', 'wp-rest-api-log' ),
						),
					'default' => array( 'ip_address' ),
					)
				);

		}


		static public function sanitize_settings( $settings ) {

			$settings['purge-days'] = empty( $settings['purge-days'] ) ? '' : absint( $settings['purge-days'] );

			if ( 0 === $settings['purge-days'] ) {
				$settings['purge-days'] = '';
			}

			return $settings;
		}
	}

}

