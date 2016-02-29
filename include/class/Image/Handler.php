<?php

/**
 * @author: Szymon Błąkała [vsemak@gmail.com]
 * @version: 2.0
 */

/*
 * Klasa służy do obsługi podstawowych typów zdjęć.
 * 
 * Postawowa funkcja to 'scale' służaca do zmiany rozmiaru zdjęcia.
 * 
 * v.2.0
 * Dodanie metod zwracajacych obiekt sam w sobie, efektem czego możliwe jest użycie tego kodu:
 * $this->width(100)->height(200)->resize()->save();
 * 
 */

class Image_Handler extends FileHandler {
	
	private $_width;
	private $_height;
	private $_bits;
	private $_mime;
	
	private $_new_width;
	private $_new_height;
	
	private $_dst_width;
	private $_dst_height;
	
	private $_quality = 96;
	private $_transparency = true;
	
	private $_x_offset = 0;
	private $_y_offset = 0;
	
	private $_source;
	private $_thumb;
	
	function __construct($path) {
		
		parent::__construct($path);
		
		if (($p = getimagesize($path)) === false) {
			//throw new Exception('Plik <code>'.$path.'</code> nie jest obrazkiem.');
		}

		$this->_width = $p[0];
		$this->_height = $p[1];
		$this->_bits = $p['bits'];
		$this->_mime = $p['mime'];
		
		if (!$this->_source = $this->imageCreate($this->_path)) {
			throw new Exception('Nie udało się załadować do pamięci obrazka: <code>'.$this->_path.'</code>.');
		}
	}
	
	function getWidth() {
		return $this->_width;
	}
	
	function getHeight() {
		return $this->_height;
	}
	
	function getNewWidth() {
		return $this->_new_width;
	}
	
	function getNewHeight() {
		return $this->_new_height;
	}
	 
	function getMime() {
		return $this->_mime;
	} 
	
	private function imageCreate($path) {
		
		return new Imagick($path);
	}
	
	private function image($image, $destination, $quality = 96) {
		$image->writeImage($destination);
	}

	function width($new_width) {
		$this->_new_width = $new_width;
		return $this;
	}
	
	function height($new_height) {
		$this->_new_height = $new_height;
		return $this;
	}
	
	function quality($quality) {
		$this->_quality = $quality;
		return $this;
	}
	
	function setTransparentColor($color) {
		$this->_transparent_color = $color;
		return $this;
	}
	
	function noTransparency() {
		$this->_transparency = false;
		return $this;
	}
	
	function resize() {
		/*
		 * do nothing, keep new dimensions and resize image to them
		 */
		$this->_thumb = imagecreatetruecolor($this->_new_width, $this->_new_height);

		if ($this->_transparency === true) {
			$this->_MakeTransparency($this->_thumb, $this->_source);
		}
		imagecopyresampled($this->_thumb, $this->_source, $this->_x_offset, $this->_y_offset, 0, 0, $this->_new_width, $this->_new_height, $this->_width, $this->_height);
		
		return $this;
	}
	
	public function copy() {
		
		$this->_thumb = imagecreatetruecolor($this->getWidth(), $this->getHeight());

		if ($this->_transparency === true) {
			$this->_MakeTransparency($this->_thumb, $this->_source);
		}
		imagecopyresampled($this->_thumb, $this->_source, $this->_x_offset, $this->_y_offset, 0, 0, $this->_width, $this->_height, $this->_width, $this->_height);

		return $this;
	}
	
