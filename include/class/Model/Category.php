<?php

class Model_Category extends Generic_Object {
	
	private static $_paths = array();
	
	public static function Build_Url($o) {
		
		if (is_array($o)) {

			return Link::Instance()->Build('sklep/'.self::Build_Path($o['parent_id']).$o['alias'].'/',array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
			
		} else if (is_object($o)) {

			return Link::Instance()->Build('sklep/'.self::Build_Path($o->get('parent_id')).$o->get('alias').'/',array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
		}
	}
	
	/**
	 * 
	 * @param type $parent_id - first parent
	 */
	private static function Build_Path($parent_id) {

		if (!$parent_id) {
			return '';
		}
		
		if (isset(self::$_paths[$parent_id])) {
			return self::$_paths[$parent_id];
		}
		
		$parts = array();
		
		$parent = array('parent_id'=>$parent_id);
		
		do {
			$parent = Db::Instance()->first("SELECT `parent_id`,`alias` FROM `category` WHERE `id` = ".(int)$parent['parent_id']."");
			
			$parts []= $parent['alias'];
			
		} while ($parent['parent_id'] > 0);
		
		return self::$_paths[$parent_id] = implode('/',  array_reverse($parts)).'/';
	}
}