<?php

class Warranty_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['product_name']) {
			$this->error('Brakuje nazwy produktu.');
		}
		
		if (!$t['invoice_number']) {
			$this->error('Brakuje numeru faktury.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Warranty::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('product_name',$t['product_name'])
				->set('product_model',$t['product_model'])
				->set('invoice_date',$t['invoice_date'])
				->set('product_barcode',$t['product_barcode'])
				->set('product_serial',$t['product_serial'])
				->set('invoice_number',$t['invoice_number'])
				->set('store',$t['store'])
				->set('sell_date',$t['sell_date'])
				->set('sell_invoice_number',trim($t['sell_invoice_number']))
				->set('customer_id',$t['customer_id'])
				->set('months',$t['months'])
				->set('description',$t['description'])
				->save();
			
			$this->msg('Zapisano gwarancję.');
			
			$this->request->execute($this->link->Build(array('warranty','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora gwarancji, operacja zapisu przerwana.');
		}
		
		if (!$t['product_name']) {
			$this->error('Brakuje nazwy produktu.');
		}
		
		if (!$t['invoice_number']) {
			$this->error('Brakuje numeru faktury.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Warranty($t['id']);
			
			$o	->set('product_name',$t['product_name'])
				->set('product_model',$t['product_model'])
				->set('invoice_date',$t['invoice_date'])
				->set('product_barcode',$t['product_barcode'])
				->set('product_serial',$t['product_serial'])
				->set('invoice_number',$t['invoice_number'])
				->set('store',$t['store'])
				->set('sell_date',$t['sell_date'])
				->set('sell_invoice_number',trim($t['sell_invoice_number']))
				->set('customer_id',$t['customer_id'])
				->set('months',$t['months'])
				->set('description',$t['description'])
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->save();

			$this->msg('Zapisano zmiany gwarancji.');
			
			$this->request->execute($this->link->Build('warranty'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora gwarancji, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Warranty($t['id']);
			$o->set('removed',1);
			$o->set('remove_date',date('Y-m-d H:i:s'));
			$o->save();
			
			$this->msg('Gwarancja została wyłączona.');
		}
	}
}