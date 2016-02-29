<?php

class Model_Config_Option extends Generic_Object {
	
	function GetGroupID() {
		return $this->_data['group_id'];
	}
	
	function GetPosition() {
		return $this->GetSequence();
    }

	function Validate() {

		if (empty($this->_data['Config_Option']['name'])) {
			throw new Exception('Nie podano nazwy opcji.');
		}
		
		if (empty($this->_data['Config_Option']['key'])) {
			throw new Exception('Nie podano unikalnego klucza.');
		}
		
		if (empty($this->_data['Config_Option']['type'])) {
			throw new Exception('Typ pola nie został wypełniony.');
		}
		
		if (!$this->_data['Config_Option']['group_key']) {
			throw new Exception('Nie wybrano grupy.');
		}
		return true;
	}
}