<?php

class Module_Galleries extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','galleries');
	}
	
	public function index() {
		
		$this->addCss('/assets/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		$this->addJs('/assets/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		
		$o = array(
			'name' => 'Gallery.`name`',
			'id' => 'Gallery.`id`',			
			'update_date' => 'Gallery.`update_date`',
			'status' => 'Gallery.`active`',
			'pos' => 'Gallery.`pos`'
		);
		$c = array(
			'search' => array('type'=>'multistring','value'=>array('Gallery.`name`'))
		);
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultOrderBy('pos','asc');
		$this->list->populate(new Model_Gallery(),false,250);
	}
	
	public function add() {
		
		$this->oid = 0;
		
		$this->output['object'] = new Model_Gallery();
	}
	
	public function edit() {
		
		if (!$this->oid) {
			$this->error('Proszę wybrać galerię do edycji.');
			$this->redirect('index');
		}
		
		$this->addCss('/assets/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		$this->addJs('/assets/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Gallery($this->oid);
		$this->output['object']->set('update_user',$this->db->first("SELECT CONCAT(`name`,' ',`lastname`) FROM `user` WHERE `id` = ".(int)$this->output['object']->get('update_user_id'),DB_FETCH_ARRAY_FIELD));
		$this->output['images'] = $this->db->all("SELECT * FROM `gallery_image` WHERE `gallery_id` = ".(int)$this->oid." ORDER BY `pos` ASC;");
		
		$this->output['next'] = $this->db->first("SELECT `id` FROM `gallery` WHERE `id` > ".(int)$this->oid." ORDER BY `id` ASC LIMIT 1", DB_FETCH_ARRAY_FIELD);
		$this->output['prev'] = $this->db->first("SELECT `id` FROM `gallery` WHERE `id` < ".(int)$this->oid." ORDER BY `id` DESC LIMIT 1", DB_FETCH_ARRAY_FIELD);
	}
}