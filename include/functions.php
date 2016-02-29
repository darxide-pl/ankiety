<?php


if (!function_exists('f_autoload')) {

	function f_autoload($class_name) {

		$path = explode('_', $class_name);

		$file_name = array_pop($path) . '.php';

		$dir = '';
		if (sizeof($path) > 0) {
			$dir .= implode('/', $path) . '/';
		}

		if (@include DIR_INC_CLASS . $dir . $file_name) {
			return true;
		} else {

			# search actions
			if ($file_name == 'Actions.php') {
				# get next part
				$file_name = array_pop($path) . '.php';
			}
			$dir = 'Actions/';
			if (sizeof($path) > 0) {
				$dir .= implode('/', $path) . '/';
			}

			if (@include DIR_INC_CLASS . $dir . $file_name) {
				return true;
			}

			$dir = 'PEAR/';
			if (sizeof($path) > 0) {
				$dir .= implode('/', $path) . '/';
			}

			if (@include DIR_INC_CLASS . $dir . $file_name) {
				return true;
			}
		}

		//throw new Exception('f_autoload: class ' . $class_name . ' not found.');
	}

    spl_autoload_register('f_autoload');
}

if (!function_exists('get_called_class')) {

	class class_tools {

		static $i = 0;
		static $fl = null;

		static function get_called_class() {

			$bt = debug_backtrace();

			if (self::$fl == $bt[2]['file'] . $bt[2]['line']) {
				//self::$i++;
			} else {
				//self::$i = 0;
				self::$fl = $bt[2]['file'] . $bt[2]['line'];
			}
			$lines = file($bt[2]['file']);
			preg_match_all('/([a-zA-Z0-9\_]+)::' . $bt[2]['function'] . '/', $lines[$bt[2]['line'] - 1], $matches);

			return $matches[1][self::$i];
		}
	}

	function get_called_class() {
		return class_tools::get_called_class();
	}
}

function f_ob_turnoff($display = true) {
	
	$level = ob_get_level();
	
	if ($level > 0) {
		if ($display) {
			for($i=0;$i<=$level;$i++) {
				ob_end_flush();
			}
		} else {
			for($i=0;$i<=$level;$i++) {
				ob_end_clean();
			}
		}
	}
	
	header_remove('Content-Encoding');
}

function f_strtoupper($str) {
	return mb_strtoupper($str,'UTF-8');
}

function f_strtolower($str) {
	return mb_strtolower($str,'UTF-8');
}

function f_is_ne_array( $object ) {
	return (bool) ( is_array($object) && sizeof($object) );
}

function f_array_unshift_assoc( &$array, $key, $value) {
   $array = f_array_merge_with_keys(array($key => $value), $array);
   return $array;
}

function f_array_merge_with_keys( $array1, $array2 ) {
	if (is_array($array2) && count($array2)) {
      foreach ($array2 as $k => $v) {
        if (is_array($v) && count($v)) {
          $array1[$k] = f_array_merge_with_keys($array1[$k], $v);
        } else {
          $array1[$k] = $v;
        }
      }
    }
	return $array1;
}

function f_date_to_time($date) {
	$date = explode('-',$date);
	return mktime(0,0,0,$date[1],$date[2],$date[0]);
}

function f_time_to_string($seconds) {
	$hours = $seconds / 3600;
	$rest = $seconds % 3600;
	$minutes = $rest / 60;
	$seconds = $rest % 60;
	if ($hours < 10) $hours = '0'.(int)$hours;
	else $hours = (int)$hours;
	if ($minutes < 10) $minutes = '0'.(int)$minutes;
	else $minutes = (int)$minutes;
	if ($seconds < 10) $seconds = '0'.(int)$seconds;
	else $seconds = (int)$seconds;
	return $hours.':'.$minutes.':'.$seconds;
}

function f_time_to_string2($seconds) {
	$time = '';
	$hours = (int) ($seconds / 3600);
	$rest = $seconds % 3600;
	$minutes = (int) ($rest / 60);
	$seconds = (int) ($rest % 60);
	$do = false;
	if ($hours > 0) {
		$do = true;
		$time .= $hours.'h';
	}
	if ($do == true || $minutes > 0) $time .= $minutes.'m ';
	$time .= $seconds.'s';
	return $time;
}

function f_get_years_to_array($from, $to, $direction = 'ASC') {

	$dir_desc = strtoupper($direction) == 'DESC';

	if ($dir_desc) {
		if ((int)$from > (int)$to) {

		} else {
			$temp = $from;
			$from = $to;
			$to = $temp;
		}
	} else {
		if ((int)$from < (int)$to) {

		} else {
			$temp = $from;
			$from = $to;
			$to = $temp;
		}
	}

	$i = 100;
	$years = array();
	$years [$from] = $from;
	do {
		$i--;
		if ($from != $to) {
			$dir_desc ? $from-- : $from++;
		}
		$years [$from] = $from;

	} while ($from != $to && $i);

	return $years;
}

