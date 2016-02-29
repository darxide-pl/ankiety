<?php

class Generic_Object_Iterator {
	
	private $i;
	private $rows;
	private $count;
	
	public function __construct($rows) {
		$this->rows = $rows;
		$this->count = sizeof($rows);
		$this->i = 1; 
	}
	
	public function add() {
		
	}
	
	public function remove() {
		
	}
	
	public function next() {
		$this->i++;
		if ($this->i > $this->count) {
			$this->i = $this->count;
		}
		return $this->get($this->i);
	}
	
	public function prev() {
		$this->i--;
		if ($i < 1) {
			$this->i = 1;
		}
		return $this->get($this->i);
	}
	
	public function last() {
		
	}
	
	public function first() {
		
	}

	public function get($i) {
		if (isset($this->rows[$i-1])) {
			return $this->rows[$i-1];
		}
		return null;
	}
}