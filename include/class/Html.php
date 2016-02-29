<?php

class Html {
	
	static function Input($type, $name, $value, $a = array()) {
		if (!isset($a['id']) || !$a['id']) {
			$a['id'] = $name;
		}

		if (empty($type)) {
			$type = 'text';
		}

		$s = '<input';
		$s .= ' type="'.$type.'"';
		$s .= ' name="'.$name.'"';
		$s .= ' value="'.$value.'"';
		$s .= ' id="'.strtr($a['id'],'[]','__').'"';
		$s .= isset($a['size']) ? ' size="'.$a['size'].'"' : '';
		$s .= isset($a['autocomplete']) && !$a['autocomplate'] ? ' autocomplate="no"' : '';
		$s .= isset($a['maxlen']) ? ' maxlength="'.$a['maxlen'].'"' : '';
		$s .= isset($a['onclick']) ? ' onclick="'.$a['onclick'].'"' : '';
		$s .= isset($a['onfocus']) ? ' onfocus="'.$a['onfocus'].'"' : '';
		$s .= isset($a['onblur']) ? ' onblur="'.$a['onblur'].'"' : '';
		$s .= isset($a['onkeyup']) ? ' onkeyup="'.$a['onkeyup'].'"' : '';
		$s .= isset($a['class']) ? ' class="'.$a['class'].'"' : '';
		$s .= isset($a['style']) ? ' style="'.$a['style'].'"' : '';
		$s .= isset($a['checked']) && $a['checked'] ? ' checked="checked"' : '';
		$s .= isset($a['readonly']) && $a['readonly'] ? ' readonly="readonly"' : '';
		$s .= isset($a['disabled']) && $a['disabled'] ? ' disabled="disabled"' : '';
		$s .= ' />';
		return $s;
	}

	static function TextInput($name, $value, $a = array()) {
		return self::Input('text', $name, $value, $a);
	}

	static function TextDateInput($name, $value, $a = array()) {
		if (!isset($a['size'])) $a['size'] = 11;
		if (!isset($a['maxlen'])) $a['maxlen'] = 10;
		return self::Input('text', $name, $value, $a);
	}

	static function RadioInput($name, $value, $checked = false, $a = array()) {
		$a['checked'] = $checked;
		return self::Input('radio', $name, $value, $a);
	}

	static function CheckboxInput($name, $value, $checked = false, $a = array()) {
		$a['checked'] = $checked;
		return self::Input('checkbox', $name, $value, $a);
	}

	static function HiddenInput($name, $value, $a = array()) {
		return self::Input('hidden', $name, $value, $a);
	}

	static function PasswordInput($name, $value, $a = array()) {
		return self::Input('password', $name, $value, $a);
	}

	static function FileInput($name, $a = array()) {
		return self::Input('file', $name, '', $a);
	}

	static function PriceInput($name, $value, $a = array()) {
		$a['class'] .= ' price';
		if (!isset($a['onblur'])) $a['onblur'] = 'formatPrice(this);';
		if (!isset($a['size'])) $a['size'] = '8';
		if (!isset($a['maxlen'])) $a['maxlen'] = '10';
		return self::Input('text', $name, $value, $a);
	}
	
	static function DatePickerInput($name, $value) {
		
		$id = str_replace(array('[',']'),'_',$name);

		if ($value == '' || $value == '0000-00-00') {
			$value = date('Y-m-d');
		}
		
		$input = '<script type="text/javascript">
			$(document).ready(function(){
				$( "#'.$id.'" ).datepicker();
			});
			</script>';

		$input .= Html::TextInput($name,$value,array('size'=>10,'maxlen'=>10,'id'=>$id));	

		return $input;
	}

	static function Select($name, $options, $a = array()) {

		if (!isset($a['id']) || !$a['id']) {
			$a['id'] = $name;
		}

		$s = '<select';
		$s .= isset($a['class']) ? ' class="'.$a['class'].'"' : '';
		$s .= ' name="'.$name.'"';
		$s .= ' id="'.strtr($a['id'],'[]','__').'"';
		$s .= isset($a['onclick']) ? ' onclick="'.$a['onclick'].'"' : '';
		$s .= isset($a['onchange']) ? ' onchange="'.$a['onchange'].'"' : '';
		$s .= isset($a['size']) ? ' size="'.(int)$a['size'].'"' : '';
		$s .= isset($a['style']) ? ' style="'.$a['style'].'"' : '';
		$s .= '>';
		$s .= $options;
		$s .= '</select>';
		return $s;
	}

	static function SelectOption($k, $v, $selected = null) {
		$opt_attr = '';
		if ($selected !== null) {
			if (is_string($selected)) {
				$opt_attr = strcmp($k, $selected) == 0 ? 'selected="selected"' : '';
			} else if (is_array($selected)) {
				$opt_attr = isset($selected[$k]) ? 'selected="selected"' : '';
			} else {
				$opt_attr = $k == $selected ? 'selected="selected"' : '';
			}
		}
		return '<option value="'.$k.'" '.$opt_attr.'>'.$v.'</option>';
	}

	static function SelectOptionGroup($label, $options = array()) {
		if (!empty($options) && is_array($options)) {
			$options = implode("\n", $options);
		}
		return '<optgroup label="'.$label.'">'.$options.'</optgroup>';
	}
	
	static function SelectOptions($options, $selected = null, $v2k = false) {
		$list = '';
		if (is_array($options) && sizeof($options)) {
			if ($v2k === false) {
				foreach ($options as $k => $v) {
					$list .= self::SelectOption($k, $v, $selected);
				}
			} else {
				foreach ($options as $v) {
					$list .= self::SelectOption($v, $v, $selected);
				}
			}
		}
		return $list;
	}

