<?php

class Model_News extends Generic_Object {
	
	public static function Build_Url($o) {

		if (is_array($o)) {
			return Link::Instance()->Build('aktualnosci/'.$o['alias'],array('domain'=>BASE_DOMAIN.BASE_DIR.LT.$dir));
		} else if (is_object($o)) {
			return Link::Instance()->Build('aktualnosci/'.$o->get('alias'),array('domain'=>BASE_DOMAIN.BASE_DIR.LT.$dir));
		}
	}
}
