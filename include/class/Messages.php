<?php

/**
 * 
 * Messages handler (errors/success)
 * 
 * @author Szymon Błąkała <vsemak@gmail.com>
 * @version 1.0
 *
 */

class Messages {
	/**
	 * Container for Messages instace
	 * @var Messages
	 */
	private static $_Instance;
	
	private $_messages;
	
	private function __construct() {
		 $this->_messages = array();
	}
	
	/**
	 * Get instance of first Messages object,
	 * instead of creating another new.
	 * 
	 * @return new Messages or pointer
	 */
	static function Instance() {
		if (!isset(self::$_Instance)) {
			self::$_Instance = new Messages;
		}
		return self::$_Instance;
	}
	
	public function isError() {
		return (int) sizeof ($this->_messages['errors']);
	}
	
	function getAll() {
		return $this->getErrors() . $this->getSuccess();
	}

	function getErrors( $clear = true ) {
		if (isset($this->_messages['errors'])) {    
			$html = '<div class="page-alerts">'.$this->_messages['errors'].'</div>';
			if ($clear == true) {
				unset($this->_messages['errors']);
			}
			return $html;
		}
	}

	function getSuccess() {
		if (isset($this->_messages['success'])) {
			$html = '<div class="page-alerts">'.$this->_messages['success'].'</div>';
			unset($this->_messages['success']);
			return $html;
		}
	}
	
	function add($text) {
		$this->_messages['success'] .= '<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">×</a>' . $text . '</div>';
	}

	function addError($text) {
		$this->_messages['errors'] .= '<div class="alert alert-danger"><a class="close" data-dismiss="alert" href="#">×</a>' . $text . '</div>';
	}

	function __toString() {
		return $this->getAll();
	}
}