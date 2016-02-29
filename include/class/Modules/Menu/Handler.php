<?php

class Modules_Menu_Handler {

	private $menu = array();
	private $options = array();
	private $module_name;
	private $view;
	private $prefix;
	private $add_button = '';
	private $search_field;
	
	private $css_class = 'list-table';

	function __construct($view, $module_name = null) {
		$this->prefix = '';
		$this->view = trim($view);
		$this->module_name = trim($module_name);
	}
	
	public function setCssClass($css_class) {
		$this->css_class = $css_class;
	}

	function add($view, $name, $href = null) {
		if (!empty($view) && !empty($name)) {
			if (!$href) {
				$href = array('page' => $this->module_name, 'subpage' => $view);
			}
			$href = Link::Instance()->Build($href);
			$this->menu [$view]['name'] = $name;
			$this->menu [$view]['href'] = $href;
		}
	}
	
	function addIfActive($view, $name, $href = null) {
		if ($this->view == $view) {
			$this->add($view, $name, $href);
		}
	}
	
	function addSub($view, $name, $href = null) {
		$name = '<span class="pointer">'.$name.'</span>';
		$this->add($view, $name, $href);
	}

	function isIn($views = array()) {
		if (is_array($views) && sizeof($views)) {
			return (bool) in_array($this->view, $views);
		}
		return false;
	}
	
	function addOption($view, $name, $href) {
		if (!empty($view) && !empty($name)) {
			$href = f_link($href);
			$this->options [$view][] = array('name' => $name, 'href' => $href);
		}
	}
	
	function addSearchField($title = null, $subpage = null, $field_name = null) {
		$this->search_field = array(
			'title' 		=> $title ? $title : 'Szukaj',
			'subpage'		=> $subpage ? $subpage : $this->view,
			'field_name' 	=> $field_name ? $field_name : 'search');
	}

	function isEmpty() {
		return (bool) !sizeof($this->menu);
	}
	
	function draw() {
		
		$s = '';
		
		if (is_array($this->menu) && sizeof($this->menu)) {
			$s .= Html::BoxOpen();
			$s .= '<table class="'.$this->css_class.'" cellspacing="0" cellpadding="0">';
			foreach ($this->menu as $view => $link) {
				$active = ($view == $this->view) ? 'active ' : '';
				$s .= '<tr class="'.$active.'clickable" onclick="location.href=\''.$link['href'].'\';"><td>'.$this->prefix;
				$s .= '<a href="'.$link['href'].'">'.$link['name'].'</a></td></tr>';
			}
			if (isset($this->options[$this->view]) && is_array($this->options[$this->view]) && sizeof($this->options[$this->view])) {
				foreach ($this->options[$this->view] as $link) {
					$s .= '<tr class="clickable add" onclick="location.href=\''.$link['href'].'\';"><td>'.$this->prefix;
					$s .= '<a href="'.$link['href'].'" class="plus">'.$link['name'].'</a></td></tr>';
				}
			}
			if ($this->search_field) {
				$s .= '<tr><th class="title">'.$this->search_field['title'].'</th></tr>';
				$s .= '<tr><td><form action="'.f_link(array('page'=>$this->module_name,'subpage'=>$this->search_field['subpage'])).'" id="mod_search_form" name="mod_search_form" method="post">';
				$s .= Html::TextInput('filters['.$this->search_field['field_name'].']',null,array('size'=>13,'maxlen'=>512));
				$s .= f_html_draw_button('submit_search',' ','document.getElementById(\'mod_search_form\').submit();').'</form></td></tr>';
			}
			$s .= '</table>';
			$s .= Html::BoxClose();
		}

		return $s;
	}

}