function f_get_months_to_array() {
	return array(1 => 'Styczeń', 2 => 'Luty', 3 => 'Marzec', 4 => 'Kwiecień', 5 => 'Maj', 6 => 'Czerwiec', 7 => 'Lipiec', 8 => 'Sierpień', 9 => 'Wrzesień', 10 => 'Październik', 11 => 'Listopad', 12 => 'Grudzień');
}

function f_get_days_to_array($str_len = 0) {
	$_array = array('poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota', 'niedziela');
	if ($str_len > 0) {
		return array_map('substr', $_array, array_fill(0,7,0), array_fill(0,7,$str_len));
	}
	return $_array;
}

function f_check_date($date) {
	list($y,$m,$d)=explode('-',$date);
	if (is_numeric($y) && is_numeric($m) && is_numeric($d)) {
		return (bool) checkdate($m,$d,$y);
	}
	return false;
}

function f_check_email($email) {
	return eregi("^[a-z0-9._%-]+@[a-z0-9._%-]+\.[a-z]{2,6}$", $email);
}

function f_check_nip($nip) {
	$steps = array(6, 5, 7, 2, 3, 4, 5, 6, 7);
	$nip = str_replace('-', '', $nip);
	$nip = str_replace(' ', '', $nip);
	if (strlen($nip) != 10) { return false; }
	for ($x = 0; $x < 9; $x++) $sum_nb += $steps[$x] * $nip[$x];
	if ($sum_nb % 11 == $nip[9]) { return true; }
	return false;
}

function f_check_password($password) {
	if (strlen($password) < 5 || strlen($password) > 32) {
		return false;
	}
	return true;
}

function f_is_html($sting) {
	return strlen($sting) != strlen(strip_tags($sting));
}

function f_filter_inputs($value) {
	if (is_array($value)) {
		return array_map('f_filter_inputs', $value);
	} else {
		if (get_magic_quotes_gpc()) $value = stripslashes($value);
		//$value = htmlspecialchars($value);
		return $value;
	}
}

function f_escape($value) {
	return htmlspecialchars($value);
}

function f_quote($value) {
	return htmlspecialchars($value);
}

function f_quote_like($value) {
	return str_replace('%','\%',htmlspecialchars($value));
}

function f_clear_float($number) {
	if (is_array($number)) {
		return array_map('f_clear_float', $number);
	} else {
		if (empty($number)) {
			$number = 0.00;
		} else {
			$number = str_replace(' ', '', $number);
			$number = strtr($number, ',', '.');
		}
	}
	return $number;
}

function f_clear_html($value) {
	if (is_array($value)) {
		return array_map('f_clear_html', $value);
	} else {
		return strip_tags($value);
	}
}

function f_clear_price($number) {
	return number_format(round(f_clear_float($number), 2),2,'.','');
}

function f_clear_file_name($file_name) {
	$file_name = trim(preg_replace('/\s+/'," ",$file_name));
	$file_name = strtr($file_name,' ','_');
	return preg_replace('/[^_\-a-zA-Z0-9\.]/',"",$file_name);
}

function f_clear_dir_name($dir_name) {
	return f_clear_file_name($dir_name);
}

function f_format_file_size($bytes = 0) {
	if ($bytes > 0) {
		$s = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
		$e = floor(log($bytes)/log(1024));
		return sprintf('%.2f '.$s[$e], ($bytes/pow(1024, floor($e))));
	} else {
		return '0 B';
	}
}

function f_remove_space($string) {
	return str_replace(' ', '', $string);
}

