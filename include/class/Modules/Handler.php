<?php

abstract class Modules_Handler extends Core {

	# module name
	protected $name;
	# remember last edited object id
	protected $oid;
	# some data that is reloading on each refresh
	private $_data;
	# view
	protected $view = '';
	# default subpage view
	protected $default_view = 'index';
	# Modules_Menu_Handler
	public $menu;
	# ModulesListHandler
	protected $list;
	# view output variables
	protected $output;

	# probably not used anymore
	private $_access_list = array();
	
	# define allowed actions
	protected $allowed_actions;

	# cache configuration
	protected $view_cache_config;
	
	# layout file or type
	protected $layout = 'html';
	
	public static $load_css = array();
	public static $load_js = array();

	function __construct() {
		
		$this->_initModule();
		
		if (!$this->name) {
			
			$name = get_class($this);
			$name = substr(strtolower($name),7);
			
			$this->name = $name;
		}
		
		# init Core
		parent::__construct();

		if (!$this->rv->is_empty('oid','request')) {
			$this->oid = $this->session->set('oid', $this->rv->get('oid','request'));
		} else {
			$this->oid = $this->session->get('oid');
		}

		$this->view = $this->rv->isset_var('subpage','request') &&
			! $this->rv->is_empty('subpage','request')
			? $this->rv->get('subpage','request') : $this->default_view;

		//$this->menu = new Modules_Menu_Handler($this->view, $this->name);

		$this->_reload();
	}
	
	public function _initModule() {
		
	}
	
	public static function addCss($file_path) {
		self::$load_css []= $file_path;
	}
	
	public static function addJs($file_path) {
		self::$load_js []= $file_path;
	}
	
	public static function loadCss() {
		if (self::$load_css) {
			foreach (self::$load_css as $file_path) {
				echo '<link href="'.BASE_DIR.''.$file_path.'" media="all" rel="stylesheet" type="text/css" />';
			}
		}
	}
	
	public static function loadJs() {
		if (self::$load_js) {
			foreach (self::$load_js as $file_path) {
				echo '<script type="text/javascript" src="'.BASE_DIR.''.$file_path.'"></script>';
			}
		}
	}
	
	public function setViewCache($view, $timeout = 3600, $unique_id = null) {
		$this->view_cache_config[$view] = array('timeout'=>$timeout,'unique_id'=>$unique_id);
	}
	
	function getLayout() {
		return $this->layout;
	}
	
	function getName() {
		return $this->name;
	}

	function getView() {
		return $this->view;
	}

	function redirect($view, $params = null) {

		if (empty($view) && $params['page']) {
			//$view = 'index';
		}
		
		$this->rv->set('subpage', $view, 'all');

		$params_names = array();
		if ($params) {
			if (is_array($params) && sizeof($params)) {
				foreach ($params as $k => $v) {
					$this->rv->set($k, $v, 'all');
					array_push($params_names, $k);
				}
			}
		}

		$this->session->set('msg', $this->msg);

		$R = new Request($params_names);
		$R->execute();
	}
	
	public function redirect_url($url) {
		$this->session->set('msg', $this->msg);
		$this->request->execute($url);
	}
	
	function load() {
		
		global $page;
		
		if ($this->_checkView($this->view)) {

			$this->LoadAction($this->rv->get('page_action','all'),true);
	
			if (!$this->auth || $this->auth->hasAccess(array($this->name,$this->view),'view',true)) {

				Method::call(array(&$this, $this->view));

				$this->display($this->view);

			} else {

				$this->name = 'error';

				$this->display('noaccess');
			}

		}
	}

	function setDefaultView($view) {
		$this->default_view = $view;
	}

	private function _checkView($view) {
		if (empty($view)) {
			return false;
		}
		return true;
	}

	protected function set($var, $value) {
		$this->_data[$var] = $value;
		$this->session->set('mod_'.$this->name, $this->_data);
	}

	protected function get($var) {
		if (isset($this->_data[$var])) {
			return $this->_data[$var];
		}
	}
	
