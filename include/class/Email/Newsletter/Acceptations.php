<?php

class Email_Newsletter_Acceptations extends Core {

	private $data;
	
	private $mailbox;
	
	/**
	 * 
	 * @param type $server
	 * @param type $username
	 * @param type $password
	 */
	public function __construct($server, $username, $password, $email, $limit = 25) {
		$this->data ['server'] = $server;
		$this->data ['username'] = $username;
		$this->data ['password'] = $password;
		$this->data ['email'] = $email;
		$this->data ['limit'] = (int)$limit;
	}
	
	public function read_mailbox() {

		$this->mailbox = imap_open($this->data['server'], $this->data['username'], $this->data['password']);
		
		if (!$this->mailbox) {
			throw new Exception('Nie udało się otworzyć skrzynki. Popraw dane dostępowe i spróbuj ponownie. '. imap_last_error());
		}

		$emails = imap_search($this->mailbox,'UNSEEN');//, 'UNSEEN');
		
		$i = 0; // processed count
		
		if ($emails) {
			
			/* for every email... */
			foreach ($emails as $k => $email_number) {

				if (($k+1) == $this->data ['limit']) {
					break;
				}
				
				$i ++;
				
				/* get information specific to this email */

				//$overview = imap_fetch_overview($this->mailbox, $email_number, 0);
				// $overview[0]->seen, $overview[0]->subject, $overview[0]->from, $overview[0]->date

				$message = imap_utf8(imap_fetchheader($this->mailbox, $email_number));

				imap_clearflag_full($this->mailbox, $email_number, "//Seen");
				
				// process bounce email
				$analysis = $this->process_message($message);

				if (!empty($analysis['email'])) {
					
					$user  = $this->db->FetchRecord("SELECT * FROM `newsletter_user` WHERE `email` = '".$this->db->quote($analysis['email'])."'
						AND `newsletter_id` = ".(int)$analysis['newsletter_id'].";");
					if ($user && !$user['accepted']) {
						
						// set row as accepted
						$sql = "UPDATE `newsletter_user` SET `accepted` = 1 WHERE
							`email` = '".$this->db->quote($analysis['email'])."'
							AND `newsletter_id` = ".(int)$analysis['newsletter_id'].";";

						$this->db->query($sql);
					}
					
					
					self::Send_Newsletter($analysis['newsletter_id'],$analysis['email']);
				}

				// remove message
				imap_delete($this->mailbox, $email_number);
			}
		}

		imap_close($this->mailbox, CL_EXPUNGE);
		
		return $i;
	}
	
	function process_message($message) {
		
		$analysis = array(
			'email' => 0,
			'newsletter_id' => 0
		);
		
		// first see if we can find the unique header ID for a given mail
		//In-Reply-To: <1354965218.7379.79852b5b234fa752c55a8ecaa06b055c@i-bazy.pl>
		$match = array();
		$matched = preg_match(
			'/In-Reply-To:(.*)\r?\n/', $message, $match
		);
		
		if ($matched) {

			$message_id = str_replace(array('<','>'),'',trim($match[1]));
			
			$sql = "SELECT * FROM `email_stack` WHERE `message_id` = '".$this->db->quote($message_id)."'
						AND `type` = 1;";
			$row = $this->db->FetchRecord($sql);
			
			if ($row && $row['email'] ) {
				$analysis['email'] = $row['email'];
				$analysis['newsletter_id'] = $row['database_id'];
			}
		}

		// if we don't have that, then we'll try identifying the user the hard way,
		// by examining all of the email addresses we can find.

		if (empty($analysis['mail'])) {
			
			$match = array();
			//To: szymon <szymon@aisza.com.pl>
			$matched = preg_match(
				'/To.?:[^<>]*<(.*)>\r?\n/', $message, $match
			);
			if ($matched) {
				$email = strtolower(trim($match[1]));
			}

			$sql = "SELECT count(1) AS `count`, `database_id`, `type` FROM `email_stack` WHERE `email` = '".$this->db->quote($email)."';";
			$row = $this->db->FetchRecord($sql, DB_FETCH_ARRAY);

			if ($row['count'] > 0) {
				$analysis['mail'] = $email;
				$analysis['database_id'] = $row['database_id'];
				$analysis['type'] = $row['type'];
			}
		}

		return $analysis;
	}
	
	public static function Send_Newsletter($newsletter_id, $email) {
		
		$newsletter = new Model_Newsletter($newsletter_id);
		
		$senders []= Config::Get('email.sender_email');
			
		$_other_senders = preg_split('/[,]+/', Config::Get('emailcampaign.additional_senders'), null, PREG_SPLIT_NO_EMPTY);
		if ($_other_senders) {
			$_other_senders = array_map( 'trim', $_other_senders );
			foreach ($_other_senders as $sender) {
				$senders [] = $sender;
			}
		}

		$smtp = new SendEmailController();
		$smtp->setTitle( $newsletter->get('title') );
		
		$sender_name =  $newsletter->get('sender_name') ? $newsletter->get('sender_name') : Config::Get('email.sender_name');
		
		$smtp->setAuthor( $senders[0], $sender_name);
		
		if (!f_check_email($email)) {
			Db::Instance()->Update('newsletter_user',array('sent'=>'-1'),'`email` = \''.$email.'\'');
			return false;
		}
		
		$smtp->setRecipient($email, $email);
		
		// get message id
		$message_id = $smtp->swift_message->getHeaders()->get('Message-ID');
		$message_id->setId(microtime(true).'.'.md5($email).'@i-bazy.pl');

		// set our custom bounce id
		$smtp->swift_message->getHeaders()->addIdHeader('x-bounce-identifier', $smtp->swift_message->getHeaders()->get('Message-ID')->getId());
		
		Db::Instance()->Insert('email_stack',array(
			'date' => date('Y-m-d H:i:s'),
			'database_id' => $newsletter_id,
			'type' => 1,
			'email' => $email,
			'message_id' => $message_id->getId()
		));
		
		if ($newsletter->get('reply_to')) {
			$smtp->setReplyTo($newsletter->get('reply_to'));
		}

		$html = str_replace('{ADRES_REZYGNACJI}',Link::Instance()->Build('subscribers/resignation').'?email='.$email.'&amp;id='.$message_id->getId(),$newsletter->get('html'));
		$html = str_replace('{ADRES_POTWIERDZENIA}',Link::Instance()->Build('subscribers/acceptation').'?email='.$email.'&amp;id='.$message_id->getId(),$html);
		$html = $smtp->findAndEmbedAllImages($html);
		$html .= '<img src="'.Link::Instance()->Build('subscribers/set_readed').'/read.gif?email='.$email.'&amp;id='.$message_id->getId().'" alt="" width="0" height="0" />';

		$text = str_replace('{ADRES_REZYGNACJI}',Link::Instance()->Build('subscribers/resignation').'?email='.$email.'&amp;id='.$message_id->getId(),$newsletter->get('text'));
		$text = str_replace('{ADRES_POTWIERDZENIA}',Link::Instance()->Build('subscribers/acceptation').'?email='.$email.'&amp;id='.$message_id->getId(),$text);

		$smtp->setContent($html,'text/html');
		$smtp->addPart($text,'text/plain');

		if ($smtp->send()) {
			Db::Instance()->Update('newsletter_user',array('sent'=>1,'send_date'=>date('Y-m-d H:i:s')),'`email` = \''.$email.'\' AND `newsletter_id` = '.(int)$newsletter->get('id'));
		} else {
			Db::Instance()->Update('newsletter_user',array('sent'=>'-2'),'`email` = \''.$email.'\' AND `newsletter_id` = '.(int)$newsletter->get('id'));
		}
		
		return true;
	}
}
