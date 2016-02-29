<?php

class Helper_Users {
	
	/**
	 * 
	 * @param datetime $last_seen
	 */
	public static function IsOnline($last_seen) {
		$diff = time() - strtotime($last_seen);		
		return $diff < 10;
	}
}