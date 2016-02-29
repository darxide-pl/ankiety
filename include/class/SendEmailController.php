<?php

/**
 * 
 * Swift 4 Plugin extension
 * 
 * @author Szymon Błąkała <vsemak@gmail.com>
 * @version 1.1
 * 
 * CHANGELOG
 * 
 ** v1.1
 *	- transport param added (php::mail() or smtp server)
 *	- fixed addRecipient (to multiple recipients, before it was using setRecipient phisics)
 *	- added setRecipient (to rewrite actual recipients)
 *
 */

require_once DIR_INC_PLUGINS."Swift4/lib/swift_required.php";

class SendEmailController {

	public $swift_transport;
	public $swift_mailer;
	public $swift_message;

	private $content;
	private $title;
	
	private $failures;
	
	private $images;
	
	# tablica z danymi do konta pocztowego
	private $_account;
	
	function __construct($acc = 'email', $title = null) {

		if ($acc instanceof Model_Email_Account) {
			
		} else {
			
			if (Config::Exists($acc.'.smtp_server')) {
				$acc_data = array(
					'sender_email' => Config::Get($acc.'.sender_email'),
					'sender_name' => Config::Get($acc.'.sender_name'),
					'smtp_server' => Config::Get($acc.'.smtp_server'),
					'smtp_login' => Config::Get($acc.'.smtp_login'),
					'smtp_password' => Config::Get($acc.'.smtp_password'),
					'smtp_port' => Config::Get($acc.'.smtp_port'),
					'smtp_secure' => Config::Get($acc.'.smtp_secure'),
					'transport' => Config::Get($acc.'.transport')
				);
				$acc = new Model_Email_Account($acc_data);
			}
			if (!$acc instanceof Model_Email_Account) {
				$acc = new Model_Email_Account();
			}
		}

		$this->_account = $acc;
		
		if ($this->_account->Get('smtp_port') < 1) {
			if (strpos($this->_account->Get('smtp_server'), 'gmail.com') != false) {
				$this->_account->Set('smtp_port',465);
			}
		}
		
		switch ($this->_account->Get('smtp_secure')) {
			case 'none':
				$secure = null;
				break;
			case 'ssl':
				$secure = 'ssl';
				break;
			case 'tls':
				$secure = 'tls';
				break;
			case 'auto':
			default:
				$secure = null;
				
		}
	
		if ($this->_account->Get('transport') == 'mail') {
			
			$this->swift_transport = Swift_MailTransport::newInstance();
			
		} else {
			$this->swift_transport = Swift_SmtpTransport::newInstance(
				$this->_account->Get('smtp_server'), 
				$this->_account->Get('smtp_port'), 
				$secure)
				->setUsername($this->_account->Get('smtp_login'))
				->setPassword($this->_account->Get('smtp_password'));
		}

		$this->swift_mailer = Swift_Mailer::newInstance($this->swift_transport);
		$this->swift_message = Swift_Message::newInstance();
		$this->swift_message->setFrom($this->_account->Get('sender_email'), $this->_account->Get('sender_name'));
		
		if ($title) {
			$this->setTitle($title);
		}
	}

	function setAuthor($email, $name) {
		$this->swift_message->setFrom($email, $name);
	}

	function addRecipient($email, $name) {
		$this->swift_message->addTo($email, $name);
	}
	
	function setRecipient($email, $name) {
		$this->swift_message->setTo($email, $name);
	}

	public function setReplyTo($email,$name = null) {
		$this->swift_message->setReplyTo($email,$name?$name:$email);
	}
	
	public function setReturnPath($email) {
		$this->swift_message->setReturnPath($email);
	}
	
	function setTitle($title) {
		$this->title = $title;
		$this->swift_message->setSubject($title);
	}

	function setContent($content, $type = 'text/html') {
		$this->content = $content;
		$this->swift_message->setBody($content, $type);
	}
	
	public function addPart($content, $type = 'text/plain') {
		$this->swift_message->addPart($content, $type);
	}
	
	/**
	 * @param type $path
	 * @return new embed path
	 */
	public function embed_image($path) {
		return $this->swift_message->embed(Swift_Image::fromPath($path));
	}
	
	/**
	 * Embed all images in document
	 * @param string $content 
	 * @return document with embed images
	 */
	public function findAndEmbedAllImages($content) {
	
		$match = array();
		
		preg_match_all('~<img.*?(?:\s+src="([^"]+)").*/>~', $content, $match);

		if (sizeof($match[1])) {
			foreach ($match[1] as $src) {

				$path = str_replace('http://biostat.home.pl/crm/', APPLICATION_PATH.'/', $src);
				
				// attach image
				$new_src = $this->embed_image($path);

				// replace image url
				$content = str_replace($src, $new_src, $content);
			}
		}
		
		return $content;
	}
	
	/**
	 * 
	 * @param string $path
	 * @return new embed patch
	 */
	function attachFile($path) {
		return $this->swift_message->attach(Swift_Attachment::fromPath($path));
	}
	
	function send() {
		
		if (empty($this->title)) {
			throw new Exception('Nie podano tytułu wiadomości');
		}
		
		if ( empty($this->content)) {
			throw new Exception('Nie podano treści wiadomości.');
		}
		
		return $this->swift_mailer->send($this->swift_message, $this->failures);
	}
	
	function sendBatch() {
		
		if (empty($this->title)) {
			throw new Exception('Nie podano tytułu wiadomości');
		}
		
		if ( empty($this->content)) {
			throw new Exception('Nie podano treści wiadomości.');
		}
		
		return $this->swift_mailer->batchSend($this->swift_message, $this->failures);
	}
	
	function contFailures() {
		return sizeof($this->failures);
	}
	
	function getFailuresToString() {
		if (is_array($this->failures)) {
			return implode(', ', $this->failures);
		}
		return '';
	}
}