<?php

class Reports_Actions extends Action_Script {
	
	public function _approve_person() {
		
		$report_id = $this->rv->get('oid');
		
		$report = new Model_Report($report_id);
		
		if ($report->get('customer_contact_id')) {
			$this->error('Osoba już została zatwierdzona.');
		}
		
		if ($report->get('customer_id') < 1) {
			$this->error('W zgłoszeniu nie ma klienta lub klient nie istnieje');
		}
		
		if ($this->pass()) {
			
			$person = Model_Customer_Agent::NewInstance()
				->set('customer_id',$report->get('customer_id'))
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('name',$report->get('customer_name'))
				->set('lastname',$report->get('customer_lastname'))
				->set('phone',$report->get('customer_phone'))
				->set('email',$report->get('customer_email'))
				->save();
			
			$report->set('customer_contact_id',$person->get('id'))
				->save();
			
			$this->msg('Osoba została zatwierdzona.');
		}
	}
	
	public function _register() {
		
		$t = $this->rv->getVars('post');
	
		if (!$t['name'] || !$t['lastname'])  {
			$this->error('Proszę podać imię i nazwisko');
		}
		
		if (!$t['nip']) {
			$this->error('Proszę podać NIP firmy.');
		}
		
		if ($this->pass()) {
			
			// check voucher
			$voucher_code = preg_replace('/[^0-9a-zA-Z]+/','',$t['voucher']);

			$sql = "SELECT * FROM `voucher` WHERE `code` = '".$this->db->quote($voucher_code)."';";
			$voucher = $this->db->first($sql);

			if ($voucher['use_date'] > 0) {

				$voucher = false;
				$voucher_code = '';

				$this->msg('Voucher '.$voucher_code.' już został wykorzystany.',true);

			} else if ($voucher) {

				$this->db->query("UPDATE `voucher` SET `use_date` = NOW() WHERE `id` = ".(int)$voucher['id'].";");

			} else {

				$voucher_code = '';
			}

			// find customer by nip
			$t['nip'] = preg_replace('/[^0-9]+/','',$t['nip']);
			$sql = "SELECT * FROM `customer` WHERE `nip_cleared` = '".$this->db->quote($t['nip'])."';";
			$customer = $this->db->first($sql);

			// find contact person
			if ($customer) {

				$sql = "SELECT * FROM `customer_agent` WHERE `email` = '".$this->db->quote($t['email'])."';";
				$contact_person = $this->db->first($sql);

			}

			// create report

			$report = new Model_Report();
			$report
				->set('add_date',date('Y-m-d H:i:s'))
				->set('customer_id',$customer['id'])
				->set('customer_nip',$t['nip'])
				->set('customer_name',$t['name'])
				->set('customer_lastname',$t['lastname'])
				->set('customer_contact_id',(int)$contact_person['id'])
				->set('description',$t['description'])
				->set('status','new')
				->set('voucher',$voucher_code)
				->set('customer_email',$t['email'])
				->set('customer_phone',$t['phone'])
				->set('source','www')
				->save();

			
			if ($this->session->get('landingpage_files')) {
				
				foreach ($this->session->get('landingpage_files') as $k => $file_id) {
					
					$file = new Model_Report_File($file_id);
					$file->set('report_id',$report->get('id'));
					$file->save();
					
					mkdir(APPLICATION_PATH.'/upload/reports/'.$report->get('id').'/',0755);
					mkdir(APPLICATION_PATH.'/upload/reports/'.$report->get('id').'/thumb/',0755);
					
					copy(APPLICATION_PATH.'/upload/tmp/'.$file->get('filename'),APPLICATION_PATH.'/upload/reports/'.$report->get('id').'/'.$file->get('filename'));
					copy(APPLICATION_PATH.'/upload/tmp/thumb/'.$file->get('filename'),APPLICATION_PATH.'/upload/reports/'.$report->get('id').'/thumb/'.$file->get('filename'));
					
					unlink(APPLICATION_PATH.'/upload/tmp/'.$file->get('filename'));
					unlink(APPLICATION_PATH.'/upload/tmp/thumb/'.$file->get('filename'));
				}
				
				$this->session->set('landingpage_files',array());
			}
			
			$this->msg('Zgłoszenie zostało przyjęte.');
		}
	}
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['customer_id']) {
			$this->error('Brakuje firmy.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Report::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('customer_id',$t['customer_id'])
				->set('customer_name',$t['customer_name'])
				->set('customer_gender',$t['customer_gender'])
				->set('customer_contact_id',$t['customer_contact_id'])
				->set('title',$t['title'])
				->set('description',$t['description'])
				->set('priority',$t['priority'])
				->set('status',$t['status'])
				->set('status_date',$t['status_date'].':00')
				->set('place',$t['place'])
				->set('source',$t['source'])
				->set('product_serial',$t['product_serial'])
				->save();
			
			$this->msg('Zgłoszenie zostało zapisane.');
			
			$c = new Model_Customer($o->get('customer_id'));
			
			if ($c->get('email') != '') {
				
					$tpl = new System_Messages('report_new',$this->session->get('language'));

					$Email = new SendEmailController;

					//$recipient = $c->get('email');
					$recipient = 'vsemak@gmail.com';

					$parse = array(
						'company_name' => $c->get('company_name'),
						'phone' => $c->get('phone'),
						'email' => $c->get('email'),
						'gender' => $o->get('customer_gender'),
						'name' => $o->get('customer_name'),
						'username' => $this->auth->user['name'].' '.$this->auth->user['lastname'],
						'address_street' => $c->get('address_street'),
						'address_zip' => $c->get('address_zip'),
						'address_city' => $c->get('address_city'),
						'nip' => $c->get('nip'),
						'date' => date('Y-m-d H:i:s')
					);

					$title = $tpl->getTitle();

					$Email->setRecipient($recipient,$recipient);
					$Email->setTitle($title);
					$Email->setContent($tpl->getParsedContent($parse).$this->auth->user['email_signature']);

					// send email

					if (!$Email->send()) {
						$this->error('Nie udało się wysłać wiadomości na adres e-mail: '.$recipient);
					}
				}
			
			$this->request->execute($this->link->Build(array('reports','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja zapisu przerwana.');
		}
		
		if ($this->pass() && !$t['customer_id']) {
			//$this->error('Brakuje firmy');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Report($t['id']);
			
			$o	//->set('customer_id',$t['customer_id'])
				->set('title',$t['title'])
				->set('description',$t['description'])
				->set('priority',$t['priority'])
				->set('status',$t['status'])
				->set('status_date',$t['status_date'].':00')
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->set('customer_contact_id',$t['customer_contact_id'])
				->set('customer_name',$t['customer_name'])
				->set('customer_gender',$t['customer_gender'])
				->set('source',$t['source'])
				->set('place',$t['place'])
				->set('product_serial',$t['product_serial'])
				->save();

			$this->msg('Zapisano zmiany w zgłoszeniu.');
			
			if ($t['user_id']) {

				// load actual users
				$sql = "SELECT `user_id`,`user_id` FROM `report_user` WHERE `report_id` = ".(int)$o->get('id').";";
				$users = $this->db->all($sql,DB_FETCH_ASSOC_FIELD);
				
				foreach ($t['user_id'] as $user_id) {
					
					if (!isset($users[$user_id])) {
						
						// add new user
						$this->db->Insert('report_user',array(
							'user_id' => $user_id,
							'report_id' => $o->get('id'),
							'add_date' => date('Y-m-d H:i:s')
						));
					}
				}
				
				// remove unused users
				$sql = "DELETE FROM `report_user` WHERE `report_id` = ".(int)$o->get('id')." AND `user_id` NOT IN (".implode(',',$t['user_id']).");";
				$this->db->query($sql);
			}
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Report($t['id']);
			$o->remove();
			
			$this->msg('Zgłoszenie zostało usunięte.');
		}
	}
	
	public function _close() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['oid']) {
			$this->error('Brakuje identyfikatora, operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Report($t['oid']);
			$o->set('status','closed')
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->save();;
			
			$this->msg('Zgłoszenie zostało zamknięte.');
		}
	}
	
	public function _complain() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['oid']) {
			$this->error('Brakuje identyfikatora, operacja reklamacji została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Report($t['oid']);
			$o	->set('status','complain')
				->set('update_user_id',$this->auth->user['id'])
				->set('update_date',date('Y-m-d H:i:s'))
				->save();
			
			$this->msg('Zgłoszenie zostało zareklamowane.');
		}
	}
	
	public function _add_task() {
		
		$this->mode = 'json';
		
		$id = $this->rv->get('report_id');
		
		if ($id) {
			
			$report = new Model_Report($id);
			
			$c = new Model_Customer($report->get('customer_id'));
			
			$o = new Model_Report_Task();
			
			$o	->set('report_id',$id)
				->set('add_date',date('Y-m-d H:i:s'))
				->set('start',date('Y-m-d H:i:s'))
				->set('user_id',$this->auth->user['id'])
				->set('complain',$report->get('status') == 'complain' ? 1 : 0)
				->save();
			
			$this->output['id'] = $o->get('id');
			$this->output['date'] = $o->get('start');
			
			
			

			if ($report->get('status') == 'new') {
				
				$report
					->set('status','inprogress')
					->set('update_date',date('Y-m-d H:i:s'))
					->set('update_user_id',$this->auth->user['id'])
					->save();
				
				if ($c->get('email') != '') {
				
					$tpl = new System_Messages('report_inprogress',$this->session->get('language'));

					$Email = new SendEmailController;

					//$recipient = $c->get('email');
					$recipient = 'vsemak@gmail.com';

					$parse = array(
						'company_name' => $c->get('company_name'),
						'phone' => $c->get('phone'),
						'email' => $c->get('email'),
						'gender' => $report->get('customer_gender'),
						'name' => $report->get('customer_name'),
						'username' => $this->auth->user['name'].' '.$this->auth->user['lastname'],
						'address_street' => $c->get('address_street'),
						'address_zip' => $c->get('address_zip'),
						'address_city' => $c->get('address_city'),
						'nip' => $c->get('nip'),
						'date' => date('Y-m-d H:i:s')
					);

					$title = $tpl->getTitle();

					$Email->setRecipient($recipient,$recipient);
					$Email->setTitle($title);
					$Email->setContent($tpl->getParsedContent($parse).$this->auth->user['email_signature']);

					// send email

					if (!$Email->send()) {
						$this->error('Nie udało się wysłać wiadomości na adres e-mail: '.$recipient);
					}
				}
				
			}
			
			$this->msg('Zadanie zostało rozpoczęte.');
		}
	}
	
	public function _save_task() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Proszę wskazać zadanie do zakończenia');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Report_Task($t['id']);
			$o	->set('end',date('Y-m-d H:i:s'))
				->set('notice',$t['notice'])
				->set('internal_notice',$t['internal_notice'])
				->set('place',$t['place'])
				->save();
			
			$this->msg('Zadanie zostało zakończone.');
			
			if ($t['task_user_id']) {
				
				// load actual users
				$sql = "SELECT `user_id`,`user_id` FROM `report_task_user` WHERE `task_id` = ".(int)$o->get('id').";";
				$users = $this->db->all($sql,DB_FETCH_ASSOC_FIELD);

				foreach ($t['task_user_id'] as $user_id) {

					if (!isset($users[$user_id])) {

						// add new user
						$this->db->Insert('report_task_user',array(
							'user_id' => $user_id,
							'report_id' => $o->get('report_id'),
							'task_id' => $o->get('id'),
							'add_date' => date('Y-m-d H:i:s')
						));
					}
				}

				// remove unused users
				$sql = "DELETE FROM `report_task_user` WHERE `report_id` = ".(int)$o->get('id')." AND `user_id` NOT IN (".implode(',',$t['task_user_id']).");";
				$this->db->query($sql);
			}
		}
	}
	
	public function _remove_task() {
		
		$t = $this->rv->getVars('all');
		
		if ($t['json']) {
			$this->mode = 'json';
		}
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora, operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Report_Task($t['id']);
			$o->remove();
			
			$sql = "DELETE FROM `report_task_user` WHERE `task_id` = ".(int)$t['id'].";";
			$this->db->query($sql);
			
			$this->msg('Zadanie zostało usunięte.');
		}
	}
	
	public function _upload_from_clipboard() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('request');
		
		$sourceString = $t['source'];
		
		$thumb_dir = APPLICATION_PATH.'/upload/reports/'.$t['id'].'/thumb/';
		
		if (!file_exists($thumb_dir)) {
			@mkdir($thumb_dir,0777,true);
		}
		
		$dir = APPLICATION_PATH.'/upload/reports/'.$t['id'].'/';
		$filename = session_id().microtime().'.jpg';
		
		$image = imagecreatefromstring(base64_decode($sourceString));
		imagejpeg($image, $dir.$filename, 95);

		if (file_exists($dir.$filename)) {

			$extension = substr($filename,strrpos($filename,'.')+1);

			$file = new Model_Report_File();
			$file->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->set('ip',f_get_ip_address())
				->set('report_id',$t['id'])
				->set('filename',$filename)
				->set('title','zrzut ekranu')
				->set('type','image')
				->set('extension',$extension)
				->save();

			if ($file->get('type') == 'image') {
				$img = new ImageHandler($dir.$filename);
				$img->width(100)
					->height(70)
					->scaleToBox(true)
					->save($thumb_dir.$filename);
			}
		}
	}
	
	public function _upload_tmp_from_clipboard() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('request');
		
		$sourceString = $t['source'];
		
		$thumb_dir = APPLICATION_PATH.'/upload/tmp/thumb/';
		
		if (!file_exists($thumb_dir)) {
			@mkdir($thumb_dir,0777,true);
		}
		
		$dir = APPLICATION_PATH.'/upload/tmp/';
		$filename = session_id().microtime().'.jpg';
		
		$image = imagecreatefromstring(base64_decode($sourceString));
		imagejpeg($image, $dir.$filename, 95);

		if (file_exists($dir.$filename)) {

			$extension = substr($filename,strrpos($filename,'.')+1);

			$file = new Model_Report_File();
			$file->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',0)
				->set('ip',f_get_ip_address())
				->set('report_id',-1)
				->set('filename',$filename)
				->set('title','zrzut ekranu')
				->set('type','image')
				->set('extension',$extension)
				->save();

			if ($file->get('type') == 'image') {
				$img = new ImageHandler($dir.$filename);
				$img->width(100)
					->height(70)
					->scaleToBox(true)
					->save($thumb_dir.$filename);
			}
			
			$session_files = $this->session->get('landingpage_files');
			$session_files[] = $file->get('id');
			$this->session->set('landingpage_files',$session_files);
		}
	}
	
	public function _upload_file() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->getVars('request');
		
		if ($this->auth->checkRight('admin|programers')) {
			// from post
		} else {
			$t['user_id'] = $this->auth->user['id'];
		}
		
		$thumb_dir = APPLICATION_PATH.'/upload/reports/'.$t['id'].'/thumb/';
		
		if (!file_exists($thumb_dir)) {
			@mkdir($thumb_dir,0777,true);
		}
		
		$dir = APPLICATION_PATH.'/upload/reports/'.$t['id'].'/';
		
		$upload = new Helper_Plupload();
		$upload_result = $upload->Upload($dir);
		
		if ($upload_result !== false) {
			
			if (file_exists($upload_result)) {

				$filename = basename($upload_result);
				$extension = substr($filename,strrpos($filename,'.')+1);

				$file = new Model_Report_File();
				$file->set('add_date',date('Y-m-d H:i:s'))
					->set('add_user_id',$this->auth->user['id'])
					->set('ip',f_get_ip_address())
					->set('report_id',$t['id'])
					->set('filename',$filename)
					->set('title',$t['original_name'])
					->set('type',$extension == 'jpg' || $extension == 'png' || $extension == 'bmp' || $extension == 'gif' ? 'image' : 'other')
					->set('extension',$extension)
					->save();

				if ($file->get('type') == 'image') {
					$img = new ImageHandler($dir.$filename);
					$img->width(100)
						->height(70)
						->scaleToBox(true)
						->save($thumb_dir.$filename);
				}
				
				// return url
				die('{"id":"'.$file->get('id').'","path":"'.DIR_UPLOAD_ABSOLUTE.'/reports/'.$t['id'].'/'.$filename.'","filename":"'.$filename.'"}');
			}
		}

		die();
	}
	
	public function _upload_tmp_file() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->getVars('request');
		
		if ($this->auth->checkRight('admin|programers')) {
			// from post
		} else {
			$t['user_id'] = $this->auth->user['id'];
		}
		
		$thumb_dir = APPLICATION_PATH.'/upload/tmp/thumb/';
		
		if (!file_exists($thumb_dir)) {
			@mkdir($thumb_dir,0777,true);
		}
		
		$dir = APPLICATION_PATH.'/upload/tmp/';
		
		$upload = new Helper_Plupload();
		$upload_result = $upload->Upload($dir,true);
		
		if ($upload_result !== false) {
			
			if (file_exists($upload_result)) {

				$filename = basename($upload_result);
				$extension = substr($filename,strrpos($filename,'.')+1);

				$file = new Model_Report_File();
				$file->set('add_date',date('Y-m-d H:i:s'))
					->set('add_user_id',0)
					->set('ip',f_get_ip_address())
					->set('report_id',-1)
					->set('filename',$filename)
					->set('title',$t['original_name'])
					->set('type',$extension == 'jpg' || $extension == 'png' || $extension == 'bmp' || $extension == 'gif' ? 'image' : 'other')
					->set('extension',$extension)
					->save();
				
				$session_files = $this->session->get('landingpage_files');
				$session_files[] = $file->get('id');
				$this->session->set('landingpage_files',$session_files);

				if ($file->get('type') == 'image') {
					$img = new ImageHandler($dir.$filename);
					$img->width(100)
						->height(70)
						->scaleToBox(true)
						->save($thumb_dir.$filename);
				}
				
				// return url
				die('{"id":"'.$file->get('id').'","path":"'.DIR_UPLOAD_ABSOLUTE.'/tmp/'.$filename.'","filename":"'.$filename.'"}');
			}
		}

		die();
	}
}