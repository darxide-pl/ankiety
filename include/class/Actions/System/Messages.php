<?php

class System_Messages_Actions extends Action_Script {
    
	public function _add() {
		
		$t = $this->rv->GetVars('post');
		
		# create system action
		$action = Model_System_Action::NewInstance()
					->Set('name',$t['action_name'])
					->Set('constant',$t['action_code'])
					->Save();
		
		# save action vars
		if ($t['action_var']) {
			foreach ($t['action_var'] as $v) {
				if ($v['name']) {
					$var = Model_System_Action_Var::NewInstance()
							->Set('name',$v['name'])
							->Set('desc',$v['desc'])
							->Set('action_id',$action->GetID())
							->Save();
				}
			}
		}
		
		# create system message
        $message = Model_System_Message::NewInstance()
					->Set('action_id',$action->GetID())
					->Set('title',$t['title'])
					->Set('content',$t['content'])
					->Save();
		
		// save descriptions
		if ($t['d'] && $message) {
			foreach ($t['d'] as $lang => $d) {
				$this->db->query("REPLACE INTO `system_message_description`
					(`lang`,`message_id`,`title`,`content`)
					VALUES ('".$this->db->quote($lang)."', '".(int)$message->GetID()."', '".$this->db->quote($d['title'])."', '".$this->db->quote($d['content'])."');");
			}
		}

		$this->Msg('Powiadomienie zostało zapisane z powodzeniem.');
		
		$this->request->execute($this->link->Build(array('system_messages')));
		
	}
	
	function _save() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->GetVars('post');
		
        $O = new Model_System_Message;

		if ($t['message_id'] < 1) {
			$O->ForceModify();
		} else {
			$O->findById($t['message_id']);
		}
	
		if ($this->Pass() && $t['action_name']) {
			# update system action
			$action = new Model_System_Action($t['action_id']);
			$action ->Set('name',$t['action_name'])
					->Set('constant',$t['action_code'])
					->Save();
		}
		
		if ($this->Pass()) {
			
			# Save existing action vars
			if ($t['action_var']) {
				foreach ($t['action_var'] as $var_id => $v) {
					$var = new Model_System_Action_Var($var_id);
					if ($v['name']) {
						$var->Set('name',$v['name'])
							->Set('desc',$v['desc'])
							->Save();
					} else {
						$var->Delete();
					}
				}
			}
			
			# save new action vars
			if ($t['action_var_new']) {
				foreach ($t['action_var_new'] as $v) {
					if ($v['name']) {
						$var = Model_System_Action_Var::NewInstance()
								->Set('name',$v['name'])
								->Set('desc',$v['desc'])
								->Set('action_id',$O->get('action_id'))
								->Save();
					}
				}
			}
			
			# update message
			$O->Set('action_id', $t['action_id']);
			
			try {
				
				# validate changes in message
				$O->Validate();
				# apply changes to message
				$O->Save();
				
				// save descriptions
				if ($t['d']) {
					foreach ($t['d'] as $lang => $d) {
						$this->db->query("REPLACE INTO `system_message_description`
							(`lang`,`message_id`,`title`,`content`)
							VALUES ('".$this->db->quote($lang)."', '".(int)$O->GetID()."', '".$this->db->quote($d['title'])."', '".$this->db->quote($d['content'])."');");
					}
				}
				
				$this->Msg('Powiadomienie zostało zapisane z powodzeniem.');
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
		} else {
			$this->Error('Powiadomienie nie zostało zapisane ze względu na błędy.');
		}
	}
	
	function _delete()
	{
		$id = (int) $this->rv->Get('message_id', 'request');
		
		if ($id < 1) {
			$this->Error('Nie podano identyfikatora wiadomości.');
		} else {
            $O = new Model_System_Message($id);
		}
		
		if ($this->Pass()) {
			try {
				$O->Remove();
				$this->Msg('Wiadomość została usunięta.');
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
		} else {
			$this->Error('Wiadomość nie została usunięta ze względu na wystąpienie błędów.');
		}
	}
}