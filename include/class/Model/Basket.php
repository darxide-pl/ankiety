<?php

class Model_Basket extends Generic_Object {
	
	private static $instance;
	private $items = array();
	
	public function __construct($data = array(), $options = null) {
		
		parent::__construct($data, $options);
		
		try {
			
			if (!$this->get('id')) {

				$this
					->ForceModify()
					->set('add_date', date('Y-m-d H:i:s'))
					->set('ip', f_get_ip_address())
					->set('session_id',session_id())
					->save();
			}
			
			// save basket id to cookie
			Cookie_Handler::Create('ubkid',$this->get('id'), 3600 * 24 * 7 ); // 7 days

			// load basket data, becouse we dont have basket id 
			$this->reload();

		} catch (Exception $e) {
			//nothing
		}

		# We create basket once in session when user insert first item into basket,
		# this is great oportunity to clear too old baskets

		# Run garbage collector.

		self::__gc();
	}
	
	public static function Instance() {
		
		if (!self::$instance instanceof Model_Basket) {
			self::$instance = new Model_Basket((int)$_COOKIE['ubkid']);
		}
		
		return self::$instance;
	}
	
	public static function __gc() {
		
		# expire time
		$expire_date = date('Y-m-d',mktime(0,0,0,date('m'),date('d')-7,date('Y')));  
		
		$sql = "DELETE b.*, i.*
			FROM `basket` b LEFT JOIN `basket_item` i ON i.`basket_id` = b.`id`
			WHERE b.`add_date` < '".$expire_date."';";

		DB::Instance()->query($sql);
		
		return true;
	}
	
	public function reload() {

		$this->items = Model_Basket_Item::NewInstance()->find()
			->fields('IF(`Basket_Item`.`product_name` != \'\', '
				. '`Basket_Item`.`product_name`, p.`name`) AS `Basket_Item.name`, '
				. 'p.`alias` AS `Basket_Item.alias`, '
				. '(SELECT `filename` FROM `product_image` WHERE `product_id` = Basket_Item.`product_id` ORDER BY `pos` ASC LIMIT 1) AS `Basket_Item.image_filename`, '
				. 'p.`category_id` AS `Basket_Item.category_id` ')
			->join('LEFT JOIN `product` `p` ON `p`.`id` = `Basket_Item`.`product_id`')
			->group('Basket_Item.`id`')
			->where('Basket_Item.`basket_id` = '.$this->get('id'))
			->fetch();
		
		return $this->items;
	}
	
	public function getItems() {
		return $this->items;
	}
	
	public function getItemsCount() {
		$count = 0;
		if (sizeof($this->items)) {
			foreach ($this->items as $item) {
				$count += $item->get('amount');
			}
		}
		return $count;
	}
	
	public function GetSumNetto() {
		$sum = 0;
		if (sizeof($this->items)) {
			foreach ($this->items as $item) {
				$sum += round($item->get('price')*$item->get('amount'),2);
			}
		}
		return f_clear_price(f_get_price_netto($sum));
	}
	
	public function GetSumBrutto() {
		$sum = 0;
		if (sizeof($this->items)) {
			foreach ($this->items as $item) {
				$sum += round($item->get('price')*$item->get('amount'),2);
			}
		}
		return f_clear_price($sum);
	}
}