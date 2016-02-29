<?php

class FileHandler {
	
	protected $_path;
	protected $_extension;
	protected $_file_name;
	protected $_dir_name;
	protected $_file_size;
	
	function __construct($path) {

		$this->_path = $path;
	
		$p = pathinfo($path);
		$this->_extension = $p['extension'];
		$this->_dir_name = $p['dirname'];
		$this->_file_name = substr($p['basename'],0,strrpos($p['basename'],'.'));
	
	}
	
	function getSize() {
		return filesize($this->_path);
	}
	
	function getExt() {
		return $this->_extension;
	}
	
	function setExtension($ext) {
		$this->_extension = $ext;
	}
	
	function getFileName() {
		return $this->_file_name;
	}
	
	function getDirName() {
		return $this->_dir_name;
	}
	
	function getPath() {
		return $this->_path;
	}
	
	function buildSubFilePath($suffix = '', $prefix = '') {
		if (!$this->_error) {
			return $this->getDirName().'/'.($prefix?$prefix.'_':'').$this->getFileName().($suffix?'_'.$suffix:'').'.'.$this->getExt();
		}
		return false;
	}
}