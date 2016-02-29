<?php

class Breadcrumbs {
	
	private static $crumbs = array();
	private static $separator = '';
	
	public static function add($name, $url, $active = false, $params = array()) {
		
		if (empty($name)) {
			return false;
		}
		
		if (empty($url)) {
			return false;
		}
		
		$params['name'] = $name;
		$params['url'] = $url;
		$params['active'] = $active;
		
		array_push(self::$crumbs, $params);
		return true;
	}
	
	# build crumbs list and return html
	public static function build($params = array()) {
		
		$html = '';
		
		if (is_array(self::$crumbs) && $num = sizeof(self::$crumbs)) {
			
			$html .= '<li class="home"> <b>Gdzie jesteś:</b> <a href="'.Link::Instance()->Build('/').'">Strona główna</a></li>'.self::$separator;
			
			foreach (self::$crumbs as $k => $crumb) {
				
				$url = Link::Instance()->Build($crumb['url']);
				
				$class = $crumb['active'] ? 'active' : '';
				
				if (!$class && $k+1 == $num) {
					$class = 'active';
				}
				
				$html .= '<li class="'.$class.'"><a href="'.$url.'" title="'.ucfirst($crumb['name']).'">'.$crumb['name'].'</a></li>';
				
				if ($k+1 != $num) {
					$html .= self::$separator;
				}
			}
			
			$html = '<ul class="breadcrumb">'.$html.'</ul>';
		}
		
		return $html;
	}
}