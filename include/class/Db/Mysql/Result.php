<?php

class Db_Mysql_Result {
	
	private $result;
	
	public function __construct($result) {
		$this->result = $result;
	}
	
	public function fetch_assoc() {
		return mysql_fetch_assoc($this->result);
	}
	
	public function fetch_array() {
		return mysql_fetch_array($this->result);
	}
	
	public function fetch_row() {
		return mysql_fetch_row($this->result);
	}
	
	public function num_rows() {
		return mysql_num_rows($this->result);
	}
	
	public function close() {
		return mysql_free_result($this->result);
	}
	
	public function data_seek($offset) {
		return mysql_data_seek($this->result, $offset);
	}
}