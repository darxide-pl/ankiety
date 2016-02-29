<?php

class Modules_List_Core extends Core {
	
	protected $_module;
	
	public $header;
	
	protected $_name;
	
	protected $_view;
	
	protected $_data = array();
	
	public $conditions;
	
	//public $fform;
	
	protected $_pages = 0;
	protected $_default_on_page = 50;
	protected $_actual_on_page = 0;
	protected $_amount = 0;
	protected $_offset = 0;
	
	protected $_order_attributes = array();
	protected $_default_order_by = '';
	protected $_default_order_dir = 0;
	
	protected $_css_class = 'list-table';
	protected $_draw_navigation = true;
	
	protected $_rows = array();
	
	protected $_border = true;
	
	protected $_link_params = array();
	
	protected $_options = array();
	
	function __construct($module, $name = null, $order_attributes = array(), $conditions = null, $filters = null, $options = array()) {
		
		if (is_array($options)) {
			foreach ($options as $k => $v) {
				$this->_data[$k] = $v;
			}
		}
		
		# init Core
		parent::__construct();
		
		$this->_module = $module;
		
		$this->_setOrderAttributes($order_attributes);
		
		$this->_name = 'list_'.$this->_module;
		
		if (!empty($name)) {
			$this->_name .= '_'.$name;
			$this->_view = $name;
		}
		
		if (is_array($filters) && sizeof($filters)) {
			$this->_data['filters'] = $filters;
		}

		$this->_reload();
		
		$this->conditions = new Modules_Conditions($this->_data['conditions']);
		
		if ($conditions) {
			$this->parseConditions($conditions);
		}
		
		//$this->fform = new Modules_Filters_Form($this->_data['filters']);
		
		$this->header = new Modules_List_Header($this->_module, array_keys($this->_order_attributes), $this->_data['order_dir'], $this->_data['order_by'], $this->rv->get('subpage', 'request'));
	}
	
	function AddLinkParam($name,$value) {
		$this->_link_params[$name] = $value;
	}
	
	function SetBorder($status = true) {
		$this->_border = (bool) $status;
	}
	
	function SetCssClass($class) {
		$this->_css_class = $class;
	}
	
	function GetPages() {
		return (int)$this->_pages;
	}
	
	public static function GetDataByModule($module, $var) {
		if (Session::Instance()->isset_var('list_'.$module)) {
			$data = Session::Instance()->get('list_'.$module);
			if (isset($data[$var])) {
				return $data[$var];
			}
		}
		return false;
	}
	
	public static function GetActiveFilters($module) {
		
		if (Request_Vars::Instance()->isset_var('reset_filters','all')) {
			return array();
		} else {
			if (Request_Vars::Instance()->isset_var('filters','all')) {
				return Request_Vars::Instance()->get('filters','all');
			} else {
				return Modules_List_Handler::GetDataByModule($module,'filters');
			}
		}
	}
	
	public function GetConditions() {
		$options = $this->conditions->getToString();
		$options['order'] = $this->_buildSortDirection();
		return $options;
	}
	
	function GetData($var) {
		return $this->_data[$var];
	}
	
	function GetFilter($filter) {
		return $this->_data['filters'][$filter];
	}
	
	function GetActualOnPage() {
		return $this->_actual_on_page;
	}
	
	function GetAmount() {
		return $this->_amount;
	}
	
	public function GetOffset() {
		return $this->_offset;
	}
	
	function turnOffNavigation() {
		$this->_draw_navigation = false;
	}
	
