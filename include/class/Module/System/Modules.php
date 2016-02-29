<?php

class Module_System_Modules extends Modules_Handler {

	function __construct() {

		parent::__construct();

		if ($this->rv->isset_var('module_id','request')) {
			$this->set('module_id', $this->rv->get('module_id','request'));
		}
	}
	
	function index() {
		
		$order_attributes = array(
			'name' => 'System_Module.name'
		);
		
		$conditions = array();
		
		$this->list = new Modules_List_Handler($this->name, null, $order_attributes, $conditions);
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
		
		$sql = "SELECT `id`, `name` FROM `user_group` ORDER BY `id` ASC;";
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
	
	function add() {
		$this->output['object'] = new Model_System_Module($this->rv->getVars('post'));
		$this->view = 'edit';
	}
	
	function edit() {
		$this->set('module_id',$this->oid);
		$this->output['object'] = new Model_System_Module($this->oid); 
	}
	
	function add_view() {
		
		$o = new Model_System_Module;
		$modules = Generic_Object::ExtractObjectToList($o->find(array('order' => 'System_Module.`name` ASC')),'id','name');
		f_array_unshift_assoc($modules,'0','- wybierz moduł -');
		
		$this->output['object'] = new Model_System_Module_View($this->rv->getVars('request'));
		$this->output['modules'] = $modules;
		
		$this->set('module_id',$this->output['object']->GetModuleId());
		
		$this->view = 'edit_view';
	}
	
	function edit_view() {
		$o = new Model_System_Module;
		$this->output['object'] = new Model_System_Module_View($this->oid); 
		$this->output['modules'] = Generic_Object::ExtractObjectToList($o->find(array('order' => 'System_Module.`name` ASC')),'id','name');
		
		$this->set('module_id',$this->output['object']->GetModuleId());
	}
}
