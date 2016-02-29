<?php

class Language_Controller {
	
	private $language = '';
	
	public function __construct($language, $page = null) {
		$this->Set($language, $page);
	}
	
	public function Set($language, $page = null) {
		
		if (!empty($language)) {
			
			if (Session::Instance()->get('language') != $language &&
				Session::Instance()->isset_var('user_id') &&
				Session::Instance()->get('user_id') > 0) {
					
				$sql = "UPDATE `user` SET `language` = '".$language."' WHERE `id` = ".(int)Session::Instance()->get('user_id').";";

				if (!Db::Instance()->query($sql)) {
					$language = Page_Controller::$_PAGE_CONFIG['default_language'];
				}
			} else {
				Session::Instance()->set('language',$language);
			}
			
		} else {
			
			$language = Page_Controller::$_PAGE_CONFIG['default_language'];

			if (Session::Instance()->get('language') != '') {
				$language = Session::Instance()->get('language');
			}
			Session::Instance()->set('language',$language);
		}
		
		$this->language = $language;
		
		$L = new SysLanguage($this->language);
		try {
			$L->Load();
		} catch (Exception $e) {
			//$this->Error($e->getMessage());
		}

		if (!empty($page)) {
			$L = new SysLanguage($this->language, $module);
			try {
				$L->Load();
			} catch (Exception $e) {
				echo $e->getMessage();
				//$this->Error($e->getMessage());
			}
		}
	}
	
	public function GetLanguage() {
		return $this->language;
	}
}