<?php

class SystemActionsFactory {

	const TABLE = 'system_action';
	const ID_FIELD = 'id';
	const OBJECT = 'SystemAction';

	static function GetToOptionsList($order_by = "sa.`name` ASC") {
		if ($order_by) {
			$order_by = " ORDER BY ".$order_by;
		}
		$sql = "SELECT sa.`".self::ID_FIELD."`, sa.`name` FROM `".self::TABLE."` sa ".$order_by.";";
		return Db::Instance()->FetchRecords($sql, DB_FETCH_ASSOC_FIELD);
	}

	static function GetNotAssignedToAssoc($selected = 0) {
		if ($selected) {
			$sql_where .= " OR sa.`id` = ".(int)$selected;
		} else $sql_where = "";
		$sql = "SELECT sa.`".self::ID_FIELD."`, sa.`name` FROM `".self::TABLE."` sa LEFT JOIN `system_message` sm ".
			"ON sm.`action_id` = sa.`id` WHERE sm.`id` IS NULL ".$sql_where." ORDER BY sa.`name` ASC;";
		return Db::Instance()->FetchRecords($sql, DB_FETCH_ASSOC_FIELD);
	}
}
