<?php

class Generic_Object_Tree_Builder {
	
	private $_id_field;
	private $_parent_id_field;
	
	# rows ordered by parent_id
	public $rows = array();
	
	# list of records with level number
	public $levels = array();
	
	function __construct($objects, $id_field = 'id', $parent_id_field = 'parent_id') {
		
		$this->_id_field = $id_field;
		$this->_parent_id_field = $parent_id_field;
		
		if ($objects) {
			foreach ($objects as $O) {
				if ($O instanceof Generic_Object) {
					$this->rows [(int)$O->Get($parent_id_field)][(int)$O->Get($id_field)] = $O;
				}
			}
		}
	}
	
	function Build($parent_id, $level = 0, &$rows) {
		$children = $this->GetChildren($parent_id);
		if ($children) {
			foreach ($children as $id => $O) {
				$O->SetField('list.level',$level);
				$rows[] = $O;
				$this->Build($O->Get($this->_id_field),($level+1),$rows);
			}
		}
	}
	
	function GetChildren($id = 0) {
		if (isset($this->rows[$id])) {
			$rows = $this->rows[$id];
			//unset($this->rows[$id]);
			return $rows;
		}
		return false;
	}
	
	function CountChildren($id) {
		return sizeof($this->rows[$id]);
	}
}