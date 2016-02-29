<?php

class Module_Orders_Postages extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
	}
	
	public function index() {
		
		$o = array(
			'name' => '`name`',
			'id' => '`id`',
			'price' => '`price`'
		);
		
		$c = array(
			'search' => array(
				'type' => 'multistring',
				'value' => array(
					'`name`',
					'`price`',
					'`description`'
				)
			)
		);
		
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultorderBy('name','asc');
		$this->list->conditions->setOptions(array(
			'fields' => '(SELECT COUNT(*) FROM `order_postage_payment` WHERE `postage_id` = `Order_Postage`.`id`) AS `payments_count`'
		));
		$this->list->populate(new Model_Order_Postage);
	}
	
	public function add() {
		
		$this->oid = 0;
		$this->output['object'] = new Model_Order_Postage();
		$this->output['payments'] = $this->db->all("SELECT * FROM `order_payment` ORDER BY `name` ASC;");
	}
	
	public function edit() {
		
		if (!$this->oid) {
			$this->error('Proszę wybrać element do edycji.');
			$this->redirect('index');
		}
		
		$this->output['object'] = new Model_Order_Postage($this->oid);
		
		if (!$this->output['object']->get('id')) {
			$this->error('Obiekt nie istnieje.');
			$this->redirect('index');
		}
		
		$this->output['payments'] = $this->db->all("SELECT * FROM `order_payment` ORDER BY `name` ASC;");
		$this->output['postage_payments'] = $this->db->all("SELECT `payment_id`,`payment_id` FROM `order_postage_payment` WHERE `postage_id` = ".$this->oid.";",DB_FETCH_ASSOC_FIELD);
	}
}