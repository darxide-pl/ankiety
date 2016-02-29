<?php

class Model_System_Action extends Generic_Object {

	function __toString() {
		return (string) $this->GetName();
	}
}