<?php

class Model_System_Module extends Generic_Object {
	function __toString() {
		return $this->GetName();
	}
}
