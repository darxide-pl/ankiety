<?php

class Cookie_Handler {
	
	public static function Create($name,$data,$expire = 0) {
		setcookie($name,$data,$expire ? time()+$expire : 0,'/');
	}
	
	public static function Remove($name) {
		setcookie($name,' ',time()-3600,'/');
	}
}