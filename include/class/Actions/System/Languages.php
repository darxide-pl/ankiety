<?php

class System_Languages_Actions extends Action_Script {
	
	public function _save_translations() {
		
		$this->_redirect_after_success = false;

		$t = $this->rv->get('t','post');
		$d = $this->rv->get('d','post');
		$lang = $this->rv->get('lang');
		
		if ($t) {
			
			foreach ($t as $key => $value) {
				
				// delete if selected
				if (isset($d[$key]) && $d[$key] > 0) {
					
					$sql = "DELETE FROM `i18n_translation` WHERE `key` = '".$this->db->quote($key)."';";
					$this->db->query($sql);
					
					continue;
				}
				
				// find if exists
				$sql = "SELECT `id` FROM `i18n_translation` WHERE `key` = '".$key."' AND `lang` = '".$lang."'";
				$translation_id = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
				
				// insert if new
				if (!$translation_id && $value != '') {
					
					$this->db->Insert('i18n_translation',array('lang'=>$lang,'key'=>$key,'text'=>$value));
					
				// update if exists
				} else {
					
					$this->db->Update('i18n_translation',array('text'=>$value),'`id` = '.(int)$translation_id);
				}
			}
		}
	}
}
