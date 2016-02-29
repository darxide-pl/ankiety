<?php

class Model_User_Group extends Generic_Object {

	function IsHidden() {
		return (bool) $this->_data['hidden'];
	}
	
	function Validate() {
		if (empty($this->_data['name'])) {
			throw new Exception('Nie podano nazwy grupy.');
		}
		
		if (empty($this->_data['code'])) {
			throw new Exception('Nie podano kodu grupy.');
		}
		return true;
	}

	function __toString() {
		return '<span style="color:'.$this->GetColor().';">'.$this->GetName().'</span>';
	}

}

?>
