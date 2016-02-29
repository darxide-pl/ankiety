<?php

class Module_Login extends Modules_Handler {
	
	function index() {
		
	}
	
	public function ajax_check() {
		
		$this->layout = 'none';
		
		$a = array();
		
		if($this->auth->IsLoged()) {
			$sql = "SELECT c.*, u.`name`, u.`lastname` FROM `customer` c
				LEFT JOIN `user` u ON u.`id` = c.`user_id`
				WHERE u.`id` = ".(int)$this->auth->user['id'].";";
			$customer = $this->db->FetchRecord($sql);

			$a['customer'] = $customer;
		} else {
			$a['error'] = strip_tags($this->msg);
		}
		
		echo json_encode($a);
	}
}