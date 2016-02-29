<?php

class Date {
	
	static $days_short = array(0, 'pon', 'wto', 'śro', 'czw', 'pią', 'sob','nie');
	static $days = array(0,'poniedziałek','wtorek','środa','czwartek','piątek','sobota','niedziela');
	static $months_short = array('', 'sty', 'lut', 'mar', 'kwi', 'maj', 'cze', 'lip', 'sie', 'wrz', 'paź', 'lis', 'gru');
	static $months = array('', 'styczeń', 'luty', 'marzec', 'kwiecień', 'maj', 'czerwiec', 'lipiec', 'sierpień', 'wrzesień', 'październik', 'listopad', 'grudzień');
	
	static function diff($date1, $date2, $in = 'days') {
		$time1 = self::toTime($date1);
		$time2 = self::toTime($date2);
		$diff = $time1 - $time2;
		switch ($in) {
			case 'months':
				return round($diff/(3600*24*31));
			case 'seconds':
				return round($diff);
			case 'minutes':
				return round($diff/60);
			case 'days':
			default:
				return intval($diff/(3600 * 24));
		}
	}
	
	static function toString($date,$type = 'long') {
		
		if ($type == 'wordifcan') {
			return self::_toString_wordifcan($date);
		}
		
		$days = $type == 'short' ? self::$days_short : self::$days;
		$months = $type == 'short' ? self::$months_short : self::$months;
		list ($year, $month, $temp_day) = explode('-', Date::onlyDate($date));	
		return $temp_day.' '.$months[(int)$month].' '.$year;
	}
	
	static function toTime($date) {
		return strtotime($date); 
	}
	
	static function fromTime($time, $format = 'Y-m-d') {
		return date($format, $time);
	}
	
	static function onlyDate($datetime) {
		return substr($datetime,0,10);
	}
	
	static function onlyTime($datetime) {
		return substr($datetime,11);
	}
	
	public static function _toString_wordifcan($datetime) {

        $timestamp = strtotime($datetime);

		$now = time();

		if ($timestamp > $now) {
			return 'Podana data nie może być większa od obecnej.';
		}

		$diff = $now - $timestamp;

		$minut = floor($diff / 60);
		$godzin = floor($minut / 60);
		$dni = floor($godzin / 24);

		if ($minut <= 60) {
			$res = self::_toString_minutes($minut);
			switch ($res) {
				case 0: return "przed chwilą";
				case 1: return "minutę temu";
				default: return $res;
			}
		}
		
		$timestamp_wczoraj = mktime(0,0,0,date('m'),date('d')-1,date('Y'));
		$timestamp_przedwczoraj = mktime(0,0,0,date('m'),date('d')-2,date('Y'));

		if ($godzin > 0 && $godzin <= 6) {

			$restMinutes = ($minut - (60 * $godzin));
			$res = self::_toString_minutes($restMinutes);
			if ($godzin == 1) {
				return "Godzinę temu "; //.$res
			} else {
				return "$godzin godzin temu ";
			}
		} else if (date("Y-m-d", $timestamp) == date("Y-m-d", $now)) {//jesli dzisiaj
			return "Dzisiaj " . date("H:i", $timestamp);
		} else if (date("Y-m-d", $timestamp_wczoraj) == date("Y-m-d", $timestamp)) {//jesli wczoraj
			return "Wczoraj " . date("H:i", $timestamp);
		} else if (date("Y-m-d", $timestamp_przedwczoraj) == date("Y-m-d", $timestamp)) {//jesli wczoraj
			return "Przedwczoraj " . date("H:i", $timestamp);
		}

		switch ($dni) {
			case ($dni < 7): return "$dni dni temu, " . date("Y-m-d", $timestamp);
				break;
			case 7: return "Tydzień temu, " . date("Y-m-d", $timestamp);
				break;
			case ($dni > 7 && $dni < 14): return "Ponad tydzień temu, " . date("Y-m-d", $timestamp);
				break;
			case 14: return "Dwa tygodznie temu, " . date("Y-m-d", $timestamp);
				break;
			case ($dni > 14 && $dni < 30): return "Ponad 2 tygodnie temu, " . date("Y-m-d", $timestamp);
				break;
			case 30: case 31: return "Miesiąc temu";
				break;
			case ($dni > 31): return date("Y-m-d H:i", $timestamp);
				break;
		}
		return date("Y-m-d", $timestamp);
	}
	
	public static function _toString_minutes($minut) {
        switch ($minut) {
			case 0: return 0;
				break;
			case 1: return 1;
				break;
			case ($minut >= 2 && $minut <= 4):
			case ($minut >= 22 && $minut <= 24):
			case ($minut >= 32 && $minut <= 34):
			case ($minut >= 42 && $minut <= 44):
			case ($minut >= 52 && $minut <= 54): return "$minut minuty temu";
				break;
			default: return "$minut minut temu";
				break;
		}
		return -1;
	}
}