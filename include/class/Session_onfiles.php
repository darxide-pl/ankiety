<?php

class Session_onfiles {
	
	private $session_timeout;
	private $session_lifespan;
	private $user_agent;
	private $user_ip_address;
	
	/**
	 * Container for Session instace
	 * @var Session
	 */
	private static $_Instance;
	
	function  __construct($session_name = null, $session_cookie_domain = null, $session_save_path = null, $session_cookie_path = null) {

		if ($session_name) {
			session_name($session_name);
		} else {
			if (Config::Get('session.def_name') != '') {
				session_name(Config::Get('session.def_name'));
			}
		}

		if (!$session_cookie_domain) {
			$session_cookie_domain = Config::Get('session.def_cookie_domain');
		}

		if (!$session_save_path) {
			session_save_path(Config::Get('session.def_save_path'));
		} else {
			session_save_path($session_save_path);
		}

		if (!$session_cookie_path) {
			$session_cookie_path = '/';
		}

		$this->session_lifespan = Config::Get('session.lifetime');
		$this->session_timeout = Config::Get('session.timeout');

		$this->user_ip_address = f_get_ip_address();
		$this->user_agent = getenv('HTTP_USER_AGENT');

		ini_set("session.cookie_path", $session_cookie_path);
		ini_set("session.cookie_domain", $session_cookie_domain);
		ini_set("session.gc_maxlifetime", $this->session_timeout);
		
		# remember login for long time
		$long_time_length = 3600*24*30;
		$long_time = time()+$long_time_length;
		if (isset($_POST['remember_login'])) {
			if ($_POST['remember_login']) {
				setcookie('remember_login','1',$long_time,$session_cookie_path,$session_cookie_domain);
				$this->session_lifespan = $long_time_length;
			} else {
				setcookie('remember_login','',time()-1,$session_cookie_path,$session_cookie_domain);
			}
		} else if (isset($_COOKIE['remember_login']) && $_COOKIE['remember_login'] > 0) {
			$this->session_lifespan = $long_time_length;
		}
		
		ini_set("session.cookie_lifetime", $this->session_lifespan);
		ini_set("session.use_trans_sid", 0);
		ini_set("session.use_only_cookies", 1);
		
		$this->initSession();
		
		self :: $_Instance = $this;
	}

	/**
	 * Get instance of first Session object,
	 * instead of creating another new.
	 * 
	 * @return new Session or pointer
	 */
	static function Instance() {
		if (!self::$_Instance instanceof Session) {
			throw new Exception('Session::Instance: Session is not started.');
		}
		return self::$_Instance;
	}
	
	function get($var) {
		if (isset($_SESSION[$var])) {
			return $_SESSION [$var];
		}
	}
	
	function set($var, $value) {
		return $_SESSION [$var] = $value;
	}
	
	function is_empty($var) {
		return empty($_SESSION[$var]);
	}
	
	function isset_var($var) {
		return (bool) isset($_SESSION [$var]);
	}
	
	function unset_var($var) {
		unset($_SESSION[$var]);
	}
	
	function initSession() {
		
		register_shutdown_function('session_write_close');
		
		# create session
		session_start();
		//session_regenerate_id(false);
		
		# verify client, when false destroy session
		if (!$this->verifyClient()) {
			session_destroy();
		}
	}

	function checkBrowser() {
		if ($this->get('SESSION_CLIENT_BROWSER') == '') {
			$this->set('SESSION_CLIENT_BROWSER',  $this->user_agent);
		}
		if ($this->get('SESSION_CLIENT_BROWSER') != $this->user_agent) {
			return false;
		}
		return true;
	}

	function checkIPAddress() {
		if ($this->get('SESSION_IP_ADDRESS') == '') {
			$this->set('SESSION_IP_ADDRESS',  $this->user_ip_address);
		}
		if ($this->get('SESSION_IP_ADDRESS') != $this->user_ip_address) {
			return false;
		}
		return true;
	}

	function verifyClient() {
		if ($this->checkBrowser() && $this->checkIPAddress()) {
			return true;
		}
		return false;
	}
}