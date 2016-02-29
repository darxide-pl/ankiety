<?php

class Link {
	
	private $_params = array();
	private $_ports = array();
	private $_default_port = 'http';
	
	static private $_Instance;
	
	public function __construct() {
		$this->_params = array(
			'domain' => DEFAULT_HOST_ADDRESS,
			'port' => DEFAULT_PORT,
		);
		
		$this->_ports = array(
			'ftp' => 'ftp://',
			'http' => 'http://',
			'https' => 'https://',
		);
	}
	
	static function Instance() {
		if (!isset(self::$_Instance)) {
			self::$_Instance = new Link();
		}
		return self::$_Instance; 
	}
	
	function Append($data = '', $params = null, $no_autofill = false) {
		if (is_array($data)) {
			array_unshift($data, trim(str_replace(INTERFACE_DIR,'',$_SERVER['REQUEST_URI']),'/'));
		} else {
			$data = trim(str_replace(INTERFACE_DIR,'',$_SERVER['REQUEST_URI']),'/').$data;
		}
		return $this->Build($data, $params, $no_autofill);
	}
	
	function Build($data = '', $params = null, $no_autofill = false) {
		
		if (is_string($data) && strpos($data,'http') === 0) {
			return $data;
		}
		
		$p = $this->_params;
		
		if (isset($params['port'])) {
			$p['port'] = strtolower($params['port']);
		}
		
		if (isset($params['domain'])) {
			$p['domain'] = $params['domain'];
		}
		
		if (isset($this->_ports[$p['port']])) {
			$a = $this->_ports[$p['port']];
		} else {
			$a = $this->_ports[$this->_default_port];
		}
		
		$a .= $p['domain'];
		
		if (is_array($data)) {
			if (!empty($data['page'])) {
				$a .= $data['page'] . LT;
				unset($data['page']);
				if (!empty($data['subpage'])) {
					$a .= $data['subpage'] . LT;
					unset($data['subpage']);
				} elseif ($no_autofill == false) {
					$a .= 'index' . LT;
				}
			}
			
			if (sizeof ($data)) {
				foreach ($data as $k => $v) {
					if((!empty($v) || is_numeric($v)) && isset($k)) {
						if (is_numeric($k)) {
							$a .= $v . LT;
						} else {
							$a .= $k . LT . $v . LT;
						}
					}
				}
			}
		} else {
			if (substr($data,0,1) == LT) {
				$a .= substr($data,1);
			} else {
				$a .= $data;
			}
		}

		return $a;
	}
}