	public function crop($v = 'center',$h = 'center') {

		$width = $this->_new_width;
		$height = $this->_new_height;
		
		if ($width > $this->_width) {
			$width = $this->_width;
		}
		
		if ($height > $this->_height) {
			$height = $this->_height;
		}
		
		if ($v == 'center') {
			$this->_x_offset = (int) round(($this->_width - $width) / 2);
		} else if ($v == 'left') {
			$this->_x_offset = 0;
		} else if ($v == 'right') {
			$this->_x_offset = $this->_width - $width;
		}
		
		if ($h == 'center') {
			$this->_y_offset = (int) round(($this->_height - $height) / 2);
		} else if ($v == 'top') {
			$this->_y_offset = 0;
		} else if ($v == 'bottom') {
			$this->_y_offset = $this->_height - $height;
		}
		
		if ($this->_x_offset < 0) $this->_x_offset = 0;
		if ($this->_y_offset < 0) $this->_y_offset = 0;
		
		$this->_thumb = imagecreatetruecolor($width, $height);

		if ($this->_transparency === true) {
			$this->_MakeTransparency($this->_thumb, $this->_source);
		}
		
		imagecopy($this->_thumb, $this->_source, 0, 0, $this->_x_offset, $this->_y_offset, $width, $height);

		return $this;
	} 
	
	public function cropXY($x,$y) {
		
	}
	
	public function convertToGrey() {
		
		$this->_thumb = imagecreatetruecolor($this->getWidth(), $this->getHeight());
		
		imagecopyresampled($this->_thumb, $this->_source, 0, 0, 0, 0, $this->_width, $this->_height, $this->_width, $this->_height);
		imagefilter($this->_thumb, IMG_FILTER_GRAYSCALE);

		return $this;
	}
	
	public function apply() {
		if ($this->_thumb) {
			$this->_source = $this->_thumb;
			$this->_width = imagesx($this->_thumb);
			$this->_height = imagesy($this->_thumb);
		}
		return $this;
	}
	
	public function roundCorners($size = 10,$color = '#FFFFFF',$transparency = 127) {
		
		$this->_thumb = imagecreatetruecolor($this->getWidth(), $this->getHeight());
		$this->_thumb = round_corners($this->_source,$size,$color,$transparency);

		return $this;
	}
	
	/**
	 * 
	 * @param type $fill_color
	 * @param type $crop
	 * @return \ImageHandler
	 */
	function scaleToBox($fill_color = false, $crop = false) {
		
		if (!$this->_new_height) {
			$this->_new_height = $this->_height;
		}
		
		if (!$this->_new_width) {
			$this->_new_width = $this->_width;
		}
		
		
		if ($this->_height < $this->_new_height && $this->_width < $this->_new_width) {
			# if image is smaller than box leave dimension
			$this->_dst_width = $this->_width;
			$this->_dst_height = $this->_height;
		} else {
			if ($this->_new_width / $this->_width > $this->_new_height / $this->_height) {
				$this->_dst_height = $this->_new_height;
				$this->_dst_width = (float) ($this->_new_height / $this->_height) * $this->_width;
			} else if ($this->_new_width / $this->_width < $this->_new_height / $this->_height)  {
				$this->_dst_height = (float) ($this->_new_width / $this->_width) * $this->_height;
				$this->_dst_width = $this->_new_width;
			} else {
				$this->_dst_height = $this->_new_height;
				$this->_dst_width = $this->_new_width;
			}
		}
	
		if ($fill_color) {
			
			
			if (is_array($fill_color)) {
				if (isset($fill_color['red'])) { 
					$fill_color[0] = $fill_color['red']; 
				}
				if (isset($fill_color['green'])) { 
					$fill_color[1] = $fill_color['green'];
				}
				if (isset($fill_color['blue'])) {
					$fill_color[2] = $fill_color['blue'];
				}
			} else {
				# default white
				$fill_color = array(255,255,255);
			}
			
		}

		$this->_source->resizeImage($this->_dst_width, $this->_dst_height, Imagick::FILTER_LANCZOS, 1);

		return $this;
	}
	
