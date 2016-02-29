<?php

class File
{
	# file
	private $_path;
	private $_name;
	private $_dir;
	private $_extension;
	private $_size;
	
	# image
	private $_width;
	private $_height;
	private $_type;
	private $_mime;
	private $_bits;
	
	private $_exists;
	
	private $_images_extensions = array(
		1 => '.gif',
		'.jpg',
		'.png',
		'.swf',
		'.psd',
		'.bmp',
		'.tif',
		'.tif',
	);
	
	function __construct($path, $upload_file_array = null) {
		
		$path = realpath($path);
		
		$this->_path = $this->ClearPath($path);

		if ( ! file_exists($path)) {
			$this->_exists = false;
			return false;
		} else {
			$this->_exists = true;

			$this->_size = @filesize($path);
			
			$this->ReadFromPath();
			
			if (!$this->GetName()) {
				$this->_exists = false;
				return false;
			}

			$info = @getimagesize($path);
	
			if (!$info) {
				if ($upload_file_array && $upload_file_array['type']) {
					$this->_mime = $upload_file_array['type'];
				} else if(class_exists('finfo')) {
					try {
						$finfo = @new finfo(FILEINFO_MIME);
						$fres = @$finfo->file($this->_path);
						if (is_string($fres) && !empty($fres)) {
							$this->_mime = $fres;
						} 
					} catch (Exception $e ) {
						
					}
				}
			} else {
				$this->_width = $info[0];
				$this->_height = $info[1];
				$this->_type = $info[2];
				$this->_bits = $info['bits'];
				$this->_mime = $info['mime'];
			}
			
		}
	}
	
	public function Exists() {
		return $this->_exists;
	}
	
	function ClearPath( $path ) {
		$path = strtr( $path, '\\', '/' );
		return $path;
	}
	
	static function ClearFilename( $name ) {
		$name = trim( strtolower( $name ) );
		$name = str_replace(" ", "_", str_replace("%20", "_", $name) );
		$name = ereg_replace("[^a-z0-9\.\_\-]", "", $name);
		if ($name{0} == '.') {
			$name = "_".$name;
		}
		if ( !strlen( $name ) ) {
			//$name = 'uploaded_file';
		}
		return $name;
	}
	
	private function ReadFromPath() {
		$slash_pos = strrpos( $this->_path, '/' ) + 1;
		$this->_dir = substr( $this->_path, 0, $slash_pos );
		$this->_name = self::ClearFilename( substr( $this->_path, $slash_pos ) );
		if ( strrpos( $this->_name, '.' ) ) {
			$this->_extension = strtolower(substr( $this->_name, strrpos( $this->_name, '.' ) + 1 ));
		} else {
			$this->_extension = '';
		}
	}
	
	function GetPath() {
		return $this->_path;
	}
	
	function GetName() {
		return $this->_name;
	}
	
	function GetOnlyName() {
		return substr( $this->_name, 0, strpos( $this->_name, '.' ) );
	}
	
	function GetDir() {
		return $this->_dir;
	}
	
	function GetExtension() {
		return $this->_extension;
	}
	
	function GetSize() {
		return $this->_size;
	}
	
	function IsImage() {
		return (bool) $this->_type;
	}
	
	function GetWidth() {
		return $this->_width;
	}
	
	function GetHeight() {
		return $this->_height;
	}
	
	function GetType() {
		return $this->_type;
	}
	
	function GetExtensionFromType() {
		return $this->_images_extensions[$this->_type];
	}
	
	function GetBites() {
		return $this->_bits;
	}
	
	function GetMime() {
		return $this->_mime;
	}
	
	function BuildSubFilePath($suffix, $dir = null) {
		if (!$dir) {
			$dir = $this->GetDir();
		}
		return $dir . $this->GetOnlyName() . '_' . $suffix . '.' . $this->GetExtension();
	}
	
	function __toString() {
		return $this->GetName() . ' - ' .$this->GetSize().' b (path: '.$this->_path.')';
	}
	
	function FitImageToBox($w,$h) {
		if ($this->IsImage()) {
			if ($this->_height < $h && $this->_width < $w) {
				# if image is smaller than box leave dimension
				$style = '';
				$w = $this->_width;
				$h = $this->_height;
			} else {
				if ($w / $this->_width >= $h / $this->_height) {
					$w = (float) ($h / $this->_height) * $this->_width;
					$style = 'height: '.$h.'px;';
				} else if ($w / $this->_width < $h / $this->_height)  {
					$h = (float) ($w / $this->_width) * $this->_height;
					$style = 'width: '.$w.'px;';
				}
			}
			return array('width' => $w, 'height' => $h, 'style' => $style);
		}
		return false;
	}
}