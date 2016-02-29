<?php

class Timer {
	public static $last_time;
	public static function write($title = '') {
		if (self::$last_time) {
			echo '<div>'.$title.' '.round(microtime()-self::$last_time,4).' s</div>';
		}
		self::$last_time = microtime();
	}
}