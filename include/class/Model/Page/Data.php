<?php

class Model_Page_Data extends Generic_Object {
	
	public static $values = array();
	
	public static function display($key, $default = '', $btn = true) {
		
		if (!self::$values) {
			self::$values = Db::Instance()->all("SELECT `key`,`value` FROM `page_data` WHERE `lang` = '".Session::Instance()->get('language')."';",DB_FETCH_ASSOC_FIELD);
		}
		
		if ($btn && Auth::Instance()->checkRight('admin|programers')) {
			$btn = ' <span class="btn btn-default btn-pde" data-key="'.$key.'" data-href="'.Link::Instance()->build('/manager/pages/edit_data_html/key/'.$key).'">edytuj</span>';
			$btn .= ' <span class="btn btn-primary btn-pde-save" data-key="'.$key.'">zapisz zmiany</span>';
		} else {
			$btn = '';
		}
		
		if (isset(self::$values[$key])) {
			return '<div id="page_data_'.$key.'">'.self::$values[$key] . '</div>' . $btn;
		}
		
		Db::Instance()->insert(
			'page_data',array(
				'key' => $key,
				'value' => $default,
				'lang' => 'pl'
			)
		);
			
		return '<div id="page-data-'.$key.'">'.($default?$default:'[..]') . '</div>' . $btn;
	}
}