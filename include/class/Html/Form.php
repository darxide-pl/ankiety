<?php

class Html_Form {

	public static function ClickForm($name, $vars = array(), $url_params = null) {
		if (empty($name)) {
			return false;
		}
		$L = new Link;
		$action = $url_params?$L->Build($url_params):$_SERVER['REQUEST_URI'];
		$s = '<form action="'.$action.'" method="post" name="'.$name.'" id="'.$name.'" style="display: none;">';
		if (f_is_ne_array($vars)) {
			foreach ($vars as $k => $v) {
				$s .= Html::HiddenInput($k,$v,array('id'=>'cf_'.$name.'_'.$k));
			}
		}
		$s .= '</form>'."\n";
		return $s;
	}
	
	public static function Open() {
		return '<div class="form">';
	}
	
	public static function Field($label, $input, $info = null) {
		$label = $label ? '<div class="fieldLabel">'.$label.'</div>' : '';
		$info = $info ? '<div class="fieldInputInfo">'.$label.'</div>' : ''; 
		return '<div class="formField"><div class="fieldInput">'.$input.$info.'</div>'.$label.'</div>';
	}
	
	public static function Title($title) {
		return '<div class="formTitle">'.$title.'</div>';
	}
	
	public static function Text($text) {
		return '<div class="formText">'.$text.'</div>';
	}
	
	public static function Info($text) {
		return '<div class="formInfo">'.$text.'</div>';
	}
	
	public static function Close() {
		return '</div>';
	}
}