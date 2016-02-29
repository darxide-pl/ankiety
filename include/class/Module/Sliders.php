<?php

class Module_Sliders extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','sliders');
	}
	
	public function index() {
		
		$this->addCss('/include/plugins/jquery/jquery-ui-1.9.2/css/smoothness/jquery-ui-1.9.2.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js');
		
		$parent_id = $this->rv->get('parent_id');
		
		$o = array(
			'pos' => 'Slider.`pos`'
		);
		
		$c = array(
			'search' => array( 'type' => 'multistring', 'value' => array('Slider.`name`','Slider.`description`')),
			'parent' => array( 'type' => 'number', 'value' => "`Slider`.`parent_id`", 'default' => ((int)$parent_id).'' ),
			'modified' => array('value'=>'`Slider`.`modify_date` != \'0000-00-00 00:00:00\'')
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'join' => '',
			'fields' => '(SELECT COUNT(*) FROM `slider` s WHERE s.`parent_id`= Slider.`id`) AS `Slider.children`, '.
				'(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = Slider.`user_id`) AS `Slider.user_name`'
		));
		$this->list->setDefaultOrderBy('pos','asc');
		$this->list->populate(new Model_Slider());
		
		$this->output['parent_id'] = $parent_id;
		
		$this->output['parent'] = new Model_Slider($parent_id);
	}
	
	public function add() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Slider();
		$this->output['user'] = new Model_User($this->auth->user['id']);
		
		$this->output['parent_id'] = (int)$this->rv->get('parent_id');
		
		# get new position
		$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `slider` WHERE `parent_id` = ".(int)$this->output['parent_id'].";",DB_FETCH_ARRAY_FIELD);
		
		$this->output['object']
				->set('publich',0)
				->set('add_date',date('Y-m-d H:i:s'))
				->set('user_id',$this->auth->user['id'])
				->set('pos',$position+1)
				->set('parent_id',$this->output['parent_id'])
				->save();
		
		$this->rv->set('oid',$this->output['object']->get('id'));
		
		$this->edit();
		
		$this->output['object']->set('publish',1);
		
		$this->output['new'] = true;
		
		$this->view = 'edit';
	}
	
	public function edit() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Slider((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
		
		// lock system
		
		$lock = Model_System_Lock::Lock($this->auth->user['id'], 'slider', $this->output['object']->get('id'));
		
		if ($lock < 1) {
			$this->error('Ten baner aktualnie edytuje inny użytkownik.');
			$this->redirect('index');
		}
		
		$this->output['lock'] = true;
		
		$this->output['groups'] = $this->db->FetchRecords("SELECT `id`, `name` FROM `slider` WHERE `parent_id` = 0 ORDER BY `pos` ASC;",DB_FETCH_ASSOC_FIELD);
	}
	
	public function build_breadcrumb($parent_id) {

		if ($parent_id > 0) {
			$breadcrumbs = array();
			do {
				$b = $this->db->FetchRecord("SELECT `name`,`id`,`parent_id` FROM `slider` WHERE `id` = ".(int)$parent_id);
				$parent_id = $b['parent_id'];
				$breadcrumbs []= $b;
			} while ($parent_id > 0);
		}

		$breadcrumb_string = '';
		
		if ($breadcrumbs) {
			$breadcrumbs = array_reverse($breadcrumbs);
			
			foreach ($breadcrumbs as $b) {
				$url = $this->link->Build(array('page'=>$this->name,'parent_id'=>(int)$b['id']));
				$breadcrumb_string .= '<li><a href="'.$url.'">'.$b['name'].'</a> <span class="divider">/</span></li>';
			}
		}
		return $breadcrumb_string;
	}
}