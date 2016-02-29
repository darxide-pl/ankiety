<?php

/**
 * @title Użytkownicy systemu
 * @acl users
 */
class Module_Users extends Modules_Handler {

	function __construct() {

		parent::__construct();
		
		$this->rv->set('menu','users');
	}
	
	/**
	 * @title Lista użytkowników
	 */
	function index() {
		
		$o = array(
			'id' => 'User.id',
			'name' => 'User.name',
			'lastname' => 'User.lastname',
			'status' => 'User.active',
			'email' => 'User.email',
			'group' => 'User.group_id',
			'add_date' => 'User.add_date',
			'last_visit' => '`User.last_visit`'
		);
		
		$c = array(
			'status' => 	array( 'type' => 'number', 'value' => "`User`.`active`" ),
			'group_id' => 	array( 'type' => 'number', 'value' => "`User`.`group_id`" ),
			'search' => 	array( 'type' => 'multistring', 'value' => array('User.`name`','User.`lastname`','User.`email`')),
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c);
		$this->list->setDefaultOrderBy('id','asc');
		
		if (!Auth::isSuperadmin()) {
			$this->list->conditions->add('User_Group .`hidden` IS NULL OR User_Group .`hidden` = 0');
		}
        
        $this->list->conditions->setOption('group', '`User`.`id`');
        
        $User = new Model_User;
		$User->BelongsToObject('User_Group', 'group_id');
        $User->HasObject('User_Login_History','user_id',false);
        
        $this->list->conditions->setOption('fields', 'MAX(`User_Login_History`.`date`) AS `User.last_visit`');

		$this->list->populate($User);

        $this->output['groups'] = $this->_loadUserGroups();
	}
	
	/**
	 * @title Formularz edycji użytkownika
	 */
	function edit() {
		
		$this->addJs('/include/plugins/ckeditor4/ckeditor.js');
		
		$object = new Model_User;
		$object->findById($this->oid);
		
		if (!$object) {
			$this->error('Nie udało się pobrać danych użytkownika.');
		} else {
			$this->output['object'] = $object;
            $this->output['groups'] = $this->_loadUserGroups();
		}

		$this->output['modules'] = $this->db->all("SELECT * FROM `system_module` WHERE `access` != '' ORDER BY `title`;");
		$this->output['object']->set('access_list', unserialize($this->output['object']->get('access_list')));
	}
	
	/**
	 * @title Formularz nowego użytkownika
	 */
	function add() {
		$object_vars = $this->rv->getVars('post');
		$this->output['object'] = new Model_User($object_vars);
        $this->output['groups'] = $this->_loadUserGroups();
	}
	
	/**
	 * @title Edycja konta zalogowanego użytkownika
	 */
	function edit_account() {
		$object = new Model_User($this->auth->user['id']);
		if (!$object->GetID()) {
			$this->error('Nie udało się pobrać danych użytkownika.');
		} else {
			$this->output['object'] = $object;
		}
	}
	
    private function _loadUserGroups() {
        $group = new Model_User_Group;
        $options = Auth::isSuperadmin() ? '' : array('where' => 'User_Group.code != \'programers\' AND User_Group.code != \'__anonymous\' AND User_Group.code != \'customer\'');
        $groups = $group->find($options);
        return Generic_Object::ExtractObjectToList($groups, 'id', 'name');
    }

    /**
	 * @title Historia logowania użytkownika
	 */
	function login_history() {
		
		$o = array(
			'id' => 'User_Login_History.id',
			'date' => 'User_Login_History.`date`'
		);
		
		$c = array(
			'user_id' => array( 'type' => 'number', 'value' => "`User_Login_History`.`user_id`"),
		);
		
		$f = array(
			'user_id' => $this->oid
		);
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $o, $c, $f);
		$this->list->setDefaultOrderBy('date','desc');
		$this->list->populate('Model_User_Login_History');
	}
	
	/**
	 * @title Rejestracja użytkownika
	 */
	public function register() {

	}
	
	/**
	 * @title Prawa dostępu
	 */
	public function groups_rights() {
		
		// rewrite menu to configuration 
		$this->rv->set('menu','configuration');
		
		$order_attributes = array(
			'name' => 'System_Module.name'
		);
		
		$conditions = array();
		
		$this->list = new Modules_List_Handler($this->name, $this->view, $order_attributes, $conditions);
		$this->list->setDefaultOrderBy('name','asc');
		$this->list->conditions->setOption('fetch_array',true);
		
		$population = $this->list->populate('Model_System_Module',false,999);
		
		$_views = array();
		if ($population) {
			$View = new Model_System_Module_View;
			$View->BelongsToObject('System_Module','module_id',false);
			$views = $View
				->find()
				->fetch_array(true)
				->order('System_Module_View.`name`')
				->fields('System_Module.`object` AS `System_Module.object`')
				->fetch();
			if ($views) {
				foreach ($views as $k => $v) {
					$_views[$v['System_Module.object']][] = $v;
				}
			}
			$this->output['views'] = $_views;
		}
		
		$sql = "SELECT `id`, `name` FROM `user_group` WHERE `code` != 'programers' ORDER BY `id` ASC;";
		$ugroups = $this->db->FetchRecords($sql);
		
		$this->output['ugroups'] = $ugroups;
		
		# load all views rights and modules rights
		$views_grouped = array();
		$modules_grouped = array();
		
		if ($ugroups) {
			foreach ($ugroups as $group) {
				
				# modules
				$sql = "SELECT sm.`object` AS `module`, ugr.`access` FROM `system_module` sm LEFT JOIN `user_group_right` ugr ON ugr.`module` = sm.`object` AND (ugr.`view` = '' OR ugr.`view` IS NULL) AND ugr.`group_id` = ".(int)$group['id'].";";
				$modules = $this->db->FetchRecords($sql,DB_FETCH_ASSOC_FIELD);
		
				$modules_grouped [$group['id']] = $modules;
				
				# views
				$sql = "SELECT smv.`module` AS `module`, smv.`view` AS `view`, ugr.`access` FROM `system_module_view` smv LEFT JOIN `user_group_right` ugr ON ugr.`module` = smv.`module` AND ugr.`view` = smv.`view` AND ugr.`group_id` = ".(int)$group['id'].";";
				$views = $this->db->FetchRecords($sql);
				
				
				if ($views) {
					foreach ($views as $view) {
						$views_grouped [$view['module'].'-'.$view['view'].'-'.$group['id']] = (int)$view['access'];
					}
				}
			}
		}
		
		$this->output['view_rights'] = $views_grouped;
		$this->output['modules_rights'] = $modules_grouped;
	}
}