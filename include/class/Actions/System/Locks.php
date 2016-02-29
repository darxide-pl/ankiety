<?php

class System_Locks_Actions extends Action_Script {
	
	public function _lock() {
		
		$this->mode = 'json';
		
		if (!$this->auth->isLoged()) {
			return false;
		}
		
		// clear old blockades
		Model_System_Lock::Clear();
		
		$type = $this->rv->get('type');
		$object_id = (int) $this->rv->get('object_id');
		$user_id = (int) $this->auth->user['id'];
		
		$lock = Model_System_Lock::Lock($user_id, $type, $object_id);
		
		if (!$lock) {
			$this->error('Blokada nie została założona. Ktoś inny edytuje już ten wpis.');
		}
	}
	
	public function _check_locks() {
		
		$this->mode = 'json';
		
		$type = $this->rv->get('type');
		$objects = $this->rv->get('objects');

		$locks = Model_System_Lock::Check_Locks($type, $objects);
		
		$this->output['locks'] = $locks;
	}
}
