<?php

class Cache {
	
	private $name;
	private $path;
	private $absolute_path;
	private $file_ext;
	private $file_name;
	private $expire;
	private $cache_started;
	public static $cache;
	private $flush_after_save;
	private $type; 
	
	const DONT_FLUSH = false;
	const DO_FLUSH = true;
	
	const FORCE_CACHE = 1;
	const SIMPLE_CACHE = 0;
	
	public function __construct($name, $expire = null, $extension = '.cache', $flush = true, $type = Cache::SIMPLE_CACHE) {
		
		//Log::open('Cache_Controller');
		
		$this->cache_started = false; 
		$this->name = $name;
		if ($expire <= 0) {
			$expire = 0;
		} else if ($expire == null) {
			$expire = 600;
		}
		$this->type = $type;
		$this->expire = $expire;
		$this->flush_after_save = $flush;
		$this->file_ext = $extension;
		$this->file_name = $this->_getFileName();
		$this->path = DIR_CACHE_HTML;
		$this->absolute_path = DIR_CACHE_HTML_ABSOLUTE;
		$this->_rebuildDirectory();
		
		if (!$this->Read()) {
			ob_start();
			$this->cache_started = true;
		}
	}
	
	public function Readed() {
		return !$this->cache_started;
	}
	
	public function GetPathTo() {
		return $this->path . $this->file_name;
	}
	
	public function GetAbsolutePathTo() {
		return $this->absolute_path . $this->file_name;
	}
	
	public function Stop() {
		if ($this->cache_started) {
			if ($this->flush_after_save == true) {
				$cache = ob_get_flush();	
			} else {
				$cache = ob_get_clean();
			}
			$this->Write($cache);
		}
	}
	
	private function Read() {
		
		if (self::$cache || $this->type == Cache::FORCE_CACHE) {
			
			if (file_exists($this->path.$this->file_name)) {
				
				if ($fp = @fopen($this->path.$this->file_name, "rb")) {
				
					if (@flock($fp, LOCK_EX)) { // do an exclusive lock
					    $mtime = filemtime($this->path.$this->file_name);
						if ((time() - $this->expire) > $mtime) {
							return false;
						}
						
						# log when it will expire
						//Log::write('Cache_Controller',$this->file_name.' will expire in '.(int)($this->expire-(time()-$mtime)));
						
						flock($fp, LOCK_UN); // release the lock
					}
					fclose($fp);
					clearstatcache();
				} else {
					return false;
				}
				
				if ($this->flush_after_save) {

					//Log::write('Cache_Controller',$this->file_name.' should be printed.');
					
					echo file_get_contents($this->path.$this->file_name);
				}
				return true;
			} else if ($this->type == Cache::FORCE_CACHE) {
				return false;
			}
		}
		return false;
	}

	private function Write($result) {
		
		if (!self::$cache && $this->type != Cache::FORCE_CACHE) {
			return false;
		}
		
		if (file_exists($this->path.$this->file_name)) {
			@unlink($this->path.$this->file_name);
		}

		file_put_contents($this->path.$this->file_name,$result);
		@chmod($this->path.$this->file_name, 0755); 
	}

	public static function ClearCache() {
		$dir = opendir($this->path);
		while($entry = readdir($this->path)) {
			if (file_exists($this->path.$entry)) {
				@unlink($this->path.$entry);
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
		return md5($this->name).$this->file_ext;
	}
	
	private function _rebuildDirectory() {
		if (!file_exists($this->path)) {
			@mkdir($this->path,0755);
		}
	}
}