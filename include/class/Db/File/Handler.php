<?php

class Db_File_Handler extends File {
	
	protected $_db_real_file_name;
	protected $_db_file_id;
	protected $_db_file_size;
	protected $_db_file_add_date;
	protected $_db_dir;
	
	/**
	 * 
	 * @param (int) $file_id
	 * @param (string) $dir
	 */
	function __construct($file_id, $dir) {

		$db = Db::Instance();
		
		$this->_db_dir = $dir;
		$sql = "SELECT * FROM `file` WHERE `id` = ".(int)$file_id.";";
		$result = $db->query($sql);
		if ($result && $result->num_rows == 1) {
			$file = $result->fetch_assoc();
			$this->_db_real_file_name = f_clear_file_name($file['original_name']);
			$this->_db_file_id = (int)$file_id;
			$this->_db_file_size = $file['size'];
			$this->_db_file_add_date = $file['add_date'];
		} else {
			return false;
		}
		return parent::__construct($dir . $file['name']);
	}
	
	function GetAddDate() {
		return $this->_db_file_add_date;
	}
	
	function GetRealFileName() {
		if (empty($this->_db_real_file_name)) {
			return $this->_file_name;
		}
		return $this->_db_real_file_name;
	}
}