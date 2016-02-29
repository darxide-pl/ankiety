<?php

class Method {
	
	static function executable($method) {
		return is_callable($method);
	}
	
	static function call($method, $arg = null) {
		if (!self::executable($method)) {
			if (is_array($method)) {
				$s = '';
				foreach ($method as $k => $v) {
					$s .= '::';
					if (is_object($v)) {
						$s .= get_class($v);
					} else {
						$s .= $v;
					}
				}
				$method = substr($s,2);
			}
			throw new Exception('Metoda nie mogła zostać wywołana zdalnie. ('.$method.')');
		}
		if (is_array($arg)) {
			return call_user_func_array($method, $arg);
		} elseif ($arg) { 
			return call_user_func($method, $arg);
		} else {
			return call_user_func($method);
		}
	}
	
}

?>