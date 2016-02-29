<?php

class Model_System_Lock extends Generic_Object {
	
	/**
	 * How much time object will be hold after edit ends to be realised.
	 * (seconds)
	 */
	const LOCK_PERIOD = 10;
	
	/**
	 * How often check lock status.
	 * (seconds)
	 */
	const LOCK_RATE = 5;
	
	public static function Clear() {
		return Db::Instance()->query("DELETE FROM `system_lock` WHERE `timestamp` < '".date('Y-m-d H:i:s',time()-self::LOCK_PERIOD)."'");
	}
	
	/**
	 * 
	 * @param type $user_id
	 * @param type $type
	 * @param type $object_id
	 * @return boolean
	 */
	public static function Lock($user_id, $type, $object_id) {
		
		$db = Db::Instance();
		
		// find existing blockade
		$sql = "SELECT * FROM `system_lock` WHERE `type` = '".$db->quote($type)."' AND `object_id` = ".(int)$object_id." AND `timestamp` > '".date('Y-m-d H:i:s',time()-self::LOCK_PERIOD)."';";
		$lock = $db->FetchRecord($sql);
		
		if ($lock) {
			if ($lock['user_id'] != $user_id) {
				return -1;
			} else {
				$db->query("UPDATE `system_lock` SET `timestamp` = NOW() WHERE `id` = ".(int)$lock['id'].";");
			}
		} else {
			$db->Insert('system_lock',array(
				'user_id' => $user_id,
				'type' => $type,
				'object_id' => $object_id
			));
		}
		
		return true;
	}
	
	public static function Check_Locks($type,$objects) {
		
		$db = Db::Instance();
		
		$locks = array();
		
		if ($objects) {
	
			$sql = "SELECT l.`object_id`, l.`id`, l.`user_id`, CONCAT(u.`name`,' ',u.`lastname`) AS `username`
				FROM `system_lock` l
				LEFT JOIN `user` u ON u.`id` = l.`user_id`
				WHERE l.`type` = '".$db->quote($type)."'
					AND l.`object_id` IN (".implode(',',$objects).")
					AND l.`timestamp` > '".date('Y-m-d H:i:s',time()-self::LOCK_PERIOD)."';";

			$locks = $db->FetchRecords($sql, DB_FETCH_ASSOC);
			
			foreach ($objects as $object_id) {
				if (!isset($locks[$object_id])) {
					$locks[$object_id] = 0;
				} else {
					$locks[$object_id] = $locks[$object_id]['username'];
				}
			}
		}

		return $locks;
	}
}