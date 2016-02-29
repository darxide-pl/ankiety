<?php

class Module_Events extends Modules_Handler {
	
	public function __construct() {
		
		parent::__construct();
		
		$this->rv->set('menu','events');
	}
	
	public function index() {
		
		$o = array(
			'id' => 'Event.`id`',
			'add_date' => 'Event.`add_date`'
		);
		
		$c = array(
			'search' => array( 'type' => 'multistring', 'value' => array('Event.`name`','Event.`description`'))
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'fields' => '(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = Event.`user_id`) AS `Event.user_name`'
		));
		$this->list->setDefaultOrderBy('id','desc');
		$this->list->populate(new Model_Event());
	}
	
	public function add() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Event();
		
		$this->output['object']
			//->set('title','')
			->set('publish',0)
			->set('add_date',date('Y-m-d H:i:s'))
			->save();
		
		$this->rv->set('oid',$this->output['object']->get('id'));
		
		$this->edit();
		
		$this->output['object']->set('publish',1);
		
		$this->view = 'edit';
	}
	
	public function edit() {
		
		if ($this->rv->get('preview') == 1) {
			$this->preview();
			return true;
		}
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		$this->addCss('/include/plugins/jquery/jquery-ui-1.10.1/css/smoothness/jquery-ui-1.10.1.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.10.1/js/jquery-ui-1.10.1.custom.min.js');
		
		$this->output['object'] = new Model_Event((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
	
		$this->output['galleries'] = $this->db->all("SELECT `id`,`name` FROM `gallery` ORDER BY `name` ASC;", DB_FETCH_ASSOC_FIELD);
		
		// lock system
		$lock = Model_System_Lock::Lock($this->auth->user['id'], 'events', $this->output['object']->get('id'));
		
		if ($lock < 1) {
			$this->error('To zdarzenie aktualnie edytuje inny użytkownik.');
			$this->redirect('index');
		}
		
		$this->output['lock'] = true;
	}
}