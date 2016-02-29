<?php

class Model_System_Language {
	
	private $_name;
	
	private $_language_ext = '.php';
	
	private $_path;

	private $_module;
	
	public function __construct($language, $module = null) {
		$this->_name = $language;
		$this->_module = $module;
		$this->_path = $this->_buildPath();
	}
	
	private function _buildPath() {
		if ($this->_module) {
			$f = $this->_name . '_m_' . $this->_module;
		} else {
			$f = $this->_name;
		}
		return DIR_INC_LANGUAGES . $this->_name . LT . $f . $this->_language_ext;
	}
	
	function GetName() {
		return $this->_name;
	}
	
	function GetPath() {
		return $this->_path;
	}
	
	function Load() {
		if (file_exists($this->_path)) {
			include ($this->_path);
		} else {
			throw new Exception('Tłumaczenie nie istnieje. Język: '.$this->_name.'; Moduł: '.$this->_module.'; Ścieżka: '.$this->_path);
		}
	}
}