<?php

class Events_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brak tytułu wydarzenia.');
		}

		$alias_tmp = trim(Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['name']));
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `event` WHERE `alias` = '".$this->db->quote($alias_tmp)."';";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp;
		
		if ($this->pass()) {
			
			$o = new Model_Event();
			$o->set('add_date',date('Y-m-d H:i:s'));
			$o->set('user_id',$this->auth->user['id']);
			
			// save page
			
			$o	->set('name',$t['name'])
				->set('alias',$t['alias'])
				->set('description',$t['description'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->save();
			
			$this->msg('Zdarzenie została zapisana.');
			
			$this->request->execute($this->link->Build(array('events','edit','oid'=>$o->get('id'))), true);
		}
	}
	
	public function _update() {
		
		$t = $this->rv->getVars('post');
		
		
		if (!$t['name']) {
			$this->error('Brak nazwy wydarzenia.');
		}

		$alias_tmp = Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['name']);
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `event` WHERE `alias` = '".$this->db->quote($alias_tmp)."' AND `id` != ".(int)$t['id'].";";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp;
		
		if ($this->pass()) {
			
			$o = new Model_Event($t['id']);
			
			// save page
			
			$o	->set('name',$t['name'])
				->set('alias',$t['alias'])
				->set('description',$t['description'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('from',$t['from'])
				->set('to',$t['to'])
				->set('where',$t['where'])
				->set('gallery_id',$t['gallery_id'])
				->save();
			
			$this->msg('Wydarzenie zostało zapisane.');
		}
		
		$this->request->execute($this->link->Build(array('events','edit','oid'=>$t['id'])),true);
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('get');
		
		if ($t['id'] < 1) {
			$this->error('Nie podano identyfikatora.');	
		}
		
		if ($this->pass()) {
			try {
				
				$O = new Model_Event($t['id']);
				$O->delete();

				$this->msg('Wydarzenie <b>'.$O->get('name').'</b> zostało usunięte.');
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
			
			$this->request->refresh();
		}
	}
	
	function _switch_publish() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('request');
		
		if ($t['id'] < 1) {
			$this->Error('Nie podano identyfikatora.');
		}
		
		if ($this->Pass()) {
			
			try {
				
				$O = new Model_Event($t['id']);
				$O->set('publish', !$O->get('publish'));
				
				# always set this data
				$O->set('modify_date',date('Y-m-d H:i:s'));
				
				# change modifier only if not superadmin
				if (!$this->auth->isSuperadmin()) {
					$O->set('modify_user_id',$this->auth->user['id']);
				}
				
				$O->save();
				
				$this->msg('Wydarzenie zostało '.($O->get('publish') ? 'opublikowane' : 'ukryte').'.');
				
				# used in ajax request
				$this->output['publish'] = (int)$O->get('publish');
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
		}
	}
}