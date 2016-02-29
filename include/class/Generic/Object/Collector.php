<?php

class Generic_Object_Collector {
	
	private $_o;
	private $_a;
	
	private static $_cached_results;
	
	function __construct(Generic_Object &$o) {
		$this->_o = $o;
	}
	
	function __call($method, $args) {
		if (method_exists($this, $method)) {
			return call_user_func_array(array($this, $method), $args);
		}
		
		if (substr($method,0,6) == 'findBy') {
			return $this->findBy(substr($method,6),$args[0],$args[1],$args[2]);
		}
		
		if (substr($method,0,2) != '__') {
			if (strcmp($args[1],'permanent_and') === 0) {
				$this->_a[$method.'_permanent_and'] = $args[0];
			} else if ($args[1]) {
				$this->_a[$method] .= $args[0];
			} else {
				$this->_a[$method] = $args[0];
			}
			return $this;
		}
	}
	
	function findBy($field,$v,$a,$method = 'all') {
		$field = explode('.',$field);
		$object = '';
		if (sizeof($field) > 1) {
			$object = $field[0];
			$field = $field[1];
		} else {
			$field = $field[0];
		}
		$field = strtolower(preg_replace('/(.)([A-Z])/','$1_$2',$field));
		if ($object) {
			$field = '`'.$object.'`.`'.$field.'`';
		} else {
			$field = '`'.$field.'`';
		}
		if ($v !== false) {
			if (isset($a['where']) && $a['where'] != '') {
				$a['where'] .= ' AND '.$field.' = \''.$v.'\'';
			} else {
				$a['where'] = $field.' = \''.$v.'\'';
			}
		}
		return $this->fetch($a, $method);
	}
	
	function first($a = null) {
		return $this->fetch($a,'first');
	}
	
	function all($a = null) {
		return $this->fetch($a,'all');
	}
	
	function fetch($a = null, $method = 'all') {
		
		if (is_array($a)) {
			$this->_a = $a;
		}

		extract($this->_parse());
		
		# get it
		$sql = "SELECT ".$fields." ".$from." ".$join." ".$where." ".$group." ".$having." ".$order." ".";"; // .$limit
		
		# if count
		if (isset($this->_a['count'])) {

			# execute
			$result = Db::Instance()->query($sql);
			if ($result) {
				
				self::$_cached_results [md5($sql)]= $result;

				# count and RETURN
				return $result->num_rows();

			} else {
				return 0;
			}

        } else {
        	
        	$cache_key = md5($sql);
        	
        	if (isset(self::$_cached_results[$cache_key])) {
        		$result = self::$_cached_results[$cache_key];
        	} else {
        		$result = Db::Instance()->query($sql);
        	}
        	
        	if ($result) {

		        if (isset($this->_a['fetch_array']) && $this->_a['fetch_array']) {
	
					$offset = 0;
		        	$on_page = -1;
		        	
		        	if ($limit) {
		        		if (strpos($limit,',') === false) {
		        			$on_page = (int) $limit;
		        		} else {
			        		list($offset, $on_page) = explode(',',$limit);
			        		$offset = (int) $offset;
			        		$on_page = (int) $on_page;
			        		$result -> data_seek($offset);
		        		}
		        	}
		        	
		        	$i = 1;
		       		while ($row = $result -> fetch_assoc()) {
		        		$objects []= $row;
		        		$i++;
		        		if ($on_page > 0 && $i > $on_page) {
		        			break;
		        		}
		        	}
		        	
				} else {
		        	
					$offset = 0;
		        	$on_page = -1;

		        	if ($limit) {
		        		if (strpos($limit,',') === false) {
		        			$on_page = $limit ;
		        		} else {
			        		list($offset, $on_page) = explode(',',$limit);
			        		$offset = (int) $offset;
			        		$on_page = (int) $on_page;
			        		$result -> data_seek($offset);
		        		}
		        	}
		        	
		        	$i = 1;
		       		while ($row = $result -> fetch_assoc()) {
		        		$rows []= $row;
		        		$i++;
		        		if ($on_page > 0 && $i > $on_page) {
		        			break;
		        		}
		        	}
	
			        $class_name = 'Model_'.$this->_o->_class_name;
			        
					if ($rows) {
			            foreach ($rows as $data) {
							$_new_o = clone $this->_o;
							$_new_o->_extractData($data,true);
							$objects []= $_new_o;
			            }
					}
		        }
        	}
        }

		switch ($method) {
			case 'first':
				return $objects[0];
			case 'last':
				return $objects[sizeof($objects)];
			case 'all':
			default:
				return $objects;
		}
		
	}
	
	public function getQueryParsed($a = array()) {
		if (is_array($a)) {
			$this->_a = $a;
		}
		return $this->_parse();
	}
	
