<?php

class Customers_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['company_name']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if (!$t['nip']) {
			$this->error('Brakuje NIP-u.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Customer::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('company_name',$t['company_name'])
				->set('represented_by_gender',$t['represented_by_gender'])
				->set('nip',$t['nip'])
				->set('nip_cleared',preg_replace('/[^0-9]+/','',$t['nip']))
				->set('connection',$t['connection'])
				->set('address_street',$t['address_street'])
				->set('address_zip',$t['address_zip'])
				->set('address_city',$t['address_city'])
				->set('notice',trim($t['notice']))
				->set('sector',$t['sector'])
				->set('phone',$t['phone'])
				->set('email',$t['email'])
				->set('represented_by',$t['represented_by'])
				->set('subscription',$t['subscription'])
				->set('subscription_limit',$t['subscription_limit'])
				->set('subscription_interval',$t['subscription_interval'])
				->save();
			
			$this->msg('Zapisano dane klienta.');
			
			$this->request->execute($this->link->Build(array('customers','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora klienta operacja zapisu przerwana.');
		}
		
		if ($this->pass() && !$t['company_name']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if ($this->pass() && !$t['nip']) {
			$this->error('Brakuje NIP-u.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Customer($t['id']);
			
			$o	->set('company_name',$t['company_name'])
				->set('represented_by_gender',$t['represented_by_gender'])
				->set('nip',$t['nip'])
				->set('nip_cleared',preg_replace('/[^0-9]+/','',$t['nip']))
				->set('connection',$t['connection'])
				->set('address_street',$t['address_street'])
				->set('address_zip',$t['address_zip'])
				->set('address_city',$t['address_city'])
				->set('notice',trim($t['notice']))
				->set('sector',$t['sector'])
				->set('phone',$t['phone'])
				->set('email',$t['email'])
				->set('represented_by',$t['represented_by'])
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->set('subscription',$t['subscription'])
				->set('subscription_limit',$t['subscription_limit'])
				->set('subscription_interval',$t['subscription_interval'])
				->save();

			$this->msg('Zapisano zmiany w koncie klienta.');
			
			$this->request->execute($this->link->Build('customers'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora klienta operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Customer($t['id']);
			$o->set('removed',1);
			$o->set('remove_date',date('Y-m-d H:i:s'));
			$o->save();
			
			$this->msg('Konto klienta zostało wyłączone.');
		}
	}
	
	public function _activate() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora klienta operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Customer($t['id']);
			$o->set('removed',0);
			$o->set('remove_date',date('Y-m-d H:i:s'));
			$o->save();
			
			$this->msg('Konto klienta zostało aktywowane.');
		}
	}
	
	public function _add_agent() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brakuje imienia / nazwy.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Customer_Agent::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('name',$t['name'])
				->set('lastname',$t['lastname'])
				->set('notice',trim($t['notice']))
				->set('phone',$t['phone'])
				->set('mobile',$t['mobile'])
				->set('position',$t['position'])
				->set('email',$t['email'])
				->set('customer_id',$t['customer_id'])
				->save();
			
			$this->msg('Zapisano dane osoby kontaktowej.');
			
			$this->request->execute($this->link->Build(array('customers','edit_agents','oid'=>$t['customer_id'])),true);
		}
	}
	
	public function _save_agent() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brakuje imienia / nazwy.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Customer_Agent($t['id']);
			$o	->set('name',$t['name'])
				->set('lastname',$t['lastname'])
				->set('notice',trim($t['notice']))
				->set('mobile',$t['mobile'])
				->set('position',$t['position'])
				->set('phone',$t['phone'])
				->set('email',$t['email'])
				->save();
			
			$this->msg('Zapisano dane osoby kontaktowej.');
			
			$this->request->execute($this->link->Build(array('customers','edit_agents','oid'=>$o->get('customer_id'))),true);
		}
	}
	
	public function _remove_agent() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora osoby kontaktowej operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Customer_Agent($t['id']);
			$o->remove();
			
			$this->msg('Osoba kontaktowa została usunięta.');
		}
	}
}