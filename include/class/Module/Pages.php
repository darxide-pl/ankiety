<?php

/**
 * @title Strony
 * @acl pages
 **/
class Module_Pages extends Modules_Handler {
	
	public function __construct() {
	
		parent::__construct();
		
		$this->rv->set('menu','pages');
		
		if ($this->rv->isset_var('l')) {
			$this->set('language',$this->rv->get('l') != 'pl' ? 'en' : 'pl');
		}
		
		if ($this->get('language') == '') {
			$this->set('language','pl');
		}
		
		if ($this->rv->isset_var('g')) {
			$this->set('group_id',$this->rv->get('g'));
		}
	}
	
	/**
	 * @title Lista stron
	 */
	public function index() {
		
		$this->addCss('/include/plugins/jquery/jquery-ui-1.9.2/css/smoothness/jquery-ui-1.9.2.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js');
		
		$parent_id = $this->rv->get('parent_id');
		
		$o = array(
			'id' => 'Page.`id`',
			'add_date' => 'Page.`add_date`',
			'pos' => 'Page.`pos`'
		);
		
		$c = array(
			'parent' => array( 'type' => 'number', 'value' => "`Page`.`parent_id`", 'default' => ((int)$parent_id).'' ),
			'search' => array( 'type' => 'multistring', 'value' => array('Page.`title`','Page.`text`')),
			'language' => array('value'=>'`Page`.`language` = \''.$this->db->quote($this->get('language')).'\''),
			'group_id' => array('value'=>'`Page`.`group_id` = '.(int)$this->get('group_id'))
		);
		
		$active_filters = Modules_List_Handler::GetActiveFilters('pages_index');
		if ($active_filters['search'] != '') {
			unset($c['parent']);
			$this->output['search'] = true;
		}
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'join' => '',
			'fields' => '(SELECT COUNT(*) FROM `page` p WHERE p.`parent_id`= Page.`id`) AS `Page.children`, '.
				'(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = Page.`user_id`) AS `Page.user_name`'
		));
		$this->list->setDefaultOrderBy('pos','asc');
		$this->list->populate(new Model_Page());
		
		$this->output['parent'] = new Model_Page($parent_id);
		
		$this->output['cfg_faq'] = new Model_Page((int)Config::get('page.faq'));

		$this->output['groups'] = $this->db->all('SELECT * FROM `page_group`');
		
	}
	
	/**
	 * @title Dodawanie stron
	 */
	public function add() {
		
		$this->addCss('/include/plugins/jquery/jquery-ui-1.9.2/css/smoothness/jquery-ui-1.9.2.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js');
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `page` WHERE `parent_id` = '".(int)$this->rv->get('parent_id')."' AND `language` = '".$this->get('language')."';", DB_FETCH_ARRAY_FIELD);
		
		$this->output['object'] = new Model_Page();
		$this->output['object']
				->set('parent_id',$this->rv->get('parent_id'))
				->set('language',$this->get('language'))
				->set('group_id',$this->get('group_id'))
				->set('pos',$position)
				->set('type',$this->rv->get('type'))
				->set('add_date',date('Y-m-d H:i:s'))
				->set('add_user_id',$this->auth->user['id'])
				->save()
				->set('publish',1);
		
		$this->output['user'] = new Model_User($this->auth->user['id']);
			
		$pages = Model_Page::NewInstance()
			->find()
			->all_fields(false)
			->fields('Page.`id` AS `Page.id`, Page.`title` AS `Page.title`, Page.`pos` AS `Page.pos`, Page.`parent_id` AS `Page.parent_id`')
			->where('`language` = \''.$this->db->quote($this->get('language')).'\' AND `group_id` = '.(int)$this->get('group_id'))
			->order('`parent_id` ASC,`pos` ASC')
			->fetch();

		$Tree = new Generic_Object_Tree_Builder($pages);
		$Tree->Build(0,0,$rows);

		$pages = array(
			0 => 'Brak'
		);
		if ($rows) {
			foreach ($rows as $row) {
				$pages [$row->get('id')] = str_repeat('|-- ',(int)$row->get('list.level')).' '.$row->get('title');
			}
		}
		
		$this->output['pages'] = $pages;
		
		$this->output['new'] = true;
		
		$this->view = 'edit';
	}
	
	/**
	 * @title Edycja strony
	 */
	public function edit() {
		
		if ($this->rv->get('preview') == 1) {
			$this->preview();
			return true;
		}
		
		$this->addCss('/include/plugins/jquery/jquery-ui-1.9.2/css/smoothness/jquery-ui-1.9.2.custom.min.css');
		$this->addJs('/include/plugins/jquery/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js');
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$this->output['object'] = new Model_Page((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
		
		// lock system
		
		$lock = Model_System_Lock::Lock($this->auth->user['id'], 'page', $this->output['object']->get('id'));
		
		if ($lock < 1) {
			$this->error('Tą stronę aktualnie edytuje inny użytkownik.');
			$this->redirect('index');
		}
		
		$this->output['lock'] = true;
		
		$pages = Model_Page::NewInstance()
			->find()
			->all_fields(false)
			->fields('Page.`id` AS `Page.id`, Page.`title` AS `Page.title`, Page.`pos` AS `Page.pos`, Page.`parent_id` AS `Page.parent_id`')
			->where('`id` != '.(int)$this->rv->get('oid').' AND `language` = \''.$this->db->quote($this->get('language')).'\' AND `group_id` = '.(int)$this->get('group_id'))
			->order('`parent_id` ASC,`pos` ASC')
			->fetch();

		$Tree = new Generic_Object_Tree_Builder($pages);
		$Tree->Build(0,0,$rows);

		$pages = array(
			0 => 'Brak'
		);
		if ($rows) {
			foreach ($rows as $row) {
				$pages [$row->get('id')] = str_repeat('|-- ',(int)$row->get('list.level')).' '.$row->get('title');
			}
		}
		
		$this->output['pages'] = $pages;
		
		$this->output['attributes'] = $this->db->FetchRecords("SELECT * FROM `page_faq` WHERE `page_id` = ".(int)$this->output['object']->get('id')." ORDER BY `pos` ASC;",DB_FETCH_ASSOC);
	}
	
	/**
	 * @title Rewizje
	 */
	public function revisions() {
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		$this->addCss('/include/tpl/text_diff.css');
		
		$this->output['object'] = new Model_Page((int)$this->rv->get('oid'));
		$this->output['user'] = new Model_User($this->output['object']->get('user_id'));
		
		$o = array(
			'add_date' => 'Page_Copy.`add_date`'
		);
		
		$c = array(
			'page_id' => array( 'type' => 'number', 'value' => "`Page_Copy`.`page_id`", 'default' => ((int)$this->rv->get('oid')).'' ),
			'search' => array( 'type' => 'multistring', 'value' => array('Page_Copy.`title`','Page_Copy.`text`')),
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->conditions->setOptions(array(
			'join' => '',
			'fields' => '(SELECT CONCAT(u.`name`,\' \',u.`lastname`) FROM `user` u WHERE u.`id` = Page_Copy.`user_id`) AS `Page_Copy.user_name`'
		));
		$this->list->setDefaultOrderBy('add_date','desc');
		$this->list->populate(new Model_Page_Copy());
		
		if ($this->rv->get('rid')) {
			$this->output['revision'] = new Model_Page_Copy($this->rv->get('rid'));
		}
	}
	
	/**
	 * @title Breadcrumb
	 */
	public function build_breadcrumb($parent_id) {

		if ($parent_id > 0) {
			$breadcrumbs = array();
			do {
				$b = $this->db->FetchRecord("SELECT `title`,`id`,`parent_id` FROM `page` WHERE `id` = ".(int)$parent_id);
				$parent_id = $b['parent_id'];
				$breadcrumbs []= $b;
			} while ($parent_id > 0);
		}

		$breadcrumb_string = '';
		
		if ($breadcrumbs) {
			$breadcrumbs = array_reverse($breadcrumbs);
			
			foreach ($breadcrumbs as $b) {
				$url = $this->link->Build(array('page'=>$this->name,'parent_id'=>(int)$b['id']));
				$breadcrumb_string .= '<li><a href="'.$url.'">'.$b['title'].'</a> <span class="divider">/</span></li>';
			}
		}
		return $breadcrumb_string;
	}
	
	/**
	 * @title Edycja treści HTML z poziomu strony
	 */
	public function edit_data_html() {
		
		$t = $this->rv->getVars('all');
		
		$this->addJs('/include/plugins/ckeditor/ckeditor.js');
		
		$sql = "SELECT * FROM `page_data` WHERE `key` = '".$this->db->quote($t['key'])."' AND `lang` = '".$this->session->get('language')."';";
		$this->output['object'] = $this->db->first($sql);
		
		if (!$this->output['object']) {
			$this->output['object'] = array(
				'key' => $t['key'],
				'lang' => $this->session->get('language'),
				'type' => 'html'
			);
		}
	}
}