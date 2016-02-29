<?php

class Model_User extends Generic_Object {

	public static $status = array(
		'0' => 'Zablokowani',
		'1' => 'Aktywni'
	);
	
	function GetFullName() {
		return $this->_data['User']['name'].' '.$this->_data['User']['lastname'];
	}

	function CheckPassword($password) {
		return (bool) ( strcmp($this->_data['User']['password'], sha1($password)) == 0 ); 
	}
	
	function IsActive() {
		return (bool) $this->_data['User']['active'];
	}
	
	function IsSuperAdmin() {
		return (bool) $this->_data['User']['super_admin'];
	}
	
	function Validate() {
		return true;
	}
	
	function __toString() {
		return $this->GetFullName();
	}
	
	public static function CheckLogin($login) {
		
		if (empty($login)) {
			return 'Nie podano identyfikatora.';
		}
		
		if (strlen($login) < 3) {
			return 'Login musi składać się z conajmniej 3 znaków.';
		}
		
		$User = new Model_User();
		$users = $User->find()
			->where('User.`login` = \''.$login.'\'')
			->count(true)
			->fetch();
		
		if ($users > 0) {
			return 'Taki login już istnieje w bazie.';
		}
		
		return true;
	}
}