	private function _parse() {
		
		$a = array();

        if (isset($this->_a['count']) && intval($this->_a['count']) == 1) {
           $this->_a['fields'] = array($this->_o->_class_name => array($this->_o->_getObjectIdField($this->_o->_class_name)));
           $a['all_fields'] = false;
        } else {
            $a['all_fields'] = (bool) (isset($this->_a['all_fields'])) ? $this->_a['all_fields'] : true;
        }
        
        $a['fields'] = $this->_collectOptionsFields($this->_a['fields'], $a['all_fields']);

        $a['from'] = '';
        $a['join'] = '';
        
		foreach ($this->_o->_objects as $k => $object) {
			# if it is real and exists in database
			if (!isset($this->_o->_not_real[$object]) || !$this->_o->_not_real[$object]) {
				# table id field
				$id_field = $this->_o->_getObjectIdField($object);
				# join conditions if there is some relations
				if ($this->_o->_recursive) {
					$on = array();
					if (isset($this->_o->_relations[$object])) {
						$relations = $this->_o->_relations[$object];
						$relations_conditions = $this->_o->_relations_conditions[$object];
						
						if (isset($relations['hasObject'])) {
							foreach($relations['hasObject'] as $rel_obj => $rel_field) {

								$cond = '';
								
								if ($rel_field) {
									if (strpos($rel_field,'.')) {
										list ($_object, $_field) = explode('.',$rel_field);  
									} else {
										$_object = $rel_obj;
										$_field = $rel_field;
									}
									$cond = "`".$_object."`.`".$_field."` = ".Generic_Object::GetFieldFullName($id_field, $object);
								}
								
								$and_cond = $relations_conditions['hasObject'][$rel_obj];
								if ($cond) {
									$cond .= $and_cond ? (' AND '.$and_cond) : '';
								} else {
									$cond = $and_cond;
								}
								
								$a['join'] .= " LEFT JOIN `".Generic_Object::GetTableNameByObject($rel_obj)."` AS `".$rel_obj."`
									ON ".$cond;
							}
						}
						
						if (isset($relations['belongsToObject'])) {
							foreach($relations['belongsToObject'] as $rel_obj => $rel_field) {

								$cond = '';
								
								if ($rel_field) {
									if (strpos($rel_field,'.')) {
										list ($_object, $_field) = explode('.',$rel_field);  
									} else {
										$_object = $object;
										$_field = $rel_field;
									}
									$cond = "`".$rel_obj."`.`".$this->_o->_getObjectIdField($rel_obj)."` = ".Generic_Object::GetFieldFullName($_field, $_object);
								}

								$and_cond = $relations_conditions['belongsToObject'][$rel_obj];
								if ($cond) {
									$cond .= $and_cond ? (' AND '.$and_cond) : '';
								} else {
									$cond = $and_cond;
								}

								$a['join'] .= " LEFT JOIN `".Generic_Object::GetTableNameByObject($rel_obj)."` AS `".$rel_obj."`
									ON ".$cond;
							}
						}
					}
				}
				# from
				if ($k == 0) {
					$a['from'] .= "FROM `".Generic_Object::GetTableNameByObject($object)."` AS `".$object."`";
                    if (!$this->_o->_recursive) {
                        break;
                    }
				}
			}
		}
		
		if ($this->_a['where_permanent_and']) {
			if ($this->_a['where']) {
				$this->_a['where'] .= ' AND ' . $this->_a['where_permanent_and'];
			} else {
				$this->_a['where'] .= $this->_a['where_permanent_and'];
			}
		}
		
		$a['join'] .= isset($this->_a['join']) ? $this->_a['join'] : '';
        $a['group'] = !empty($this->_a['group']) ? ' GROUP BY '.$this->_a['group'] : '';
		$a['order'] = !empty($this->_a['order']) ? ' ORDER BY '.$this->_a['order'] : '';
		$a['having'] = !empty($this->_a['having']) ? ' HAVING '.$this->_a['having'] : '';
        //$a['limit'] = !empty($this->_a['limit']) ? ' LIMIT '.$this->_a['limit'] : '';
        $a['limit'] = $this->_a['limit'];
		$a['where'] = !empty($this->_a['where']) ? ' WHERE '.$this->_a['where'] : '';

		return $a;
	}
	
	private function _collectOptionsFields($fields, $all_fields = null) {
        $return = '';
        if (is_null($all_fields)) {
            $all_fields = true;
        }
        if (is_array($fields)) {
            # if $fields = array($object => $field(s))
            foreach ($fields as $object => $field) {

                # if $field = array($field_name)
                if (is_array($field)) {
                    foreach ($field as $field_name) {
                        $return .= ', `'.$object.'`.`'.$field_name.'` AS `'.$object.'.'.$field_name.'`';
                    }
                # if $field = field_name
                } else {
                    $return .= ', `'.$object.'`.`'.$field.'` AS `'.$object.'.'.$field.'`';
                }
            }
        } elseif (!empty($fields)) {
            $return .= ', '.$fields;
        }

        # default fields
        if ($all_fields) {
            foreach ($this->_o->_objects as $k => $object) {
                if ((!isset($this->_o->_not_real[$object]) || !$this->_o->_not_real[$object])
                	&& !isset($this->_o->_dont_get_fields[$object])) {

                    $fields = $this->_o->_getObjectFields($object);
                    if ($fields) {
                        foreach ($fields as $desc) {
                            $return .= ', `'.$object.'`.`'.$desc.'` AS `'.$object.'.'.$desc.'`';
                        }
                    }
                }
                if (!$this->_o->_recursive) {
                    break;
                }
            }
        }
        
        # remove first ', '
        $return = substr($return, 2);

        return $return;
    }
}