function f_link($param = '', $separator = '&amp;', $path = '', $port = DEFAULT_PORT, $host_address = DEFAULT_HOST_ADDRESS) {

	$port = strtolower($port);

	switch ($port) {
		case 'ftp': $address = 'ftp://'; break;
		case 'ssl': $address = 'https://'; break;
		case 'http': $address = 'http://'; break;
	}

	if (empty($path)) {

		$address .= $host_address;

		if (!empty($param)) {

			if (is_array($param)) {


				if (!empty($param['page'])) {
					$address .= $param['page'].LT;
					if (empty($param['subpage'])) {
						$address .= 'index'.LT;
					} else {
						$address .= $param['subpage'].LT;
						unset($param['subpage']);
					}
					unset($param['page']);

					foreach ($param as $k => $v) {
						if(!empty($v) || (is_numeric($v))) {
							$address .= $k.LT.$v.LT;
						}
					}
				}
			} else {

				if (strpos($param, '?')) {
					$param = substr($param, strpos($param, '?'));
				}

				if (!is_array($param)) {
					$param = explode($separator, $param);
					foreach ($param as $p) {
						list ($k, $v) = explode('=', $p);
						if ($v ==  '') {

						} else if ($k == 'page' || $k == 'subpage') {
							$address .= $v.LT;
						} else {
							$address .= $k.LT.$v.LT;
						}
					}
				}
			}
		}
	} else {
		$address .= $host_address . $path;

		if (!empty($param)) {
			if (is_array($param)) {
				$params = '';
				foreach ($param as $k => $v) {
					$params .= $k.'='.$v.$separator;
				}
				$param = substr($params, 0, strlen($params) - strlen($separator));
			}
		}
		$address .= '?'.$param;
	}

	return $address;
}

function f_format_date($format,$date) {
	return date($format,strtotime($date));
}

function f_date_to_string($date) {
	$days = array('nie', 'pon', 'wto', 'śro', 'czw', 'pią', 'sob');
	$months = array('', 'sty', 'lut', 'mar', 'kwi', 'maj', 'cze', 'lip', 'sie', 'wrz', 'paź', 'lis', 'gru');
	list ($year, $month, $temp_day) = explode('-', $date);
	$date_in_sec = strtotime($date);
	$day = date('N', $date_in_sec);
	return $days[(int)$day].' '.$temp_day.' '.$months[(int)$month].' '.substr($year, 2,2);
}

function f_implode_date($date_array) {
	return $date_array['year'].'-'.$date_array['month'].'-'.$date_array['day'];
}

function f_get_ip_address() {
	if (isset($_SERVER)) {
		if (isset($_SERVER['HTTP_X_FORWARDED_FOR']))
		return $_SERVER['HTTP_X_FORWARDED_FOR'];
		elseif (isset($_SERVER['HTTP_CLIENT_IP']))
		return $_SERVER['HTTP_CLIENT_IP'];
		else
		return $_SERVER['REMOTE_ADDR'];
	}
}

function f_generate_chars($length, $alphabet = 'ALL', $style = 'DEFAULT') {
	srand((double)microtime()*1000000);
	$alphabet = strtoupper($alphabet);
	$style = strtoupper($style);
	$alphabet = explode('|', $alphabet);
	$chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	$chars .= "abcdefghijklmnopqrstuvwxyz";
	$numbers = "0123456789";
	$special_chars = "!@#$%^&*()_+-=";
	$chars_list = '';
	if (in_array('NUMBERS', $alphabet)) $chars_list .= $numbers;
	if (in_array('CHARS', $alphabet)) $chars_list .= $chars;
	if (in_array('SPECIAL', $alphabet)) $chars_list .= $special_chars;
	if (empty($chars_list)) $chars_list = $numbers.$chars.$special_chars;
	$chars_list_lenght = strlen($chars_list);
	for($i=0, $random = ''; $i<$length; $i++) {
		$random .= substr($chars_list,(rand()%($chars_list_lenght)), 1);
	}
	if ($style == 'UPPER') $random = strtoupper($random);
	if ($style == 'LOWER') $random = strtolower($random);
	return $random;
}

function f_generate_numbers($from, $to, $step = 1) {
	for($number = $from; $number <= $to; $number = $number + $step) {
		$array[$number] = $number;
	}
	return $array;
}

function f_print_r($arr) {
	echo '<pre>';
	print_r($arr);
	echo '</pre>';
}

function f_var_debug($var,$indent='&nbsp;&nbsp;',$niv='0')
{
	$str = '';
	if(is_array($var)) {
		$str .= "<b>[array][".count($var)."]</b><br />";
		foreach($var as $k=>$v) {
			for($i=0;$i<$niv;$i++) $str.= $indent;
			$str .= "$indent<code> \"{$k}\" => </code>";
			$str .= f_var_debug($v,$indent,$niv+1);
		}
	}
	else if(is_object($var)) {
		$str .= "[object]::class[<b>".get_class($var)."</b>] [<br />";
		$arr = get_class_methods($var);
		foreach ($arr as $method) {
			for($i=0;$i<$niv;$i++) $str.= $indent;
			$str .= $indent."function-><b>$method()</b><br />";
		}
		$str .= "]";
		$str .= "</b><br />";
		$str .= f_var_debug(get_object_vars($var),$indent,$niv+1);
	}
	else {
		$str.= "<span style=\"color: #555;\"> (".strtolower(gettype($var)).") </span> [{$var}]<br />";
	}
	return($str);
}

