<?php

class Module_Search extends Modules_Handler {
	public function __construct() {
		parent::__construct();
	}
	
	public function all() {
		
		$query = $this->db->quote(trim($this->rv->get('query')));
		
		$sql = "(SELECT c.`id`, 'customer' AS `type`, c.`company_name` AS `label` FROM `customer` c WHERE c.`company_name` LIKE '%".$query."%' "
			. "OR c.`represented_by` LIKE '%".$query."%' "
			. "OR c.`nip` LIKE '%".$query."%' "
			. "OR c.`email` LIKE '%".$query."%' "
			. "OR c.`phone` LIKE '%".$query."%'"
			. "OR c.`address_street` LIKE '%".$query."%') UNION"
			. "(SELECT r.`id`, 'report' AS `type`, r.`title` AS `label` FROM `report` r WHERE r.`title` LIKE '%".$query."%')";
		
		$sql = "SELECT x.* FROM (".$sql.") AS x";
		
		$results = $this->db->FetchRecords_Assoc($sql,DB_FETCH_ARRAY);
		
		die(json_encode($results));
	}
	
	public function attributes() {
		
		$query = $this->db->quote(trim($this->rv->get('query')));
		
		$sql = "SELECT a.`value` AS `label` FROM `product_attribute` a WHERE a.`value` LIKE '%".$query."%' AND a.`attribute_id` = ".(int)$this->rv->get('attribute_id')." AND a.`value` != '' GROUP BY `value` ORDER BY `value` ASC;";
		
		$results = $this->db->FetchRecords_Assoc($sql,DB_FETCH_ARRAY);
		
		die(json_encode($results));
	}
	
	public function pages() {
		
		$query = $this->db->quote(trim($this->rv->get('query')));
		
		$sql = "SELECT `id`, CONCAT(a.`title`,' - ',a.`id`) AS `label` FROM `page` a WHERE a.`title` LIKE '%".$query."%' ORDER BY `title` ASC;";
		
		$results = $this->db->all($sql,DB_FETCH_ARRAY);
		
		die(json_encode($results));
	}
}