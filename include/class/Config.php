<?php

class Config {
	
	private static $_data;
	
	private static $_languages = array('pl'=>'Polski');

	public function __construct() {
		self::$_data = parse_ini_file(DIR_CACHE . 'config.php', true);
	}
	
	public static function GetLanguages() {
		return self::$_languages;
	}

	public static function Get($var) {
		if (strpos($var,'.') === false) {
			//throw new Exception('Nieprawidłowe odwołanie do konfiguracji: '.$var);
		}
		list ($group,$var) = explode('.',$var);
		if(!isset(self::$_data[$group][$var])) {
			//throw new Exception('Odwołanie do nieistniejącej dyrektywy: '.$group.'.'.$var);
		}
		return self::$_data[$group][$var];
	}
	
	public static function Set($var, $value) {
		
		if (strpos($var,'.') === false) {
			throw new Exception('Nieprawidłowe odwołanie do konfiguracji: '.$var);
		}
		list ($group,$var) = explode('.',$var);
		self::$_data[$group][$var] = $value;
		
		return $value;
	}
	
	public static function Exists($var) {
		if (strpos($var,'.') === false) {
			return false;
		}
		list ($group,$var) = explode('.',$var);
		if(!isset(self::$_data[$group][$var])) {
			return false;
		}
		return true;
	}
	
	public static function GetData() { 
		return self::$_data;
	}
}