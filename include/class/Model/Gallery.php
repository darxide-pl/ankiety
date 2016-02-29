<?php

class Model_Gallery extends Generic_Object {
	
	public static function Build_Url($o) {
		
		if (is_array($o)) {
			return Link::Instance()->Build('g/'.$o['alias'].'-'.$o['id'].'',array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
		} else if (is_object($o)) {
			return Link::Instance()->Build('g/'.$o->get('alias').'-'.$o->get('id').'',array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
		}
	}
}