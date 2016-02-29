<?php

class LoggerDb {
	
	const TURN_LOG_ON = true;
	const TURN_LOG_OFF = false;

	private static $_do_log = true;
	
	public static function write($comment, $query, $errno, $time) {

		if (!self::Log()) {
			return true;
		}
		
		$type = strtok($query,' ');
		
/*		file_put_contents(
			APPLICATION_PATH.'/tmp/log/db-'.date('Ym').'.log',
			date('Y-m-d H:i:s')."\t".$errno."\t".$type."\t".$query."\n",
			FILE_APPEND
		);*/

	}
	
	public static function Log($flag = null) {
		if ($flag !== null) {
			self::$_do_log = (bool)$flag;
		}
		return (bool) self::$_do_log;
	}
}