	function parseConditions($conditions) {
		if (is_array($conditions)) {
			$methods = array('number' => 'addNumber', 'datetime' => 'addDateTime', 'expression' => 'addExpression', 'string' => 'addString', 'multistring' => 'addMultiString', 'date' => 'addDate'); 
			foreach ($conditions as $k => $v) {
				
				if (!isset($v['type'])) {
					$v['type'] = null;
				}
				
				if (!isset($v['default'])) {
					$v['default'] = null;
				}
				
				if (!isset($v['values'])) {
					$v['values'] = null;
				}
				
				if (!isset($v['operator'])) {
					$v['operator'] = null;
				}
				
				if (!isset($v['exception'])) {
					$v['exception'] = null;
				}
				
				if (isset($this->_data['filters'][$k])) {
					$data = $this->_data['filters'][$k];
				} else {
					$data = null;
				}
	
				if ($data == null && $v['default'] != null) {
					$data = $v['default'];
					$this->_data['filters'][$k] = $data;
				}
				$v['value'] = $v['values'] ? (isset($v['values'][$data]) ? $v['values'][$data] : '') : $v['value'];
				
				if ($v['exception'] && $data == $v['exception']) {
					$data = null;
				}
				
				if (isset($methods[$v['type']])) {
					$this->conditions->{$methods[$v['type']]}($data, $v['value'], $v['operator']);
				} elseif ($v['type'] == 'if') {
					$this->conditions->addIf($data, $v['true'], $v['false']);
				} else if ($v['type'] == 'matchstring') {
					$this->conditions->addMatchString($data, $v['value'], $v['revelation'], $v['operator']);
				} else {
					if ($data == null && $v['default'] != null) {
						$v['value'] = $v['default'];
						$this->_data['filters'][$k] = $v['value'];
					}
					$v['value'] = $v['values'] ? $v['values'][$data] : $v['value'];
					$this->conditions->add($v['value']);
				}
			}
		}
	}
	
	/**
	 * @param type $classname
	 * @param type $list_foot
	 * @param type $on_page
	 * @param type $count_with_fields
	 * @return boolean 
	 */
	function populate($classname, $list_foot = true, $on_page = null, $count_with_fields = false) {
		
		if (!is_object($classname)) {
			$object = new $classname;
		} else {
			$object = $classname;
		}
		
		$options = $this->build_options($object, $list_foot, $on_page, $count_with_fields);
		
		
		if ($options) {

			return $this->_rows = Method::call(array($object, 'find'), array($options));
		}
		
		return false;
	}
	
	public function build_options($classname, $list_foot = true, $on_page = null, $count_with_fields = false) {
		
		$this->_draw_navigation = $list_foot;
		
		$options = $this->conditions->getToString();
		
		if ($on_page) {
			$this->_data['on_page'] = $on_page;
		} else {
			$this->_data['on_page'] = $this->_default_on_page;
		}
		
		if (!is_object($classname)) {
			$object = new $classname;
		} else {
			$object = $classname;
		}
		
		$count_options = $options;
		$count_options['count'] = $count_with_fields ? 2 : 2; // 2 : 1
		$count_options['order'] = $this->_buildSortDirection(); // new engine
		
		$this->_amount = Method::call(array($object, 'find'), array($count_options));
		
		if ($this->_amount) {
		
			$this->_pages = ceil($this->_amount / $this->_data['on_page']);
		
			if ($this->_data['page_nr'] < 1) {
				$this->_data['page_nr'] = 1;
			}
			if ($this->_data['page_nr'] > $this->_pages) {
				$this->_data['page_nr'] = $this->_pages;
			}
		
			$this->_offset = ( $this->_data['page_nr'] - 1 ) * $this->_data['on_page'];
		
			if ( $this->_amount > $this->_offset + $this->_data['on_page'] ) { # not last
				$this->_actual_on_page = $this->_data['on_page'];
			} else if ( $this->_offset > 0 ) { # last
				$this->_actual_on_page = $this->_amount % $this->_offset;
			} else { # first
				$this->_actual_on_page = $this->_amount;
			}
		
			$options['order'] = $this->_buildSortDirection();
			$options['limit'] = $this->_offset.", ".$this->_data['on_page'];
			
			return $options;
		}
		
		return false;
	}

	function population() {
		return $this->_rows;
	}
	
	function setDefaultOrderBy($order_by, $order_dir = 'asc') {
		$order_dir = strtolower($order_dir);
		$order_dir = $order_dir == 'desc' || $order_dir > 0 ? 1 : 0;
		$this->_default_order_by = $order_by;
		$this->_default_order_dir = $order_dir;
	}
	
