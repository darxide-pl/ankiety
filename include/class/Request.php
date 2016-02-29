<?php

class Request {
	
	private $_global_params = array(); // tablica zmiennych ktore ew. beda dokładane do url
	
	function __construct($params = null) {
		
		$this->addParam('page');
		$this->addParam('subpage');
		$this->addParam('oid');
		
		if ($params) {
			$this->addParams($params);
		}
		return true;
	}
	
	function addParams($params) {
		if (is_array($params) && sizeof($params)) {
			foreach ($params as $param) {
				if (!empty($param)) {
					$this->addParam($param);
				}
			}
		}
	}

	function addParam($param) {
		if (!empty($param)) {
			array_push($this->_global_params, $param);
		}
	}
	
	function collectParams($force_params = array(),$glue = LT) {
		
		$params = array();
		
		if ($force_params) {
			$do_params = $force_params;
		} else {
			$do_params = $this->_global_params;
		}
		
		foreach ($do_params as $param) {
			if (isset($_REQUEST[$param])) {
				$params [$param]= $_REQUEST[$param];
			}
		}
		
		# if there is no subpage name and you set some after modifiers in action script
		# define subpage to avoid errors
		if (!$force_params) {
			if (sizeof($params) > 2 && !isset($_REQUEST['subpage'])) {
				$params['subpage'] = 'index';
			}
		}
		return $params;
	}
	
	/**
	 * 
	 * @param type $params
	 * @param type $save_messages
	 * @param type $continue
	 */
	function execute($params = null, $save_messages = false, $continue = false) {

		$link = new Link;
		
		if ($params && is_string($params)) {
			$location = $params;
		} else if (is_array($params) && in_array('_LINK_',$params)) {
			$location = $link->Build(urldecode($_REQUEST['_LINK_']));
		} else {
			if ($params) {
				$params = is_array($params) ? $params : array($params);
				$location = $link->Build($params);
			} else {
				$location = $link->Build($this->collectParams());
			}
		}

		if ($save_messages) {
			Session::Instance()->set('msg', Messages::Instance());
		}

		header('Location: '.$location);
		
		if (!$continue) {
			exit(); 
		}
	}
	
	/**
	 * Refresh page using requested URI
	 * 
	 * @param bool $pass_message - save messages to session
	 * @param bool $continue - stop or continue this script execution
	 */
	public function refresh($pass_message = true, $continue = false) {
		
		if ($pass_message === true) {
			# save messages
			Session::Instance()->set('msg', Messages::Instance());
		}
		
		# rebuild full url
		$uri = ltrim($_SERVER['REQUEST_URI'],'/\\');
		$uri = str_replace('page_action','_page_action',$uri);
		
		header('Location: ' . DEFAULT_PORT . '://' . BASE_DOMAIN .'/' . $uri);
		
		# stop script by default or continue if user specified
		if ($continue === false) {
			exit();
		}
	}

	public static function Error404() {
		header('Location: '.f_link(array('page'=>'error')));
		exit();
	}
}