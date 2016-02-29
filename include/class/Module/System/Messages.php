<?php

class Module_System_Messages extends Modules_Handler {

	function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','configuration');
	}

	function index() {
		$this->list = new Modules_List_Handler($this->name, $this->view);
        $object = new Model_System_Message;
        $object->BelongsToObject('System_Action', 'action_id');
		$object->HasObject('System_Message_Description', 'message_id',false,'System_Message_Description.`lang` = \''.$this->session->get('language').'\'');
		$this->list->conditions->setOptions(array(
			'fields' => 'System_Message_Description.`title` AS `System_Message.title`,
					System_Message.`id` AS `System_Message.id`,
					System_Action.`name` AS `System_Action.name`,
					System_Action.`constant` AS `System_Action.constant`',
			'all_fields' => false));
		$this->list->populate($object, true, Config::Get('on_page.default'));
		
	}

	function edit() {

		$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
		
		$object = new Model_System_Message;
		$object->BelongsToObject('System_Action', 'action_id');
		$object->findById($this->oid);

		$this->output['object'] = $object;

		$actions_vars = Model_System_Action_Var::NewInstance()
				->find()
				->where('`action_id` = '.(int)$object->get('action_id'))
				->fetch();
		$this->output['actions_vars'] = $actions_vars;
		
		$this->output['langs'] = Config::GetLanguages();
		
		$this->output['description'] = $this->db->FetchRecords("SELECT `lang`, `title`, `content` FROM `system_message_description` WHERE `message_id` = ".(int)$this->output['object']->GetID(), DB_FETCH_ASSOC);
	}

	function add() {

		$object_vars = $this->rv->getVars('post');

		$this->output['object'] = new Model_System_Message($object_vars);
		$this->output['object']->BelongsToObject('System_Action', 'action_id');
		
		$this->output['langs'] = Config::GetLanguages();
	}
}