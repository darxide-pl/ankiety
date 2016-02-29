<?php

/**
 * Get fields to array
 */
define('DB_FETCH_ARRAY', 0);
/**
 * Get fields to assoc array first field is a key 
 */
define('DB_FETCH_ASSOC', 1);
/**
 * Get first field as key and second field as value
 */
define('DB_FETCH_ASSOC_FIELD', 2);
/**
 * Get first field
 */
define('DB_FETCH_ARRAY_FIELD', 3);

abstract class Db {

	public $db; // object
	public $queries = 0;
	public $insert_id = 0;

	protected static $_debug = false;

	protected static $_Instance;
	
	public $_queries_sql = array();
	public $_error = false;
	
	protected $_data;
	
	protected static $_throw_exceptions = true;
	
	protected $_connected = false;

	public function __construct($data) {
		
		$this->_data = $data;

		if (!$this->Connect()) {
			
			if (self::$_throw_exceptions == true) {
				throw new Exception('Error: When connecting to database. ('.$this->ConnectError().')');
			}
		}

		$this->SetCharset();

	}
	
	public function GetData($param_name) {
		return isset($this->_data[$param_name]) ? $this->_data[$param_name] : null;
	}
	
	public static function ThrowExceptions($bool) {
		self::$_throw_exceptions = (bool)$bool;
	}
	
	public static function isInitialized() {
		return (bool)sizeof(self::$_Instance);
	}
	
	/**
	 * Get instance of first DB object,
	 * instead of creating another new.
	 * 
	 * @return new DB or pointer
	 */
	static function Instance($data = null, $connection_name = 'default') {

		if (is_null($data)) {
			
			$data = array(
				'host' => DB_HOST,
				'user' => DB_USER,
				'password' => DB_PASSWORD,
				'database' => DB_NAME,
				'protocol' => DB_PROTOCOL
			);
			
		}
		
		if (!isset(self::$_Instance[$connection_name])) {
			switch($data['protocol']) {
				case 'mysqli':
					self::$_Instance[$connection_name] = new Db_Mysqli_Protocol($data);
					break;
				case 'mysql':
					self::$_Instance[$connection_name] = new Db_Mysql_Protocol($data);
					break;
			}
		}
		return self::$_Instance[$connection_name];
	}
	
	static function Debug($flag) {
		self::$_debug = (bool) $flag; 
	}
	
	function GetLastQuery() {
		return $this->_queries_sql[sizeof($this->_queries_sql)-1]['sql'];
	}

	function first($sql,$type = 0) {
		
		$result = $this->db->query($sql);
		
		if ($result) {
			
			$row = $result->fetch_assoc();
			$result->close();
			
			if ($row === false) {
				return null;
			}
			switch ($type) {
				case 0: return $row;
				case 1: return array(current($row)=>$row);
				case 2: return array(current($row)=>next($row));
				case 3: return current($row);
			}
		}
		
		return false;
	}
	
	function all($sql, $type = 0) {
		
		$result = $this->query($sql);
		
		if ($result) {
			
			$rows = array();
			
			while ($row = $result->fetch_assoc()) {
				switch ($type) {
					case 0: $rows []= $row;  break;
					case 1: $rows [current($row)]= $row; break;
					case 2: $rows [current($row)]= next($row); break;
					case 3: $rows []= current($row); break;
				}
			}
			
			$result->close();
			
			return $rows;
		}
		return false;
	}
	
	function FetchRecord($sql, $assoc_type = 0, $class_name = null, $sign = null) {
		
		$result = $this->query($sql, $sign);

		if ($result) {
			$row = $result->fetch_array();
			if (!$result->num_rows()) return null;
			$result->close();
			if ($class_name && class_exists($class_name)) {
				switch ($assoc_type) {
					case 0: $r = new $class_name($row); break;
					case 1: $r = array($row[0], new $class_name($row)); break;
				}
			} else {
				switch ($assoc_type) {
					case 0: $r = $row; break;
					case 1: $r = array($row[0],$row); break;
					case 2: $r = array($row[0],$row[1]); break;
					case 3: $r = $row[0]; break;
				}
			}
			if (!empty($r)) {
				return $r;
			}
		}
		return false;
	}
	
