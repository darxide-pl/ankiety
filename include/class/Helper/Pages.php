<?php

class Helper_Pages {
	
	public static function Find_Root_Parent($parent_id) {
		
		$db = DB::Instance();

		$parent = false;
		
		do {
			
			$sql = "SELECT `id`, `parent_id`, `title`, `alias`, `publish` FROM `page` WHERE `id` = ".(int)$parent_id.";";
			$tmp_parent = $db->FetchRecord($sql);
			
			$parent_id = $tmp_parent['parent_id'];
			
			$parent = $tmp_parent;
			
		} while($parent['parent_id'] != 0);
		
		return $parent;
	}
	
	/**
	 * 
	 * @param type $parent_id - first parent
	 * @param type $direction / 0 - desc, 1 - asc
	 * @return type
	 */
	public static function Find_Parents($parent_id, $direction = 0) {
		
		$db = DB::Instance();

		$parents = array();
		
		do {
			
			$sql = "SELECT `id`, `parent_id`, `title`, `alias`, `publish` FROM `page` WHERE `id` = ".(int)$parent_id.";";
			$parent = $db->FetchRecord($sql);
			
			$parent_id = $parent['parent_id'];
			
			$parents []= $parent;
			
		} while($parent['parent_id'] != 0);
		
		if (!$direction) return array_reverse($parents); 
		else return $parents;
	}
	
	public static function Update_Order($order) {
		
		# Old order values
		$old_order = array();
		
		# Objects ids list
		$ids = array();
		
		# Summary table
		$summary = array();
		
		if (sizeof($order)) {
			
			foreach ($order as $new_pos => $posid) {
				
				# Process only if posid not empty
				# it is posible to get first row empty this will ommit it
				if ($posid) {
					
					# Collect ids and old pos to different collections
					list($old_pos, $id) = explode('.',$posid);
					
					$old_order	[]= $old_pos;
					$ids		[]= $id;
				}
			}
			
			# If all posid was empty this array will be empty too
			# To avoid warnings check it is empty or not
			if ($old_order) {
				
				# Count first old position (this will be base to offset)
				# Whole this script is to handle multiple pages of articles
				$start_pos = min($old_order);

				# Loop again throught order to update records positions id database
				foreach ($old_order as $new_pos_offset => $old_pos) {
					
					$summary []= array(
						'id'=>$ids[$new_pos_offset], // id of article
						'pos'=>$start_pos + $new_pos_offset); // new article position
					
					$sql = "UPDATE `page` SET `pos` = ".intval($start_pos+$new_pos_offset)." WHERE `id` = ".$ids[$new_pos_offset].";";
					
					# We are in ajax layout db errors are not welcome
					Db::Instance()->query($sql);
				}
			}
		}
		
		return $summary;
	}
}