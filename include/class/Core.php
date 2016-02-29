<?php

abstract class Core {

	static protected $_objects;
	
	private static $core_components;
	
	protected $_errors ;
	
	protected static $default_components_loaded = false;
	
	protected static $globals = array();
	
	function __construct() {
		
		$this->_errors = 0;
		
		# turn on default components
		$this->_install();
	}
	
	/**
	 * Initialize default components
	 */
	private function _install() {
		
		if (self::$default_components_loaded) {
			return true;
		}
		
		if (!isset(self::$core_components['msg'])) {
			self::$core_components['msg'] = Messages::Instance();
		}
		
		self::$core_components['rv'] = Request_Vars::Instance();
		self::$core_components['db'] = Db::Instance();
		self::$core_components['request'] = new Request;
		self::$core_components['link'] = Link::Instance();
		
		self::$default_components_loaded = true;
	}
	
	public static function Install_Component($name,$object) {
		self::$core_components[$name] = $object;
	}
	
	public function __get($var) {
		if (isset(self::$core_components[$var])) {
			return self::$core_components[$var];
		}
	}
	
	/**
	 * Add new success message
	 * @param (string) $msg
	 * @return undefined
	 */
	function msg($text) {
		$this->msg->add($text);
	}
	
	/**
	 * Add new error message and increase error or not ($pass_throught)
	 *
	 * @param (string) $error_msg
	 * @param (bool) $pass_throught
	 * @return undefined
	 */
	function error($text, $pass_throught = false) {
		$this->msg->addError($text);

		if ($pass_throught == false) {
			$this->_errors++;
		}
	}
	
	# Check is there some errors
	function Pass() {
		return $this->_errors == 0;
	}
	
	public static function AssignObjectToCore($object) {
		
		if (is_object($object)) {
			$object_name = get_class($object);
			self::$_objects[$object_name] = $object;
		} else {
			throw new Exception('Zmienna \$object nie jest obiektem. '.__CLASS__.'::'.__FUNCTION__);
		}
	}
	
	public static function Call($name) {
		return self::$_objects[$name];
	}
	
	public function setGlobal() {
		
	}
	
	public function getGlobal() {
		
	}
}