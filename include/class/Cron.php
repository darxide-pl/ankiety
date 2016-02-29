<?php

class Cron extends Core {
	
	public function __construct($debug = false) {
		
		parent::__construct();
		
		try {
			
			// newsletter acceptations has higher priority
			$count = $this->_emailcampaign_newsletter_acceptations_process();
			
			if ($count < 10) {
				$this->_emailcampaign_bounces_process();
			}
			
		} catch (Exception $e) {
			if ($debug) {
				echo $e->getMessage();
			}
		}
	}
	
	public function _emailcampaign_bounces_process() {
		
		$hostname = '{'.$this->cfg->get('emailbox.server')
				.($this->cfg->get('emailbox.port')?':'.$this->cfg->get('emailbox.port'):'')
				.'/'.$this->cfg->get('emailbox.protocole')
				.($this->cfg->get('emailbox.secure')?'/'.$this->cfg->get('emailbox.secure'):'')
				.($this->cfg->get('emailbox.cerificate')?'/'.$this->cfg->get('emailbox.cerificate'):'')
				.'}'.$this->cfg->get('emailbox.folder');
		
		$username = $this->cfg->get('emailbox.login');
		$password = $this->cfg->get('emailbox.password');
		$bounce_email = $this->cfg->get('emailcampaign.bounce_email');
		$bounce_limit = $this->cfg->get('emailcampaign.bounce_limit');
		
		$bounce = new Email_Bounces($hostname, $username, $password, $bounce_email, $bounce_limit);
		return $bounce->read_mailbox();
	}
	
	public function _emailcampaign_newsletter_acceptations_process() {
		
		$hostname = '{'.$this->cfg->get('newsletterbox.server')
				.($this->cfg->get('newsletterbox.port')?':'.$this->cfg->get('newsletterbox.port'):'')
				.'/'.$this->cfg->get('newsletterbox.protocole')
				.($this->cfg->get('newsletterbox.secure')?'/'.$this->cfg->get('newsletterbox.secure'):'')
				.($this->cfg->get('newsletterbox.cerificate')?'/'.$this->cfg->get('newsletterbox.cerificate'):'')
				.'}'.$this->cfg->get('newsletterbox.folder');
		
		$username = $this->cfg->get('newsletterbox.login');
		$password = $this->cfg->get('newsletterbox.password');
		$email = $this->cfg->get('newsletter.replay_to');
		$limit = $this->cfg->get('newsletter.message_limit');
		
		$bounce = new Email_Newsletter_Acceptations($hostname, $username, $password, $email, $limit);
		return $bounce->read_mailbox();
	}
}