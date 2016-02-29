<?php

class Routes {
	
	public static $routes;
	
	public static function addRoute($route) {
		self::$routes []= $route;
	}
	
	public static function parse($url_vars) {
		
		$url = implode(LT,$url_vars);
		
		if (is_array($url_vars) && sizeof($url_vars)) {
			
			$_GET['page'] = $_REQUEST['page'] = array_shift($url_vars);
			if (sizeof ($url_vars)) {
				$_GET['subpage'] = $_REQUEST['subpage'] = array_shift($url_vars);
			}

			$params = '';
			
			do {
				$key = array_shift($url_vars);
				$value = array_shift($url_vars);
				$params .= '&'.$key.'='.$value; 
			} while (sizeof($url_vars) > 1);
			parse_str(urldecode(substr($params,1)), $result);
			$_GET = f_array_merge_with_keys($_GET,$result);
			$_REQUEST = f_array_merge_with_keys($_REQUEST,$result);
		}
		
		if (self::$routes) {
			foreach (self::$routes as $route) {
				if (preg_match($route['pattern'], $url, $found)) {
					
					if (sizeof($found)) {
						foreach ($found as $k => $v) {
							if (is_string(($k))) {
								$_GET[$k] = $_REQUEST[$k] = $v;
							}
						}
					}
					if (isset($route['vars']) && sizeof($route['vars'])) {
						foreach ($route['vars'] as $k => $v) {
							$_GET[$k] = $_REQUEST[$k] = $v;
						}
					}
					# end of searching
					break;
				}
			}
		}
	}
	
	public static function cleanURL($string){
		$url = str_replace("'", '', $string);
		$url = str_replace('%20', ' ', $url);
		$url = preg_replace('~[^ \\pL0-9_]+~u', '-', $url); // substitutes anything but letters, numbers and '_' with separator
		$url = trim($url, "-");
		$url = iconv("utf-8", "us-ascii//TRANSLIT", $url);  // you may opt for your own custom character map for encoding.
		$url = strtolower($url);
		$url = preg_replace('~[^-a-z0-9_]+~', '', $url); // keep only letters, numbers, '_' and separator
		return $url;
	}
	
	public static function humanizeURL($string) {
		$url = str_replace("'", '', $string);
		$url = str_replace('%20', ' ', $url);
		$url = preg_replace('~[^ \\pL0-9_]+~u', '-', $url); // substitutes anything but letters, numbers and '_' with separator
		$url = trim($url, "-");
		
		$table = array(
	        'Š'=>'S', 'š'=>'s', 'Đ'=>'Dj', 'đ'=>'dj', 'Ž'=>'Z', 'ž'=>'z', 'Č'=>'C', 'č'=>'c', 'Ć'=>'C',
	        'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
	        'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O',
	        'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U', 'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss',
	        'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c', 'è'=>'e', 'é'=>'e',
	        'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o',
	        'ô'=>'o', 'õ'=>'o', 'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'ý'=>'y', 'þ'=>'b',
	        'ÿ'=>'y', 'Ŕ'=>'R', 'ŕ'=>'r',
	        'ą'=>'a','ę'=>'e','ó'=>'o','ś'=>'s','ł'=>'l','ż'=>'z','ź'=>'z','ć'=>'c','ń'=>'n',
			'Ą'=>'a','Ę'=>'e','Ó'=>'o','Ś'=>'s','Ł'=>'l','Ż'=>'z','Ź'=>'z','Ć'=>'c','Ń'=>'n'
	    );
	   
	    $url = strtr($url, $table);
	    
		$url = iconv("utf-8", "us-ascii//TRANSLIT", $url);  // you may opt for your own custom character map for encoding.
		$url = strtolower($url);
		$url = preg_replace('~[^\\\/a-z0-9_]+~', '-', $url); // keep only letters, numbers, '_' and separator
		return $url;
	}
}