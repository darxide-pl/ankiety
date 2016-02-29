<?php

class Module_User extends Modules_Handler {
	
	/**
	 * New user register page
	 */
	public function register() {
		if ($this->auth->isLoged()) {
			$this->redirect('',array('page'=>''));
		}
	}
	
	/**
	 * Loged user invites to accept
	 */
	public function invites() {
		
		$o = array();
		$c = array(
			'email' => array('value'=>"`User_Invite`.`email` = '".$this->db->quote($this->auth->user['email'])."'"),
			'status' => array('type'=>'number','value'=>'`User_Invite`.`status`','default'=>'-1')
		);
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		
		$this->list->conditions->setOptions(array(
			'join' => 'LEFT JOIN `workspace` `w` ON `w`.`id` = `User_Invite`.`workspace_id`
					LEFT JOIN `user` `u` ON `u`.`id` = `User_Invite`.`user_id`',
			'fields' => '`w`.`name` AS `workspace_name`, `u`.`email` AS `user_email`',
		));
		
		$this->list->populate('Model_User_Invite');
	}
	
	/**
	 * Loged user profile page
	 */
	public function index() {
		
		$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
		
		$this->output['profile'] = $this->db->first("SELECT * FROM `user` WHERE `id` = ".(int)$this->auth->user['id']);
	}
	
	/**
	 * Preview other users
	 */
	public function preview() {
		
	}
}