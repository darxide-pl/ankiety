<?php

class Auth extends Core
{
	protected $login;
	protected $password;
	
	var $user = array();

	protected $loged = false;
	protected $actions = array('login', 'logout');
	
	protected $_ip_blockade = false;

	static public $_instance;
	
	public $redirect_params;
	
	/**
	 * Initialize authorization module, create first instance
	 * 
	 * @param string $login user login
	 * @param string $password user password
	 * @param array $not_allowed_groups list of not allowed group names
	 * @param bool $allow_anonymous_login 
	 */
	function __construct($login, $password, $not_allowed_groups = null, $allow_anonymous_login = false ) {

		parent::__construct();
		
		$this->_allow_anonymous_login = $allow_anonymous_login;
		$this->_not_allowed_groups = $not_allowed_groups;
		
		$this->login = $login;
		$this->password = sha1($password);

		# if ip blockade was activated while user was loged try to log him out
		if ($this->_ip_blockade) {
			if ($this->isLoged()) {
				$this->loadAction('logout');
			}
		}
		
		self::$_instance =& $this;
		
		# load start actions
		$this->OnStart();
	}
	
	static function Instance() {
		
		return self::$_instance;
	}

	/**
	 * if user session is created and he is loged return true
	 * else false
	 * @return (bool)
	 */
	function isLoged() {
		return (bool) $this->session->get('user_loged');
	}
	
	/**
	 * if there is no blockades on user ip address then return true
	 * else false
	 * @return (bool)
	 */
	protected function validateIPAddress() {
		$sql = "SELECT COUNT(`ip`) FROM `ip_blockade` WHERE `ip` = '".f_get_ip_address()."';";
		return (bool) !(Db::Instance()->FetchRecord($sql, DB_FETCH_ARRAY_FIELD) > 0);
	}

	/**
	 * save user state, update his session id and add new record to login history
	 * @param (int) $user_id
	 * @param (int) $error
	 * @return unknown_type
	 */
	protected function saveLoginState($user_id, $error = 0) {
		$a = array(
			'user_id' => (int) $user_id,
			'date' => date('Y-m-d H:i:s'),
			'ip_address' => f_get_ip_address(),
			'browser' => ''.$this->session->get('SESSION_CLIENT_BROWSER'),
			'error' => (int) $error,
			'last_action_time' => date('Y-m-d H:i:s'),
			'session_id' => ($error ? '' : session_id())
		);

		if (!$this->db->Insert('user_login_history',$a)) {
			$this->Error('Nie udało się zapisać historii logowania.');
		}
		$this->session->set('user_login_record_id', $this->db->insert_id);
	}

	/**
	 * while user is loged in try to record his last activity
	 * @param (int) $user_id
	 * @return null
	 */
	protected function updateLoginState($user_id) {
		if ($this->session->get('user_login_record_id') > 0) {
			$a = array('last_action_time' => date('Y-m-d H:i:s'));
			$this->db->Update('user_login_history',$a,"`id` = '".(int)$this->session->get('user_login_record_id')."'");
		}
	}

