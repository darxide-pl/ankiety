<?php

class Module_News extends Modules_Handler {
	
	public function __construct() {
		
		parent::__construct();
		
		$this->rv->set('menu','news');
		 
		if ($this->rv->isset_var('l')) {
			$this->set('language',$this->rv->get('l') != 'pl' ? 'en' : 'pl');
		}
		
		if ($this->get('language') == '') {
			$this->set('language','pl');
		}
	}
	
	public function index() {
		
		$o = array(
			'id' => 'News.`id`',
			'add_date' => 'News.`add_date`'
		);
		
		$c = array(
			'search' => array( 'type' => 'multistring', 'value' => array('News.`title`','News.`text`')),
			'language' => array('value'=>'`News`.`language` = \''.$this->db->quote($this->get('language')).'\''),
			'group_id' => array('value'=>'`News`.`group_id` = '.(int)$this->get('group_id'))
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'fields' => '(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = News.`user_id`) AS `News.user_name`'
		));
		$this->list->setDefaultOrderBy('add_date','desc');
		$this->list->populate(new Model_News());
	}
	
	public function add() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_News();
		
		$this->output['object']
				->set('title','aktualnosc')
				->set('publish',0)
				->set('add_date',date('Y-m-d'))
				->set('language',$this->get('language'))
				->set('group_id',$this->get('group_id'))
				->save();
		
		$this->rv->set('oid',$this->output['object']->get('id'));
		
		$this->edit();
		
		$this->output['object']->set('publish',1);
		
		$this->view = 'edit';
	}
	
	public function preview() {
		
		$this->layout = 'tpl:index';
		$this->view = 'preview';
		
		$object = new Model_News($this->rv->getVars('post'));
		
		Hp::Set('title',$object->get('meta_title')?$object->get('meta_title'):$object->get('title'));
		if ($object->get('meta_description')) Hp::Set('description',$object->get('meta_description'));
		if ($object->get('meta_keywords')) Hp::Set('keywords',$object->get('meta_keywords'));
		
		$this->output['object'] = $object;
	}
	
	public function edit() {
		
		if ($this->rv->get('preview') == 1) {
			$this->preview();
			return true;
		}
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		$this->addCss('/include/plugins/jquery/jquery-ui-1.10.1/css/smoothness/jquery-ui-1.10.1.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.10.1/js/jquery-ui-1.10.1.custom.min.js');
		
		$this->output['object'] = new Model_News((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
	
		// lock system
		$lock = Model_System_Lock::Lock($this->auth->user['id'], 'news', $this->output['object']->get('id'));
		
		if ($lock < 1) {
			$this->error('Ten news aktualnie edytuje inny użytkownik.');
			$this->redirect('index');
		}
		
		$this->output['lock'] = true;
	}
	
	public function revisions() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		$this->addCss('/include/tpl/text_diff.css');
		
		$this->output['object'] = new Model_News((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
		
		$o = array(
			'add_date' => 'News_Copy.`add_date`'
		);
		
		$c = array(
			'news_id' => array( 'type' => 'number', 'value' => "`News_Copy`.`news_id`", 'default' => ((int)$this->rv->get('oid')).'' ),
			'search' => array( 'type' => 'multistring', 'value' => array('News_Copy.`title`','News_Copy.`text`')),
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'join' => '',
			'fields' => '(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = News_Copy.`user_id`) AS `News_Copy.user_name`'
		));
		$this->list->setDefaultOrderBy('add_date','desc');
		$this->list->populate(new Model_News_Copy());
		
		if ($this->rv->get('rid')) {
			$this->output['revision'] = new Model_News_Copy($this->rv->get('rid'));
		}
	}
}