	public static function Read($module,$var = null) {
		$data = Session::Instance()->get('mod_'.$module);
		if ($var) {
			if (isset($data[$var])) {
				return $data[$var];
			}
		}
		return $data;
	}
	
	public static function Write($module,$var,$value) {
		/*
		 *  TODO: set function in modules handler
		 */
	}
	

	private function _reload() {
		$this->_data = $this->session->get('mod_'.$this->name);
	}
	
	public function CheckAction($action) {
		
		if (!$action) {
			return 0;
		}
		
		$allow_action = false;
		if ($this->allowed_actions[$this->view]) {
			if (isset($this->allowed_actions[$this->view][$action])) {
				$allow_action = true;
			}
		} else {
			$allow_action = true;
		}
		
		if ($allow_action) {
			return 1;
		}
		
		return -1;
	}
	
	protected function AllowActions($view,$actions) {
		if (f_is_ne_array($actions)) {
			foreach ($actions as $class => $methods) {
				if (f_is_ne_array($methods)) {
					foreach ($methods as $method) {
						$this->allowed_actions[$view][$class.'|'.$method] = 1;
					}
				} else {
					$this->allowed_actions[$view][$class.'|'.$methods] = 1;
				}
			} 
			return true;
		}
		return false;
	}	
	
	protected final function display($tpl = null) {
		 
		global $page;

		$tpl = $tpl ? $tpl : $this->view;
		
		$__path = DIR_INC_TEMPLATES . $this->name . '/' . $tpl . DIRS_INC_TPL_EXTENSION;

		if (is_array($this->output)) {
			extract($this->output);
		}

		if (!include_once($__path)) {
			$this->session->set('error','Plik '.$__path.' nie istnieje.');
			$this->request->execute($this->link->Build('error'));
		}
	}
	
	protected function LoadAction($action, $byhash = false, $allow_redirect = true, $display_success_msg = true) {
			
		if ($byhash) {
			$action = f_decrypt($action);
		}
		
		$do = $this->CheckAction($action);
		
		if ($do === -1) {
			$this->Error('Akcja nie mogła zostać wykonana. Nie posiadasz odpowiednich uprawnień.');
		} else if ($do === 0) {
			# do nothing
		} else {

			$after_modifiers = array();
			# catch and decrypt action name
			//$action = f_decrypt($action);
			
			if (strpos($action, '|')) {
				$redirect = false;
				# new action execute method
				
				list ($class, $action) = explode('|', $action);
				if ($class == '' || $action == '') {
					$this->Error('Nieprawidłowy prototyp skryptu akcji.');
				}
				# try to execute action of selected class
				$class = $class . '_Actions';
				if (class_exists($class)) {
					try {
						
						# if class of this script exists
						$instance = new $class($action);

						if (is_subclass_of($instance, 'Action_Script')) {
							
							$instance->DisplaySuccessMessages($display_success_msg);
							
							# try to execute actions
							$return = $instance->Execute();
							if ($instance->Pass() && $instance->Redirect()) {
								$after_modifiers = $instance->GetAfterModifiers();
								$redirect = true;
							}
						} else {
							$this->Error('Skrypt akcji nie posiada prawidłowej definicji.');
						}
					} catch (Exception $e) {
						$this->Error($e->getMessage());
					}
				}
				else {
					# if there is no such class
					$this->Error('Definicja sryptów akcji nie istnieje.');
				}
			} else {
				$this->Error('Podano nieprawidłowe parametry. Przyczyną możę być wygaśnięcie lub odnowienie sesji, możliwe jest również, że próbowano złamać zabezpieczenia i uzyskać prawa do ważnych informacji.');
			}
			# if script is ended succesfully and there is redirect active in aaction scripts
			if ($redirect && $allow_redirect) {
				$this->request->addParams($after_modifiers);
				$this->session->set('msg', $this->msg);
				$this->request->execute();
			}
		}
		
		return $return['result'];
	}
	
	protected function LoadActionSilent($action,$display_msg = false) {
		return $this->LoadAction($action,false,false,$display_msg);
	}
	
	public function t($key, $value) {
		return t($key, $value, $this->name, $this->view);
	}
}