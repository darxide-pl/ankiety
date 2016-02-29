<?php

class Users_Groups_Actions extends Action_Script {
	
	public function DoAfterSave() {
		
	}
	
	function _save() {
		
		$t = $this->rv->GetVars( 'post' );
		
		$where_and_group_id = '';

		$O = new Model_User_Group;
		
		if ($t['oid'] < 1) {
			$O->ForceModify();
		} else {
			$O->findById($t['oid']);
			$where_and_group_id = "AND `id` != '".$t['oid']."'"; 
		}
		
		if ($this->Pass()) {

			$O->Set('code', $t['code']);
			$O->Set('name', $t['name']);
			$O->Set('color', $t['color']);
			
			try {
				$O->Validate();
				$O->Save();
				$this->Msg('Grupa użytkowników <b>'.$O->GetName().'</b> została zapisana z powodzeniem.');
			} catch (Exception $e) {
				$this->Error(TASE_WOBJECT);
				$this->Error('Grupa użytkowników <b>'.$O->GetName().'</b> nie została zapisana.');
			}
		} else {
			$this->Error('Grupa użytkowników nie została zapisana przez błędy w formularzu.');
		}
	}
	
	function _delete() {
		
		$t = $this->rv->getVars( 'get' );
		
		if ($t['oid'] < 1) {
			$this->Error('Nie wybrano grupy do usunięcia.');
		}
		
		if ($this->Pass()) {
			try {
				$O = new Model_User_Group($t['oid']);
				$O->Remove();
				$this->Msg('Grupa użytkowników została usunięta z powodzeniem.');
			} catch(Exception $e) {
				$this->Error($e->getMessage());
				$this->Error('Grupa użytkowników nie została usunięta.');
			}
		} else {
			$this->Error('Grupa użytkowników nie została usunięta.');
		}
	}
	
	public function _save_rights2() {
		
		$t = $this->rv->getVars('post');
		
		$sql = "TRUNCATE `user_group_right`;";
		$result = $this->db->query($sql);
		
		if ($t['mr']) {

			foreach ($t['mr'] as $module => $groups) {
				if ($groups) {
					foreach ($groups as $group_id => $access) {
						$UGR = new Model_User_Group_Right(false,array('where' => '`module` = \''.$module.'\' AND `group_id` = '.(int)$group_id.' AND `view` = \'\''));
						$UGR->Set('group_id', $group_id);
						$UGR->Set('module', $module);
						$UGR->Set('access', $access);
						$UGR->Save();
					}
				}
			}
			
			$this->Msg('Prawa do modułów zostały zapisane z powodzeniem.');
		} else {
			$this->Error('Nie wybrano żadnych modułów do zapisu.');
		}
		
		if ($t['r']) {

			foreach ($t['r'] as $module => $views) {
				if ($views) {
					foreach ($views as $view => $groups) {
						if ($groups) {
							foreach ($groups as $group_id => $access) {
								$UGR = new Model_User_Group_Right(false,array('where' => '`module` = \''.$module.'\' AND `group_id` = '.(int)$group_id.' AND `view` =\''.$view.'\''));
								$UGR->Set('group_id', $group_id);
								$UGR->Set('module', $module);
								$UGR->Set('access', $access);
								$UGR->Set('view', $view);
								$UGR->Save();
							}
						}
					}
				}
			}
			
			$this->Msg('Prawa do widoków zostały zapisane z powodzeniem.');
		} else {
			$this->Error('Nie wybrano żadnych widoków do zapisu.');
		}
		
		$sql = "SELECT `id` FROM `user_group`;";
		$groups = $this->db->FetchRecords($sql,DB_FETCH_ARRAY_FIELD);
		if ($groups) {
			foreach ($groups as $group_id) {
				self::RewriteConfigurationFile((int)$group_id);
			}
		}
	}
	
	public function _save_single_right() {
		
		$t = $this->rv->getVars('post');

		if ($t['mr']) {

			foreach ($t['mr'] as $module => $groups) {
				if ($groups) {
					foreach ($groups as $group_id => $access) {
						$UGR = new Model_User_Group_Right(false,array('where' => '`module` = \''.$module.'\' AND `group_id` = '.(int)$group_id.' AND `view` = \'\''));
						$UGR->Set('group_id', $group_id);
						$UGR->Set('module', $module);
						$UGR->Set('access', $access);
						$UGR->Save();
					}
				}
			}
		}
		
		if ($t['r']) {

			foreach ($t['r'] as $module => $views) {
				if ($views) {
					foreach ($views as $view => $groups) {
						if ($groups) {
							foreach ($groups as $group_id => $access) {
								$UGR = new Model_User_Group_Right(false,array('where' => '`module` = \''.$module.'\' AND `group_id` = '.(int)$group_id.' AND `view` =\''.$view.'\''));
								$UGR->Set('group_id', $group_id);
								$UGR->Set('module', $module);
								$UGR->Set('access', $access);
								$UGR->Set('view', $view);
								$UGR->Save();
							}
						}
					}
				}
			}
		}
		
		die('OK');
	}
	
	public function _rewrite_config_file() {
		
		$sql = "SELECT `id` FROM `user_group`;";
		$groups = $this->db->FetchRecords($sql,DB_FETCH_ARRAY_FIELD);
		if ($groups) {
			foreach ($groups as $group_id) {
				self::RewriteConfigurationFile((int)$group_id);
			}
		}
		
		die('Pliki praw zostały wygenerowane.');
	}
	
	public static function RewriteConfigurationFile($group_id) {
		
		$g = new Model_User_Group($group_id);
		
		$r = new Model_User_Group_Right();
		$r = $r->find()->where('`group_id` = '.(int)$group_id.'')->order('`module` ASC, `view` ASC')->fetch();
		
		$a = array();
		
		if ($r) {
			foreach ($r as $k => $v) {
				if ($v->GetAccess() > 0) {
					if (!$v->GetView()) {
						$a [$v->GetModule()]['__mod_access'] = $v->GetAccess();
					} else {
						$a [$v->GetModule()][$v->GetView()] = $v->GetAccess();
					}
				}
			}
		}

		$rights = serialize($a);
		
		$file_name = 'group.'.$g->GetCode().'.r';
		file_put_contents(DIR_CACHE_RIGHTS . $file_name, $rights);
		
		return true;
	}
}