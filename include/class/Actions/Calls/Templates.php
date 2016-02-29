<?php

class Calls_Templates_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['name']) {
			$this->error('Brakuje nazwy.');
		}
		
		if (!$t['title']) {
			$this->error('Brakuje tytułu wiadomości');
		}
		
		if (!$t['content']) {
			$this->error('Brakuje treści wiadomości');
		}
		
		if ($this->pass()) {
			
			$o = Model_Call_Template::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->set('name',$t['name'])
				->set('title',$t['title'])
				->set('content',$t['content'])
				->save();
			
			$this->msg('Szablon utworzony.');
			
			$this->request->execute($this->link->Build(array('calls_templates','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja zapisu przerwana.');
		}
		
		if (!$t['name']) {
			$this->error('Brakuje nazwy.');
		}
		
		if (!$t['title']) {
			$this->error('Brakuje tytułu wiadomości');
		}
		
		if (!$t['content']) {
			$this->error('Brakuje treści wiadomości');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Call_Template($t['id']);
			
			$o	->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->set('name',$t['name'])
				->set('title',$t['title'])
				->set('content',$t['content'])
				->save();

			$this->msg('Zamiany zostały zapisane.');
			
			//$this->request->execute($this->link->Build('calls_templates'),true);
		}
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['oid']) {
			$this->error('Brakuje identyfikatora, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Call_Template($t['oid']);
			$o->remove();
			
			$this->msg('Usunięto szablon.');
		}
	}
	
	public function _load_to_editor() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikator.');
		}
		
		if ($this->pass()) {
			$o = new Model_Call_Template((int)$t['id']);
			
			$this->output['html'] = $o->get('content');
		}
	}
}