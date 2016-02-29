<?php

class BrowserSniffer {

	private $_version = '0.0.0';
	private $_name = 'unknown';
	
	private $_agent = 'unknown';
	private $_allow_header_redirect = true;

	private $_browsers = array();

	public function __construct($user_agent = null) {
		 
		if (!$user_agent) {
			$user_agent = $_SERVER['HTTP_USER_AGENT'];
		}
		 
		$this->_agent = strtolower($user_agent);
		 
		$this->_browsers = array(
        	"firefox" => "Mozilla Firefox",
        	"msie" => "Microsoft Internet Explorer",
        	"opera" => "Opera",
        	"chrome" => "Google Chrome",
        	"safari" => "Safari",
			"mozilla" => "Mozilla",
			"seamonkey" => "SeaMonkey",
			"konqueror" => "Konqueror",
			"netscape" => "Netscape",
			"gecko" => "Gecko",
			"navigator" => "Navigator",
			"mosaic" => "Mosaic",
			"lynx" => "Lynx",
			"amaya" => "Amaya",
			"omniweb" => "OmniWeb",
			"avant" => "Avant Browser",
			"camino" => "Camino",
			"flock" => "Flock",
			"aol" => "AOL",
		);

		foreach($this->_browsers as $k => $v) {
			if (preg_match("#($k)[/ ]?([0-9.]*)#", $this->_agent, $match)) {
				$this->_name = $v;
				$this->_version = $match[2];
				break ;
			}
		}

		$this->_allow_header_redirect = !($this->_name == "msie" && $this->_version < 7);
	}
	
	public function GetName() {
		return $this->_name;
	}
	
	public function GetVersion() {
		return $this->_version;
	}
}