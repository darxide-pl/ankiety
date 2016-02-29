<?php

class Bootstrap extends Core {
	

	public static $pages;
	public static $page_current = array();
	
	public function __construct() {
		parent::__construct();
	}
	
	public function init() {
		$this->_load_pages();
	}
	
	private function _load_pages() {
		
		$sql = "SELECT * FROM `page` WHERE `publish` = 1 AND `homepage` = 0 ORDER BY `pos` ASC;";
		$result = $this->db->query($sql);
		
		self::$pages = array();
		
		if ($result) {
			while ($row = $result->fetch_assoc()) {
				self::$pages [(int)$row['group_id']] [(int)$row['parent_id']] []= $row;
			}
		}
	}
}