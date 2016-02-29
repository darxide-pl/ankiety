<?php

class Hp {
	private static $data;
	const APPEND = 0;
	const PREPPEND = 1;
	const REWRITE = 2;
	public static function Get($var) {
		return self::$data[$var];
	}
	public static function Set($var,$value,$method = Hp::REWRITE) {
		
		if (!$value) return true;
		
		switch ($method) {
			case Hp::APPEND:
				$value = self::$data[$var].' '.$value;
				break;
			case Hp::PREPPEND:
				$value .= ' '.self::$data[$var];
				break;
			case Hp::REWRITE:
			default:
				// nth
		}
		self::$data [$var] = $value;
	}
	public static function Init() {
		self::Set('title', Config::Get('main_page.title'));
		self::Set('encoding', Config::Get('admin_page.meta_encoding'));
		self::Set('language', Config::Get('admin_page.meta_language'));
		self::Set('description', Config::Get('main_page.meta_description'));
		self::Set('keywords', Config::Get('main_page.meta_keywords'));
		self::Set('template_id', 1);
	}
}