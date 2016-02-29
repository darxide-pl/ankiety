<?php

class Model_System_Message extends Generic_Object {

	function IsActive() {
		return $this->_data['active'];
	}

}