function f_microtime_float() {
	list($usec, $sec) = explode(" ", microtime());
	return ((float)$usec + (float)$sec);
}

/**
 * 
 * @param type $timestamp
 * @param type $num_times
 * @return string
 */
function f_time_ago_to_string($timestamp, $num_times = 3) {
	$times = array(31536000 => 'year', 2592000 => 'month', 86400 => 'day', 3600 => 'hour', 60 => 'minute', 1 => 'second');

	$labels = array(
		'year' => array('default' => 'lat', 1 => 'rok', 2 => 'lata', 3 => 'lata', 4 => 'lata'),
		'month' => array('default' => 'miesięcy', 1 => 'miesiąc', 2 => 'miesiące', 3 => 'miesiące', 4 => 'miesiące'),
		'day' => array('default' => 'dni', 1 => 'dzień'),
		'hour' => array('default' => 'g'),
		'minute' => array('default' => 'm'),
		'second' => array('default' => 's'),
	);

	$now = time();
	$secs = $now - $timestamp;
	if ($secs == 0)
	$secs = 1;
	$count = 0;
	$time = '';
	foreach ($times AS $key => $value) {
		if ($secs >= $key) {
			$s = '';
			$time .= floor($secs / $key);
			if (isset($labels[$value][$time])) {
				$label = $labels[$value][$time];
			} else $label = $labels[$value]['default'];
			$time .= ' ' . $label . $s;
			$count++;
			$secs = $secs % $key;
			if ($count > $num_times - 1 || $secs == 0)
			break;
			else
			$time .= ', ';
		}
	}
	return $time;
}

function f_html_draw_button($type, $text, $onclick = null, $align = 'left', $alt_text = null) {
	$type = strtolower($type);
	$align_css = $align == 'left' ? 'float: left;' : ($align == 'right' ? 'float: right' : '');
	$style = 'style="'.$align_css.'"';
	$subclass = '';
	switch($type ){
		case 'submit_black':
			$subclass = ' black';
			break;
		case 'submit_ok':
			$subclass = ' submit';
			break;
		case 'submit_red':
			$subclass = ' submit_red';
			break;
		case 'submit_search':
			$subclass = ' search';
			break;
	}
	$text = strip_tags($text);
	switch ($type) {
		case 'delete':
			return '<div align="center"><img src="'.DIR_INC_IMAGES.'but_delete.png" alt="'.strip_tags($text).'" title="'.strip_tags($text).'" onclick="'.$onclick.'" class="link" style="text-align: center; display: block; " onmouseover="this.src=\''.DIR_INC_IMAGES.'but_delete_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_delete.png\'" /></div>';
		case 'edit':
			return '<div align="center"><img src="'.DIR_INC_IMAGES.'but_edit.png" alt="'.strip_tags($text).'" title="'.strip_tags($text).'" onclick="'.$onclick.'" class="link" style="text-align: center; display: block; " onmouseover="this.src=\''.DIR_INC_IMAGES.'but_edit_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_edit.png\'" /></div>';
		case 'submit_black':
		case 'submit_ok':
		case 'submit_search':
		case 'submit_red':
		case 'submit':
			return '<input type="button" name="" value="'.$text.'" onclick="'.$onclick.'" class="button'.$subclass.'" />';
		case 'arrow_up':
		case 'arrow_down':
		case 'arrow_left':
		case 'arrow_right':
			return '<div align="center"><img src="'.DIR_INC_IMAGES.$type.'.png" alt="'.$alt_text.'" title="'.$alt_text.'" onclick="'.$onclick.'" class="link" style="text-align: center; display: block; " '.$style.' /></div>';
		case 'next':
			return '<img src="'.DIR_INC_IMAGES.'but_next.png" alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' onmouseover="this.src=\''.DIR_INC_IMAGES.'but_next_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_next.png\'" align="top" />';
		case 'prev':
			return '<img src="'.DIR_INC_IMAGES.'but_prev.png" alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' onmouseover="this.src=\''.DIR_INC_IMAGES.'but_prev_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_prev.png\'" align="top" />';
		case 'first':
			return '<img src="'.DIR_INC_IMAGES.'but_first.png" alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' onmouseover="this.src=\''.DIR_INC_IMAGES.'but_first_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_first.png\'" align="top" />';
		case 'last':
			return '<img src="'.DIR_INC_IMAGES.'but_last.png" alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' onmouseover="this.src=\''.DIR_INC_IMAGES.'but_last_a.png\'" onmouseout="this.src=\''.DIR_INC_IMAGES.'but_last.png\'" align="top" />';
		case 'ico_file':
			return '<img src="'.DIR_INC_IMAGES.'ico_file.png"  alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' align="top" />';
		case 'ico_dir_up':
			return '<img src="'.DIR_INC_IMAGES.'ico_dir_up.png"  alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' align="top" />';
		case 'ex_red':
			return '<img src="'.DIR_INC_IMAGES.'sign_ex.png"  alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' align="top" />';
		case 'ex_green':
			return '<img src="'.DIR_INC_IMAGES.'sign_ex_green.png"  alt="'.$alt_text.'" onclick="'.$onclick.'" class="link" '.$style.' align="top" />';
		default:
			return '<input type="button" value="'.$text.'" onclick="'.$onclick.'" '.$style.' />';
	}
}

