<?php

class Db_Mysqli_Protocol extends Db {
	
	public function Connect() {
		$this->db = mysqli_init();
		
		$_isConnected = mysqli_real_connect(
			$this->db,
			$this->_data['host'],
			$this->_data['user'],
			$this->_data['password'],
			$this->_data['database']
		);

		if ($_isConnected === false || $this->ConnectError()) {
			return false;
		}
		
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
	
	public function SetCharset($charset = 'utf8', $collation = 'utf8_unicode_ci') {
		
		$this->db->set_charset($charset);
	}
	
	public function ConnectError() {
		return $this->db->connect_error;
	}
	
	public function ConnectErrno() {
		return $this->db->connect_errno;
	}
	
	public function Error() {
		return $this->db->error;
	}
	
	public function Errno() {
		return $this->db->errno;
	}
	
	public function InsertID() {
		return $this->db->insert_id;
	}
	
	public function quote($string,$characters_to_slash = array()) {
		
		# escape string to use it on statements
		$string = $this->db->real_escape_string($string);
		
		# addslashes to defined characters
		if ($characters_to_slash && is_array($characters_to_slash)) {
			foreach ($characters_to_slash as $char) {
				$string = str_replace($char,'\\'.$char,$string);
			}
		}
		
		return $string;
	}
	
	function query($sql, $sign = '') {
		
		if ($this->_connected == false) return false;
		
		if (self::$_debug == true) {
			$time_from = f_microtime_float();
		}
		
		$result = $this->db->query($sql);

		if (self::$_debug == true) {
			
			$time_to = f_microtime_float();
			$time = $time_to - $time_from;
			
			$this->_queries_sql []= array('sql' => $sql, 'error' => !$result, 'errno' => $this->Errno(), 'time' => $time, 'affected_rows' => $this->AffectedRows(), 'sign' => $sign);
			
			$this->queries++;
		}
		
		if (!$result) {
			$this->_error = true;
			LoggerDb::write($sign, $sql, $this->Errno(), $time);
		}

		$this->insert_id = $this->InsertID();
		
		if ($result) {
			return new Db_Mysqli_Result($result);
		} else {
			return false;
		}
	}
	
	function AffectedRows() {
		return $this->db->affected_rows;
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