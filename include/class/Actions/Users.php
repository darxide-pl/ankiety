<?php

/**
 * @title Użytkownicy
 * @acl users
 */
class Users_Actions extends Action_Script {

	/**
	 * @title Zapisz użytkownika
	 * @acltype write
	 */
	function _save() {
		
		$t = $this->rv->GetVars( 'post' );
		
		$where_and_user = '';

		$O = new Model_User;
		
		if ($t['user_id'] < 1) {
			$O->ForceModify();
			$O->Set('add_date',date('Y-m-d H:i:s'));
		} else {
			$O->findById($t['user_id']);
			$where_and_user = " AND `id` != '".$t['user_id']."'";
		}
		
		$this->_redirect_after_success = false;
		
		if ($t['change_password'] || $t['user_id'] < 1) {
			if (!empty($t['password'])) {
				if (strlen($t['password']) < 5 || strlen($t['password']) > 32) {
					$this->Error('Hasło nie zostało zmienione ponieważ wykracza poza zakres od 5 do 32 znaków.');
				} else {
					$O->Set('password', f_generate_hash(sha1($t['password'])));
				}
			}
		}

        $options['count'] = true;
        $options['where'] = "`email` = '".$t['email']."'".$where_and_user;

		if ($O->find($options)) {
			$this->Error('Taki adres e-mail już istnieje. Spróbuj ponownie.');
		}
		
		if ( $this->Pass() ) {
			
			# try to upload file
			if ($_FILES['avatar']['tmp_name']) {
				
				$old_image_filename = $O->Get('avatar');
				
				$file = FilesActions::SaveUploadFile('avatar',DIR_UPLOAD.'users/',array('accept_types'=>array('image')));

				FilesActions::ResizeImage($file->GetPath(), $file->GetPath(), IMG_SCALE_TO_WH, 150, 150);
				
				$O->Set('avatar',$file->GetName());
				
				if ($old_image_filename) {
				
					# try to delete old file
					if (@file_exists(DIR_UPLOAD.'users/' . $old_image_filename)) {
						unlink(DIR_UPLOAD.'users/' . $old_image_filename);
					}
				}
			} else if ($t['remove_image'] > 0) {
				
				$O->Set('avatar','');
				
				$old_image_filename = $O->Get('avatar');
				
				if ($old_image_filename) {
					# try to delete old file
					if (@file_exists(DIR_UPLOAD.'users/' . $old_image_filename)) {
						unlink(DIR_UPLOAD.'users/' . $old_image_filename);
					}
				}
			}
			
			$O->Set('name', $t['name']);
			$O->Set('lastname', $t['lastname']);
			$O->Set('email', $t['email']);
			$O->Set('active', $t['active']);
			$O->Set('login', $t['login']);
			$O->Set('group_id', $t['group_id']);
			$O->set('email_signature',$t['email_signature']);

			if (isset($t['access_list'])) {
				$O->set('access_list',serialize($t['access_list']));
			}
			
			try {
				$O->Validate();
				$O->SetRecursion(0);
				$O->Save();
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
			
			if ( $this->Pass() ) {
				$this->Msg('Użytkownik <b>'.$O->GetFullName().'</b> został zapisany.');
			} else {
				$this->Error('Użytkownik <b>'.$O->GetFullName().'</b> nie został zapisany. Błąd zapytania do bazy danych.');
			}
		} else {
			$this->Error('Użytkownik nie został zapisany ze względu na błędy w formularzu.');
		}
		
		if (!$t['user_id']) {
			//$this->request->execute($this->link->Build(array('users','edit','oid'=>$O->GetID())), true);
		}
	}
	
	/**
	 * @title Zapisz dane zalogowanego użytkownika
	 * @acltype write
	 */
	function _save_account() {
		
		$t = $this->rv->GetVars( 'post' );
		
		//$where_and_user = '';
		
		$t['user_id'] = $this->auth->user['id'];

		$O = new Model_User($t['user_id']);
		if (!$O->GetID()) {
			$this->Error('Użytkownik nie isnieje.');
		}
		
		if ($t['change_password'] || $t['user_id'] < 1) {
			if (!empty($t['password'])) {
				if (strlen($t['password']) < 5 || strlen($t['password']) > 32) {
					$this->Error('Hasło nie zostało zmienione ponieważ wykracza poza zakres od 5 do 32 znaków.');
				} else {
					$O->Set('password', f_generate_hash(sha1($t['password'])));
				}
			}
		}
		
		/*
		$where_and_user = " AND `id` != '".$t['user_id']."'";

        $options['count'] = true;
        $options['where'] = "`login` = '".$t['login']."'".$where_and_user;

		if ($O->find($options)) {
			$this->Error('Taki login już istnieje. Spróbuj ponownie.');
		}
		
        $options['where'] = "`email` = '".$t['email']."'".$where_and_user;

		if ($O->find($options)) {
			$this->Error('Taki adres e-mail już istnieje. Spróbuj ponownie.');
		}
		*/
		
		if ( $this->pass() ) {
			
			/*$O->Set('name', $t['name']);
			$O->Set('lastname', $t['lastname']);
			$O->Set('email', $t['email']);
			$O->Set('login', $t['login']);*/
			
			//$O->set('email_signature',$t['email_signature']);
		
			try {
				$O->Validate();
				$O->SetRecursion(0);
				$O->Save();
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
			
			if ( $this->Pass() ) {
				$this->msg('Zmiany zostały zapisane.');
			} else {
				$this->error('Błąd zapytania do bazy danych.');
			}
		} else {
			$this->error('Użytkownik nie został zapisany ze względu na błędy w formularzu.');
		}
	}

	/**
	 * @title Usun użytkownika
	 * @acltype remove
	 */
	function _delete() {
		
		$user_id = (int) $this->rv->Get( 'oid', 'request' );
		
		if ($user_id < 1) {
			$this->Error('Nie podano identyfikatora użytkownika.');
		} else {
			$O = new Model_User;
			$O->findById($user_id);
		}
		
		if ( $this->Pass() ) {
			try {
				$O->SetRecursion(0);
				$O->Remove();
			} catch (Exception $e) {
				$this->Error( $e->getMessage() );
			}
			
			if ( $this->Pass() ) {
				$this->Msg('Użytkownik <b>'.$O->GetFullName().'</b> został usunięty.');
			} else {
				$this->Error('Użytkownik <b>'.$O->GetFullName().'</b> nie został usunięty. Błąd zapytania do bazy danych.');
			}
		} else {
			$this->Error('Użytkownik nie został usunięty ze względu na wystąpienie błędów.');
		}
	}
	
	/**
	 * @title Odpowiedz na zaproszenie
	 * @acltype write
	 */
	public function _answer_invitation() {
		
		//$this->_redirect_after_success = false;
		
		if ($this->auth->isLoged()) {
		
			$invite_id = (int)$this->rv->get('invite_id');
			$decision = (int)$this->rv->get('decision'); // decision
			
			// loged user
			$user_id = $this->auth->user['id'];
			$email = $this->auth->user['email'];
			
			$invite = Model_User_Invite::NewInstance()
				->find()
				->join('LEFT JOIN `workspace` `w` ON `w`.`id` = `User_Invite`.`workspace_id`
					LEFT JOIN `user` `u` ON `u`.`id` = `User_Invite`.`user_id`')
				->fields('`w`.`name` AS `workspace_name`, `u`.`email` AS `user_email`')
				->where("`User_Invite`.`email` = '".$this->db->quote($email)."'
							AND `User_Invite`.`id` = ".(int)$invite_id."
							AND `added` > date_sub(NOW(), interval 2 day)")
				->first();
			
			if ($invite) {
				
				if ($invite->get('workspace_name') == '') {
					$this->error('Przestrzeń już nie istnieje.');
					$invite->set('status',-2)->save();
				}
				
				// check user is already in workspace
				$user_workspace = Model_User_Workspace::NewInstance()
						->find()
						->where('`workspace_id` = '.(int)$invite->get('workspace_id').' AND `user_id` = '.(int)$user_id)
						->fetch();
				
				if ($user_workspace) {
					$this->error('Już należysz do tej przestrzeni.');
					$invite->set('status',-2)->save();
				}
				
				if ($this->pass()) {
					
					// set decision status
					$invite->set('status',$decision?1:0)
						->save();
			
					if ($invite->get('status') == 1) {
						
						// add user to workspace
						Model_User_Workspace::NewInstance()
								->set('user_id',$user_id)
								->set('workspace_id',$invite->get('workspace_id'))
								->save();
						
						$this->msg('Zaproszenie zostało zaakceptowane.');
					} else {
						$this->msg('Zaproszenie zostało odrzucone.');
					}
				}
				
			} else {
				$this->error('Zaproszenie wygasło.');
				$invite->set('status',-2);
			}
		}
	}
	
	/**
	 * @title Zarejestruj konto
	 * @acltype write
	 */
	public function _register() {
		
		if ($this->auth->isLoged()) {
			$this->request->execute($this->link->Build('/'));
		}
		
		
		$email = str_replace(' ', '', $this->rv->get('email'));
		$password = trim($this->rv->get('password'));
		
		if (!f_check_password($password)) {
			$this->error('Hasło powinno mieć od 5 do 32 znaków.');
		}
		
		if (!f_check_email($email)) {
			$this->error('Adres e-mail ma nieprawidłowy format.');
		}
		
		if ($this->pass()) {
			
			// check email exists
			$sql = "SELECT COUNT(*) FROM `user` WHERE `email` = '".$this->db->quote($email)."';";
			$exist = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			if ($exist) {
				$this->error('Adres e-mail jest już zajęty :-(');
			}
		}
		
		if ($this->pass()) {
			
			$password_sha1 = f_generate_hash(sha1($password));
			
			// create user
			$user = Model_User::NewInstance()
				->set('language','pl')
				->set('email',$email)
				->set('login',$email)
				->set('group_id',4)
				->set('active',1)
				->set('password',$password_sha1)
				->save();
			
			$this->msg('Konto zostało utworzone z powodzeniem.');
			
			// load template

			$tpl = new System_Messages('user_after_register',$this->session->get('language'));

			$Email = new SendEmailController;
			
			$parse = array(
				'EMAIL' => $email,
				'PASSWORD' => $password,
				'DATE' => date('Y-m-d H:i:s'),
				'IP' => f_get_ip_address(),
				'LOGIN_PAGE_LINK' => $this->link->build('login/index'),
			);

			$title = $tpl->getTitle();

			$Email->setRecipient($email,$email);
			$Email->setTitle($title);
			$Email->setContent($tpl->getParsedContent($parse));

			// send email

			if (!$Email->send()) {
				$this->error('Nie udało się wysłać wiadomości na adres e-mail: '.$email);
			}	
		}
	}
	
	/**
	 * @title Aktywuj/Deaktywuj konto
	 * @acltype write
	 */
	public function _toggle_active() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Proszę wybrać użytkownika.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_User($t['id']);
			
			$o	->set('active',$o->get('active') == 1 ? 0 : 1)
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->save();
			
			$this->output['update_date'] = $o->get('update_date');
			
			$this->msg('Zmieniono status');
		}
	}
}