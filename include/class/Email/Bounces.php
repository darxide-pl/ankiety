<?php

/**
 * insert into bounce_processing_scores (smtp_code, score, description) values
('421', 0, 'Probably greylist response'),
('422', 0, 'Server out of space error'),
('450', 0, 'Varying soft bounces'),
('451', 0, 'Greylist response'),
('452', 50, 'Soft account out of space bounce'),
('454', 0, 'Temporary server error'),
('500', 25, 'Server error'),
('501', 25, 'Server error'),
('502', 25, 'Server error'),
('503', 25, 'Server error'),
('504', 25, 'Server error'),
('550', 50, 'Definitive hard bounce'),
('551', 50, 'Definitive hard bounce'),
('553', 50, 'Definitive hard bounce'),
('554', 50, 'Definitive hard bounce'),
('552', 50, 'Hard account out of space bounce'),
('4.1.1', 25, 'No such mailbox'),
('4.2.1', 25, 'Mailbox disabled'),
('4.2.2', 25, 'Mailbox full'),
('4.7.1', 0, 'Greylist response'),
('5.1.1', 50, 'No such mailbox'),
('5.2.1', 50, 'Mailbox disabled'),
('5.2.2', 50, 'Mailbox full');
 */

class Email_Bounces extends Core {

	private $data;
	
	private $mailbox;
	
	/**
	 * 
	 * @param type $server
	 * @param type $username
	 * @param type $password
	 */
	public function __construct($server, $username, $password, $bounce_email, $bounce_limit = 50) {
		$this->data ['server'] = $server;
		$this->data ['username'] = $username;
		$this->data ['password'] = $password;
		$this->data ['bounce_email'] = $bounce_email;
		$this->data ['bounce_limit'] = (int)$bounce_limit;
	}
	
	public function read_mailbox() {

		$this->mailbox = imap_open($this->data['server'], $this->data['username'], $this->data['password']);
		
		if (!$this->mailbox) {
			throw new Exception('Nie udało się otworzyć skrzynki. Popraw dane dostępowe i spróbuj ponownie. '. imap_last_error());
		}

		$emails = imap_search($this->mailbox, 'UNSEEN FROM "'.$this->data ['bounce_email'].'"');
		
		if ($emails) {

			/* for every email... */
			foreach ($emails as $k => $email_number) {

				if (($k+1) == $this->data ['bounce_limit']) {
					break;
				}
				
				/* get information specific to this email */

				//$overview = imap_fetch_overview($this->mailbox, $email_number, 0);
				// $overview[0]->seen, $overview[0]->subject, $overview[0]->from, $overview[0]->date

				$message = imap_utf8(imap_fetchbody($this->mailbox, $email_number, 1));

				// process bounce email
				$analysis = $this->process_message($message);

				if (!empty($analysis['mail'])) {

					if ($analysis['type'] == '1') {
						
						// set row as bounced
						$sql = "UPDATE `newsletter_user` SET `bounced` = 1 WHERE
							`email` = '".$this->db->quote($analysis['mail'])."'
							AND `newsletter_id` = ".(int)$analysis['database_id'].";";
						
					} else {
						
						// set row as bounced
						$sql = "UPDATE `database_row` SET `email_bounced` = 1 WHERE
							`email` = '".$this->db->quote($analysis['mail'])."'
							AND `database_id` = ".(int)$analysis['database_id'].";";
					
					}
					
					$this->db->query($sql);
				}

				// remove message
				imap_delete($this->mailbox, $email_number);
			}
		}
		
		imap_close($this->mailbox);
	}
	
	function process_message($message) {
		
		$analysis = array(
			'mail' => 0,
			'smtp_code' => '',
		);
		
		// first see if we can find the unique header ID for a given mail
		$match = array();
		$matched = preg_match(
			'/x-bounce-identifier.?:(.*)\r?\n/', $message, $match
		);
		
		if ($matched) {

			$message_id = str_replace(array('<','>'),'',trim($match[1]));

			$sql = "SELECT * FROM `email_stack` WHERE `message_id` = '".$this->db->quote($message_id)."';";
			$row = $this->db->FetchRecord($sql);
			
			if ($row && $row['email'] ) {
				$analysis['mail'] = $row['email'];
				$analysis['database_id'] = $row['database_id'];
				$analysis['type'] = $row['type'];
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

		// lastly, we try to find out what sort of non-delivery report this is.
		// we'll be using smtp codes, plus some other general categories

		
		$code = $this->process_smtp_code_from_text($message);
		$analysis['smtp_code'] = $code;
		
		if (empty($analysis['smtp_code'])) {
			$analysis['smtp_code'] = '-1';
		}
		
		// store the results if something was found
		if ($analysis['mail']) {
			$sql = "UPDATE `email_stack` SET `smtp_code` = '".$this->db->quote($analysis['smtp_code'])."' WHERE `email` = '".$this->db->quote($analysis['mail'])."' AND `database_id` = ".(int)$analysis['database_id'].";";
			$this->db->query($sql);
		}

		return $analysis;
	}
	
	/**
	 * Helper function to parse out an emails from text.
	 */
	function process_emails_from_text($text) {
		$matches = array();
		preg_match_all(
			"/([A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4})/i", $part['data'], $matches
		);
		return $matches[1];
	}

	/**
	 * Helper function to parse out an SMTP response code from text.
	 */
	function process_smtp_code_from_text($text) {
		// rfc821 return code e.g. 550
		$matches = array();
		if (preg_match('/\b([45][01257][012345])\b/', $text, $matches)) {
			return $matches[1];
		}
		// rfc1893 return code e.g. 5.1.1
		if (preg_match('/([45]\.[01234567]\.[012345678])/', $text, $matches)) {
			return $matches[1];
		}
		return '';
	}

}
