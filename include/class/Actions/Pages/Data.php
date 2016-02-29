<?php

class Pages_Data_Actions extends Action_Script {
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['key']) {
			$this->error('Proszę wskazać klucz treści do edycji.');
		}
		
		if ($this->pass()) {
			
			// search
			$sql = "SELECT * FROM `page_data` WHERE `key` = '".$this->db->quote($t['key'])."' AND `lang` = '".$this->db->quote($t['lang'])."';";
			$data = $this->db->first($sql);
			
			if (!$data) {
				
				$this->db->insert('page_data',array(
					'key' => $t['key'],
					'value' => $t['value'],
					'type' => $t['type'],
					'lang' => $t['lang']
				));
				
				$this->msg('Treść została dodana do bazy.');
				
			} else {
				
				$this->db->update('page_data',array(
					'key' => $t['key'],
					'value' => $t['value'],
					'type' => $t['type'],
					'lang' => $t['lang']
				),'`key` = \''.$this->db->quote($t['key']).'\' AND `lang` = \''.$this->db->quote($t['lang']).'\'');
				
				$this->msg('Zmiany zostały zapisane.');
			}
			
			
			$this->request->refresh();
		}
	}
}

