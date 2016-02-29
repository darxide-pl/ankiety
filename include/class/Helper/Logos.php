<?php

class Helper_Logos {
	
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
					
					$sql = "UPDATE `logo` SET `pos` = ".intval($start_pos+$new_pos_offset)." WHERE `id` = ".$ids[$new_pos_offset].";";
					
					# We are in ajax layout db errors are not welcome
					Db::Instance()->query($sql);
				}
			}
		}
		
		return $summary;
	}
}