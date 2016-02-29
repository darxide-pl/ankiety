<?php

class Db_Logger {

	private $_log_title;
	private $_log_id;
	
	function __construct($log_title) {
		$this->_log_title = $log_title;	
		$this->_log_id = $this->Create();
	}
	
	function Write($title, $text) {
		$o = new ScriptLogRecord;
		$o->ForceModify();
		try {
			$o->Set('log_id',(int)$this->_log_id);
			$o->Set('title',addslashes(strip_tags($title)));
			$o->Set('text',addslashes(strip_tags($text)));
			$o->Set('error',0);
			$o->Save();
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	function Error($title, $text) {
		$o = new ScriptLogRecord;
		$o->ForceModify();
		try {
			$o->SetField('log_id',(int)$this->_log_id);
			$o->SetField('title',addslashes(strip_tags($title)));
			$o->SetField('text',addslashes(strip_tags($text)));
			$o->SetField('error',1);
			$o->Save();
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	function Create() {
		$o = new ScriptLog;
		$o->ForceModify();
		try {
			$o->Set('log_title',addslashes(strip_tags($this->_log_title)));
			$o->Set('date',date('Y-m-d H:i:s'));
			$o->Save();
			return $o->GetID();
		} catch (Exception $e) {
			return false;
		}
	}
}