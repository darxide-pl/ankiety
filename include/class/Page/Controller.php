<?php

/**
 * 
 * Whole page controller
 * 
 * @author Szymon Błąkała <vsemak@gmail.com>
 * @version 2.0 2013.01.03
 *
 */

class Page_Controller extends Core {
	
	public $page_url;
	
	private $_page;
	private $_page_module;
	public $mod;

	private $_path = '';

	var $menu;
	private $_page_content;

	var $language = '';

	public static $_PAGE_CONFIG = array(
		'default_page' => '',
		'page_encoding' => '',
		'page_default_timezone' => '',
		'default_language' => 'pl',
		'debug' => false,
		'auth_login_page' => 'login'
	);

	const DEFAULT_ENCODING = 'text/html; charset=UTF-8';
	const DEFAULT_TIMEZONE = 'Europe/Warsaw';

	function __construct($configurations = array()) {
		
		# this page url
		$this->page_url = 'http'.((empty($_SERVER['HTTPS'])&&$_SERVER['SERVER_PORT']!=443)?'':'s').'://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		
		# configuration of controller
		$this->loadControllerConfiguration($configurations);
		
		# encoding
		$this->setEncoding(self::$_PAGE_CONFIG['page_encoding']);
		
		# timezone
		$this->setDefaultTimeZone(self::$_PAGE_CONFIG['page_default_timezone']);
		
		# init Core
		parent::__construct();

		# page name
		$this->setPage($this->rv->get('page', 'request'));
	}

	static function parseUrl() {

		$url = $_SERVER['REDIRECT_URL'];
		$url = preg_replace('/\/[\/]+/','/',$url);

		if (defined('INIT_DIR') && INIT_DIR != '') {
			# remove init dir from parts
			$url = substr($url,strlen(INIT_DIR));
		}

		$url = ltrim($url,'\\/');
		$parts = explode('/', $url);
		
		Routes::addRoute(
			array('pattern' => '/^([a-zA-Z0-9\.\-\_]+\/)+([a-zA-Z0-9\.\-\_]+)\/$/',
				'parser' => false)
		);
		Routes::addRoute(
			array('pattern' => '/^([a-zA-Z0-9\.\-\_]+)\/$/',
				'vars' => array('subpage' => ''))
		);
		
		Routes::parse($parts);
	}
	
	public static function debug($flag) {
		Db::Debug($flag);
		self::$_PAGE_CONFIG['debug'] = $flag;
	}

	function loadControllerConfiguration( $configurations ) {
		if ( is_array($configurations) && sizeof($configurations) ) {
			foreach ( $configurations as $k => $v) {
				$k = strtr( strtolower($k), ' ', '_' );
				self::$_PAGE_CONFIG[$k] = $v;
			}
		}
	}

	function getMessages() {
		$s = '';
		if ( $this->session->isset_var('msg') ) {
			$s .= $this->session->get('msg');
			$this->session->unset_var('msg');
		}
		$s .= $this->msg;
		return $s;
	}

	function setDefaultTimeZone($timezone) {
		if ( empty($timezone) ) {
			$timezone = $timezone = self :: DEFAULT_TIMEZONE;
		}
		date_default_timezone_set($timezone);
	}

	function setEncoding($encoding) {
		if ( empty($encoding) ) {
			$encoding = self :: DEFAULT_ENCODING;
		}
		header('Content-type: text/html; charset='.$encoding);
	}

	function setPage($page) {
		$this->_page = trim($page);
		if (empty($this->_page)) {
			$this->_page = self::$_PAGE_CONFIG['default_page'];
		}
	}

	function getLoginPage() {
		return $this->_auth_login_page;
	}

	function getPage() {
		return $this->_page;
	}

	private function LoadFile($path) {
		
		if (@include $path) {
			return true;
		} else {
			die('Plik '.$path.' nie istnieje.');
		}

		if (self::$_PAGE_CONFIG['debug']) {
			$this->__Flash(array('path'=>$path,'comment'=>'Plik nie istnieje.'));
			Request::Error404();
		} else {
			$this->rv->set('page','');
			$this->rv->set('subpage','');
			$this->request->execute();
		}
		
	}

