<?php

abstract class Generic_Object {

	public $_class_name;

	public $_data;

	public $_modified;

	public $_modified_fields;

	public $_force_modify;

	public $_objects = array();

	static $_fields;

	static $_tables;

	public $_relations;

	public $_relations_conditions = array();

	public $_not_real;
	
	public $_recursive = true;

	public $_dont_get_fields = array();
	
	function __construct($data = array(), $options = null) {

		$this->_class_name = substr(get_class($this),6);
		$this->_not_real[__CLASS__] = true;
		$this->_getObjects();
		$this->_init();

		$this->_modified = false;
		$this->_modified_fields = array();

		if ((is_numeric($data) && $data > 0) || $data === false) {
			$this->findById($data, $options);
		} elseif (!is_null($data)) {
			$this->_extractData($data);
		}
	}

	protected function _init() {
		return true;
	}

	public static function NewInstance() {
		$called_class_name = get_called_class();
		return new $called_class_name;
	}
	
	function GetID() {
		return $this->_data[$this->_class_name][$this->_getObjectIdField($this->_class_name)];
	}

	function SetID($id) {
		$this->_data[$this->_class_name][$this->_getObjectIdField($this->_class_name)] = $id; 
		return $this;
	}

	function Get($field) {
		if (is_array($this->_data)) {
			if (strpos($field,'.')) {
				list($o, $f) = explode('.', $field);
				return $this->_data[$o][$f];
			} elseif (isset($this->_data[$this->_class_name][$field])) {
				return $this->_data[$this->_class_name][$field];
			}
		} 
		return false;
	}

	function GetAllFields() {
		return $this->_data;
	}

	public function Set($field,$value = '') {
		$this->SetField($field,$value);
		return $this;
	}
	
	function SetField($field, $value) {
		
		$f = $field;
		# if full name of field was specified eg. User.name
		if (strpos($field,'.')) {
			list($o, $f) = explode('.', $field);
		} else {
			# if there is not set object to edit use root class name
			$o = $this->_class_name;
		}
		
		$is_recurency_id = (bool) ($this->_getObjectIdField($o) == $f);
		$is_id = (bool) ($is_recurency_id && $o == $this->_class_name);

		# if there is no such field try to create it
		if (!isset($this->_data[$o][$f])) {
			# if it is not id field or this is root class
			if (!$is_id) {
				if (!isset($this->_data[$o][$f])) {
					$this->_data[$o][$f] = '';
				}
			}
		}
		
		if ($this->_data[$o][$f] != $value) {
			if (!$is_recurency_id) {
				# if it is not id field write to first layer (rest are update by reference &)
				$this->_data[$o][$f] = $value;
			} else {
				# if it is id field write only to it
				$this->_data[$o][$f] = $value;
				if (is_array($this->_relations)) {
					# if this is not id field and there is some relations 
					if (isset($this->_relations[$o]['hasObject'])) {
						# update related foreign keys and add it to modified fields
						foreach ($this->_relations[$o]['hasObject'] as $fk_object => $fk_field) {
							$this->_data[$fk_object][$fk_field] = $value;
							$this->_modified_fields[$fk_object][$fk_field] = true;
						}
					}
					# if this is not root id field and there is some relations 
					if (isset($this->_relations[$this->_class_name]['belongsToObject'])) {
						# update related foreign keys and add it to modified fields
						foreach ($this->_relations[$this->_class_name]['belongsToObject'] as $fk_object => $fk_field) {
							$this->_data[$this->_class_name][$fk_field] = $value;
							$this->_modified_fields[$this->_class_name][$fk_field] = true;
						}
					}
				}
			}
			# check that there was some modifications
			$this->_modified = true;
			# add key to modified fields
			$this->_modified_fields[$o][$f] = true;
		}

		return true;
	}

	function ForceModify() {
		$this->_force_modify = true;
		return $this;
	}

	function DoForceModify() {
		return (bool) $this->_force_modify;
	}

	function Modified() {
		return $this->_modified;
	}
	
	function IsFieldModified($field) {
		if (empty($field)) {
			return false;
		}
		if (strpos($field,'.')) {
			list($o,$f) = explode('.',$field);
			return (bool) $this->_modified_fields[$o][$f];
		}
		return (bool) $this->_modified_fields[$field];
	}

	function __set($param, $value) {
		# not used since SetField()
		//$this->_data[$param] = $value;
	}
	
	function __get($param) {
		return $this->Get($param);
	}