	function FetchRecords($sql, $assoc_type = 0, $class_name = null, $sign = null) {
		
		$result = $this->query($sql, $sign);
		if ($result) {
			$rows = array();
			while ($row = $result->fetch_array()) {
				if ($class_name && class_exists($class_name)) {
					switch ($assoc_type) {
						case 0: $rows []= new $class_name($row); break;
						case 1: $rows [$row[0]]= new $class_name($row); break;
					}
				} else {
					switch ($assoc_type) {
						case 0: $rows []= $row;  break;
						case 1: $rows [$row[0]]= $row; break;
						case 2: $rows [$row[0]]= $row[1]; break;
						case 3: $rows []= $row[0]; break;
					}
				}
			}
			$result->close();
			return $rows;
		}
		return false;
	}
	
	function FetchRecords_Assoc($sql, $assoc_type = 0, $class_name = null, $sign = null) {
		
		$result = $this->query($sql, $sign);
		if ($result) {
			$rows = array();
			while ($row = $result->fetch_assoc()) {
				if ($class_name && class_exists($class_name)) {
					switch ($assoc_type) {
						case 0: $rows []= new $class_name($row); break;
						case 1: $rows [current($row)]= new $class_name($row); break;
					}
				} else {
					switch ($assoc_type) {
						case 0: $rows []= $row;  break;
						case 1: $rows [current($row)]= $row; break;
						case 2: $rows [current($row)]= $row[1]; break;
						case 3: $rows []= current($row); break;
					}
				}
			}
			$result->close();
			return $rows;
		}
		return false;
	}
	

	function Update($t, $a, $w, $comment = null) {
		if (!is_array($a) && !sizeof($a)) throw new Exception('Nie podano atrybutów do zapisania.');
		if (empty($t)) throw new Exception('Nie podano nazwy tabeli.');
		if (empty($w)) throw new Exception('Nie podano warunków zapytania.');
		$s = '';
		foreach ($a as $k => $v) {
			$s .= ', `'.$k.'` = ';
			$s .= $v === 'NULL' ? 'NULL' : '\''.$this->quote($v).'\'';
		}
		return $this->query("UPDATE `".$t."` SET ".substr($s,2)." WHERE ".$w, $comment);
	}
	
	function Insert($t, $a, $comment = null) {
		if (!is_array($a) && !sizeof($a)) throw new Exception('Nie podano atrybutów do zapisania.');
		if (empty($t)) throw new Exception('Nie podano nazwy tabeli.');
		$s = '';
		$s2 = '';
		foreach ($a as $k => $v) {
			$s .= ',';
			$s .= is_null($v) ? 'NULL' : '\''.$this->quote($v).'\'';
			$s2 .= ',`'.$k.'`';
		}
		
		$sql = "INSERT INTO `".$t."` (".substr($s2,1).") VALUES (".substr($s,1).")";
		$result = $this->query($sql, $comment);
		
		return $result ? (int)$this->insert_id : false;
	}
	
	function Replace($t, $a, $comment = null) {
		if (!is_array($a) && !sizeof($a)) throw new Exception('Nie podano atrybutów do zapisania.');
		if (empty($t)) throw new Exception('Nie podano nazwy tabeli.');
		$s = '';
		$s2 = '';
		foreach ($a as $k => $v) {
			$s .= ',';
			$s .= is_null($v) ? 'NULL' : '\''.$this->quote($v).'\'';
			$s2 .= ',`'.$k.'`';
		}
		$sql = "REPLACE INTO `".$t."` (".substr($s2,1).") VALUES (".substr($s,1).")";
		return $this->query($sql, $comment);
	}
}