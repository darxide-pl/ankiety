<?php

class Rootkit_Actions extends Action_Script {
	
	public function _clear_cache() {
		
		# sql cache dir
		$dir = APPLICATION_PATH.'/tmp/schema/';
		
		$handler = opendir($dir);
		
		if ($handler) {
		
			while ($file = readdir($handler)) {
				if ($file != '.' && $file != '..' && !is_dir($dir.$file)) {
					unlink($dir.$file);
				}
			}
			
			closedir($handler);
		}
		
		# html cache dir
		$dir = APPLICATION_PATH.'/tmp/html/';
		
		$handler = opendir($dir);
		
		if ($handler) {
		
			while ($file = readdir($handler)) {
				if ($file != '.' && $file != '..' && !is_dir($dir.$file)) {
					unlink($dir.$file);
				}
			}
			
			closedir($handler);
		}
	}
}