	public function scale($crop = false, $fill = true) {

		$width = $this->getNewWidth();
		$height = $this->getNewHeight();
		
		if ($this->getHeight() < $this->getNewHeight() && $this->getWidth() < $this->getNewWidth()) {
			// no crop
			$crop = false;
		} else {
			if ($this->getNewWidth() / $this->getWidth() > $this->getNewHeight() / $this->getHeight()) {
				$crop_by = 'height';
			} else if ($this->getNewWidth() / $this->getWidth() < $this->getNewHeight() / $this->getHeight())  {
				$crop_by = 'width';
			} else {
				$crop = false;
			}
		}

		if ($crop) {
			if ($crop_by == 'height') {
				$this
					->width($width)
					->height(null)
					->scaleToBox()
					->apply()
					->height($height)
					->width($width)
					->crop();
			} else {
				$this
					->height($this->getNewHeight())
					->width(null)
					->scaleToBox()
					->apply()
					->height($height)
					->width($width)
					->crop();
			}
		} else {
			$this
				->height($this->getNewHeight())
				->width($this->getNewWidth())
				->scaleToBox($fill == true ? array('red'=>255,'green'=>255,'blue'=>255) : null);
		}
		
		$this->apply();
		
		return $this;
	}
	
	function scaleToPercent($percent) {
		
		$this->_dst_height = (int) ($this->_height * ($percent/100));
		$this->_dst_width = (int) ($this->_width * ($percent/100));
	
		$this->_thumb = imagecreatetruecolor($this->_dst_width, $this->_dst_height);

		if ($this->_transparency === true) {
			$this->_MakeTransparency($this->_thumb, $this->_source);
		}
		imagecopyresampled($this->_thumb, $this->_source, $this->_x_offset, $this->_y_offset, 0, 0, $this->_dst_width, $this->_dst_height, $this->_width, $this->_height);

		return $this;
	}
	
	function save($path_to = null) {

		if (!$path_to) {
			$path_to = $this->getPath();
		}
		
		$dir = dirname($path_to);
		if (!file_exists($dir)) {
			if (!@mkdir($dir,0777,true)) {
				throw new Exception('Katalog <b>'.$dir.'</b> nie istnieje lub nie masz praw do zapisu w nim.');
			}
		}
		
		$this->image($this->_source, $path_to, $this->_quality);
		
		return $this;
	}
	
	function _MakeTransparency($new_image, $image_source, $transparent_color = null) {
		
		# get actual transparent color id
		$t_index = imagecolortransparent($image_source);
		
		if($transparent_color)  {
			# set new transparent color (by force)
			$t_color = $transparent_color;
		} elseif ($t_index >= 0) {
			# detect image transparent color
			# if transparent color is active (-1 == no transparency)
			# change default transparent color to transparent color from source image
			$t_color = imagecolorsforindex($image_source, $t_index);   
		} else {
			# no transparency
			imagealphablending($new_image, false);
			imagesavealpha($new_image, true);  
			imagealphablending($image_source, true);
			return true;
		}

		# allocate transparent color
		$t_index = imagecolorallocate($new_image, $t_color['red'], $t_color['green'], $t_color['blue']);
		# add transparent color to new image
		imagefill($new_image, 0, 0, $t_index);
		imagecolortransparent($new_image, $t_index);
	}
	
	public function addWatermark($watermark_path, $hpos = 'middle', $vpos = 'center' ) {
		if (imagecreatefrompng($watermark_path)) {
			
		}
		if ($watermark = imagecreatefrompng($watermark_path)) {
			
			$watermark_width = imagesx($watermark);  
			$watermark_height = imagesy($watermark);
			
			$white_color = imageColorAllocate($watermark,255,255,255);
			imageColorTransparent($watermark,$white_color);
			
			switch ($hpos) {
				case 'left':  
					$dest_x = 0;
					break;
				case 'right':
					$dest_x = $this->_width - $watermark_width;
					break;
				case 'center':
				default;
 					$dest_x = intval(($this->_width - $watermark_width )/2); 
					break;
			}
			
			switch ($hpos) {
				case 'top':  
					$dest_y = 0;
					break;
				case 'bottom':
				case 'bot':  
					$dest_y = $this->_height - $watermark_height;
					break;
				case 'middle':
				case 'mid':
				default: 
					$dest_y = intval(($this->_height - $watermark_height )/2);  
					break;
			}
			
			$this->_thumb = imagecreatetruecolor($this->_width, $this->_height);
			
			$source = $this->imageCreate($this->_path);
			
			imagecopyresampled($this->_thumb, $source, 0, 0, 0, 0, $this->_width, $this->_height, $this->_width, $this->_height);
			
			imagecopy($this->_thumb, $watermark, $dest_x, $dest_y, 0, 0, $watermark_width, $watermark_height);
		} else {
			throw new Exception('Nie udało się załadować do pamięci obrazka: <code>'.$watermark_path.'</code>.');
		}
		
		return $this->save($this->_path);
	}
}

