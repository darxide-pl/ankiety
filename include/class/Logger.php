<?php

class Logger {
	
	const TURN_LOG_ON = true;
	const TURN_LOG_OFF = false;
	
	private static $_file_name;
	private static $_file_path;
	private static $_do_log = false;
	
	function __construct($file_name, $file_path) {
		self::$_do_log = true;
		self::$_file_name = $file_name;
		self::$_file_path = $file_path;
	}
	
	public static function write($operation, $comment = '') {
		
		if (!self::Log()) {
			return true;
		}
		
		if ($fp = fopen(self::$_file_path . self::$_file_name, "a+")) {
			$ip_address = f_get_ip_address();
			$log_text = date('Y-m-d H:i:s')."\t-- IP: ".$ip_address."\t-- ".$operation."\t--  ".$comment."\n";
			fwrite($fp, $log_text);
			fclose($fp);
		}
	}
	
	public static function Log() {
		return (bool) self::$_do_log;
	}
}