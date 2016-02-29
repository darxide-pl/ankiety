<?php

class Basket_Actions extends Action_Script {
	
	public function _update_item() {
		
		$basket = Model_Basket::Instance();
		
		$item_id = (int)$this->rv->get('item_id');
		$amount = (int)$this->rv->get('amount');
		
		if (!$item_id) {
			$this->error('Proszę wybrać przedmiot do aktualizacji.');
		} else {
			$item = new Model_Basket_Item($item_id);
			
			if (!$item->get('id') || $item->get('basket_id') != $basket->get('id')) {
				$this->error('Produkt nie znajduje się w Twoim koszyku.');
			}
		}
		
		if ($this->pass()) {
			
			if ($amount == 0) {
				$item
					->remove();
			} else {
				$item
					->set('amount',$amount)
					->save();
			}
			
			$this->msg('Produkt został usunięty z koszyka.');
		}
		
	}
	
	public function _remove_item() {
		
		$basket = Model_Basket::Instance();
		
		$item_id = (int)$this->rv->get('item_id');
		
		if (!$item_id) {
			$this->error('Proszę wybrać przedmiot do usunięcia.');
		} else {
			$item = new Model_Basket_Item($item_id);
			
			if (!$item->get('id') || $item->get('basket_id') != $basket->get('id')) {
				$this->error('Produkt nie znajduje się w Twoim koszyku.');
			}
		}
		
		if ($this->pass()) {
			
			$item->remove();
			
			$this->msg('Produkt został usunięty z koszyka.');
		}
	}
	
	public function _add() {
		
		$this->_redirect_after_success = false;
		
		$basket = Model_Basket::Instance();
		$items = $basket->getItems();
		
		$product_id = $this->rv->get('product_id');
		
		if (!$product_id) {
			$this->error('Proszę wybrać produkt.');
		} else {
			$product = new Model_Product($product_id);
			
			if ($product->get('id') == 0 || $product->get('active') == 0) {
				$this->error('Produkt nie istnieje.');
			} else if ($product->get('price') <= 0) {
				$this->error('Produkt jest aktualnie niedostępny.');
			}
		}
		
		if ($this->pass()) {
			
			if ($items) {
				// if item already in basket only increase its amount
				foreach ($items as $i) {
					if ($i->get('product_id') == $product_id) {
						$item = $i;
						break;
					}
				}
			}
			
			if (!$item) {
			
				$item = new Model_Basket_Item();

				$item
					->set('product_id',$product_id)
					->set('basket_id',$basket->get('id'))
					->set('product_name',$product->get('name'))
					->set('price',f_clear_price($product->get('price')))
					->set('price_old',f_clear_price($product->get('price_old')))
					->set('amount',1)
					->save();
				
			} else {
				
				$item
					->set('amount',$item->get('amount') + 1)
					->set('product_name',$product->get('name'))
					->set('price',f_clear_price($product->get('price')))
					->set('price_old',f_clear_price($product->get('price_old')))
					->save();
			}
			
			$this->msg('Produkt został dodany do koszyka.');
			
			$this->request->execute($this->link->Build(array('sklep','koszyk')),true);
		}
	}
}