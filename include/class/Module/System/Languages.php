<?php

class Module_System_Languages extends Modules_Handler {

	function __construct() {

		parent::__construct();
	}
	
	function index() {
		
		if ($this->rv->get('on_page') > 0) {
			$this->set('on_page',(int)$this->rv->get('on_page'));
		}
		
		if (!$this->get('on_page')) {
			$this->set('on_page',10);
		}
		
		if ($this->rv->isset_var('set_language')) {
			$this->set('language',$this->rv->get('set_language'));
		}
		
		$sql = "SELECT * FROM `i18n_language` ORDER BY `name`;";
		
		$this->output['langs'] = $this->db->FetchRecords($sql,DB_FETCH_ARRAY);
		
		if (!$this->get('language') && $this->output['langs'][0]) {
			$this->set('language',$this->output['langs'][0]['key']);
		}
	
		$c = array(
			'lang' => array('value'=>'`I18n_Translation`.`lang` = \''.$this->get('language').'\''),
			'only_empty' => array('type'=>'if','true'=>'(`ToTranslate`.`id` IS NULL OR `ToTranslate`.`text` = \'\')','false'=>''),
			'search' => array('type'=>'multistring','value'=>array('`I18n_Translation`.`text`','`I18n_Translation`.`key`','`ToTranslate`.`text`'))
		);

		$o = array(
			'key' => 'I18n_Translation.`key`',
		);
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultOrderBy('key');
		$this->list->conditions->setOptions(array(
			'join' => 'LEFT JOIN `i18n_translation` `ToTranslate` ON `ToTranslate`.`key` = `I18n_Translation`.`key` AND `ToTranslate`.`lang` = \'pl\'',
			'fields' => '`ToTranslate`.`text` AS `ToTranslate.text`, `ToTranslate`.`id` AS `ToTranslate.id`',
		));
		$this->list->populate(new Model_I18n_Translation,false,$this->get('on_page'));
	}
}