<?php 

class Model_Page extends Generic_Object {
	
	private static $_paths = array();
	
	public static function Build_Url($o) {
		
		if (is_array($o)) {
			
			if ($o['page_type'] == 1) {
				if (substr($o['url'],0,1) == '/') {
					return Link::Instance()->Build($o['url']);
				} else {
					return $o['url'];
				}
			}

			return Link::Instance()->Build(self::Build_Path($o['parent_id']).$o['alias'],array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
			
		} else if (is_object($o)) {

			if ($o->get('page_type') == 1) {
				if (substr($o->get('url'),0,1) == '/') {
					return Link::Instance()->Build($o->get('url'));
				} else {
					return $o->get('url');
				}
			}

			return Link::Instance()->Build(self::Build_Path($o->get('parent_id')).$o->get('alias'),array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
			
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
			$parent = Db::Instance()->FetchRecord("SELECT `parent_id`,`alias`,`publish` FROM `page` WHERE `id` = ".(int)$parent['parent_id']);
			if ($parent['publish']) {
				$parts []= $parent['alias'];
			}
		} while ($parent['parent_id'] > 0);
		
		return self::$_paths[$parent_id] = implode('/',  array_reverse($parts)).'/';
	}
}