function f_html_box_open($width = null, $theme = 'grey') {
	$class = '';
	switch($theme) {
		case 'blue':
			$class = 'box2';
			break;
		default:
			$class = 'box';
	}
	if ($width) {
		$width = is_int($width) ? $width . 'px' : $width;
		$width = 'style="width: '.(int)$width.';"';
	}
	$s = '<table class="'.$class.'" cellspacing="0" cellpadding="0" '.$width.'>';
	$s .= '<tr><td class="boxtl"><div></div></td>';
	$s .= '<td class="boxt"><div></div></td>';
	$s .= '<td class="boxtr"><div></div></td></tr>';
	$s .= '<tr><td class="boxl"><div></div></td>';
	$s .= '<td style="">';

	return $s;
}

function f_html_box_close() {
	$s = '</td>';
	$s .= '<td class="boxr"></td></tr>';
	$s .= '<tr><td class="boxbl"></td>';
	$s .= '<td class="boxb"></td>';
	$s .= '<td class="boxbr"></td></tr>';
	$s .= '</table>';

	return $s;
}

function f_html_filters_box_open($action = '', $height = null) {

	if (empty($action)) $action = f_link(array('page' => $_GET['page'], 'subpage' => $_GET['subpage']));
	$s = '<div id="filters-box">';
	$s .= '<div id="filters">';
	$s .= '<form action="'.$action.'" method="post" id="filters_form" name="filters_form">';
	$s .= f_html_box_open();

	return $s;
}

function f_html_filters_box_close($clear_url = '') {

	if (empty($clear_url)) $clear_url = f_link(array('page' => $_GET['page'], 'subpage' => $_GET['subpage'], 'reset_filters' => 'true'));
	$s = f_html_box_close();
	$s .= f_html_draw_button('submit', TFBOX_BUTT_UPDATE_FILTERS, 'LFilters.Submit();', 'left', 'Filtruj listę');
	$s .= ' <a href="'.$clear_url.'" title="'.TFBOX_BUTT_CLEAR_FILTERS.'">'.TFBOX_BUTT_CLEAR_FILTERS.'</a>';
	$s .= '</form></div></div>';

	$height = '';
	if (!empty($height)) $height= 'LFilters.SetHeight('.(int)$height.');';
	$s .= '<script type="text/javascript" src="'.DIR_INC_JS.'js_list_filters.js"></script>';
	$s .= '<script type="text/javascript">var LFilters = new ListFiltersHandler();'.$height.'</script>';

	return $s;
}

function f_print_page_statistics() {
	$a = explode(' ', SITE_PARSE_TIME);
	$b = explode(' ', microtime());
	$c = number_format(($b[1] + $b[0] - ($a[1] + $a[0])), 4);
	return $c.' s | '.round(memory_get_usage()/1000000,5).' MB';
}

function f_eas($a) {
	$key = sha1(DEFAULT_ENCRYPT_KEY.$a);
	$p1 = substr($key,0,13);
	$p2 = substr($key,13);
	return urlencode($p1.'__'.strtr(base64_encode($a),array('+/=' => '-.,')).'__'.$p2);
	//return urlencode(strtr(base64_encode($a.$_SESSION['action_script_key']),array('+/=' => '-.,')));
}

function f_decrypt($a) {
	if(strpos($a,'__') !== false) {
		list($p1, $action, $p2) = explode('__',$a);
		$a = base64_decode(urldecode(strtr($action,array('-.,'=>'+/='))));
		if ($p1.$p2 == sha1(DEFAULT_ENCRYPT_KEY.$a)) {
			return $a;
		}
	}
	//return substr(base64_decode(urldecode(strtr($a,array('-.,'=>'+/=')))),0,-(strlen($_SESSION['action_script_key'])));
}

