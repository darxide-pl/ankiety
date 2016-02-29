<?php

class Module_Error extends Modules_Handler {

	function __construct() {
		parent::__construct();
	}

	function index() {

		$this->output['flash'] = $this->session->get('page_flash');
		$this->session->unset_var('page_flash');
		
		if ($this->session->get('error')) {
			$this->output['error'] = $this->session->get('error');
			$this->session->unset_var('error');
		} else {
			$this->request->execute($this->link->Build('/'));
		}
	}

	public function noaccess() {
		

	}
}