	/**
	 * try to login user
	 * @param (string) $login
	 * @param (string) $password (encoded)
	 * @return (bool) success/error
	 */
	protected function login($login, $password, $user_id = false) {

		# faster way than object related €
		$sql = "SELECT u.*, ug.`code`, ug.`name` AS `group_name`
				FROM `user` u 
				LEFT JOIN `user_group` ug ON ug.`id` = u.`group_id`
				WHERE (u.`email` = '".$this->db->quote($login)."') ";
		 
		if (is_array($this->_not_allowed_groups) && sizeof($this->_not_allowed_groups)) {
			$sql .= " AND ug.`code` NOT IN ('".implode('\', \'',$this->_not_allowed_groups)."')";
		}
		 
		if ($user_id) {
			$sql .= " AND u.`id` = ".(int)$user_id;
		} elseif (!$this->validateIPAddress()) {
			$this->Error(t('Session expired','Session expired',''));
			$this->logout('INACTIVE_ACCOUNT');
			return false;
		}

		$User = $this->db->FetchRecord($sql, DB_FETCH_ARRAY);

		if ($User) {

			if ($password != $User['password']) {

				$this->saveLoginState($User['id'], 1);
				if ($user_id > 0) {
					$this->logout('WRONG_PASSWORD');
				}
				$this->Error(t('Wrong password','Wrong password',''));

			} else if ($User['active'] == 0) {
				$this->saveLoginState($User['id'], 2);
				if ($user_id > 0) {
					$this->logout('INACTIVE_ACCOUNT');
				}
				$this->Error(t('Account blocked','Account blocked',''));
			} else {

				$this->loged = $this->session->set('user_loged', true);
				$this->user ['id'] = $this->session->set('user_id', $User['id']);
				$this->user ['group'] = $this->session->set('user_group', $User['code']);
				$this->user ['group_name'] = $User['group_name'];
				$this->user ['email'] = $User['email'];
				$this->user ['email_signature'] = $User['email_signature'];
				$this->user ['password'] = $this->session->set('user_password',$password);
				$this->user ['login'] = $this->session->set('user_login', $User['email']);
				$this->user ['name'] = $User['name'];
				$this->user ['lastname'] = $User['lastname'];
				$this->user ['language'] = $this->session->set('language', $User['language']);
				$this->user ['access_list'] = unserialize($User['access_list']);
				
				setcookie('language',$User['language']);
				
				$this->user ['rights'] = $this->_loadUserGroupRights($User['code']);
		
				if (!$user_id) {
					$this->user ['login_time'] = $this->session->set('user_login_time', date('Y-m-d H:i:s'));
					$this->Msg(t('loged in','Loged in',''));
					$this->saveLoginState($User['id']);
				} else {
					$this->user ['login_time'] = $this->session->get('user_login_time');
					$this->updateLoginState($User['id']);
				}

				return true;
			}
		} else {
			$this->logout('NO_USER');
			$this->Error('Brak użytkownika.');
		}
		
		return false;
	}

	public function AddUserData($var,$value) {
		if (!isset($this->user[$var])) {
			$this->user[$var] = $value;
		}
	}
	
	protected function _loadUserGroupRights($group) {
		if (!$group) return false;
		$file_name = 'group.'.$group.'.r';
		if (file_exists(DIR_CACHE_RIGHTS.$file_name)) {
			$rights = file_get_contents(DIR_CACHE_RIGHTS . $file_name);
			return unserialize($rights);
		}
		return false;
	}
	
	/**
	 * logout user
	 * @param (mixed)$code
	 * @return null
	 */
	protected function logout($code = null) {
		$this->user = array();
		
		unset(
			$_SESSION['user_id'],
			$_SESSION['user_login'],
			$_SESSION['user_password'],
			$_SESSION['login_time'],
			$_SESSION['user_loged'],
			$_SESSION['user_group']
			);
		
		session_destroy();

		if ( empty($code) ) {
			$this->Msg(t('Loged out','Loged out',''));
		}
	}

