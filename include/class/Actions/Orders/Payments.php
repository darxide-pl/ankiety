<?php

class Orders_Payments_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brakuje nazwy.');
		}
		
		if ($this->pass()) {
			
			Model_Order_Payment::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('name',$t['name'])
				->set('description', $t['description'])
				->set('plugin',$t['plugin'])
				->save();
			
			$this->msg('Zmiany zostały zapisane.');	
			
			$this->request->execute($this->link->Build(array('orders_payments')),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja zapisu przerwana.');
		}
		
		if (!$t['name']) {
			$this->error('Brakuje nazwy.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Order_Payment($t['id']);
			
			$o	->set('name',$t['name'])
				->set('description', $t['description'])
				->set('plugin',$t['plugin'])
				->save();

			$this->msg('Zmiany zostały zapisane.');

			$this->request->execute($this->link->Build('orders_payments'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Order_Payment($t['id']);
			$o->remove();
			
			$this->msg('Forma płatności została usunięta.');
		}
	}
}