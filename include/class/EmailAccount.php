<?php

/**
 * 
 * Email account
 * 
 * @author Szymon Błąkała <vsemak@gmail.com>
 * @version 1.1
 *
 * CHANGELOG
 * 
 ** v1.1
 *  - transport param added (important in Validate method)
 *
 */

class EmailAccount extends Generic_Object {
	
	public function __construct($data = array(), $options = null) {
		$this->_not_real[__CLASS__] = true;
		parent::__construct($data,$options);
	}
	
	public function Validate() {
		
		if ($this->Get('transport') == 'mail') {
			
			# php send mail function
			// mail();
			
		} else {
		
			if ($this->Get('smtp_server') == '') {
				throw new Exception('Serwer SMTP poczty wychodzącej nie został zdefiniowany.');
			}
			
			if ($this->Get('smtp_port') < 1) {
				throw new Exception('Port służący do połączenia z serwerem SMTP nie został zdefiniowany lub jest nieprawidłowy.');
			}
			
			if ($this->Get('smtp_login') == '') {
				throw new Exception('Nie podano loginu do konta e-mail.');
			}
			
			if ($this->Get('smtp_password') == '') {
				throw new Exception('Nie podano hasła do konta e-mail.');
			}
		}
		
		if ($this->Get('sender_email') == '') {
			throw new Exception('Nie podano adresu e-mail nadawcy.');
		}
		
		if ($this->Get('sender_name') == '') {
			throw new Exception('Nie podano nazwy nadawcy wiadomości e-mail.');
		}
	}
}