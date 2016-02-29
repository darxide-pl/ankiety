<?php

class Modules_List_Header {
	
	private $_module;
	private $_headers;
	private $_order_attributes;
	private $_order_by;
	private $_order_dir;
	private $_view;

	function __construct($module_name, $order_attributes, $order_dir, $order_by, $view = null) {
		$this->_module = $module_name;
		$this->_order_attributes = $order_attributes;
		$this->_order_dir = ((int)$order_dir)^1;
		$this->_order_by = $order_by;
		$this->_view = $view;
	}

	function add($name, $order_by = '', $width = 0, $colspan = null) {
		$this->_headers []= array('name' => $name, 'order_by' => $order_by, 'width' => $width, 'colspan' => $colspan);
	}

	function count() {
		$count = 0;
		if (is_array($this->_headers)) {
			foreach ($this->_headers as $v) {
				if ($v['colspan'] > 0) {
					$count += (int) $v['colspan'];
				} else {
					$count ++;
				}
			}
		}
		return $count;
	}

	function draw() {
		
		if (is_array($this->_headers)) {
			$rows = '<tr>';
			foreach ($this->_headers as $h) {
				
				$active = (!empty($this->_order_by) && $this->_order_by == $h['order_by']);
				
				$name = $h['name'];
				$width = $h['width'] > 0 ? ' style="width:'.$h['width'].'px;"' : '';
				$class = $active ? 'selected' : '';
				
				$src = DIR_INC_IMAGES . ($this->_order_dir ? 'list_up_a.png' : 'list_down_a.png');
				
				$style = $active ? ' style="padding-right: 15px; background: url(\''.$src.'\') no-repeat top right;"' : '';
				
				if (!empty($h['order_by'])) {
					$name = '<a href="'.f_get_current_url(false).'?order_by='.$h['order_by'].'&amp;direction='.$this->_order_dir.'">'.$name.'</a>';
				}
				
				$colspan = $h['colspan'] > 0 ? ' colspan="'.(int)$h['colspan'].'" ' : '';
				$rows .= '<th' . $width . ' class="title '. $class. '"' . $colspan . '>' . $name . '</th>';
			}
			$rows .= '</tr>';

			return '<thead>' . $rows . '</thead>';
		}
		return false;
	}
	
	
	function __toString() {
		if (! ($s = $this->draw())) {
			return (string) '';
		}
		return $s;
	}
}