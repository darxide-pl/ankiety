<?php

class Db_Cache {
	private $sql;
	private $path;
	private $file_ext;
	private $file_name;
	public static $cache = true;
	
	public function __construct($sql) {
		$this->sql = $sql;
		$this->file_ext = '.cache';
		$this->file_name = $this->_getFileName();
		$this->path = DIR_CACHE_SQL;
		$this->_rebuildDirectory();
	}
	
	public function Load() {
		if (!self::$cache) {
			return false;
		}

		if (file_exists($this->path.$this->file_name)) {
			$content = file($this->path.$this->file_name);
			if (time() > $content[0]) {
				@unlink($this->path.$this->file_name);
				return false;
			}
			$content[0] = null;
			return unserialize(implode('',$content));
		}
		return false;
	}

	public function Create($result, $minutes = 3600) {
		
		if (!self::$cache) {
			return false;
		}
		
		if (file_exists($this->path.$this->file_name)) {
			@unlink($this->path.$this->file_name);
		}
		
		file_put_contents($this->path.$this->file_name,
			mktime((int)date('H'),(int)date('i')+$minutes,(int)date('s'),(int)date('m'),(int)date('d'),(int)date('Y'))."\n".serialize($result));
	}

	public static function ClearCache() {
		$dir = opendir(DIR_CACHE_SQL);
		while($entry = readdir(DIR_CACHE_SQL)) {
			if (file_exists(DIR_CACHE_SQL.$entry)) {
				@unlink(DIR_CACHE_SQL.$entry);
			}
		}
		closedir($dir);
	}
	
	public static function On() {
		self::$cache = true;
	}
	
	public static function Off() {
		self::$cache = false;
	}
	
	private function _getFileName() {
		return md5($this->sql).$this->file_ext;
	}
	
	private function _rebuildDirectory() {
		if (!file_exists($this->path)) {
			@mkdir($this->path,0777);
		}
	}
}