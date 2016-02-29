<?php

class Module_Box extends Modules_Handler {
	
	public function __construct() {
		
		parent::__construct();
		
		$this->rv->set('menu','box');
	}
	
	public function index() {
		
		$o = array(
			'id' => 'Box.`id`',
			'add_date' => 'Box.`add_date`'
		);
		
		$c = array(
			'search' => array( 'type' => 'multistring', 'value' => array('Box.`title`','Box.`text`'))
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->setDefaultOrderBy('add_date','desc');
		$this->list->populate(new Model_Box());
	}
	
	public function add() {
		
		$this->output['object'] = new Model_Box();
		
		$this->output['object']
				->set('title','')
				->set('publish',0)
				->set('add_date',date('Y-m-d H:i:s'))
				->save();
		
		$this->rv->set('oid',$this->output['object']->get('id'));
		
		$this->edit();
		
		$this->output['object']->set('publish',1);
		
		$this->view = 'edit';
	}
	
	public function edit() {
		
		$this->addCss('/include/plugins/jquery/jquery-ui-1.10.1/css/smoothness/jquery-ui-1.10.1.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.10.1/js/jquery-ui-1.10.1.custom.min.js');
		
		$this->output['object'] = new Model_Box((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
	
		$this->output['page_box'] = $this->db->all("SELECT `page_id`, `page_id` FROM `page_box` WHERE `box_id` = ".(int)$this->output['object']->get('id').";",DB_FETCH_ASSOC_FIELD);
		
		$pages = Model_Page::NewInstance()
			->find()
			->all_fields(false)
			->fields('Page.`id` AS `Page.id`, Page.`homepage` AS `Page.homepage`, Page.`fullwidth` AS `Page.fullwidth`, Page.`title` AS `Page.title`, Page.`pos` AS `Page.pos`, Page.`parent_id` AS `Page.parent_id`')
			->where('`language` = \'pl\'')
			->order('`parent_id` ASC,`pos` ASC')
			->fetch();

		$rows = array();
		
		$Tree = new Generic_Object_Tree_Builder($pages);
		$Tree->Build(0,0,$rows);
		
		$this->output['pages'] = $rows;
		
		// lock system
		$lock = Model_System_Lock::Lock($this->auth->user['id'], 'box', $this->output['object']->get('id'));
		
		if ($lock < 1) {
			$this->error('Ten box aktualnie edytuje inny użytkownik.');
			$this->redirect('index');
		}
		
		$this->output['lock'] = true;
	}
}