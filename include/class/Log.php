<?php

define('LOG_DIR',APPLICATION_PATH.'/log/');

class Log {
	
	private static $file_path = LOG_DIR;
	
	private static $logs = array();
	
	public static function open($name,$options = array()) {
		if (isset(self::$logs[$name])) {
			# do nothing	
		} else {
			self::$logs[$name] = array(
				'log' => true,
				'date_format' => $options['date_format'] ? $options['date_format'] : 'Y-m-d H:i:s',
			);
		}
	}
	
	public static function turnOff($name) {
		if (isset(self::$logs[$name])) {
			self::$logs[$name]['log'] = false;
		}
	}
	
	public static function turnOn($name) {
		if (isset(self::$logs[$name])) {
			self::$logs[$name]['log'] = true;
		}
	}
	
	public static function write($name, $comment) {
		
		if (!isset(self::$logs[$name])) {
			# log dont exist
			return false;
		}

		if (self::$logs[$name]['log'] === false) {
			# dont log
			return true;
		}
		
		if ($fp = fopen(self::$file_path . $name . '.plog', "a+")) {
			
			if (function_exists('f_get_ip_address')) {
				$ip_address = f_get_ip_address();
			} else {
				$ip_address = 'function f_get_ip_addres not implemented!';
			}
			
			$log_text = date( self::$logs[$name]['date_format'])
				. "\t-- " . $ip_address
				. "\t-- " . $comment
				. "\n";

			fwrite($fp, $log_text);
			fclose($fp);
		}
	}
}