function mb_substrws($text, $length = 180) {
    if((mb_strlen($text) > $length)) {
        $whitespaceposition = mb_strpos($text, ' ', $length) - 1;
        if($whitespaceposition > 0) {
            $chars = count_chars(mb_substr($text, 0, ($whitespaceposition + 1)), 1);
            if ($chars[ord('<')] > $chars[ord('>')]) {
                $whitespaceposition = mb_strpos($text, ">", $whitespaceposition) - 1;
            }
            $text = mb_substr($text, 0, ($whitespaceposition + 1));
        }
        // close unclosed html tags
        if(preg_match_all("|(<([\w]+)[^>]*>)|", $text, $aBuffer)) {
            if(!empty($aBuffer[1])) {
                preg_match_all("|</([a-zA-Z]+)>|", $text, $aBuffer2);
                if(count($aBuffer[2]) != count($aBuffer2[1])) {
                    $closing_tags = array_diff($aBuffer[2], $aBuffer2[1]);
                    $closing_tags = array_reverse($closing_tags);
                    foreach($closing_tags as $tag) {
                            $text .= '</'.$tag.'>';
                    }
                }
            }
        }

    }
    return $text;
}

function substrws($text, $length = 180) {
    if((strlen($text) > $length)) {
        $whitespaceposition = strpos($text, ' ', $length) - 1;
        if($whitespaceposition > 0) {
            $chars = count_chars(substr($text, 0, ($whitespaceposition + 1)), 1);
            if ($chars[ord('<')] > $chars[ord('>')]) {
                $whitespaceposition = strpos($text, ">", $whitespaceposition) - 1;
            }
            $text = substr($text, 0, ($whitespaceposition + 1));
        }
        // close unclosed html tags
        if(preg_match_all("|(<([\w]+)[^>]*>)|", $text, $aBuffer)) {
            if(!empty($aBuffer[1])) {
                preg_match_all("|</([a-zA-Z]+)>|", $text, $aBuffer2);
                if(count($aBuffer[2]) != count($aBuffer2[1])) {
                    $closing_tags = array_diff($aBuffer[2], $aBuffer2[1]);
                    $closing_tags = array_reverse($closing_tags);
                    foreach($closing_tags as $tag) {
                            $text .= '</'.$tag.'>';
                    }
                }
            }
        }

    }
    return $text;
}

function f_html_clear($string, $leave) {
	return str_replace('&nbsp;',' ',strip_tags(htmlspecialchars_decode($string),'<sup><sub>'));
}

function f_html_decode($string) {
	return htmlspecialchars_decode($string);
}

function f_get_current_url($query_str = true) {
	$s = 'http';
	if ($_SERVER["HTTPS"] == "on") {
		$s .= "s";
	}
	$s .= "://";
	if (strpos($_SERVER['REQUEST_URI'],'?') !== false) {
		$uri = $query_str ? $_SERVER['REQUEST_URI'] : substr($_SERVER['REQUEST_URI'],0,strpos($_SERVER['REQUEST_URI'],'?'));
	} else {
		$uri = $_SERVER['REQUEST_URI'];
	}
	if ($_SERVER["SERVER_PORT"] != "80") {
		$s .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$uri;
	} else {
		$s .= $_SERVER["SERVER_NAME"].$uri;
	}
	return $s;
}


/**
 * Better GI than print_r or var_dump -- but, unlike var_dump, you can only dump one variable.
 * Added htmlentities on the var content before echo, so you see what is really there, and not the mark-up.
 *
 * Also, now the output is encased within a div block that sets the background color, font style, and left-justifies it
 * so it is not at the mercy of ambient styles.
 *
 * Inspired from:     PHP.net Contributions
 * Stolen from:       [highstrike at gmail dot com]
 * Modified by:       stlawson *AT* JoyfulEarthTech *DOT* com
 *
 * @param mixed $var  -- variable to dump
 * @param string $var_name  -- name of variable (optional) -- displayed in printout making it easier to sort out what variable is what in a complex output
 * @param string $indent -- used by internal recursive call (no known external value)
 * @param unknown_type $reference -- used by internal recursive call (no known external value)
 */