function round_corners ($image, $radius, $color, $transparency)
{
	$width = imagesx($image);
	$height = imagesy($image);

	$image2 = imagecreatetruecolor($width, $height);
	imagecopy($image2, $image, 0, 0, 0, 0, $width, $height);

	imagesavealpha($image2, true);
	imagealphablending($image2, false);

	$full_color = allocate_color($image2, $color, $transparency);

	// loop 4 times, for each corner...
	for ($left=0;$left<=1;$left++) {
		for ($top=0;$top<=1;$top++) {

			$start_x = $left * ($width-$radius);
			$start_y = $top * ($height-$radius);
			$end_x = $start_x+$radius;
			$end_y = $start_y+$radius;

			$radius_origin_x = $left * ($start_x-1) + (!$left) * $end_x;
			$radius_origin_y = $top * ($start_y-1) + (!$top) * $end_y;

			for ($x=$start_x;$x<$end_x;$x++) {
				for ($y=$start_y;$y<$end_y;$y++) {
					$dist = sqrt(pow($x-$radius_origin_x,2)+pow($y-$radius_origin_y,2));

					if ($dist>($radius+1)) {
						imagesetpixel($image2, $x, $y, $full_color);
					} else {
						if ($dist>$radius) {
							$pct = 1-($dist-$radius);
							$color2 = antialias_pixel($image2, $x, $y, $full_color, $pct);
							imagesetpixel($image2, $x, $y, $color2);
						}
					}
				}
			}

		}
	}

	return $image2;
}

function allocate_color ($image, $color, $transparency)
{
	if (preg_match('/[0-9ABCDEF]{6}/i', $color)==0) {
		throw new Exception("Invalid color code.");
	}
	if ($transparency<0 || $transparency>127) {
		throw new Exception("Invalid transparency.");
	}

	$r  = hexdec(substr($color, 0, 2));
	$g  = hexdec(substr($color, 2, 2));
	$b  = hexdec(substr($color, 4, 2));

	if ($transparency>127) $transparency = 127;

	if ($transparency<=0)
	return imagecolorallocate($image, $r, $g, $b);
	else
	return imagecolorallocatealpha($image, $r, $g, $b, $transparency);
}

function antialias_pixel ($image, $x, $y, $color, $weight)
{
	$c = imagecolorsforindex($image, $color);
	$r1 = $c['red'];
	$g1 = $c['green'];
	$b1 = $c['blue'];
	$t1 = $c['alpha'];

	$color2 = imagecolorat($image, $x, $y);
	$c = imagecolorsforindex($image, $color2);
	$r2 = $c['red'];
	$g2 = $c['green'];
	$b2 = $c['blue'];
	$t2 = $c['alpha'];

	$cweight = $weight+($t1/127)*(1-$weight)-($t2/127)*(1-$weight);

	$r = round($r2*$cweight + $r1*(1-$cweight));
	$g = round($g2*$cweight + $g1*(1-$cweight));
	$b = round($b2*$cweight + $b1*(1-$cweight));

	$t = round($t2*$weight + $t1*(1-$weight));

	return imagecolorallocatealpha($image, $r, $g, $b, $t);
}