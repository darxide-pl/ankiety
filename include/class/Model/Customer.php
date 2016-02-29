<?php

class Model_Customer extends Generic_Object {
	
	private $subscriptions = array(
		'0' => 'Pakiet 1 - Abonament NO LIMIT',
		'1' => 'Pakiet 2 - Abonament z limitem godzin',
		'2' => 'Pakiet 3 - Rozliczenie czasowe'
	);
	
	public function get_subscription_name() {
		return $this->subscriptions[$this->get('subscription')];
	}
	
	public function get_subscription_details() {
		
		$sql = "SELECT COUNT(*) AS `tasks`, SUM(TIME_TO_SEC(TIMEDIFF(t.`end`, t.`start`))) AS `time` FROM `report_task` t 
			LEFT JOIN `report` r ON r.`id` = t.`report_id` 
			WHERE r.`customer_id` = ".(int)$this->get('id')." 
			AND t.`end` > 0 AND t.`start` > 0 
			AND YEAR(t.`add_date`) = '".(int)date('Y')."' 
			AND MONTH(t.`add_date`) = '".(int)date('m')."';";
		$data = Db::Instance()->first($sql);
		
		$details = array(
			'limit_passed' => false,
			'used' => 0, // hours used
			'packets' => 0, // packets used
			'time' => $data['time'], // seconds
			'tasks' => $data['tasks'], // tasks count
		);
		
		if ($this->get('subscription') > 0) {
			
			$interval = $this->get('subscription_interval') * 60; // minutes to seconds
			
			// find user tasks 
			$sql = "SELECT SUM(CEIL(TIME_TO_SEC(TIMEDIFF(t.`end`, t.`start`))/".(int)$interval.")) 
				FROM `report_task` t 
				LEFT JOIN `report` r ON r.`id` = t.`report_id` 
				WHERE r.`customer_id` = ".(int)$this->get('id')." 
				AND t.`end` > 0 AND t.`start` > 0 
				AND YEAR(t.`add_date`) = '".(int)date('Y')."' 
				AND MONTH(t.`add_date`) = '".(int)date('m')."';";
			
			$details['packets'] = Db::Instance()->first($sql,DB_FETCH_ARRAY_FIELD);
			
			// used hours
			$details['used'] = round($details['packets'] * $this->get('subscription_interval') / 60, 2);
		}
		
		if ($this->get('subscription') == 1) {
			
			if ($details['used'] > $this->get('subscription_limit')) {
				$details['limit_passed'] = true;
			}
		}
		
		return $details;
	}
}