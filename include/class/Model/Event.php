<?php

class Model_Event extends Generic_Object {
	
	public static function Build_Url($o) {

		if (is_array($o)) {
			return Link::Instance()->Build('kalendarz-imprez/'.$o['alias'],array('domain'=>BASE_DOMAIN.BASE_DIR.LT.$dir));
		} else if (is_object($o)) {
			return Link::Instance()->Build('kalendarz-imprez/'.$o->get('alias'),array('domain'=>BASE_DOMAIN.BASE_DIR.LT.$dir));
		}
	}
}