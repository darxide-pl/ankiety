<?php

class FilesActions {
	
	const REJECT_EXTENSIONS = 'php,html,html,js,css,php4,php5,php3,class';
	
	public static function UploadImage($input_name, $dir, $max_size = null, $random_name = true) {
		
		return self::UploadFile($input_name, $dir, $max_size, array('gif','jpeg','png','flash'), null, $random_name);
	}
	
	/**
	 * Upload file
	 * 
	 * @param type $input
	 * @param type $dir
	 * @param type $options (max_file_size = 10x1MB, accept_types = all, reject_extendions = php, random_names = true)
	 * @return File 
	 */
	public static function SaveUploadFile($input, $dir, $options = array()) {
		
		$default_options = array(
			'max_file_size' => 10*1024*1024,
			'accept_types' => array(),
			'reject_extensions' => self::REJECT_EXTENSIONS,
			'random_names' => true
		);
		
		$options = f_array_merge_with_keys($default_options,$options);
		
		if (!file_exists($dir)) {
			if (!@mkdir($dir,0777,true)) {
				throw new Exception('Katalog nie istnieje lub nie masz praw do zapisu w nim.');
			}
		}

		$Upload = new UploadFile($input);

		$Upload->SetMaxFileSize((int)$options['max_file_size']);
		$Upload->SetAcceptableTypes($options['accept_types']);
		$Upload->SetRejectExtensions($options['reject_extensions']);
		$Upload->SetOverwriteMode(2, $options['random_names']);
		$Upload->SetCopyNameSuffix('_kopia');

		$Upload->Upload($dir);
		
		$file = array(
			
			//'name' => $Upload->GetLastUploadedFileName(),
			//'original_name' => $Upload->GetOriginalFileName($file_name),
			'path' => $dir . $Upload->GetLastUploadedFileName()
		);
		
		return new File($file['path']);
	}
	
	public static function UploadFile($input_name, $dir, $max_size = null, $accept_type = null, $reject_extensions = null, $random_name = true) {
		
		if (!file_exists($dir)) {
			if (!@mkdir($dir,0777)) {
				throw new Exception('Katalog nie istnieje lub nie masz praw do zapisu w nim.');
			}
		}

		$Upload = new UploadFile($input_name);

		if (!$max_size) {
			$max_size = 256000;
		}
		
		if (!$reject_extensions) {
			$reject_extensions = self::REJECT_EXTENSIONS;
		}
		
		if (!is_array($accept_type)) {
			$accept_type = array('text','application','video','audio','image');
		}

		$Upload->SetMaxFileSize((int)$max_size);
		$Upload->SetAcceptableTypes($accept_type);
		$Upload->SetRejectExtensions($reject_extensions);
		$Upload->SetOverwriteMode(2, $random_name);
		$Upload->SetCopyNameSuffix('_kopia');

		$Upload->Upload($dir);

		$file_name = $Upload->GetLastUploadedFileName();

		$original_file_name = $Upload->GetOriginalFileName($file_name);

		if ($file_id = self::AddFile($dir, $file_name, $original_file_name)) {
			return array(
				'file_id' => $file_id,
				'path' => $dir . $file_name,
				'filename' => $file_name,
				'original_filename' => $original_file_name
			);
		} else {
			throw new Exception('Nie udało się zapisać pliku w bazie danych.');
		}

	}
	
	public static function AddFile($dir, $name, $real_name = null) {
		$a = array(
			'add_date' => date('Y-m-d H:i:s'),
			'name' => $name,
			'size' => @filesize($dir . $name));
		
		if ($real_name) {
			$a ['original_name'] = $real_name;
		}

		if (Db::Instance()->Insert('file',$a)) {
			return Db::Instance()->insert_id;
		}
		
		return false;
	}
	
	public static function ResizeImage($path, $path_to, $scale, $width, $height, $fill_with = null) {
		$Image = new ImageHandler($path);
		if (!$Image->scale($path_to, $scale, (int)$width, (int)$height, $fill_with)) {
			throw new Exception('Nie udało się zmienić rozmiaru zdjęcia.'); 
		}
		return true;
	}
	
	public static function deleteFile($file_id, $dir) {
		$DBFile = new Db_File_Handler($file_id, $dir);
		$path = $DBFile->getPath();
		if (file_exists($path)) {
			@unlink($path);
		}
		$sql = "DELETE FROM `file` WHERE `id` = ".(int)$file_id.";";
		if (Db::Instance()->query($sql)) {
			return true;
		} else {
			return false;
		}
	}

	public static function GetUniqueName($dir) {
		$i = 1000;
		do {
			$name = f_generate_chars(32,'CHARS|NUMBERS');
			$i --;
		} while (file_exists($dir.$name) && $i > 0);
		return $name;
	}
}