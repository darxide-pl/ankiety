<?php

class Module_Configuration extends Modules_Handler {
	
	function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','configuration');
	}
	
	function index() {
		$this->addCss('/include/plugins/jquery/jquery-ui-1.9.2/css/smoothness/jquery-ui-1.9.2.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js');
	}
	
	public function test_smtp_connection() {
		
		$this->layout = 'ajax';
		
		error_reporting(0);
		
		if ($_POST['cfg'][$_POST['group_key']] && sizeof($_POST['cfg'][$_POST['group_key']])) {
			
			$t = array();
			foreach ($_POST['cfg'][$_POST['group_key']] as $k => $v) {
				$t[$k] = $v;
			}
			
			$Acc = new Model_Email_Account($t);

			try { 
				
				$Acc->Validate();
				
				# set email
				$Email = new SendEmailController($Acc);
				
				$Email->addRecipient($_POST['testemail'],$_POST['testemail']);
				$Email->setTitle('Test połączenia.');
				$Email->setContent('Test połączenia.');
				
				if ($Email->send()) {
					$message = '<span class="label label-success">Połącznie z serwerem zostało nawiązane, a testowa wiadomość wysłana.</span>';
				} else {
					$message = '<span class="label label-error">Połącznie z serwerem zostało nawiązane ale nie udało się wysłać wiadomości.</span>';
				}
			} catch (Exception $e) {
				$message = '<span class="label label-error">'.$e->getMessage().'</span>';
			}
		} else {
			$message = '<span class="label label-error">Brak parametrów.</span>';
		}
		
		echo $message;
		
		die();
	}
}