	function __call($method, $args) {
		if (method_exists($this, $method)) {
			return call_user_func_array(array($this, $method), $args);
		}
		
		if (substr($method,0,6) == 'findBy') {
			$c = new Generic_Object_Collector($this);
			$o = $c->findBy(substr($method,6),$args[0],$args[1],$args[2]);
			if ($args[2] == 'first') {
				$this->_data = $o->_data;
			}
			return $o;
		}
		
		if (substr($method,0,3) == 'Get' || substr($method,0,3) == 'get') {
			$field = substr($method,3);
			$field = preg_replace('/(.)([A-Z])/','$1_$2',$field);
			$field = strtolower($field);
			return $this->Get($field);
		}
	}

	public static function ExtractObjectToList($objects, $id_field, $value_field) {
		$ar = array();
		if (is_array($objects) && sizeof($objects)) {
			foreach ($objects as $O) {
				if (is_object($O) && $O instanceof Generic_Object) {
					if (is_array($value_field)) {
						$s = '';
						foreach ($value_field as $value) {
							$_v = $O->Get($value);
							if ($_v !== false) {
								$s .= $_v;
							} else {
								$s .= $value;
							}
						}
					} else {
						$s = $O->Get($value_field);
					}
					if ($id_field) {
						$ar[$O->Get($id_field)] = $s;
					} else {
						$ar[] = $s;
					}
				}
			}
		}
		return $ar;
	}

	function Save() {
		$io = new Generic_Object_IO($this);
		return $io->Save();
	}
	
	function Delete() {
		$io = new Generic_Object_IO($this);
		return $io->Delete();
	}
	
	function Remove() {
		return $this->Delete();
	}
	
	function DeleteFound($options, $method = 'all') {
		$io = new Generic_Object_IO($this);
		return $io->DeleteFound($options, $method);
	}

	function findById($id, $options = array()) {
		$c = new Generic_Object_Collector($this);
		$o = $c->findBy($this->_class_name.'.id',$id,$options,'first');
		$this->_data = $o->_data;
		return $o;
	}
	
	function find($options = null, $method = 'all') {
		$c = new Generic_Object_Collector($this);
		if (is_null($options)) {
			return $c;
		}

		return $c->fetch($options, $method);
		//return false;
	}

    function SetRecursion($status = null) {
        if (is_null($status)) {
            $status = true;
        }
        $this->_recursive = (bool)$status;
    }

	public function _extractData($data, $clear = true) {
		
		if ($clear) {
			$this->_data = array();
		}
		
		if (!$data || empty($data)) {
			return false;
		}

		if (!isset($data[0]) || !is_array($data[0])) {
			$data = array($data);
		}
		
		foreach ($data as $row) {
			if (is_array($row)) {
				foreach ($row as $k => $v) {
					if (!is_numeric($k) && strpos($k,'.')) {
						list($o, $f) = explode('.', $k);
						$this->_data[$o][$f] = $v;
					} else {
						$this->_data[$this->_objects[0]][$k] = $v;
					}
				}
			}
		}
		return true;
	}
	
	public function _getObjectIdField($object) {
		if (is_array(self::$_fields[$object])) {
			return self::$_fields[$object][0];
		} else {
			return 'id';
		}
	}
	
	public function _getObjects() {
		$names = array();
		
		array_push($names,$this->_class_name);
		$i = 0;
		while($parent != 'Generic_Object' && $parent = get_parent_class('Model_'.$names[$i])) {
			if (strpos($parent,'Model_') === 0) {
	            $parent = substr($parent,6);
			}
			array_push($names,$parent);
			$i++;
		}
		$this->_objects = $names;
		foreach ($this->_objects as $object) {
			$this->_getObjectFields($object);
		}
	}
	
	function HasObject($object, $foreign_field, $get_all_fields = true, $conditions = null) {
		if (is_array($object)) {
			$o0 = $this->AddObject($object[0]);
			$o1 = $this->AddObject($object[1]);
			$this->_relations[$o0]['hasObject'][$o1] = $foreign_field;
			$this->_relations_conditions[$o0]['hasObject'][$o1] = $conditions;
			if (!$get_all_fields) {
				$this->_dont_get_fields[$o1] = true;
			}
		} else {
			$o = $this->AddObject($object);
			$this->_relations[$this->_class_name]['hasObject'][$o] = $foreign_field;
			$this->_relations_conditions[$this->_class_name]['hasObject'][$o] = $conditions;
			if (!$get_all_fields) {
				$this->_dont_get_fields[$o] = true;
			}
		}
		return $this;
	}
	
