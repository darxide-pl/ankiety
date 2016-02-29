<?php

class IpBlockade extends Generic_Object {
	
	function __construct($data = array()) {
		parent::__construct($data);
	}
	
	function Validate() {
		if (empty($this->_data['ip'])) {
			throw new Exception('Nie podano adresu IP.');
		}
	}

	function __toString() {
		return (string) $this->_data['ip'];
	}
	
}

?>