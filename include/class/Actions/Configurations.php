<?php

class Configurations_Actions extends Action_Script {

	public function _save() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->get('cfg', 'post');
		
		if (is_array($t) && sizeof($t)) {
			
			$config = Config::GetData();
			
			foreach ($t as $group => $options) {
				
				if ($options) {
					foreach ($options as $option => $value) {
						$config[$group][$option] = $value;
					}
				}
			}
			
			if ($_FILES['cfg']['tmp_name']) {
				
				try {
					$files = FilesActions::UploadFile('cfg', APPLICATION_PATH.'/upload/config/', 25000000, null, null, $random_name = false);
				} catch (Exception $e) {
					//$this->Error($e->getMessage());
				}
				
				if ($files) {
					
					foreach ($files as $var => $file) {

						list($option,$value) = explode('.',$var);
						
						$last_file = str_replace(array('/','\\'),'',$config[$option][$value]);
						
						if ($last_file && file_exists(APPLICATION_PATH.'/upload/config/'.$last_file)) {
							unlink(APPLICATION_PATH.'/upload/config/'.$last_file);
						}

						$config[$option][$value] = $file['name'];
					}
					
				} else {
					//$this->Error($this->t('files not uploaded','Files not uploaded'));
				}
			}
			
			if ($config) {
				$s = '; <?php die();?>'."\n";
				foreach ($config as $group => $options) {
					$s .= "\n".'['.$group.']'."\n\n";
					if ($options) {
						foreach ($options as $option => $value) {
							$s .= strtolower($option).' = "'.str_replace('"','\"',$value).'"'."\n";
						}
					}
				}
				
				file_put_contents(APPLICATION_PATH.'/include/cache/config.php', $s);
			}
		}
		
		$this->msg('Ustawienia zapisane');
		
		$this->request->refresh();
		//$this->request->execute($this->link->Build(array('configuration','index','tab'=>(int)$this->rv->get('tab','post'))),true);
	}
}