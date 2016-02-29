<?php

class Modules_List_Handler extends Modules_List_Core {
	
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
}