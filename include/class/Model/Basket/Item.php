<?php

class Model_Basket_Item extends Generic_Object {
	
	public function getSumBrutto() {
		return f_clear_price($this->get('price') * $this->get('amount'));
	}
}