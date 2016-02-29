<?php

class System_Messages_Custom extends System_Messages {
	public function __construct($title,$content) {
		
		parent::__construct();
		
		$this->setTitle($title);
		$this->setContent($content);
	}
}