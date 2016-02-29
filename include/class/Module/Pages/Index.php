<?php

class Module_Pages_Index extends Modules_Handler {

	public function __construct() {
		parent::__construct();
	}

	public function index() {
		
		$alias = Routes::humanizeURL( trim($this->rv->get('alias')) );
		
		$preview = $this->rv->get('preview') && $this->auth->checkRight('admin|programers');
		
		if (!$alias && !$preview) {

			// homepage
			
			$object = Model_Page::NewInstance()
					->find()
					->where('`homepage` = 1')
					->first();

			//$this->layout = 'tpl:home';
			
			$this->view = 'home';

			if (Config::get('slider.show')) {
				$this->output['slides'] = $this->db->all("SELECT * FROM `slider` WHERE `publish` = 1 ORDER BY `pos` ASC;");
			}
			
			//Helper_Offers::Generate_Random(date('Y-m-d',strtotime('+17 days')),3);
			
			if ($this->auth->checkRight('admin|programers')) {

				$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
				$this->addJs('/assets/js/admin.js');

				if ($this->rv->isset_var('save')) {
					$object
						->set('text',$this->rv->get('text'))
						->save();
				}

				if ($this->rv->isset_var('save_data')) {
					$this->db->update('page_data',array(
						'value' => $this->rv->get('value')
					),'`key` = \''.$this->db->quote($this->rv->get('key')).'\' AND `lang` = \''.$this->db->quote($this->rv->get('language')).'\'');
				}
			}

		} else { 
		
			// subpage
			if ($preview) {
				
				$object = new Model_Page($this->rv->getVars('post'));
				
			} else {
				$object = Model_Page::NewInstance()
					->find()
					->where('`alias` = \''.$this->db->quote($alias).'\'')
					->first();
			}
			
			if ($this->auth->checkRight('admin|programers')) {

				$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
				$this->addJs('/assets/js/admin.js');

				if ($this->rv->isset_var('save')) {
					$object
						->set('text',$this->rv->get('text'))
						->save();
				}
			}
			
			if ($object) {
				
				$object->get('parent_id') > 0	? Bootstrap::$page_current []= $object->get('parent_id') : null;
				$object->get('id') > 0			? Bootstrap::$page_current []= $object->get('id') : null;
				
			} elseif (!$object) {
				
				$object = Model_News::NewInstance()
					->find()
					->where('`alias` = \''.$this->db->quote($alias).'\'')
					->first();
				
				if ($object) {

					$this->view = 'news';

					$parent = Model_Page::NewInstance()
						->find()
						->where('`system_key` = \'news\'')
						->first();
				} else {
					
					$object = Model_Event::NewInstance()
						->find()
						->where('`alias` = \''.$this->db->quote($alias).'\'')
						->first();
					
					if ($object) {
					
						$object->set('title',$object->get('name'));

						if ($object->get('gallery_id')) {
							$this->output['gallery_images'] = $this->db->all("SELECT * FROM `gallery_image` WHERE `gallery_id` = ".(int)$object->get('gallery_id')." ORDER BY `pos` ASC;");
						}
						
						$this->view = 'event';
						
						$parent = Model_Page::NewInstance()
							->find()
							->where('`system_key` = \'events\'')
							->first();

					}
				}
				
				if ($parent) {
					Bootstrap::$page_current []= $parent->get('id');
				}
			}
		}
		
		if (!$object || !$object->get('id') || ($object->get('publish') == 0 && !$preview)) {
			
			if (!$alias) {
				die('Strona główna nie istnieje.');
			} else {
				$this->error('Strona nie istnieje.');
				$this->request->execute(array(''),true);
			}
		} else {

			if ($object->get('access') == 1 && !$this->auth->isLoged() && !$preview) {
				$this->error('Aby przeglądać tą sekcję musisz zalogować się.');
				$this->redirect_url('/user/login/');
			}
			
			if (!$preview) {
				$object->set('views_total',$object->get('views_total')+1)->save();
			}
		}
		
		Hp::Set('title',$object->get('meta_title')?$object->get('meta_title'):$object->get('title'));
		Hp::Set('description',$object->get('meta_description'));
		Hp::Set('keywords',$object->get('meta_keywords'));
			
		$this->output['parents'] = Helper_Pages::Find_Parents($object->get('id'),0,$object->get('group_id'));
			
		$this->rv->set('parents', $this->output['parents']);
		
		if ($this->output['parents']) {
			
			$this->output['parents_ids_list'] = array();

			foreach ($this->output['parents'] as $parent) {
				$this->output['parents_ids_list'] []= $parent['id'];
				if ($parent['publish']) {
					Breadcrumbs::add($parent['title'],$this->link->Build(Model_Page::Build_Url($parent)));
				}
			}
		} else {

			Breadcrumbs::add($object->get('title'),$this->link->Build(Model_Page::Build_Url($object)));
		}
		
		$this->output['object'] = $object;
		
		if ($object->get('system_key') == 'news') {
			
			$o = array(
				'add_date' => '`News`.`add_date`'
			);
			
			$c = array(
				'publish' => array('value'=>'`News`.`publish` = 1')
			);
			
			$f = array();
			
			$this->list = new Modules_List_Handler($this->name,$this->view.'-news',$o,$c,$f);
			$this->list->setDefaultOrderBy('add_date','DESC');
			
			$this->output['news'] = $this->list->populate(new Model_News(),true,8);
			
		}
	
		if (Config::get('page.faq') > 0 && Config::get('page.faq_show') > 0) {
			
			$this->output['questions'] = Model_Page::NewInstance()
				->find()
				->where('`publish` = 1 AND `parent_id` = '.(int)Config::get('page.faq'))
				->order('RAND()')
				->limit(Config::get('page.faq_limit') > 0 ? Config::get('page.faq_limit') : 1)
				->fetch();
		}
		
		// custom pages
		if ($object->get('system_key')) {
			if (method_exists($this, '_plugin_'.$object->get('system_key'))) {
				call_user_method('_plugin_'.$object->get('system_key'), $this, $object);
			}
		}
	}

