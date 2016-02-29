<?php

class Contact_Form_Actions extends Action_Script {
	
	public function _send() {
		
		$t = $this->rv->getVars('post');
		
		if ($t['additional'] != '') {
			// SPAM 
			return;
		}

		if (!$t['text']) {
			$this->error('Proszę podać treść zapytania.');
		}
	
		if ($this->Pass()) {
			
			$o = new Model_Contact_Form();
			$o
				->set('text',strip_tags($t['text']))
				->set('date',date('Y-m-d H:i:s'))
				->set('name',$t['name'])
				->set('ip',  f_get_ip_address())
				//->set('phone',$t['phone'])
				->set('email',$t['email'])
				->save();
			
			$this->msg('Wiadomość została wysłana');
			
			$parse = array(
				'name' => $t['name'],
				'date' => date('Y-m-d H:i:s'),
				'ip' => f_get_ip_address(),
				'text' => htmlspecialchars(strip_tags($t['text'])),
				'phone' => $t['phone'],
				'email' => $t['email']
			);
			
			$tpl = new System_Messages('contact_form','pl');
			
			$recipients = Config::Get('default.contact_form_recipients');
			$recipients = preg_replace('/\s+/','',$recipients);
			$recipients = preg_split("/,|;/", $recipients, 0, PREG_SPLIT_NO_EMPTY);
			
			$Email = new SendEmailController;
			
			if ($recipients) {

				$Email->setTitle($tpl->getTitle());
				$Email->setContent($tpl->getParsedContent($parse,'default'));
				
				foreach ($recipients as $email) {
					
					$Email->setRecipient($email, $email);

					if (!$Email->send()) {
						//$this->error('');
					}	
				}
			}

			$this->request->refresh();
		}
	}
	
	public function _remove_selected() {
		
		$t = $this->rv->get('t');
		
		if ($t) {

			foreach ($t as $id) {
				$this->db->query("DELETE FROM `contact_form` WHERE `id` = ".(int)$id.";");
			}
			
			$this->msg('Zapytania zostały usunięte.');

		} else {
			$this->error('Proszę wybrać zapytania do usunięcia.');
		}
	}
}