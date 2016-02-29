<?php

class Request_Vars
{
	/**
	 * Container for Request_Vars instace
	 * @var Request_Vars
	 */
	private static $_Instance;
	
	/**
	 * Array of request data (post, get, request)
	 * @var (array)
	 */
	private $_vars;
	
	/**
	 * Reload vars on start
	 * @return undefined
	 */
	private function __construct()
	{
		$this->_Reload();
	}

	/**
	 * Get instance of this object or create first to avoid multiple objects of this class
	 * @return Request_Vars Instance
	 */
	static function Instance()
	{
		if (!isset(self::$_Instance))
		{
			self::$_Instance = new Request_Vars();
		}
		return self::$_Instance;
	}
	
	/**
	 * Reload vars from reqeuest to object array
	 * @return undefined
	 */
	private function _Reload()
	{
		$this->_vars ['post'] = f_filter_inputs($_POST);
		$this->_vars ['get'] = f_filter_inputs($_GET);
		$this->_vars ['request'] = f_filter_inputs($_REQUEST);
	}
	
	/**
	 * Get array of vars from specyfied request array
	 * @param (string) $source [post][get][request][all]
	 * @return unknown_type
	 */
	function getVars($source = 'post')
	{
		$source = strtolower($source);
		switch ($source)
		{
			case 'post':
				return $this->_vars ['post'];
				break;
			case 'get':
				return $this->_vars ['get'];
			case 'request':
			case 'all':
			default:
				return $this->_vars ['request'];
		}
	}
	
	/**
	 * Get single var value from specyfied source of request
	 * @param (string) $var
	 * @param (string) $source [post][get][request][all]
	 * @return (mixed)
	 */
	function get($var, $source = 'get')
	{
		$source = strtolower($source);
		switch ($source)
		{
			case 'post':
				if (isset($this->_vars ['post'] [$var])) {
					return $this->_vars ['post'] [$var];
				}
				break;
			case 'get':
				if (isset($this->_vars ['get'] [$var])) {
					return $this->_vars ['get'] [$var];
				}
			case 'request':
			case 'all':
			default:
				if (isset($this->_vars ['request'] [$var])) {
					return $this->_vars ['request'] [$var];
				}
		}
	}
	
	/**
	 * Set var on single source or in all sources and reload object data
	 * @param (string) $var
	 * @param (mixed) $value
	 * @param (string) $source [post][get][request][all]
	 * @return undefined
	 */
	function set($var, $value, $source = 'all')
	{
		$source = strtolower($source);
		switch ($source)
		{
			case 'post':
				$_POST [$var] = $value;
				break;
			case 'get':
				$_GET [$var] = $value;
				break;
			case 'request':
				$_REQUEST [$var] = $value;
				break; 
			case 'all':
			default:
				$_POST [$var] = $_GET [$var] = $_REQUEST [$var] = $value;
		}
		
		$this->_Reload();
	}

	function is_empty($var, $source = 'all')
	{
		switch ($source)
		{
			case 'post':
				return empty($_POST [$var]);
				break;
			case 'get':
				return empty($_GET [$var]);
				break;
			case 'request':
			case 'all':
			default:
				return empty($_REQUEST [$var]);
		}
	}
	
	function issetvar($var, $source = 'all') {
		return $this->isset_var($var,$source);
	}
	
	function isset_var($var, $source = 'all')
	{
		switch ($source)
		{
			case 'post':
				return isset($_POST [$var]);
				break;
			case 'get':
				return isset($_GET [$var]);
				break;
			case 'request':
			case 'all':
			default:
				return isset($_REQUEST [$var]);
		}
	}
	
	function unsset_var($var, $source = 'all')
	{
		switch ($source)
		{
			case 'post':
				unset($_POST [$var]);
				break;
			case 'get':
				unset($_GET [$var]);
				break;
			case 'request':
			case 'all':
			default:
				unset($_REQUEST [$var]);
		}
	}
}

?>