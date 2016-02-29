<?php

class Model_System_Action_Var extends Generic_Object {
		
	function __toString() {
		return (string) $this->GetName();
	}
}