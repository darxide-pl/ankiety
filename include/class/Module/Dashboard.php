<?php

/**
 * @author Szymon Błąkała
 * @version 1.0
 */

class Module_Dashboard extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','dashboard');
	}
	
	public function index() {
		
		// get last loged users
		$this->output['users'] = $this->db->FetchRecords("SELECT u.`name`,u.`lastname`,l.`date`,l.`last_action_time`
			FROM `user_login_history` l
			LEFT JOIN `user` u ON l.`user_id` = u.`id`
			ORDER BY l.`date` DESC
			LIMIT 10;");
	}
}