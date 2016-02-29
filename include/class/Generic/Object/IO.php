<?php

class Generic_Object_IO {
	
	public function __construct(Generic_Object $o) {
		$this->_o = $o;
	}
	
	function Remove() {
		$this->Delete();
	}

	function Delete() {
		
		if ($this->_o->_recursive) {
			$objects = array_reverse($this->_o->_objects);
		} else {
			$objects = array($this->_o->_class_name);
		}
		
		foreach ($objects as $o) {
				
			if ($this->_o->_not_real[$o]) {
				continue;
			}
			
			$id_field = $this->_o->_getObjectIdField($o);
			$data = $this->_o->_data[$o];
			
			if ($data[$id_field] != null) {
				$sql = "DELETE FROM `".Generic_Object::GetTableNameByObject($o)."` 
					WHERE `".$id_field."` = ".$data[$id_field].";";
				if (!Db::Instance()->query($sql)) {
					throw new Exception(sprintf(TASE_WOBJECT2, $o));
				}
			}
		}
		return true;
	}
	
	function DeleteFound($options,$method = 'all') {
		$found = $this->_o->find($options, $method);
		if ($found) {
			foreach ($found as $object) {
				$object->Delete();
			}
		}
		return true;
	}

	function Save($object = null) {
		
		if ($this->_o->_modified || $this->_o->_force_modify) {

			if ($object) {
				$objects = array($object);
			} else {
				$objects = $this->_o->_objects;
			}
			
			if ($this->_o->_recursive) {
				$objects = array_reverse($objects);
			} else {
				$objects = array($this->_o->_class_name);
			}
			
			foreach ($objects as $o) {
				
				$a = array();
				
				if ($this->_o->_not_real[$o]) {
					continue;
				}
				
				$id_field = $this->_o->_getObjectIdField($o);
				$data = $this->_o->_data[$o];
				$fields = Generic_Object::$_fields[$o];
				
				foreach ($fields as $field) {
					$field = $field;
					if ($field == $id_field) {
						continue;
					} else if ($this->_o->_force_modify || $this->_o->IsFieldModified($o.'.'.$field)) {
						$a [$field]= $data[$field];
					}
				}
				
				if ($data[$id_field] != null) {
					if (is_array($a) && sizeof ($a)) {
						$result = Db::Instance()->Update(Generic_Object::GetTableNameByObject($o), $a, "`".$id_field."` = '".$data[$id_field]."'");
					} else {
						$result = true;
					}
				} else {
					$result = Db::Instance()->Insert(Generic_Object::GetTableNameByObject($o), $a);
					if ($result) {
						
						$this->_o->SetField($o.'.'.$id_field, Db::Instance()->insert_id);
						
						if (is_array($this->_o->_relations)) {
							if (isset($this->_o->_relations[$o])) {
								if (isset($this->_o->_relations[$o]['hasObject'])) {
									$reference = current($this->_o->_relations[$o]['hasObject']);
									if ($reference) {
										$this->_o->SetField(key($reference).'.'.$reference, Db::Instance()->insert_id);
									}
								}
							}
							foreach ($this->_o->_relations as $object => $relation ) {
								if (isset($relation['belongsToObject'][$o])) {
									$reference = current($this->_o->_relations[$object]['belongsToObject']);
									if ($reference) {
										$this->_o->SetField($object.'.'.$reference, Db::Instance()->insert_id);
									}
								}
							}
						}
					}
				}
				if (!$result) {
					throw new Exception( TASE_CANT_SAVE );
				}
			}
		}
		
		return $this->_o;
	}
}