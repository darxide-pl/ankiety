<?php

class Calls_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['company_name']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if (!$t['nip']) {
			$this->error('Brakuje NIP-u.');
		}
		
		if ($this->pass()) {
			
			$o = Model_Call::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('company_name',$t['company_name'])
				->set('represented_by_gender',$t['represented_by_gender'])
				->set('nip',$t['nip'])
				->set('address_street',$t['address_street'])
				->set('address_zip',$t['address_zip'])
				->set('address_city',$t['address_city'])
				->set('notice',trim($t['notice']))
				->set('sector',$t['sector'])
				->set('phone',$t['phone'])
				->set('email',$t['email'])
				->set('represented_by',$t['represented_by'])
				->save();
			
			$this->msg('Zapisano dane klienta.');
			
			$this->request->execute($this->link->Build(array('calls','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora klienta operacja zapisu przerwana.');
		}
		
		if ($this->pass() && !$t['company_name']) {
			$this->error('Brakuje nazwy firmy.');
		}
		
		if ($this->pass() && !$t['nip']) {
			$this->error('Brakuje NIP-u.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Call($t['id']);
			
			$o	->set('company_name',$t['company_name'])
				->set('represented_by_gender',$t['represented_by_gender'])
				->set('nip',$t['nip'])
				->set('address_street',$t['address_street'])
				->set('address_zip',$t['address_zip'])
				->set('address_city',$t['address_city'])
				->set('notice',trim($t['notice']))
				->set('sector',$t['sector'])
				->set('phone',$t['phone'])
				->set('email',$t['email'])
				->set('represented_by',$t['represented_by'])
				->save();

			$this->msg('Zapisano zmiany w koncie klienta.');
			
			$this->request->execute($this->link->Build('calls'),true);
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora kontaktu operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Call($t['id']);
			$o->set('removed',1);
			$o->set('remove_date',date('Y-m-d H:i:s'));
			$o->save();
			
			$this->msg('Konto klienta zostało wyłączone.');
		}
	}
	
	public function _activate() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora kontaktu operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Call($t['id']);
			$o->set('removed',0);
			$o->set('remove_date',date('Y-m-d H:i:s'));
			$o->save();
			
			$this->msg('Konto klienta zostało aktywowane.');
		}
	}
	
	public function _add_call() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['status']) {
			$t['status'] = 0;
		}
		
		$o = new Model_Call_History();
		
		$o	->set('add_user_id',$this->auth->user['id'])
			->set('add_date',date('Y-m-d H:i:s'))
			->set('notice',$t['notice'])
			->set('status',$t['status'])
			->set('status_date',$t['status_date'].':00')
			->set('call_id',$t['oid'])
			->set('email_content',$t['email_content'])
			->set('email_title',$t['email_title'])
			->set('email_template_id',$t['email_template_id'])
			->save();
		
		$c = new Model_Call($t['oid']);
		$c	->set('status',$t['status'])
			->set('status_date',$t['status_date'].':00')
			->save();
		
		if ($t['status'] == 3) {
			
			// inform admins about planned meeting
			
			$tpl = new System_Messages('call_meeting_is_planned',$this->session->get('language'));
			
			$email_controller = new SendEmailController;
			
			$admin = new Model_User(3);
			$recipient = $admin->get('email');
			//$recipient = 'vsemak@gmail.com';
			
			$url = $this->link->Build('oferta/'.sha1($c->get('id').';'.$c->get('add_date')).'.'.microtime(true),array('domain'=>BASE_DOMAIN.BASE_DIR.LT));
			
			$parse = array(
				'date' => date('Y-m-d H:i:s'),
				'company_name' => $c->get('company_name'),
				'phone' => $c->get('phone'),
				'email' => $c->get('email'),
				'prefix' => $c->get('prefix'),
				'representant' => $c->get('representant'),
				'username' => $this->auth->user['name'].' '.$this->auth->user['lastname'],
				'notices' => $t['notice'],
				'address_street' => $c->get('address_street'),
				'address_zip' => $c->get('address_zip'),
				'address_city' => $c->get('address_city'),
				'nip' => $c->get('nip'),
				'url' => $url,
				'status_date' => $t['status_date']
			);

			$title = $tpl->getTitle();

			$email_controller->setRecipient($recipient,$recipient);
			$email_controller->setTitle($title);
			$email_controller->setContent($tpl->getParsedContent($parse).$this->auth->user['email_signature']);

			// send email

			if (!$email_controller->send()) {
				$this->error('Nie udało się wysłać wiadomości na adres e-mail: '.$recipient);
			}
			
		} else if ($t['status'] == 5) {
			// send email to customer
			
			// create voucher
			$voucher_tpl = '';
			$voucher_code = '';
			
			if ($t['voucher']) {
				$voucher = new Model_Voucher();
				$voucher
					->set('add_date', date('Y-m-d H:i:s'))
					->set('add_user_id', $this->auth->user['id'])
					->set('call_id', $t['oid'])
					->set('customer_id', $c->get('customer_id'))
					->set('code', Model_Voucher::GenerateCode())
					->save();
				
				$voucher_tpl = $voucher->getTemplate();
				$voucher_code = $voucher->get('code');
			}
			
			// create template object
			$tpl = new System_Messages_Custom($t['email_title'], $t['email_content']);

			// create email sender
			$email_controller = new Email_Controller();
			
			$parse = array(
				'company_name' => $c->get('company_name'),
				'phone' => $c->get('phone'),
				'email' => $c->get('email'),
				'gender' => $c->get('represented_by_gender'),
				'representant' => $c->get('represented_by'),
				'username' => $this->auth->user['name'].' '.$this->auth->user['lastname'],
				'notices' => $t['notice'],
				'address_street' => $c->get('address_street'),
				'address_zip' => $c->get('address_zip'),
				'address_city' => $c->get('address_city'),
				'nip' => $c->get('nip'),
				'date' => date('Y-m-d'),
				'voucher' => $voucher_code
			);

			$recipient = $c->get('email');
			
			$email_controller->setRecipient( $recipient, $recipient );
			$email_controller->setTitle( $tpl->getParsedTitle($parse) );
			$email_controller->setContent( $tpl->getParsedContent($parse) .
				$voucher_tpl . $this->auth->user['email_signature'] );
			
			
			if ($t['email_template_id']) {
				
				// get offer template
				$offer_template = new Model_Call_Template($t['email_template_id']);

				// create pdf with offer
				include(APPLICATION_PATH.'/include/plugins/mpdf57/mpdf.php');

				// create pdf template
				$pdf_tpl = new System_Messages_Custom('', $offer_template->get('content'));
				
				// generate pdf
				$mpdf = new mPDF('utf-8','A4',9,'arial',15,15,30,30); 

				$mpdf->SetHTMLHeader('<img src="'.BASE_DIR.'/upload/firmowka_top.png" style="margin: -35px -56px 0 -35px;" />');
				$mpdf->SetHTMLFooter('<img src="'.BASE_DIR.'/upload/firmowka_bottom.png" style="margin: 0 -116px -35px -85px;" />');

				$mpdf->WriteHTML($pdf_tpl->getParsedContent($parse));
				
				$offer_pdf_name = Routes::humanizeURL($offer_template->get('title')).'.pdf';
				
				$offer_pdf = $mpdf->Output($offer_pdf_name,'S');
				//$mpdf->Output();
				//die();
				
				// attach pdf to email
				$email_controller->attach_file_from_string($offer_pdf, $offer_pdf_name);
			}
			
			// send email

			if (!$email_controller->send()) {
				$this->error('Nie udało się wysłać wiadomości na adres e-mail: '.$recipient);
			}
		}
		
		$this->msg('Rozmowa została zapisana.');
		
		$this->request->refresh();
	}
	
	public function _remove_call() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora notatki, operacja została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Call_History($t['id']);
			$o->remove();
			
			$this->msg('Notatka została usunięta.');
		}
		
		$this->request->refresh();
	}
}