	/**
	 * Auth dispatcher, if return true then it provokes a redirection
	 * @param (string) $action
	 * @return (bool) $redirect
	 */
	function loadAction($action) {
		
		if ($this->session->get('loged_right_now') > 0) {
			$this->OnRightAfterLogin();
			$this->session->set('loged_right_now',0);
		}
		
		$redirect = false;
		if (!empty($action)) {
			
			switch ($action) {
				
				case 'ajax_login':
					
					if (!$this->login($this->login, $this->password)) {
						$this->user['rights'] = $this->_loadUserGroupRights('__anonymous');
					} else {

						$this->OnLogin();
						
						$this->session->set('loged_right_now',1);
					}
					
					break;
					
				case 'login':

					$redirect = true;
					
					if (!$this->login($this->login, $this->password)) {
						$this->user['rights'] = $this->_loadUserGroupRights('__anonymous');
					} else {
						
						$this->OnLogin();
						
						$this->session->set('loged_right_now',1);
						
						if ($this->session->get('last_call')) {
							$this->redirect_params = $this->session->get('last_call');
							$this->session->unset_var('last_call');
						}
					}
					break;
					
				case 'logout':
					
					$redirect = true;
					
					$this->logout();
					
					$this->OnLogout();
					
					//$this->rv->set('page','login');
					//$this->rv->set('subpage','index');
					$this->user['rights'] = $this->_loadUserGroupRights('__anonymous');
					break;
			}
			
		} else if ( $this->isLoged() ) {

			if ( ! $this->login(
				$this->session->get('user_login'),
				$this->session->get('user_password'),
				$this->session->get('user_id')) ) {
					
				$this->logout();
				
				$this->OnLogout();
				
				$this->rv->set('page','login');
				$this->rv->set('subpage','index');
				
				$redirect = true;
			} else {
				$this->OnIsStillLoged();
			}
		} else {
			$this->user['rights'] = $this->_loadUserGroupRights('__anonymous');
		}
		if ($redirect) {
			$this->session->set('msg', $this->msg);
			//session_regenerate_id(true);
		}
		
		$this->OnCompleted();
		
		return $redirect;
	}

	public function hasAccess($key, $type = 'read', $decode = false) {
		
		if ($decode && is_array($key)) {
			
			if ($key[0] && $key[1]) {

				if ($type == 'view') {
					// check view
					$sql = "SELECT `access` FROM `system_module_view` WHERE `view` = '".$key[1]."' AND `module` = '".$key[0]."';";
					$key = trim($this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD));
					$type = 'read';

				} else {
					// check action
					$sql = "SELECT `access`,`type` FROM `system_module_action` WHERE `action` = '".$key[1]."' AND `name` = '".$key[0]."';";
					$action = $this->db->first($sql);
					$key = trim($action['access']);
					$type = trim($action['type']);
				}
			}
			
			if (!$key) {
				return 1;
			}
		}

		if ($this->isSuperadmin() || $this->checkRight('__anonymous')) {
			return 1;
		}
		
		return isset($this->user['access_list'][$key][$type]) ? 1 : 0;
	}

	function isAllowed($module, $view = null) {

		if ($this->checkRight('programers')) {
			return true;
		}
			
		
		if (isset($this->user['rights'][$module]['__mod_access']) && $this->user['rights'][$module]['__mod_access'] > 0) {
			if ($view) {
				if (isset($this->user['rights'][$module][$view]) && $this->user['rights'][$module][$view] > 0) {
					return true;
				}
			} else {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * if user group is in inserted groups, return true
	 * @param (string|array) $groups
	 * @return (bool)
	 */
	static function checkRight($groups) {
		$user_group = Session::Instance()->get('user_group'); 
		if (is_array($groups)) {
			return in_array($user_group,$groups);
		}
		return stristr($groups, $user_group);
	}
	
	static function isSuperadmin() {
		return self::checkRight('programers'); 
	}
	
	public function __toString() {
		
		$session = Session::Instance();

		$s = 'Zalogowany: <b>'.($session->get('user_loged') ? 'tak':'nie').'</b><br />';
		if ($session->get('user_loged')) {
			$s .= 'Zalogowany od: '.$session->get('user_login_time').'<br />';
			$s .= 'UserID: '.$session->get('user_id').'<br />';
			$s .= 'Grupa: '.$session->get('user_group').'<br />';
		}
		
		//$s .= 'Język: '.$session->get('language').'<br />';
		
		return $s;
	}
	
	public function OnStart() {
		return true;
	}

	public function OnLogin() {
		return true;
	}
	
	public function OnLogout() {
		return true;
	}
	
	public function OnIsStillLoged() {
		return true;
	}
	
	/**
	 * After login and redirect
	 */
	public function OnRightAfterLogin() {
		return true;
	}
	
	public function OnCompleted() {
		return true;
	}
}