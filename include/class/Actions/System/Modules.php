<?php

class System_Modules_Actions extends Action_Script {
	
	/**
	 * Rabuild all modules and views from class files.
	 * Get all modules class files and reflect them to get all methods and modules name param.
	 */
	public function _rebuild_all() {
		
		# clear modules
		$sql = "TRUNCATE `system_module`;";
		$result = $this->db->query($sql);

		# clear views
		$sql = "TRUNCATE `system_module_view`;";
		$result = $this->db->query($sql);
		
		# clear actinons
		$sql = "TRUNCATE `system_module_action`;";
		$result = $this->db->query($sql);

		
		$this->_scan_modules_directory(APPLICATION_PATH.'/include/class/Module/');

		$this->_scan_actions_directory(APPLICATION_PATH.'/include/class/Actions/');
			
		$this->Msg('Przebudowa modułów zakończona powodzeniem.');
	}
	
	private function _scan_modules_directory($dir, $subdir = '') {

		# open directory of modules
		$handle = opendir($dir.$subdir);

		if ($handle) {
			while (false !== ($file = readdir($handle))) {
				if ($file != "." && $file != "..") {
					if (is_dir($dir.$subdir.$file)) {
						$this->_scan_modules_directory($dir,$subdir.$file.'/');
					} else {
						$this->_scan_module_class($subdir.$file);
					}
				}
			}
		}

		closedir($handle);
	}
	
	private function _scan_module_class($relative_file_path) {
		
		# class name
		$class_name = substr($relative_file_path,0,strpos($relative_file_path,'.'));
		$class_name = 'Module_'.str_replace(array('/','\\'),'_',$class_name);

		# initialize class (in __construct we assign name of module)
		$o = new $class_name();
		
		if (!$o instanceof Modules_Handler) {
			return true;
		}
		
		$reflect = new ReflectionClass($o);
		
		# get all methods of class
		$methods = $reflect->getMethods();
		$module_name = $o->getName();
		$module_comments = $this->getObjectAnnotations($reflect);

		# insert module to database
		$sql = "INSERT INTO `system_module` (`name`,`object`,`title`,`access`) VALUES('".$class_name."','".$module_name."','".trim($module_comments?$module_comments['title']:'')."','".trim($module_comments?$module_comments['acl']:'')."');";
		$result = $this->db->query($sql);

		# get inserted module id
		$module_id = $this->db->insert_id;

		if ($methods) {
			foreach ($methods as $m) {

				# find first char of method name (very important)
				$first_char = substr($m->name,0,1);

				$m_comments = $this->getObjectAnnotations($m);
				
				# if method is not inheritet from parent classes
				# and first char of method is not like char '_'
				# and first char is lowercase
				if ($m->class == $reflect->name && $first_char != '_' && ctype_upper($first_char) == false) {

					# insert view to database
					$sql = "INSERT INTO `system_module_view` (`name`,`view`,`module_id`,`module`,`title`,`access`) VALUES('".$m->name."','".$m->name."','".$module_id."','".$module_name."','".trim($m_comments?$m_comments['title']:'')."','".(trim($m_comments&&$m_comments['acl']?$m_comments['acl']:($module_comments?$module_comments['acl']:'')))."');";
					$result = $this->db->query($sql);
				}
			}
		}
	}

	private function _scan_actions_directory($dir, $subdir = '') {

		# open directory of modules
		$handle = opendir($dir.$subdir);

		if ($handle) {
			while (false !== ($file = readdir($handle))) {
				if ($file != "." && $file != "..") {
					if (is_dir($dir.$subdir.$file)) {
						$this->_scan_actions_directory($dir,$subdir.$file.'/');
					} else {
						$this->_scan_action_class($subdir.$file);
					}
				}
			}
		}

		closedir($handle);
	}

	private function _scan_action_class($relative_file_path) {
		
		# class name
		$class_name = substr($relative_file_path,0,strpos($relative_file_path,'.'));
		$class_name = str_replace('Actions_','',str_replace(array('/','\\'),'_',$class_name)).'_Actions';

		# initialize class (in __construct we assign name of module)
		$o = new $class_name();
		
		if (!$o instanceof Action_Script) {
			return true;
		}
		
		$reflect = new ReflectionClass($o);
		
		# get all methods of class
		$methods = $reflect->getMethods();
		//$module_name = $o->getName();
		$module_comments = $this->getObjectAnnotations($reflect);

		# insert module to database
		//$sql = "INSERT INTO `system_module` (`name`,`object`,`title`,`access`) VALUES('".$class_name."','".$module_name."','".($module_comments?$module_comments['title']:'')."','".($module_comments?$module_comments['acl']:'')."');";
		//$result = $this->db->query($sql);

		# get inserted module id
		$module_id = $this->db->insert_id;

		if ($methods) {
			foreach ($methods as $m) {

				# find first char of method name (very important)
				$first_char = substr($m->name,0,1);

				$m_comments = $this->getObjectAnnotations($m);
				
				# if method is not inheritet from parent classes
				# and first char of method is like char '_'
				# and first char is lowercase
				if ($m->class == $reflect->name && $first_char == '_' && ctype_upper($first_char) == false) {

					$acl =  trim($m_comments && isset($m_comments['acl']) ? $m_comments['acl'] : ($module_comments ? $module_comments['acl'] : ''));

					# insert view to database
					$sql = "INSERT INTO `system_module_action` (`action`,`name`,`title`,`access`,`type`) VALUES('".$m->name."','".$reflect->name."','".($m_comments?$m_comments['title']:'')."','".$acl."','".($m_comments?$m_comments['acltype']:'')."');";
					$result = $this->db->query($sql);
				}
			}
		}
	}
	
	function getObjectAnnotations($object) {
		
		$doc = $object->getDocComment();
		
		$data = array();
		
		if (preg_match_all('#@(.*?)\n#s', $doc, $annotations)) {
			$data = $annotations[1];
		}
		
		$return = array();
		
		if ($data) {
			foreach ($data as $s) {
				list ($param,$value) = explode(' ',$s,2);
				$return[trim($param,'@')] = $value;
			}
		}
		
		return $return;
	}
}