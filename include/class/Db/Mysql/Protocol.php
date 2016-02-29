<?php

class Db_Mysql_Protocol extends Db {
	
	public function Connect() {
		
		@$this->db = mysql_connect(
			$this->_data['host'],
			$this->_data['user'],
			$this->_data['password']
		);

		if ($this->ConnectError()) {
			return false;
		}

		$this->SelectDatabase($this->_data['database']);
		
		$this->_connected = true;
		
		return true;
	}
	
	public function Close() {
		
		if ($this->_connected) {
			@$this->db->close();
		}
		$this->_connected = false;
		
		return true;
	}
	
	public function SelectDatabase($database) {
		mysql_select_db($database);
	}
	
	public function SetCharset($charset = 'utf8',$collation = 'utf8_general_ci') {
		
		$sql = "SET NAMES '".$charset."' COLLATE '".$collation."';";
		$this->query($sql);
		
		$sql = "SET CHARSET SET '".$charset."';";
		$this->query($sql);
	}
	
	public function ConnectError() {
		return mysql_error();
	}
	
	public function ConnectErrno() {
		return mysql_errno();
	}
	
	public function Error() {
		return mysql_error($this->db);
	}
	
	public function Errno() {
		return mysql_errno($this->db);
	}
	
	public function InsertID() {
		return mysql_insert_id($this->db);
	}
	
	function query($sql, $sign = '') {
		
		if ($this->_connected == false) return false;
		
		if (self::$_debug == true) {
			$time_from = f_microtime_float();
		}
		
		$result = mysql_query($sql, $this->db);

		if (self::$_debug == true) {
			$time_to = f_microtime_float();
			$time = $time_to - $time_from;
			
			$this->_queries_sql []= array('sql' => $sql, 'error' => !$result, 'errno' => $this->Errno(), 'time' => $time, 'affected_rows' => $this->AffectedRows(), 'sign' => $sign);
			
			if (!$result) {
				$this->_error = true;
				LoggerDb::write($sign, $sql, $this->Errno(), $time);
			}
			
			$this->queries++;
		}

		$this->insert_id = $this->InsertID();
		return new Db_Mysql_Result($result);
	}
	
	function AffectedRows() {
		return mysql_affected_rows($this->db);
	}

	function beginTransaction() {
		$sql = "BEGIN;";
		$result = $this->query($sql);
	}
	
	function rollbackTransaction() {
		$sql = "ROLLBACK;";
		$result = $this->query($sql);
	}
	
	function commitTransaction() {
		$sql = "COMMIT;";
		$result = $this->query($sql);
	}
}