	/**
	 * Returns 3 select lists: days, months, years
	 * @param (string) $name
	 * @param (date | array(d,m,y) or dd-mm-yyyy) $date
	 * @param (array) $a - optional
	 * @return (string)
	 */
	static function SelectDate($name, $date, $a = array()) {

		if (is_array($date)) {
			$year = $date['year'];
			$month = $date['month'];
			$day = $date['day'];
		} else {
			list ($year, $month, $day) = explode('-', Date::onlyDate($date));
		}

		for ($i=1; $i<=31; $i++) {
			if ($i < 10) {
				$i = '0'.$i;
			}
			$days[$i] = $i;
		}

		$_a = $a;
		$_a['id'] = $a['id'].'_day';
		$options = self::SelectOptions($days, $day);

		$s .= self::Select($name.'[day]', $options, $_a);
		$s .= ' / ';

		for ($i=1;$i<=12;$i++) {
			if ($i < 10) {
				$i = '0'.$i;
			}
			$months [$i] = $i;
		}

		$_a = $a;
		$_a['id'] = $a['id'].'_month';

		$options = self::SelectOptions($months, $month);

		$s .= self::Select($name.'[month]', $options, $_a);
		$s .= ' / ';

		if ($a['from_year']) {
			$from_year = $a['from_year'];
		} else {
			$from_year = date('Y');
		}

		for($i=$from_year; $i>=2007; $i--) {
			$years [$i] = $i;
		}

		$_a = $a;
		$_a['id'] = $a['id'].'_year';

		$options = self::SelectOptions($years, $year);

		$s .= self::Select($name.'[year]', $options, $_a);

		return $s;
	}

	/**
	 * Returns 3 select lists: hours, minutes, seconds
	 * @param (string) $name
	 * @param (time | array(h,i,s) or hh-ii-ss) $time
	 * @param (array) $a - optional
	 * @return (string)
	 */
	static function SelectTime($name, $time, $a = array()) {
		if (is_array($time)) {
			$hour = $time['hour'];
			$minute = $time['minute'];
			$second = $time['second'];
		} else {
			list ($hour, $minute, $second) = explode(':', $time);
		}

		for ($i=0; $i<=23; $i++) {
			if ($i < 10) {
				$i = '0'.$i;
			}
			$hours[$i] = $i;
		}

		$_a = $a;
		$_a['id'] = $a['id'].'_hour';
		$options = self::SelectOptions($hours, $hour);

		$s .= self::Select($name.'[hour]', $options, $_a);
		$s .= ' / ';

		for ($i=0;$i<=59;$i++) {
			if ($i < 10) {
				$i = '0'.$i;
			}
			$min_sec [$i] = $i;
		}

		$_a = $a;
		$_a['id'] = $a['id'].'_minute';
		$options = self::SelectOptions($min_sec, $minute);

		$s .= self::Select($name.'[minute]', $options, $_a);
		$s .= ' / ';

		$_a = $a;
		$_a['id'] = $a['id'].'_second';
		$options = self::SelectOptions($min_sec, $second);

		$s .= self::Select($name.'[second]', $options, $_a);

		return $s;
	}

	static function SelectDatetime($name, $datetime, $a = array()) {

		if (!is_array($datetime)) {
			list ($date, $time) = explode(' ', $datetime);
		} else {
			$date = $datetime;
			$time = $datetime;
		}

		$s = self::SelectDate($name, $date, $a);
		$s .= '&nbsp;&nbsp;';
		$s .= self::SelectTime($name, $time, $a);

		return $s;
	}

	static function ImplodeDatetime($datetime) {
		$s = '';
		if (is_array($datetime) && sizeof($datetime)) {
			$both = false;
			if (isset($datetime['year'])
				&& isset($datetime['month'])
				&& isset($datetime['day'])) {
				$s .= $datetime['year'].'-'.$datetime['month'].'-'.$datetime['day'];
				$both = true;
			}
			if (isset($datetime['hour'])
				&& isset($datetime['minute'])
				&& isset($datetime['second'])) {
				if ($both) {
					$s .= ' ';
				}
				$s .= $datetime['hour'].':'.$datetime['minute'].':'.$datetime['second'];
			}
		} else {
			$s .= $datetime;
		}
		return $s;
	}

	static function Textarea($name, $value, $rows, $cols = 0, $a = array()) {

		if (!isset($a['id']) || !$a['id']) {
			$a['id'] = $name;
		}

		if (!$cols) {
			if (!isset($a['style']) || !$a['style']) {
				$a['style'] = 'width: 98%;';
			}
		}

		$s = '<textarea';
		$s .= ' name="'.$name.'"';
		$s .= ' id="'.strtr($a['id'],'[]','__').'"';
		$s .= ' rows="'.$rows.'"';
		$s .= ' cols="'.$cols.'"';
		$s .= ' class="'.$a['class'].'"';
		$s .= $a['style'] ? ' style="'.$a['style'].'"' : '';
		$s .= '>';
		$s .= $value;
		$s .= '</textarea>';
		return $s;
	}

	static function FormBoxLeft() {
		$s = '<table class="form-body">';
		$s .= '<tr><td class="form-left-box">';
		return $s;
	}
	
	static function FormBoxRight() {
		$s .= '</td><td class="form-right-box form-left-break">';
		return $s;
	}
	
	static function FormBoxClose() {
		$s = '</td></tr></table>';
		return $s;
	}
	
	static function BoxOpen($width = '100%', $theme = 'box', $params = null) {
		
		//return $s;
	} 
	
	static function BoxClose() {
		

		//return $s;
	}
	
	/**
	 *  PROTOTYPE
	 */
	public static function Button($name,$type,$onclick,$a = array()) {
		$s = '';
	}

}