<?php

class Orders_Postages_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brakuje nazwy.');
		}
		
		if ($this->pass()) {
			
			$postage = Model_Order_Postage::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('name',$t['name'])
				->set('description', $t['description'])
				->set('email_attachment', $t['email_attachment'])
				->set('price',$t['price'])
				->save();
			
			if ($t['payments']) {
				foreach ($t['payments'] as $payment_id) {
					$this->db->insert('order_postage_payment',array(
						'postage_id' => $postage->get('id'),
						'payment_id' => $payment_id
					));
				}
			}
			
			$this->msg('Forma dostawy zostały zapisana.');	
			
			$this->request->execute($this->link->Build(array('orders_postages')),true);
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
			
			$postage = new Model_Order_Postage($t['id']);
			
			$postage	->set('name',$t['name'])
				->set('description', $t['description'])
				->set('email_attachment', $t['email_attachment'])
				->set('price',$t['price'])
				->save();

			$this->db->query("DELETE FROM `order_postage_payment` WHERE `postage_id` = ".(int)$postage->get('id'));
			
			if ($t['payments']) {
				foreach ($t['payments'] as $payment_id) {
					$this->db->insert('order_postage_payment',array(
						'postage_id' => $postage->get('id'),
						'payment_id' => $payment_id
					));
				}
			}
			
			$this->msg('Zmiany zostały zapisane.');

			$this->request->execute($this->link->Build('orders_postages'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Order_Postage($t['id']);
			$o->remove();
			
			$this->db->query("DELETE FROM `order_postage_payment` WHERE `postage_id` = ".(int)$o->get('id'));
			
			$this->msg('Forma dostawy została usunięta.');
		}
	}
}