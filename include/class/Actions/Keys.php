<?php

class Keys_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['title']) {
			$this->error('Brakuje opisu.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Key::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('title',$t['title'])
				->set('content', f_emg_trienc($t['content']))
				->save();
			
			$this->msg('Zapisano informacje techniczne.');
			
			if ($this->auth->checkRight('admin|programers')) {
				
				if ($t['user_id']) {

					// load actual users
					$sql = "SELECT `user_id`,`user_id` FROM `key_user` WHERE `key_id` = ".(int)$o->get('id').";";
					$users = $this->db->all($sql,DB_FETCH_ASSOC_FIELD);

					foreach ($t['user_id'] as $user_id) {

						if (!isset($users[$user_id])) {

							// add new user
							$this->db->Insert('key_user',array(
								'user_id' => $user_id,
								'key_id' => $o->get('id')
							));
						}
					}

					// remove unused users
					$sql = "DELETE FROM `key_user` WHERE `key_id` = ".(int)$o->get('id')." AND `user_id` NOT IN (".implode(',',$t['user_id']).");";
					$this->db->query($sql);
				}
			}
			
			$this->request->execute($this->link->Build(array('keys','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja zapisu przerwana.');
		}
		
		if (!$t['title']) {
			$this->error('Brakuje opisu.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Key($t['id']);
			
			$o	->set('title',$t['title'])
				->set('content',f_emg_trienc($t['content']))
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->save();

			$this->msg('Zapisano zmiany.');
			
			if ($this->auth->checkRight('admin|programers')) {
				
				if ($t['user_id']) {

					// load actual users
					$sql = "SELECT `user_id`,`user_id` FROM `key_user` WHERE `key_id` = ".(int)$o->get('id').";";
					$users = $this->db->all($sql,DB_FETCH_ASSOC_FIELD);

					foreach ($t['user_id'] as $user_id) {

						if (!isset($users[$user_id])) {

							// add new user
							$this->db->Insert('key_user',array(
								'user_id' => $user_id,
								'key_id' => $o->get('id')
							));
						}
					}

					// remove unused users
					$sql = "DELETE FROM `key_user` WHERE `key_id` = ".(int)$o->get('id')." AND `user_id` NOT IN (".implode(',',$t['user_id']).");";
					$this->db->query($sql);
				}
			}
			
			$this->request->execute($this->link->Build('keys'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Key($t['id']);
			$o->remove();
			
			$this->msg('Informacja została usunięta.');
		}
	}
}