	private function _plugin_dostep(Model_Page $object) {
		$this->view = 'demo';
	}

	private function _plugin_demo(Model_Page $object) {
		$this->view = 'demo';
	}

	private function _plugin_support(Model_Page $object) {
		$this->view = 'support';
	}
	
	private function _plugin_contact(Model_Page $object) {
		
		$this->view = 'contact';
	}
	
	private function _plugin_news(Model_Page $object) {
		
	}
	
	public function gallery() {
		
		$this->addCss('/assets/js/fancybox/source/jquery.fancybox.css');
		$this->addJs('/assets/js/fancybox/source/jquery.fancybox.pack.js');
		
		$this->oid = $this->rv->get('oid');
		
		$object = new Model_Gallery($this->oid);
		
		$this->output['object'] = $object;
		
		$this->output['images'] = $this->db->all("SELECT * FROM `gallery_image` WHERE `gallery_id` = ".(int)$object->get('id')." AND `type` = 'color' ORDER BY `pos` ASC;");
	}
	
	public function search() {
		
		$this->output['object'] = new Model_Page();

		

		$query = '%'.$this->db->quote($this->rv->get('query')).'%';
		Breadcrumbs::add('Szukaj: '.$this->rv->get('query'), f_get_current_url());
		
		$queries = array();
		
		// news
		$queries[] = "SELECT `id`, `title`, `alias`, 'news' AS `search_type`, 0 AS `parent_id`, '' AS `name`, 0 AS `state_id` FROM `news` "
			. "WHERE `publish` = 1 "
			. "AND (`title` LIKE '".$query."' "
			. "OR `lead` LIKE '".$query."' "
			. "OR `text` LIKE '".$query."')";
		
		// page
		$queries[] = "SELECT `id`, `title`, `alias`, 'page' AS `search_type`, `parent_id`, '' AS `name`, 0 AS `state_id` FROM `page` "
			. "WHERE `publish` = 1 "
			. "AND (`title` LIKE '".$query."' " 
			. "OR `text` LIKE '".$query."' "
			. "OR `lead` LIKE '".$query."')"; 
		
		$sql = "SELECT * FROM (".implode(' UNION ALL ',$queries).") AS x ORDER BY x.`title` ASC;";
		
		$paginator = new Paginator();
		$paginator->populate($sql,array('page_nr' => $this->rv->get('page_nr')));
		
		$this->output['paginator'] = $paginator;
	}
}