	function BelongsToObject($object, $foreign_field, $get_all_fields = true, $conditions = null) {
		if (is_array($object)) {
			$o0 = $this->AddObject($object[0]);
			$o1 = $this->AddObject($object[1]);
			$this->_relations[$o0]['belongsToObject'][$o1] = $foreign_field;
			$this->_relations_conditions[$o0]['hasObject'][$o1] = $conditions;
			if (!$get_all_fields) {
				$this->_dont_get_fields[$o1] = true;
			}
		} else {
			$o = $this->AddObject($object);
			$this->_relations[$this->_class_name]['belongsToObject'][$o] = $foreign_field;
			$this->_relations_conditions[$this->_class_name]['belongsToObject'][$o] = $conditions;
			if (!$get_all_fields) {
				$this->_dont_get_fields[$o] = true;
			}
		}
		
		return $this;
	}
	
	function AddObject($object) {
		if (!empty($object)) {
			
			if (strpos($object,'Model_') === 0) {
				$object = substr($object,6);
			} else {
				//$object = preg_replace('/(.)([A-Z])/','$1_$2',$object);
			}

			if (!in_array($object, $this->_objects)) {
				array_push($this->_objects,$object);
			}
			$this->_getObjectFields($object);
			return $object;
		}
	} 
	
	public function _getObjectFields($object) {
		
		if (isset(self::$_fields[$object])) {
			return self::$_fields[$object];
		}
		
		$fields = array();
		if ((!isset($this->_not_real[$object]) || !$this->_not_real[$object]) && 
			(!isset(self::$_fields[$object]) || !is_array(self::$_fields[$object]))) {

			$table = Generic_Object::GetTableNameByObject($object);

			$sql = "DESCRIBE `".$table."`;";
			
			if (!file_exists(APPLICATION_PATH.'/tmp/schema/')) {
				mkdir(APPLICATION_PATH.'/tmp/schema/',755,true);
			}
			
			$options = array(
				'cacheDir' =>  APPLICATION_PATH.'/tmp/schema/',
				'lifeTime' => 2629743 // one month
			);

			$cache = new Cache_Lite($options);

			if (!($data = $cache->get(sha1($sql)))) {
				
				$fields = DB::Instance()->FetchRecords($sql);
				if ($fields) {
					$data = array();
					foreach ($fields as $field) {
						$data[] = $field['Field']; 
					}
				}

				$cache->save(serialize($data));
			} else {
				$data = unserialize($data);
			}

			return self::$_fields[$object] = $data;
		}
		return false;
	}
	
	/**
	 * 
	 * @param string $object - class name
	 * @return string - sql table name
	 */
	public static function GetTableNameByObject($object) {
		
		if (!isset(Generic_Object::$_tables[$object]) || Generic_Object::$_tables[$object] == '') {
			
			if (strpos($object,'_') === false) { 
				$object = preg_replace('/(.)([A-Z])/','$1_$2',$object);
			}
			Generic_Object::$_tables[$object] = strtolower($object);
		}
		return Generic_Object::$_tables[$object]; 
	}
	
	public static function GetObjectNameByClass($class) {
		if (strpos($class,'Model_') === 0) {
            $object = substr($class,6);
		}
		return $object;
	}
	
	public static function GetFieldFullName($field, $object = null) {
		if ($object) {
			return '`'.$object.'`.`'.$field.'`';
		}
		return '`'.$field.'`';
	}
	
	/**
	 * @param (array of objects) $objects
	 * @param (string) $key - alternative array key (must to be in object fields)
	 */
	public static function ObjectIDAsKey(&$objects,$key = null) {
		if (!is_array($objects) || !sizeof($objects)) {
			return false;
		}
		$assoc_array = array();
		foreach ($objects as $O) {
			if ($key) {
				$assoc_array[$O->Get($key)] = $O;
			} else {
				$assoc_array[$O->GetID()] = $O;
			}
		}
		return $objects = $assoc_array;
	}
	
	/**
	 * 
	 * @param (array of objects) $objects
	 * @param (string) $key
	 * @param (string) $key2 - subarray key (if empty 0..n)
	 */
	public static function GroupObjectsByField(&$objects,$key='id',$unique = false) {
		if (!is_array($objects) || !sizeof($objects)) {
			return false;
		}
		$assoc_array = array();
		foreach ($objects as $O) {
			if ($unique) {
				$assoc_array[$O->get($key)] = $O;
			} else {
				$assoc_array[$O->get($key)][]= $O;
			}
		}
		return $objects = $assoc_array;
	}
	
	public function Validate() {
		return $this;
	}
}