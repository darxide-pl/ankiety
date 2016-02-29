<?php

class ModulesMultiListHandler extends ModulesListHandler {
	
	# amounts of separeted each objects
	protected $_amounts = array();
	
	function __construct($module, $name = null, $order_attributes = array(), $conditions = null, $filters = null, $options = array()) {
		parent::__construct($module, $name, $order_attributes, $conditions, $filters, $options);
	}
	
	function GetAmount($object = null) {
		if ($object) {
			return $this->_amounts[$object];
		}
		
		return parent::GetAmount();
	}
	
	function parseConditions($array_of_conditions) {
		
		$methods = array('number' => 'addNumber', 'string' => 'addString', 'multistring' => 'addMultiString', 'date' => 'addDate');
		
		if (!is_array($this->conditions)) {
			$this->conditions = array();
		}
		
		if (is_array($array_of_conditions) && sizeof($array_of_conditions)) {
			foreach ($array_of_conditions as $classname => $conditions) {
				if (!isset($this->conditions[$classname]) || !$this->conditions[$classname] instanceof ModulesConditions) {
					$this->conditions[$classname] = new ModulesConditions();
				}
				
				if (is_array($conditions) && sizeof($conditions)) {
					foreach ($conditions as $k => $v) {
						
						if (!isset($v['type'])) {
							$v['type'] = null;
						}
						
						if (!isset($v['default'])) {
							$v['default'] = null;
						}
						
						if (!isset($v['values'])) {
							$v['values'] = null;
						}
						
						if (!isset($v['operator'])) {
							$v['operator'] = null;
						}
						
						if (isset($this->_data['filters'][$k])) {
							$data = $this->_data['filters'][$k];
						} else {
							$data = null;
						}
						
						if ($data == null && $v['default'] != null) {
							$data = $v['default'];
						}
						
						$v['value'] = $v['values'] ? (isset($v['values'][$data]) ? $v['values'][$data] : '') : $v['value'];
						
						if (isset($methods[$v['type']])) {
							$this->conditions[$classname]->{$methods[$v['type']]}($data, $v['value'], $v['operator']);
						} elseif ($v['type'] == 'if') {
							$this->conditions[$classname]->addIf($data, $v['true'], $v['false']);
						} else {
							if ($data == null && $v['default'] != null) {
								$v['value'] = $v['default'];
							}
							$v['value'] = $v['values'] ? $v['values'][$data] : $v['value'];
							$this->conditions[$classname]->add($v['value']);
						}
					}
				}
			}
		}
	}
	
	function populate($classnames, $list_foot = true, $cols = null, $on_page = null) {
		
		# generate sql conditions
		if (is_array($this->conditions) && sizeof($this->conditions)) {
			foreach ($this->conditions as $classname => $cond) {
				$options[$classname] = $cond->getToString();
			}
		}
		
		if ($on_page) {
			$this->_data['on_page'] = $on_page;
		} else {
			$this->_data['on_page'] = $this->_default_on_page;
		}
		
		$objects = array();

		# count amounts
		if (!empty($classnames)) {

			if (!is_array($this->_amounts)) {
				$this->_amounts = array();
			}

			if (is_array($classnames) && sizeof($classnames)) {
				foreach ($classnames as $classname) {

					if (is_object($classname)) {
						$object = $classname;
						$classname = get_class($object);
					} else {
						$object = new $classname;
					}

					$objects[$classname] = $object;
					
					$count_options = $options[$classname];
					$count_options['count'] = true;

					$this->_amounts[$classname] = Method::call(array($object, 'find'), array($count_options));
				}
			}
		}
		
		$this->_amount = array_sum($this->_amounts);
		
		if ($this->_amount) {
			
			$this->_pages = ceil($this->_amount / $this->_data['on_page']); 
			
			if ($this->_data['page_nr'] < 1) {
				$this->_data['page_nr'] = 1;
			}
			
			if ($this->_data['page_nr'] > $this->_pages) {
				$this->_data['page_nr'] = $this->_pages;
			}
			
			$this->_offset = ( $this->_data['page_nr'] - 1 ) * $this->_data['on_page'];
		
			if ( $this->_amount > $this->_offset + $this->_data['on_page'] ) { # not last
				$this->_actual_on_page = $this->_data['on_page'];
			} else if ( $this->_offset > 0 ) { # last
				$this->_actual_on_page = $this->_amount % $this->_offset;
			} else { # first
				$this->_actual_on_page = $this->_amount;
			}
			
			$left_on_page = $this->_data['on_page'];
			$offset = $this->_offset;
			$sum_amount = 0;
			$single_offset = $offset;
			
			foreach ($this->_amounts as $classname => $amount) {
				if ($left_on_page > 0) {
					$sum_amount += $amount;
					if ($sum_amount > $offset) {
						$get_options = $options[$classname];
						$get_options['order'] = $this->_buildSortDirection($classname);
						$get_options['limit'] = $single_offset.", ".$left_on_page;
						$rows = Method::call(array($objects[$classname], 'find'), array($get_options));
						if (sizeof($rows)) {
							$this->_rows = array_merge($this->_rows, $rows);
							$left_on_page -= sizeof($rows);
							$offset += sizeof($rows);
							$single_offset = 0;
						}
					} else {
						$single_offset -= $amount; 
					}
				}
			}
			
			return $this->_rows;
		}
		
		return false;
	}
	
	protected function _buildSortDirection($classname) {

		if (!empty($this->_data['order_by'])) {
			$order_by = $this->_data['order_by'];
			$order_dir = $this->_data['order_dir'];
		} else {
			$order_by = $this->_default_order_by;
			$order_dir = $this->_default_order_dir;
		}
		
		$order_by = explode(',', $order_by);
		
		if (is_array($order_by) && sizeof($order_by)) {
			$s = '';
			foreach ($order_by as $v) {
				if ($this->_checkOrderBy($v, $classname)) {
					$s .= ', '.$this->_getOrderBy($v, $classname).' '.($order_dir ? 'DESC' : 'ASC');
				}
			}
			if (!empty($s)) {
				$s = substr($s,2);
			}
		}

		return $s;
	}
	
	protected function _getOrderBy($key, $classname) {
		return $this->_order_attributes[$key][$classname];
	}

	protected function _checkOrderBy($key, $classname) {
		if (!empty($key)) {
			if (array_key_exists($key, $this->_order_attributes)) {
				if (array_key_exists($classname, $this->_order_attributes[$key])) {
					return true;
				}
			}
		}
		return false;
	}
}

?>