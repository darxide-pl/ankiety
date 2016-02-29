<?php

class Module_Products extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
		
		$this->rv->set('menu','products');
	}
	
	public function index() {
		
		$this->addCss('/assets/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		$this->addJs('/assets/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		
		$o = array(
			'name' => 'Product.`name`',
			'id' => array('Product.`serial` + 0','Product.`serial`'),
			'category' => 'ct.`name`',
			'update_date' => 'Product.`update_date`',
			'status' => 'Product.`active`',
			'pos' => 'Product.`pos`'
		);
		$c = array(
			'search' => array('type'=>'multistring','value'=>array('Product.`name`')),
			'category_id' => array('type'=>'number','value'=>'Product.`category_id`')
		);
		$f = array();
		
		$this->list = new Modules_List_Handler($this->name,$this->view,$o,$c,$f);
		$this->list->setDefaultOrderBy('pos','asc');
		$this->list->conditions->setOptions(array(
			'join' => 'LEFT JOIN `category` ct ON ct.`id` = Product.`category_id`',
			'fields' => 'ct.`name` AS `Product.category_name`'
		));
		$this->list->populate(new Model_Product(),false,250);
		
		$this->output['categories'] = $this->db->all("SELECT `id`,`name` FROM `category` ORDER BY `pos` ASC;",DB_FETCH_ASSOC_FIELD);
	}
	
	public function add() {
		
		$this->oid = 0;
		
		$this->addCss('/assets/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		$this->addJs('/assets/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		
		$this->output['object'] = new Model_Product();
		
		if ($this->rv->get('customer_id')) {
			$this->output['object']->set('customer_id',$this->rv->get('customer_id'));
		}
		
		$this->output['customers'] = $this->db->FetchRecords("SELECT `id`,`company_name` FROM `customer` ORDER BY `company_name` ASC;",DB_FETCH_ASSOC_FIELD);
		$this->output['categories'] = $this->db->all("SELECT `id`,`name` FROM `category` ORDER BY `pos` ASC;",DB_FETCH_ASSOC_FIELD);
		//$this->output['attributes'] = $this->db->FetchRecords("SELECT `id`,`name` FROM `attribute` ORDER BY `name` ASC;",DB_FETCH_ASSOC_FIELD);
	}
	
	public function edit() {
		
		if (!$this->oid) {
			$this->error('Proszę wybrać urządzenie do edycji.');
			$this->redirect('index');
		}
		
		$this->addCss('/assets/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		$this->addJs('/assets/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Product($this->oid);
		$this->output['object']->set('update_user',$this->db->first("SELECT CONCAT(`name`,' ',`lastname`) FROM `user` WHERE `id` = ".(int)$this->output['object']->get('update_user_id'),DB_FETCH_ARRAY_FIELD));
		$this->output['categories'] = $this->db->all("SELECT `id`,`name` FROM `category` ORDER BY `pos` ASC;",DB_FETCH_ASSOC_FIELD);
		
		$category = new Model_Category($this->output['object']->get('category_id'));
		
		$sql = "SELECT `id`,`name`,`allow_copy` FROM `attribute` WHERE `category_id` = ".(int)($category->get('parent_id')>0?$category->get('parent_id'):$category->get('id'))." ORDER BY `pos` ASC;";
		$this->output['attributes'] = $this->db->all($sql,DB_FETCH_ASSOC);
		$this->output['attributes_values'] = $this->db->all("SELECT `attribute_id`,`value` FROM `product_attribute` WHERE `product_id` = ".(int)$this->oid.";",DB_FETCH_ASSOC_FIELD);
		
		$sql = "SELECT * FROM `product_stroller` WHERE `product_id` = ".(int)$this->oid." ORDER BY `brand` ASC;";
		$this->output['strollers'] = $this->db->all($sql,DB_FETCH_ASSOC);
		
		$this->output['images_top'] = $this->db->all("SELECT * FROM `product_image` WHERE `product_id` = ".(int)$this->oid." AND `type` = 'top' ORDER BY `pos` ASC;");
		$this->output['images_desc'] = $this->db->all("SELECT * FROM `product_image` WHERE `product_id` = ".(int)$this->oid." AND `type` = 'desc' ORDER BY `pos` ASC;");
		$this->output['images'] = $this->db->all("SELECT * FROM `product_image` WHERE `product_id` = ".(int)$this->oid." AND `type` = 'main' ORDER BY `pos` ASC;");
		$this->output['colors'] = $this->db->all("SELECT * FROM `product_image` WHERE `product_id` = ".(int)$this->oid." AND `type` = 'color' ORDER BY `pos` ASC;");
		
		$this->output['accessories'] = $this->db->all("SELECT p.*,(SELECT i.`filename` FROM `product_image` i WHERE i.`type` = 'main' AND i.`product_id` = p.`id` ORDER BY i.`pos` ASC LIMIT 1) AS `image_filename` FROM `product` p WHERE p.`category_id` = 5;");
		$this->output['related'] = $this->db->all("SELECT `related_id`, `related_id` FROM `product_relation` WHERE `product_id` = ".(int)$this->oid.";",DB_FETCH_ASSOC_FIELD);
		$this->output['movies'] = $this->db->all("SELECT * FROM `product_movie` WHERE `product_id` = ".(int)$this->oid." ORDER BY `pos` ASC;",DB_FETCH_ASSOC);
		
		$this->output['next'] = $this->db->first("SELECT `id` FROM `product` WHERE `id` > ".(int)$this->oid." ORDER BY `id` ASC LIMIT 1", DB_FETCH_ARRAY_FIELD);
		$this->output['prev'] = $this->db->first("SELECT `id` FROM `product` WHERE `id` < ".(int)$this->oid." ORDER BY `id` DESC LIMIT 1", DB_FETCH_ARRAY_FIELD);
	}
	
	public function add_category() {
		$this->output['object'] = new Model_Category();
	}
	
	public function edit_category() {
		
		if (!$this->oid) {
			$this->error('Proszę wybrać grupę do edycji.');
			$this->redirect('index');
		}
		
		$this->output['object'] = new Model_Category($this->oid);
	}
	
	public function attributes_list() {
		
		$this->layout = 'none';
		
		$category = new Model_Category($this->rv->get('category_id'));
		
		$sql = "SELECT `id`,`name`,`allow_copy` FROM `attribute` WHERE `category_id` = ".(int)($category->get('parent_id')>0?$category->get('parent_id'):$category->get('id'))." ORDER BY `pos` ASC;";
		
		$this->output['attributes'] = $this->db->all($sql,DB_FETCH_ASSOC);
		$this->output['attributes_values'] = $this->db->FetchRecords("SELECT `attribute_id`,`value` FROM `product_attribute` WHERE `product_id` = ".(int)$this->rv->get('oid').";",DB_FETCH_ASSOC_FIELD);
	}
	
	public function settings() {
		
		$categories = $this->db->all("SELECT c.`id`, c.`parent_id`, c.`name`, (SELECT COUNT(*) FROM `product` p WHERE p.`category_id` = c.`id`) AS `products` FROM `category` c ORDER BY c.`pos` ASC;");		
		
		if ($categories) {
			foreach ($categories as $c) {
				$this->output['categories'][$c['parent_id']] [$c['id']] = $c;
			}
		}
		
		//$this->addCss('/js/ui/css/jquery-ui-1.9.0.custom.min.css');
		//$this->addJs('/js/ui/js/jquery-ui-1.9.0.custom.min.js');
		
		$this->addJs('/assets/js/jquery.sortable.js');
	}
}