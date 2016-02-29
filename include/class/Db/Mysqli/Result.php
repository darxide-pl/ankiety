<?php

class Db_Mysqli_Result {
	
	private $result;
	
	public $num_rows;
	
	public function __construct($result) {
		$this->result = $result;
		if (is_object($result)) {
			$this->num_rows = $result->num_rows;
		}
	}
	
	public function fetch_assoc() {
		return $this->result->fetch_assoc();
	}
	
	public function fetch_array() {
		return $this->result->fetch_array();
	}
	
	public function fetch_row() {
		return $this->result->fetch_row();
	}
	
	public function num_rows() {
		return $this->num_rows;
	}
	
	public function close() {
		return $this->result->close();
	}
	
	public function data_seek($offset) {
		return $this->result->data_seek($offset);
	}
}