function dump(&$var, $var_name = NULL, $indent = NULL, $reference = NULL)
{
	$do_dump_indent = "<span style='color:#666666;'>|</span> &nbsp;&nbsp; ";
	$reference = $reference.$var_name;
	$keyvar = 'the_do_dump_recursion_protection_scheme'; $keyname = 'referenced_object_name';

	// So this is always visible and always left justified and readable
	echo "<div style='text-align:left; background-color:white; font: 100% monospace; color:black;'>";

	if (is_array($var) && isset($var[$keyvar]))
	{
		$real_var = &$var[$keyvar];
		$real_name = &$var[$keyname];
		$type = ucfirst(gettype($real_var));
		echo "$indent$var_name <span style='color:#666666'>$type</span> = <span style='color:#e87800;'>&amp;$real_name</span><br>";
	}
	else
	{
		$var = array($keyvar => $var, $keyname => $reference);
		$avar = &$var[$keyvar];

		$type = ucfirst(gettype($avar));
		if($type == "String") $type_color = "<span style='color:green'>";
		elseif($type == "Integer") $type_color = "<span style='color:red'>";
		elseif($type == "Double"){
			$type_color = "<span style='color:#0099c5'>"; $type = "Float";
		}
		elseif($type == "Boolean") $type_color = "<span style='color:#92008d'>";
		elseif($type == "NULL") $type_color = "<span style='color:black'>";

		if(is_array($avar))
		{
			$count = count($avar);
			echo "$indent" . ($var_name ? "$var_name => ":"") . "<span style='color:#666666'>$type ($count)</span><br>$indent(<br>";
			$keys = array_keys($avar);
			foreach($keys as $name)
			{
				$value = &$avar[$name];
				dump($value, "['$name']", $indent.$do_dump_indent, $reference);
			}
			echo "$indent)<br>";
		}
		elseif(is_object($avar))
		{
			echo "$indent$var_name <span style='color:#666666'>$type</span><br>$indent(<br>";
			foreach($avar as $name=>$value) dump($value, "$name", $indent.$do_dump_indent, $reference);
			echo "$indent)<br>";
		}
		elseif(is_int($avar)) echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> $type_color".htmlentities($avar)."</span><br>";
		elseif(is_string($avar)) echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> $type_color\"".htmlentities($avar)."\"</span><br>";
		elseif(is_float($avar)) echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> $type_color".htmlentities($avar)."</span><br>";
		elseif(is_bool($avar)) echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> $type_color".($avar == 1 ? "TRUE":"FALSE")."</span><br>";
		elseif(is_null($avar)) echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> {$type_color}NULL</span><br>";
		else echo "$indent$var_name = <span style='color:#666666'>$type(".strlen($avar).")</span> ".htmlentities($avar)."<br>";

		$var = $var[$keyvar];
	}

	echo "</div>";
}

function t($key, $value = null, $module = '', $view = '') {
	static $d;
	
	$key = strtolower($key);
	
	$lang = Session::Instance()->get('language');
	
	if (!$d[$module]) {
		
		if (!DB::isInitialized()) {
			throw new Exception('Before using translator, open connection to database.');
		}
		
		$db = DB::Instance();
		
		$d[$module] = $db->FetchRecords($sql = "SELECT t.`key`,t.`text`
							FROM `i18n_translation` t
								LEFT JOIN `i18n_group` g ON g.`translation_id` = t.`id`
							WHERE g.`module` = '".$db->quote($module)."'
								
								AND t.`lang` = '".$db->quote($lang)."'", // AND g.`view` = '".$db->quote($view)."'
			DB_FETCH_ASSOC_FIELD);
	}

	if (isset($d[$module][$key])) {
		
		return $d[$module][$key];
		
	} else {

		if (!DB::isInitialized()) {
			throw new Exception('Before using translator, open connection to database.');
		}
		
		$db = DB::Instance();
		
		# insert
		$sql = "INSERT IGNORE INTO `i18n_translation` (`lang`,`key`,`text`) VALUES('".$db->quote($lang)."','".$db->quote(($key))."','".$db->quote($value)."');";
		$db->query($sql);
		
		# retrive
		$sql = "SELECT `id` FROM `i18n_translation` WHERE `key` = '".$db->quote(($key))."' AND `lang` = '".$db->quote($lang)."' LIMIT 1;";
		$translation_id = $db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);

		# assigne to group
		$sql = "INSERT IGNORE INTO `i18n_group` (`translation_id`,`module`,`view`) VALUES('".$db->quote($translation_id)."','".$db->quote($module)."','".$db->quote($view)."');";
		$db->query($sql);
		
		$d[$module][$key] = $value;
		
		return $value;
	}
}

function f_number_plural_form($forms, $number) {
	
	/**
	 * 0,5,6,7,8,9,10 - przedmiotów
	 * 1 - przedmiot
	 * 2,3,4 - przedmioty
	 */

	if ($number < 10) {
		if ($number > 5 || $number == 0) {
			return $forms[0];
		}
		if ($number > 1) {
			return $forms[2];
		}
		return $forms[1];
	}
	
	$number = $number % 10;
	
	return f_number_plural_form($forms, $number);
}

function normalize_whitespace( $str ) {
	$str  = trim($str);
	$str  = str_replace("\r", "\n", $str);
	$str  = preg_replace( array( '/\n+/', '/[ \t]+/' ), array( "\n", ' ' ), $str );
	return $str;
}

