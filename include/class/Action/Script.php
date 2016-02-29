<?php

abstract class Action_Script extends Core implements Action_Interface {
	
	# action name
	private $_action;
	# prefix of action methods names
	private $_action_method_prefix = '_';
	# action method name
	protected $action_method_name;

	private $_after_modifiers = array();

	private $_after_modifiers_prefix = '__after_';
	
	protected $_redirect_after_success = true;
	
	protected $_display_success_msg = true;

	protected $_log_comment = '';
	
	protected $mode = 'default';
	
	public $output = '';
	
	function __construct($action) {
		
		$this->_action = strtolower( urldecode($action) );
		$this->action_method_name = $this->_action_method_prefix . $this->_action;

		# init Core
		parent::__construct();
		
		# initialize action
		$this->Init();
	}

	function Init() {
		return true;
	}

	function DisplaySuccessMessages($bool = null) {
		if (!is_null($bool)) {
			$this->_display_success_msg = (bool)$bool;
		}
		return $this->_display_success_msg;
	}
	
	/**
	 * (non-PHPdoc)
	 * @see /include/class/sys/Action#Execute()
	 */
	function Execute() {
		
		$this->DoBeforeSave();
		
		if ($this->auth && $this->auth->user['group'] != 'demo') {

			if ($this->auth->hasAccess(array(get_class($this),$this->action_method_name),'action',true)) {

				try {
					
					# call action method
					$result = Method::call(array($this, $this->action_method_name));
					
				} catch (Exception $e) {
					if ($e->getMessage()) {
						$this->Error($e->getMessage());
					}
				}
			} else {

				$this->error('Brak uprawnien do wykonania polecenia.');
			}

			$this->DoAfterSave();
			
			# log actions
			$this->Log();
			
		} else {
			$this->Msg('Uprawnienia użytkownika należącego do grupy "Demo" nie pozwalają na wykonanie tej operacji.');
		}
		
		switch ($this->mode) {
		
			case 'json':
		
				die(
					json_encode(
						array(
							'msg' => str_replace('×','',strip_tags($this->msg->getSuccess())),
							'error' => str_replace('×','',strip_tags($this->msg->getErrors())),
							'output' => $this->output,
						)
					)
				);
		
				break;
		
			default:
				# Do nothing shot page or redirect if needed
		}
		
		if ($this->Pass()) {
			$this->_catchAfterModifiers();
		}

		return array('success' => $this->Pass(),'result' => $result);
	}
	
	private function Log() {
		
		if (Config::Exists('core.log_actions')
			&& Config::Get('core.log_actions') > 0) {
			
			$a = array(
				'user_id' => $this->auth->user['id'],
				'error' => strip_tags($this->msg->getErrors(false)),
				'action' => get_class($this).'::'.$this->action_method_name,
				'ip' => f_get_ip_address(),
				'comment' => $this->_log_comment,
			);
			
			$this->db->Insert('log_action',$a);
		}
	}
	
	public function LogComment($text) {
		$this->_log_comment .= $text."\n";
	}
	
	function Redirect() {
		return (bool)$this->_redirect_after_success;
	}

	private function _catchAfterModifiers() {
		$vars = $this->rv->getVars('request');
		if (is_array($vars) && sizeof($vars)) {
			foreach ($vars as $name => $value) {
				if (strpos($name,$this->_after_modifiers_prefix) !== false) {
					$real_name = substr($name,strlen($this->_after_modifiers_prefix));
					$this->rv->set($real_name, $value,'request');
					array_push($this->_after_modifiers,$real_name);
				}
			}
		}
	}
	
	function GetAfterModifiers() {
		return $this->_after_modifiers;
	}

	function DoAfterSave() {
		return true;
	}
	
	function DoBeforeSave() {
		return true;
	}
	
	function __toString() {
		return (string) $this->msg;
	}
	
	public function Msg($text) {
		if ($this->DisplaySuccessMessages()) {
			$this->msg->add($text);
		}
	}
	
	public function t($key, $value) {
		return t($key, $value, '__actions_'.$this->_action, $this->action_method_name);
	}
}