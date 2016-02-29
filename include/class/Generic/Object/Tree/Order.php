<?php

class Generic_Object_Tree_Order {
	
	private $Tree;
	private $sizeof;
	private $index;
	
	public function __construct($Tree) {
		
		$this->Tree = $Tree;
		
		$this->sizeof = array();
		$this->sizeof [0] = (int)$Tree->CountChildren(0);
	
		$this->index = array();
	}
	
	public function Count($id,$parent_id) {
		
		if (!isset($this->index[(int)$parent_id])) {
			$this->index[(int)$parent_id] = 0;
		} 
		$this->index[(int)$parent_id]++;
		
		if (!isset($this->sizeof[(int)$id])) {
			$this->sizeof [(int)$id] = (int)$this->Tree->CountChildren($id);
		}
	} 
	
	public function IsMovableUp($parent_id) {

		$a_sizeof = $this->sizeof[(int)$parent_id];
		$a_index = $this->index[(int)$parent_id];
		
		if ($a_index > 1 && $a_index != $a_sizeof+1) {
			return true;
		}
		return false;
	}
	
	public function IsMovableDown($parent_id) {
		
		$a_sizeof = $this->sizeof[(int)$parent_id];
		$a_index = $this->index[(int)$parent_id];
		
		if (($a_sizeof > $a_index || $a_sizeof > $a_index) && ( $a_index != $a_sizeof)) {
			return true;
		}
		return false;
	}
}