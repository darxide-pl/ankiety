<?php

class System_Messages_Templates {
	
	public static $tpl = array(
		'default' => '{CONTENT}',
		'store' => '<style type="text/css">
			body,html {color: #333; }
			</style>{CONTENT}',
	);
	
	public function __construct() {
		
	}
	
	public static function Parse($tpl, $content) {
		
		if (isset(self::$tpl[$tpl])) {
			$tpl = self::$tpl [$tpl];
		} else {
			$tpl = self::$tpl ['default'];
		}
		
		return str_replace('{CONTENT}', $content, $tpl);
	}
}