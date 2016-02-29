<?php

class Modules_Filters_Form {
	
	private $_mod_filters;
	
	private $_action;
	private $_height;
	
	private $_fields;
	private $_row;
	
	function __construct($module_filters) {
		$this->_mod_filters = $module_filters;
		$this->_fields = array();
		$this->_row = 0;
	}
	
	function setHeight($height) {
		$this->_height = $height;
	}
	
	function setAction($action) {
		$this->_action = $action;
	}
	
	function nextRow() {
		$this->_row++;
	}
	
	function addField($title, $filter, $size = null, $maxlen = null) {
		$a = array();
		$a['size'] = $size;
		$a['maxlen'] = $maxlen;
		$a['id'] = 'filter_'.$filter;
		$name = 'filters['.$filter.']';
		
		$value = $this->_mod_filters[$filter];
		
		$field = Html::TextInput($name, $value, $a);
		
		$this->_fields[$this->_row][] = array('html' => $field, 'value' => $value, 'title' => $title);
	}
	
	function addSelect($title, $filter, $opt_array = array()) {
		$a = array();
		$a['id'] = 'filter_'.$filter;
		$name = 'filters['.$filter.']';
		$field = Html::Select($name, Html::SelectOptions($opt_array, $this->_mod_filters[$filter]), $a);
		$this->_fields[$this->_row][] = array('html' => $field, 'value' => $opt_array[$this->_mod_filters[$filter]], 'title' => $title);
	}
	
	/**
	 * Add filter SelectDate field
	 * @param $title
	 * @param $filter
	 * @param (date | dd/mm/yyy) $default 
	 * @return undefined
	 */
	function addSelectDate($title, $filter, $default = null) {
		
		$a = array();
		$a['id'] = 'filter_'.$filter;
		$name = 'filters['.$filter.']';

		$display_date = null;
		
		if (is_array($this->_mod_filters[$filter])) {
			$display_date = $true_date = implode('-', $this->_mod_filters[$filter]);
		} else if ($default) {
			$true_date = $default;
		}
		
		$field = Html::SelectDate($name, $true_date, $a);
		
		$this->_fields[$this->_row][] = array('html' => $field, 'value' => $display_date, 'title' => $title);
	}
	
	function addSelectDatetime($title, $filter, $default = null) {
		
		$a = array();
		$a['id'] = 'filter_'.$filter;
		$name = 'filters['.$filter.']';

		$display_date = null;
		
		if (is_array($this->_mod_filters[$filter])) {
			$display_date = $true_date = implode('-', $this->_mod_filters[$filter]);
		} else if ($default) {
			$true_date = $default;
		}
		
		$field = Html::SelectDatetime($name, $true_date, $a);
		
		$this->_fields[$this->_row][] = array('html' => $field, 'value' => $display_date, 'title' => $title);
	}
	
	function getActiveFiltersString() {
		$return = false;
		if (is_array($this->_fields) && sizeof($this->_fields)) {
			$s = '<div id="filters-str">';
			$s2 = '';
			foreach ($this->_fields as $row_id => $fields) {
				if (is_array($fields) && sizeof($fields)) {
					foreach ($fields as $k => $field) {
						if ($field['value'] != null) {
							$s2 .= '<span>'.$field['title'].' <b>'.$field['value'].'</b></span>';
							$return = true;
						}
					}
				}
			}
			$s .= $s2;
			$clear_url = f_link(array('page' => $_GET['page'], 'subpage' => $_GET['subpage'], 'reset_filters' => 'true'));
			$s .= '<span><a href="'.$clear_url.'" class="xlink">' . TFBOX_BUTT_REMOVE_FILTERS . '</a></span>';	
			$s .= '</div>';
		}
		if ($return) {
			return $s;
		} else return '';
	}
	
	function __toString() {
		
		if (is_array($this->_fields) && sizeof($this->_fields)) {
		
			$s = f_html_filters_box_open($this->_action, $this->_height);
			$s .= '<table>';
			foreach ($this->_fields as $row_id => $fields) {
				if (is_array($fields) && sizeof($fields)) {
					$s .= '<tr>';
					foreach ($fields as $k => $field) {
						$s .= '<th>'.$field['title'].'</th>';
						$s .= '<td>'.$field['html'].'</td>';
					}
					$s .= '</tr>';
				}
			}
			$s .= '</table>';
			$s .= f_html_filters_box_close();
			return $s;
		}
		return '';
	}
}