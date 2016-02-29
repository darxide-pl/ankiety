<?php

class Module_Orders_Payments extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
	}
	
	public function index() {
		
		$o = array(
			'name' => '`name`',
			'id' => '`id`'
		);
		
		$c = array(
			'search' => array(
				'type' => 'multistring',
				'value' => array(
					'`name`',
					'`description`'
				)
			)
		);
		
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultorderBy('name','asc');
		$this->list->populate(new Model_Order_Payment);
	}
	
	public function add() {
		
		$this->oid = 0;
		$this->output['object'] = new Model_Order_Payment();
	}
	
	public function edit() {
		
		if (!$this->oid) {
			$this->error('Proszę wybrać element do edycji.');
			$this->redirect('index');
		}
		
		$this->output['object'] = new Model_Order_Payment($this->oid);
		
		if (!$this->output['object']->get('id')) {
			$this->error('Obiekt nie istnieje.');
			$this->redirect('index');
		}
	}
}