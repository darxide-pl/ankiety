<?php

class Stores_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['company']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Store::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('company',$t['company'])
				->set('website', $t['website'])
				->set('phone',$t['phone'])
				->set('address',$t['address'])
				->set('state_id',$t['state_id'])
				->save();
			
			$this->msg('Zmiany zostały zapisane.');	
			
			$this->request->execute($this->link->Build(array('stores')),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja zapisu przerwana.');
		}
		
		if (!$t['company']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Store($t['id']);
			
			$o	->set('company',$t['company'])
				->set('website', $t['website'])
				->set('phone',$t['phone'])
				->set('address',$t['address'])
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->set('state_id',$t['state_id'])
				->save();

			$this->msg('Zmiany zostały zapisane.');

			$this->request->execute($this->link->Build('stores'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Store($t['id']);
			$o->remove();
			
			$this->msg('Sklep został usunięty.');
		}
	}
}