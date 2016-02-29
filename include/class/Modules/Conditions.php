<?php

class Modules_Conditions {

	private $_conditions = array();

	private $_options = array();

	private $_equal_operators = array('=', '>=', '<=', '<', '>');

	public function __construct($options) {
		$this->setOptions($options);
	}
	
	function dontAddWhere() {
		$this->_with_where = false;
	}

	function add($sql_string) {
		if ($sql_string) {
			$this->_conditions []= $sql_string;
		}
	}

	function addNumber($value, $sql_attr = '', $operator = null) {
		
		if ($operator) {
			$operator = in_array($operator, $this->_equal_operators) ? $operator : $this->_equal_operators[0];
		} else {
			$operator = $this->_equal_operators[0];
		}
		
		if (is_array($value)) {
			
			$_s = '';
			
			foreach ($value as $v) {
				if ($v != '') {
					$_s .= ",'".DB::Instance()->quote($v)."'";
				}
			}
			
			if ($_s) {
				$_s = substr($_s,1);

				$this->_conditions []= $sql_attr." IN (".$_s.")";
			}
			
		} else {
		
			if ($this->checkNumber($value)) {
				$this->_conditions []= $sql_attr." ".$operator." '".(int)$value."'";
			}
		}
	}
	
	function addDate($date, $sql_attr, $operator = null) {
		if ($operator) {
			$operator = in_array($operator, $this->_equal_operators) ? $operator : $this->_equal_operators[0];
		} else {
			$operator = $this->_equal_operators[0];
		}

		if (is_array($date)) {
			$date = $date['year'].'-'.$date['month'].'-'.$date['day'];
		}

		if ($this->checkDate($date)) {
			$this->_conditions []= $sql_attr . ' ' . $operator . " '" . $date . "'";
		}
	}
	
	function addDateTime($date, $sql_attr, $operator = null) {
		if ($operator) {
			$operator = in_array($operator, $this->_equal_operators) ? $operator : $this->_equal_operators[0];
		} else {
			$operator = $this->_equal_operators[0];
		}

		if (is_array($date)) {
			$date = $date['year'].'-'.$date['month'].'-'.$date['day'].' '.$date['hour'].':'.$date['minute'].':'.$date['second'];
		}

		if (!empty($date)) {
			$this->_conditions []= $sql_attr . ' ' . $operator . " '" . $date . "'";
		}
	}

	function addString($string, $sql_attr = '') {
		if ($this->checkString($string)) {
			$this->_conditions []= $sql_attr." LIKE '%".DB::Instance()->quote($string,array('%','_'))."%'";
		}
	}

	function addExpression($value, $expression) {
		if ($value) {
			if(strpos($value,'|')) {
				$value = implode('\',\'',explode('|',$value)); 
			}
			$value = '\''.$value.'\''; 
			$this->_conditions []= sprintf($expression, $value);
		}
	}
	
	function addIf($bool, $sql_true = null, $sql_false = null) {
		if ($bool && !empty($sql_true)) { 
			$this->_conditions []= $sql_true;
		} elseif (!empty($sql_false)) {
			$this->_conditions []= $sql_false;
		}
	}
	
	function addMultiString($string, $sql_attr = array(), $operator = null) {
		if (!$operator) {
			$operator = 'OR';
		}
		if (empty($string)) return false;
		if (!is_array($sql_attr) || !sizeof($sql_attr)) return false;
		if ($this->checkString($string)) {
			$parts = explode (' ', $string);
			if (is_array($parts) && count($parts)) {
				foreach ($parts AS $part) {
					$part = trim ($part);
					if (!empty($part)) {
						foreach ($sql_attr as $attr) {
							$or_condition []= $attr." LIKE '%".DB::Instance()->quote($part,array('%','_'))."%'";
						}
					}
				}
			}
			$this->_conditions []= $this->_implode($or_condition, $operator);
		}
	}

	function addMatchString($string, $sql_attr = array(), $revelation = 0.2, $operator = null) {
		
		if (empty($string)) return false;
		if (!is_array($sql_attr) || !sizeof($sql_attr)) return false;
		if ($this->checkString($string)) {
			
			$parts = explode(' ',$string);
			$string = '';
			if ($parts) {
				foreach ($parts as $part) {
					$string .= ' '.$part;
					$part_len = strlen($part);
					if ($part_len > 4) {
						if ($part_len > 5) {
							$string .= ' '.substr($part,0,$part_len-2).'*';
						}
						$string .= ' '.substr($part,0,$part_len-1).'*';
					}
				}
			}
			
			$condition = "MATCH (".implode(',',$sql_attr).") AGAINST ('".DB::Instance()->quote($string)."' in boolean mode)";
			$this->_conditions []= $condition;
		}
	}
	
	function checkNumber($value) {
		return is_numeric($value) ;
	}

	function checkDate($date) {
		return (bool) f_check_date($date);
	}

	function checkString($value) {
		return (bool) (!empty($value));
	}

	private function _implode($conditions = array(), $operator = 'AND') {
		if (!is_array($conditions) || !sizeof($conditions)) return false;
		$operator = strtoupper($operator);
		return '('.implode(' '.$operator.' ', $conditions).')';
	}

	function setOption($option, $value) {
		$this->_options[$option] = $value;
	}
	
	function setOptions($options) {
		if (is_array($options)) {
			$this->_options = f_array_merge_with_keys($this->_options,$options);
		}
	}

	function getToString($operator = 'AND') {
		if (is_array($this->_conditions) && sizeof($this->_conditions)) {
			if (isset($this->_options['where']) && $this->_options['where']) {
				$this->_options['where'] .= ' AND '.$this->_implode($this->_conditions, $operator);
			} else {
				$this->_options['where'] = $this->_implode($this->_conditions, $operator);
			}
		}
        return $this->_options;
	}

}