function text_diff( $left_string, $right_string, $args = null ) {

	$defaults = array( 'title' => '', 'title_left' => '', 'title_right' => '' );
	$args = $args ? $args : $defaults;

	$left_string  = normalize_whitespace($left_string);
	$right_string = normalize_whitespace($right_string);

	$left_lines  = explode("\n", $left_string);
	$right_lines = explode("\n", $right_string);

	$text_diff = new Text_Diff($left_lines, $right_lines);
	$renderer  = new Text_Diff_Renderer_Table();
	$diff = $renderer->render($text_diff);

	if ( !$diff )
		return '';

	$r  = "<table class='diff'>\n";
	$r .= "<col class='ltype' /><col class='content' /><col class='ltype' /><col class='content' />";

	if ( $args['title'] || $args['title_left'] || $args['title_right'] )
		$r .= "<thead>";
	if ( $args['title'] )
		$r .= "<tr class='diff-title'><th colspan='4'>$args[title]</th></tr>\n";
	if ( $args['title_left'] || $args['title_right'] ) {
		$r .= "<tr class='diff-sub-title'>\n";
		$r .= "\t<td></td><th>$args[title_left]</th>\n";
		$r .= "\t<td></td><th>$args[title_right]</th>\n";
		$r .= "</tr>\n";
	}
	if ( $args['title'] || $args['title_left'] || $args['title_right'] )
		$r .= "</thead>\n";

	$r .= "<tbody>\n$diff\n</tbody>\n";
	$r .= "</table>";

	return $r;
}

/*
  Apply tripleDES algorthim for encryption, append "___EOT" to encrypted file ,
  so that we can remove it while decryption also padding 0's
 */
function f_emg_trienc($buffer, $key = null, $iv = null) {
	
	$key = is_null($key) ? ENC_KEY : $key;
	$iv = is_null($iv) ? ENC_IV : $iv;

	$cipher = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
	$buffer.='___EOT';
	// get the amount of bytes to pad
	$extra = 8 - (strlen($buffer) % 8);
	// add the zero padding
	if ($extra > 0) {
		for ($i = 0; $i < $extra; $i++) {
			$buffer .= '_';
		}
	}
	mcrypt_generic_init($cipher, $key, $iv);
	$result = mcrypt_generic($cipher, $buffer);
	mcrypt_generic_deinit($cipher);
	return base64_encode($result);
}

/*
  Apply tripleDES algorthim for decryption, remove "___EOT" from encrypted file ,
  so that we can get the real data.
 */
function f_emg_tridec($buffer, $key = null, $iv = null) {
	
	$key = is_null($key) ? ENC_KEY : $key;
	$iv = is_null($iv) ? ENC_IV : $iv;
	
	$buffer = base64_decode($buffer);
	$cipher = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
	mcrypt_generic_init($cipher, $key, $iv);
	$result = mdecrypt_generic($cipher, $buffer);
	$result = substr($result, 0, strpos($result, '___EOT'));
	mcrypt_generic_deinit($cipher);
	return $result;
}

function f_get_price_netto($price) {
	return round($price / ((100+f_clear_price(Config::get('store.tax_rate')))/100),2);
}

/*
* Generate a secure hash for a given password. The cost is passed
* to the blowfish algorithm. Check the PHP manual page for crypt to
* find more information about this setting.
*/
function f_generate_hash($password, $cost=11){
	/* To generate the salt, first generate enough random bytes. Because
	 * base64 returns one character for each 6 bits, the we should generate
	 * at least 22*6/8=16.5 bytes, so we generate 17. Then we get the first
	 * 22 base64 characters
	 */
	$salt = substr(base64_encode(openssl_random_pseudo_bytes(17)),0,22);
	/* As blowfish takes a salt with the alphabet ./A-Za-z0-9 we have to
	 * replace any '+' in the base64 string with '.'. We don't have to do
	 * anything about the '=', as this only occurs when the b64 string is
	 * padded, which is always after the first 22 characters.
	 */
	$salt = str_replace("+",".",$salt);
	/* Next, create a string that will be passed to crypt, containing all
	 * of the settings, separated by dollar signs
	 */
	$param='$'.implode('$',array(
			"2y", //select the most secure version of blowfish (>=PHP 5.3.7)
			str_pad($cost,2,"0",STR_PAD_LEFT), //add the cost in two digits
			$salt //add the salt
	));

	//now do the actual hashing
	return crypt($password,$param);
}

/*
* Check the password against a hash generated by the generate_hash
* function.
*/
function f_validate_pw($password, $hash){
	/* Regenerating the with an available hash as the options parameter should
	 * produce the same hash if the same password is passed.
	 */
	return crypt($password, $hash) == $hash;
}