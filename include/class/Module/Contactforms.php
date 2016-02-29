<?php

class Module_Contactforms extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','contactforms');
	}
	
	public function index() {
		
		$o = array(
			'id' => 'Contact_Form.`id`',
			'add_date' => 'Contact_Form.`date`',
			'fullname' => 'Contact_Form.`name`',
			'ip' => 'Contact_Form.`ip`'
		);
		
		$c = array(
			'search' => array('type'=>'multistring','value'=>array('Contact_Form.`phone`','Contact_Form.`email`','Contact_Form.`name`','Contact_Form.`text`')),
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->setDefaultOrderBy('add_date','desc');
		$this->list->populate(new Model_Contact_Form());
	}
}
