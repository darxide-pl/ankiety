<?php

class Helper_Date {
	
	const DATE = 'Y-m-d';
	//const MULTILINE = 'Y-m-d\<\b\r\ \/\>H:i \<\i\ \c\l\a\s\s\=\"\g\l\y\p\h\i\c\o\n\ \g\l\y\p\h\i\c\o\n\-\t\i\m\e\"\>\<\/\i\>';
	const MULTILINE = 'Y-m-d\<\b\r\ \/\>H:i';
	
	public static function format($date,$format = null) {
		return date($format?$format:self::DATE,strtotime($date));
	}
}