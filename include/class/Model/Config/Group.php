<?php

class Model_Config_Group extends Generic_Object {
	
	function GetPosition() {
		return $this->GetSequence();
	}
	
	function Validate() {
		if (empty($this->_data['Config_Group']['name'])) {
			throw new Exception('Nie podano nazwy grupy.');
		}
		if (empty($this->_data['Config_Group']['key'])) {
			throw new Exception('Nie podano unikalnego klucza.');
		}
		return true;
	}
}