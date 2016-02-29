<?php

class Session {
	
	private $db;
	
	private $user_ip_address = '0.0.0.0';
	private $user_agent = '';
	
	private $session_gc_maxlifetime = 1209600;
	private $session_cookie_lifetime = 1209600;
	
	private $remember = 0; // actual remember time
	private $remember_default = 1209600;
	
	/**
	 * Container for Session instace
	 * @var Session
	 */
	private static $_Instance;

	/**
	 *
	 * @param type $session_name
	 * @param type $session_cookie_domain
	 * @param type $session_save_path
	 * @param string $session_cookie_path 
	 */
	function __construct($session_name = null, $session_cookie_domain = null, $session_save_path = null, $session_cookie_path = null) {

		//Log::open('session');
		
		$this->db = Db::Instance();
		
		$this->user_ip_address = f_get_ip_address();
		
		$this->user_agent = getenv('HTTP_USER_AGENT');

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

		ini_set("session.cookie_path", $session_cookie_path);
		ini_set("session.cookie_domain", $session_cookie_domain);
		ini_set("session.gc_maxlifetime", $this->session_gc_maxlifetime);
		ini_set("session.cookie_lifetime", $this->session_cookie_lifetime);
		ini_set("session.use_trans_sid", 0);
		ini_set("session.use_only_cookies", 1);

		// Register this object as the session handler
		session_set_save_handler(
				array(&$this, "open"), array(&$this, "close"), array(&$this, "read"), array(&$this, "write"), array(&$this, "destroy"), array(&$this, "gc")
		);
		
		$this->initSession();
		
		setcookie(session_name(),session_id(),time()+$this->session_cookie_lifetime,$session_cookie_path);
		
		self :: $_Instance = $this;
	}

	function open($save_path, $session_name) {
		
		if (isset($_REQUEST['__session_remember__'])) {
			if ($_REQUEST['__session_remember__']) {
				$this->Remember((int)$this->remember_default);
			} else {
				$this->Forget();
			}
		}
		
		return true;
	}

	function close() {

		return true;
	}

	function read($id) {

		// Set empty result
		$data = '';

		// Fetch session data from the selected database

		$time = time();

		$newid = $this->db->quote($id);
		$sql = "SELECT `data`, `remember` FROM `session` WHERE `id` = '$newid' AND `expires` > ".$time." - `remember`;";
		// file_put_contents(APPLICATION_PATH.'/session.txt', date('Y-m-d H:i:s')."\t".$_COOKIE['CRM']."\t".$sql."\n",FILE_APPEND);
		$result = $this->db->query($sql);
		$a = $result->num_rows();

		if ($a > 0) {
			$row = $result->fetch_assoc();
			$this->remember = $row['remember'];
			$data = $row['data'];
		}
		
		//Log::write('session', 'read');

		return $data;
	}

	function write($id, $data) {

		// Build query                
		$time = time() + $this->session_gc_maxlifetime;

		$newid = $this->db->quote($id);
		$newdata = $this->db->quote($data);

		$sql = "REPLACE `session` (`id`,`name`,`data`,`expires`,`remember`) VALUES('$newid', '".session_name()."', '$newdata', $time,".$this->remember.")";
		// file_put_contents(APPLICATION_PATH.'/session.txt', date('Y-m-d H:i:s')."\t".$_COOKIE['CRM']."\t".$sql."\n",FILE_APPEND);
		return (bool) $this->db->query($sql);
	}

	function destroy($id) {
		// Build query
		$newid = $this->db->quote($id);
		$sql = "DELETE FROM `session` WHERE `id` = '$newid'";
		file_put_contents(APPLICATION_PATH.'/session.txt', date('Y-m-d H:i:s')."\t".$_COOKIE['CRM']."\t".$sql."\n",FILE_APPEND);
		$this->db->query($sql);
		return (bool) $this->db->query($sql);
	}

	function gc() {

		// Garbage Collection
		// Build DELETE query.  Delete all records who have passed the expiration time
		$sql = 'DELETE FROM `session` WHERE `expires` + `remember` < UNIX_TIMESTAMP();';
		file_put_contents(APPLICATION_PATH.'/session.txt', date('Y-m-d H:i:s')."\t".$_COOKIE['CRM']."\t".$sql."\n",FILE_APPEND);
		$this->db->query($sql);

		// Always return TRUE
		return true;
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
		
		// create session
		session_start();
		
		// Secure session by changing id on every request
		#session_regenerate_id(true); // true - mean remove old session file/record
		
		// verify client, when false destroy session
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
		//if ($this->get('SESSION_IP_ADDRESS') == '') {
		//	$this->set('SESSION_IP_ADDRESS',  $this->user_ip_address);
		//}
		//if ($this->get('SESSION_IP_ADDRESS') != $this->user_ip_address) {
		//	return false;
		//}
		return true;
	}

	function verifyClient() {
		if ($this->checkBrowser() && $this->checkIPAddress()) {
			return true;
		}
		return false;
	}
	
	public function Remember($seconds = null) {
		
		// if no param return actual remember value
		if (is_null($seconds)) {
			return $this->remember;
		}
		
		$sql = "UPDATE `session` SET `remember` = ".(int)($seconds)." WHERE `id` = '".$this->db->quote(session_id())."';";
		file_put_contents(APPLICATION_PATH.'session.txt', date('Y-m-d H:i:s')."\t".$sql."\n",FILE_APPEND);
		return $this->db->query($sql);
	}
	
	public function Forget() {
		$sql = "UPDATE `session` SET `remember` = 0 WHERE `id` = '".$this->db->quote(session_id())."';";
		file_put_contents(APPLICATION_PATH.'session.txt', date('Y-m-d H:i:s')."\t".$sql."\n",FILE_APPEND);
		return $this->db->query($sql);
	}
}