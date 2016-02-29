<?php

class SystemActionsVarsFactory {

	const TABLE = 'system_action_var';
	const ID_FIELD = 'var_id';
	const OBJECT = 'SystemActionVar';

	static function GetByActionID($action_id, $order_by = '') {
		$sql = "SELECT * FROM `".self::TABLE."` WHERE `action_id` = ".(int)$action_id." ".$order_by.";";
		return Db::Instance()->FetchRecords($sql, DB_FETCH_ARRAY, self::OBJECT);
	}
}