	protected function _reload() {

		$last_data = $this->session->get($this->_name);
		
		if ($this->session->isset_var($this->_name)) {
			$this->_data = f_array_merge_with_keys($last_data, $this->_data);
		}

		if ($this->rv->isset_var('reset_filters','request')) {
			$this->_data['filters'] = array();
		}

		// catch filters sent by request (POST and GET)
		$this->_data['filters'] = $this->_catchFilters();
	
		/**
		 * Group conditions is to determine where to reset page number
		 * e.g.
		 * 	if u change category_id in products list
		 * 	u mean to see first element of this group of products
		 */
		if (isset($this->_data['group_by_condition']) && !empty($this->_data['group_by_condition'])) {
			
			$last_group_by_condition_value = '';
			
			// get last group by condition value
			if (isset($last_data['filters'][$this->_data['group_by_condition']])) {
				$last_group_by_condition_value = $last_data['filters'][$this->_data['group_by_condition']];
			}
			
			// reset page number if group by condition was changed
			if (isset($this->_data['filters'][$this->_data['group_by_condition']])) {
				if ($this->_data['filters'][$this->_data['group_by_condition']] != $last_group_by_condition_value) {
					$this->_data['page_nr'] = 0;
				}
			}
		}

		if ($this->rv->isset_var('order_by', 'request')) {
			
			if (!$this->rv->isset_var('direction')) {
				if ($this->_data['order_by'] == $this->rv->get('order_by', 'request')) {
					$this->_data['order_dir'] = $this->_data['order_dir'] ? 0 : 1;
				} else {
					$this->_data['order_dir'] = 0;
				}
			}
			
			$this->_data['order_by'] = $this->rv->get('order_by', 'request');
			
		}
		
		if ($this->rv->isset_var('direction', 'request')) {
			$this->_data['order_dir'] = $this->rv->get('direction', 'request');
		}
		
		if (!isset($this->_data['order_by'])) {
			$this->_data['order_by'] = null;
		}
		
		if (!isset($this->_data['order_dir'])) {
			$this->_data['order_dir'] = null;
		}
		
		if ($this->_data['remember_page_nr'] == false) {
			$this->session->set($this->_name, $this->_data);
		}
		
		if ($this->rv->isset_var('page_nr', 'request')) {
			$page_nr = $this->rv->get('page_nr', 'request');
			if ($page_nr) {
				$this->_data['page_nr'] = $page_nr;
			}
		}

		if (!isset($this->_data['page_nr'])) {
			$this->_data['page_nr'] = null;
		}
		
		if ($this->_data['remember_page_nr'] == true) {
			$this->session->set($this->_name, $this->_data);
		}
	}
	
	protected function _catchFilters() {
		$filters = array();
		if (isset($this->_data['filters'])) {
			$filters = $this->_data['filters'];
		}
		if ($this->rv->isset_var('filters', 'all')) {
			$post_filters = $this->rv->get('filters', 'all');
			if (is_array($post_filters)) {
				foreach ($post_filters as $k => $v) {
					$filters[$k] = $v;
				}
			}
		}
		return $filters;
	}
	
	public function _buildSortDirection() {

		if (empty($this->_data['order_by'])) {
			$this->_data['order_by'] = $this->_default_order_by;
			$this->_data['order_dir'] = $this->_default_order_dir;
		}
		
		$order_by = $this->_data['order_by'];
		$order_dir = $this->_data['order_dir'];
		
		$order_by = explode(',', $order_by);

		if (is_array($order_by) && sizeof($order_by)) {
			$s = '';
			foreach ($order_by as $v) {
				if ($this->_checkOrderBy($v)) {
					$v = $this->_getOrderBy($v);
					if (!is_array($v)) {
						$v = array($v);
					}
					foreach ($v as $v2) {
						$s .= ','.$v2.' '.($order_dir ? 'DESC' : 'ASC');
					}
				}
			}
			if (!empty($s)) {
				$s = substr($s,1);
			}
		}

		return $s;
	}
	
	protected function _getOrderBy($key) {
		return $this->_order_attributes[$key];
	}