	function getModuleClass() {
		$mod_parts = explode('_', $this->_page);
		$mod = 'Module';
		if(sizeof($mod_parts)) {
			foreach ($mod_parts as $part) {
				$mod .= '_'.ucfirst($part);
			}
		}
		return $mod;
	}

	public function display() {
		echo $this->_page_content;
	}
	
	function loadPage() {
				
		ob_start();
		
		$mod = $this->getModuleClass();
		
		if (class_exists($mod)) {
			
			$this->mod = $this->_page_module = new $mod();
			
			if (is_subclass_of($this->_page_module, 'Modules_Handler')) {
				
				if (!$this->auth) {

					$this->_page_module->load();
				} else {

					if ($this->_page_module->GetName() == self::$_PAGE_CONFIG['auth_login_page']
							|| $this->auth->isAllowed(
									$this->_page_module->GetName(),
									$this->_page_module->GetView())
							|| Auth::isSuperadmin()) {
							
						$this->_page_module->load();
						
					} else {
						if (!$this->auth->isLoged() &&
								($this->_page != self::$_PAGE_CONFIG['auth_login_page']
									|| $this->rv->get('subpage','all') != '')
						) {
							$this->session->set('last_call', $this->page_url);
							$this->session->set('msg',$this->msg);
							$this->rv->set('page', self::$_PAGE_CONFIG['auth_login_page'], 'all');
							$this->rv->set('subpage', null, 'all');

							$this->request->execute();
						}
					}
				}
			} else {
				$this->error('Moduł <b>'.$mod.'</b> nie jest obiektem dziedziczącym po ModulesHandler.');
			}
		} else {
			$this->error('Moduł <b>'.$mod.'</b> nie istnieje.');
		}

		# Save content to var, we will display content in a templates
		$this->_page_content = ob_get_clean();
	}

	function loadTemplate($template) {
		
		if ($this->_page_module instanceof Modules_Handler) {
			$lay = $this->_page_module->getLayout();
			if (strpos($lay,':') !== false) { 
				list($k,$v) = explode(':',$lay);
				switch ($k) {
					case 'tpl':
						$path = DIR_INC_TEMPLATES . $v . '.tpl';
						$this->LoadFile($path);
						break;
				}
			} else {
			
				switch ($lay) {
					case 'home':
						$path = DIR_INC_TEMPLATES . 'home' . '.tpl';
						$this->LoadFile($path);
						break;
					case 'none':
					case 'empty':
					case 'no':
					case 'ajax':
					case 'js':
						echo $this->display();
						break;
					case 'popup':
						$path = DIR_INC_TEMPLATES . 'popup' . '.tpl';
						$this->LoadFile($path);
						break;
					case 'admin_popup':
						$path = DIR_INC_TEMPLATES . 'admin_popup' . '.tpl';
						$this->LoadFile($path);
						break;
						break;
					case 'print':
						$path = DIR_INC_TEMPLATES . 'print' . '.tpl';
						$this->LoadFile($path);
						break;
					case 'html':
					default:
						$path = DIR_INC_TEMPLATES . $template . '.tpl';
						$this->LoadFile($path);
						break;
				}
			}
		} else {
			if (self::$_PAGE_CONFIG['debug']) {
				$this->__Flash(array('template'=>$template,'comment'=>'Moduł nie istnieje.'));
				Request::Error404();
			} else {
				$this->rv->set('page','');
				$this->rv->set('subpage','');
				$this->request->execute();
			}
		}
	}
	
	public function __Flash($params = null) {
		
		if (!is_array($params)) {
			$params = array();
		}
		
		$params['page'] = $this->getPage();
		$params['subpage'] = $this->rv->get('subpage');
		$params['request_uri'] = $_SERVER['REQUEST_URI'];
		$params['datetime'] = date('Y-m-d H:i:s');
		$params['ip'] = f_get_ip_address();

		$this->session->set('page_flash',$params);
	}
}