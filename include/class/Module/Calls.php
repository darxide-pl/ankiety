<?php

class Module_Calls extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','calls');
	}
	
	public function index() {
		
		$o = array(
			'id' => '`id`',
			'company_name' => '`company_name`',
			'status' => array('`status`','`status_date`'),
			'address' => array('`address_city`','`address_street`'),
			'contact' => array('`email`','`phone`')
		);
		$c = array(
			'search' => array('type'=>'multistring','value'=>array(
				'`Call`.`address_city`',
				'`Call`.`address_zip`',
				'`Call`.`address_street`',
				'`Call`.`email`',
				'`Call`.`phone`',
				'`Call`.`company_name`',
				'`Call`.`nip`',
				'`Call`.`regon`',
				'`Call`.`notice`',
				'`Call`.`represented_by`'))
		);
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultOrderBy('id','desc');
		$this->list->populate(new Model_Call);
	}
	
	public function add() {
		
		$this->output['object'] = new Model_Call();
	}
	
	public function edit() {
		
		$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
		
		if (!$this->oid) {
			$this->error('Proszę wybrać konto klienta do edycji.');
			$this->redirect('index');
		}
		
		$this->output['object'] = new Model_Call($this->oid);
		$this->output['templates'] = $this->db->all("SELECT `id`,`name` FROM `call_template` ORDER BY `name` ASC;",DB_FETCH_ASSOC_FIELD);
		$this->output['history'] = $this->db->all("SELECT h.*, CONCAT(u.`name`,' ',u.`lastname`) AS `add_user_name`, v.`code` AS `voucher_code` "
			. "FROM `call_history` h "
			. "LEFT JOIN `user` u ON u.`id` = h.`add_user_id` "
			. "LEFT JOIN `voucher` v ON v.`call_id` = h.`call_id` "
			. "WHERE h.`call_id` = ".(int)$this->oid." ORDER BY h.`id` DESC;");
	}
	
	public function preview() {
		
		$key = $this->rv->get('key');
		
		list($sha1,$microtime) = explode('.',$key,2);
		
		$this->oid = $this->db->first("SELECT `id` FROM `call` WHERE SHA1(CONCAT(`id`,';',`add_date`)) = '".$this->db->quote($sha1)."';",DB_FETCH_ARRAY_FIELD);
		
		$this->output['object'] = new Model_Call($this->oid);
		
		$this->output['history'] = $this->db->all("SELECT h.*, CONCAT(u.`name`,' ',u.`lastname`) AS `add_user_name` "
			. "FROM `call_history` h "
			. "LEFT JOIN `user` u ON u.`id` = h.`add_user_id` "
			. "WHERE h.`call_id` = ".(int)$this->oid." ORDER BY h.`id` DESC;");
	}
}