	protected function _checkOrderBy($order_by) {
		if ( ! empty( $order_by ) ) {
			if ( array_key_exists( $order_by, $this->_order_attributes ) ) {
				return true;
			}
		}
		return false;
	}
	
	protected function _setOrderAttributes( $attributes ) {
		if ( ! is_array( $this->_order_attributes ) ) {
			$this->_order_attributes = array();
		}
		if (is_array($attributes)) {
			foreach ($attributes as $k => $v) {
				$this->_order_attributes[$k] = $v;
			}
		}
	}
	
	protected function _buildListNavigation() {
		
		$s = '<ul class="pagination">';
		$subpage = $this->rv->get('subpage', 'request');
		$linkparams = array('page' => $this->_module, 'subpage' => $subpage);
		if ($this->_link_params) {
			$linkparams = f_array_merge_with_keys($linkparams,$this->_link_params);
		}
		

		$linkparams['page_nr'] = ($this->_data['page_nr']-1);
		$s .= '<li '.($this->_data['page_nr'] > 1 ?'':'class="disabled"').'><a href="'.$this->link->Build($linkparams).'">&laquo;</a></li>';
	
		if ($this->_pages > 1) {
			$linkparams['page_nr'] = null;
			//$s .= '<select name="page_nr" class="form-control" onchange="location.href=\''.$this->link->Build($linkparams).'page_nr'.ELT.'\'+$(this).val()">';
			for($page = 1; $page<=$this->_pages; $page++) {
				$selected = $page == $this->_data['page_nr'] ? 'selected="selected"' : '';
				$linkparams['page_nr'] = $page;
				$s .= '<li '.($selected?'class="active"':'').'><a href="'.$this->link->Build($linkparams).'">'.$page.'</a></li>';
				//$s .= '<option value="'.$page.'" '.$selected.'>'.$page.'</option>';
			}
			//$s .= '</select>';
		}

		$linkparams['page_nr'] = ($this->_data['page_nr']+1);
		$s .= '<li '.($this->_data['page_nr'] < $this->_pages ?'':'class="disabled"').'><a href="'.$this->link->Build($linkparams).'">&raquo;</a></li>';

		return $s.'</ul>';
	}

	function paginator() {
		return $this->navigation();
	}
	
	function navigation() {
		
		$s = $this->_buildListNavigation();
		
		return $s;
	}
	
	function head($width = null, $top_navigation = true, $id = null) {
		
		//$s = $this->fform->getActiveFiltersString();
		
		if ($this->_border) {
			$s .= Html::BoxOpen($width);
		}
		
		if ($this->_draw_navigation && $top_navigation == true) {
			$s .= $this->navigation();
		}
		
		$s .= '<table class="'.$this->_css_class.'" id="'.$id.'" cellspacing="0" cellpadding="1">';
		
		$s .= $this->header;
		
		$s .= '<tbody>';
		
		return $s;
	}
	
	function row($title, $class = null, $onclick = null) {
		if (!empty($title)) {
			return '<tr><td colspan="'.$this->header->count().'" class="'.$class.'" onclick="'.$onclick.'">'.$title.'</td></tr>';
		}
	}
	
	function foot() {
		
		$s = '</tbody></table>';
		
		if ($this->_draw_navigation) {
			$s .= $this->navigation('list-nav-box-bottom');
		}
		
		if ($this->_border) {
			$s .= Html::BoxClose();
		}
		
		return $s;
	}
	
	function filters() {
		return $this->fform;
	}
	
	public function head_order_button($var, $title) {
		
		$url = Link::Instance()->build(array($this->_module,$this->_view,'order_by'=>$var,'direction'=>$this->GetData('order_dir')=='0'?1:0));
		$class = $this->GetData('order_by') == $var ? ($this->GetData('order_dir')=='0'?'order-asc':'order-desc') : '';
		if ($this->GetData('order_by') == $var) {
			$icon = $class == 'order-asc' ? '<i class="glyphicon glyphicon-chevron-down"></i>' : '<i class="glyphicon glyphicon-chevron-up"></i>';
		} else {
			$icon = '';
		}

		return '<a href="'.$url.'" '.$class.'>'.$title.' '.$icon.'</a>';
	}
}