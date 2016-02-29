<?php

define('UPLOAD_MODE_OVERWRITE', 1);
define('UPLOAD_MODE_RENAME', 2);
define('UPLOAD_MODE_ERROR', 3);
define('UPLOAD_MODE_REJECT', 3);

class UploadFile {
	
	private $_files;
	private $_files_var_name;
	private $_file_max_size;
	private $_image_max_width = 9999;
	private $_image_max_height = 9999;
	private $_overwrite_mode;
	private $_random_name;
	private $_reject_extensions;
	private $_acceptable_mime_types;

	private $_destination_dir;
	private $_file;
	private $_uploaded_files;
	private $_copy_name_suffix;
	private $_original_file_names;

	function __construct($files_var_name) {
		$this->_files_var_name = $files_var_name;
		$this->_files = $_FILES;

		$this->ValidateUpload();

		$this->SetRejectExtensions('php,js,htm,html,dhtml,phtml,css,php5,php4,php3,asp');
		$this->SetMaxFileSize(1000*1000); # bytes

		$this->SetCopyNameSuffix('_copy');
	}

	function GetLastUploadedFileName() {
		$last_file_id = sizeof($this->_uploaded_files) - 1;
		return $this->_uploaded_files[$last_file_id]['name'];
	}

	function GetOriginalFileName($name) {
		return $this->_original_file_names[$name];
	}

	function SetCopyNameSuffix($suffix) {
		if (!empty($suffix)) {
			$this->_copy_name_suffix = $suffix;
		}
	}

	function SetMaxFileSize($max_size) {
		if ($max_size > 0) {
			$this->_file_max_size = $max_size;
		}
	}

	function GetMaxFileSize() {
		return $this->_file_max_size;
	}

	function SetMaxImageSize($max_width, $max_height) {
		if ($max_height > 0) {
			$this->_image_max_height = $max_height;
		}
		if($max_width > 0) {
			$this->_image_max_width = $max_width;
		}
	}

	function GetImageMaxWidth() {
		return $this->_image_max_width;
	}

	function GetImageMaxHeight() {
		return $this->_image_max_height;
	}

	function SetOverwriteMode($mode, $random = false) {
		switch ($mode) {
			case 1:
			case UPLOAD_MODE_OVERWRITE:
				$this->_overwrite_mode = 'overwrite';
				break;

			case 2:
			case UPLOAD_MODE_RENAME:
				$this->_overwrite_mode = 'rename';
				break;

			case 3:
			case UPLOAD_MODE_REJECT:
			case UPLOAD_MODE_ERROR:
				$this->_overwrite_mode = 'error';
				break;
		}

		$this->_random_name = (bool) $random;
	}

	function GetOverwriteMode() {
		return $this->_overwrite_mode;
	}

	function IsNameRandom() {
		return $this->_random_name;
	}

	function SetRejectExtensions($reject_extensions) {
		if (! is_array($reject_extensions)) {
			$reject_extensions = explode(",", str_replace(' ', '', $reject_extensions));
		}
		$this->_reject_extensions = array_unique($reject_extensions);
	}

	function IsExtensionRejected($extension) {
		return (bool) in_array($extension, $this->_reject_extensions);
	}

	function SetAcceptableTypes($mime = '') {
		if (! is_array($mime)) {
			$mime = explode(",", str_replace(' ', '', $mime));
		}
		$this->_acceptable_mime_types = array_unique($mime);
	}

	function IsTypeAcceptable($mime) {
	
		if (! is_array($this->_acceptable_mime_types) || sizeof($this->_acceptable_mime_types) == 0) {
			return true;
		}
		
		$accept = false;
		foreach ($this->_acceptable_mime_types as $acceptable_mime) {
			if (preg_match("|".preg_quote($acceptable_mime)."|i", $mime)) {
				$accept = true;
			}
		}
		return (bool) $accept;
	}

	function GetAcceptableTypesString() {
		$types = '';
		if (is_array($this->_acceptable_mime_types)) {
			foreach ($this->_acceptable_mime_types as $v => $k) {
				$types .= ', ' . $k;
			}
		}
		if (empty($types)) {
			$types = 'wszystkie';
		} else {
			$types = substr($types, 2);
		}
		return $types;
	}

	function GetRejectedExtensionsString() {
		$extensions = '';
		if (is_array($this->_reject_extensions)) {
			foreach ($this->_reject_extensions as $v => $k) {
				$extensions .= ', ' . $k;
			}
		}
		if (empty($extensions)) {
			$extensions = 'żadne';
		} else {
			$extensions = substr($extensions, 2);
		}
		return $types;
	}

	function ValidateUpload() {
		$fvar_name = $this->_files_var_name;

		if (! stristr($_SERVER['CONTENT_TYPE'], 'multipart/form-data')) {
			throw new Exception('Fomularz został źle skonstruowany, należy ustawić parametr <i>enctype="multipart/form-data"</i> w tagu <i>form</i>.');
		}
		if (strtoupper($_SERVER['REQUEST_METHOD']) != 'POST') {
			throw new Exception('Przesyłane dane nie pochodzą z formularza. Należy ustawić w tagu <i>form</i> metodę na <i>POST</i>.');
		}
		if (!isset($_FILES) ||
			!isset($this->_files[$fvar_name]) ||
			!is_array($this->_files[$fvar_name]) ||
			empty($this->_files[$fvar_name]['name']) ||
			empty($this->_files[$fvar_name]['tmp_name']) ||
			empty($_FILES[$fvar_name]['size'])) {
			throw new Exception('Nie znaleziono żadnego pliku do wgrania na serwer.');
		}
	}

	function ValidateFile(&$File) {
		if ($File->GetSize() > $this->GetMaxFileSize()) {
			throw new Exception('Plik jest zbyt duży. Dopuszczalny maksymalny rozmiar to: ' . $this->GetMaxFileSize().'b');
		}
		if (! $this->IsTypeAcceptable($File->GetMime())) {
			throw new Exception('Plik ma nieodpowiedni typ. Akceptowane typy to: ' . $this->GetAcceptableTypesString());
		}
		if ($this->IsExtensionRejected($File->GetExtension())) {
			throw new Exception('Plik posiada nieodpowiednie rozszerzenie. Niedozwolone rozszerzenia to: ' . $this->GetRejectedExtensionsString());
		}
		if ($File->IsImage()) {
			if ($File->GetWidth() > $this->GetImageMaxWidth()) {
				throw new Exception('Zdjęcie jest zbyt szerokie. Maksymalna dopuszczalna szerokość to: ' . $this->GetImageMaxWidth() . ' px');
			}
			if ($File->GetHeight() > $this->GetImageMaxHeight()) {
				throw new Exception('Zdjęcie jest zbyt wysokie. Maksymalna dopuszczalna wysokość to: ' . $this->GetImageMaxHeight() . ' px');
			}
		}
	}

	function CountFilesToUpload() {
		if (isset($this->_files[$this->_files_var_name]['name'])
		&& is_array($this->_files[$this->_files_var_name]['name'])) {
			return sizeof($this->_files[$this->_files_var_name]['name']);
		} else {
			return 1;
		}
	}

	function MoveUploadedFile() {
		if (! move_uploaded_file($this->_file['tmp_name'], $this->_destination_dir . '/' . $this->_file['name'])) {
			throw new Exception('Nie udało się przenieść pliku do miesca docelowego.');
		}
	}

	function Upload($destination) {
		
		
		$this->_destination_dir = $destination;

		if (is_array($this->_files[$this->_files_var_name]['name'])) {
			$files_2_upload = $this->CountFilesToUpload();
			for ($i = 0; $i < $files_2_upload; $i++) {
				$this->_file = array();
				$this->_file['name'] = $this->_files[$this->_files_var_name]['name'][$i];
				$this->_file['type'] = $this->_files[$this->_files_var_name]['type'][$i];
				$this->_file['tmp_name'] = $this->_files[$this->_files_var_name]['tmp_name'][$i];
				$this->_file['error'] = $this->_files[$this->_files_var_name]['error'][$i];
				$this->_file['size'] = $this->_files[$this->_files_var_name]['size'][$i];

				if ($this->DoUpload($this->_file)){
					$this->_uploaded_files[] = $this->_file;
				}
			}
			if (! count($this->_files)) {
				throw new Exception('Nie udało się zapisać plików.');
			}
		} else {
			
			
			$this->_file = array();
			$this->_file['name'] = $this->_files[$this->_files_var_name]['name'];
			$this->_file['type'] = $this->_files[$this->_files_var_name]['type'];
			$this->_file['tmp_name'] = $this->_files[$this->_files_var_name]['tmp_name'];
			$this->_file['error'] = $this->_files[$this->_files_var_name]['error'];
			$this->_file['size'] = $this->_files[$this->_files_var_name]['size'];

			if ($this->DoUpload($this->_file)) {
				$this->_uploaded_files[] = $this->_file;
			} else {
				throw new Exception('Nie udało się zapisać pliku.');
			}
		}
	}

	private function DoUpload(&$file_array) {
	
		$File = new File($file_array['tmp_name'], $file_array);
		
		$file_array['width']  = $File->GetWidth();
		$file_array['height'] = $File->GetHeight();
		$file_array['extension'] = strtolower(substr($file_array['name'], strrpos($file_array['name'], '.')));
		$file_array['basename'] = File::ClearFilename(substr($file_array['name'], strrpos($file_array['name'], '\\'), strrpos($file_array['name'], '.')));
		$file_array['name'] = $file_array['basename'] . $file_array['extension'];

		$this->ValidateFile($File);
		$this->MoveFile();

		return true;
	}

	private function MoveFile() {
		$first_name = $this->_file['name'];

		switch($this->GetOverwriteMode()) {
			case 'overwrite':
				if ($this->_random_name) {
					$this->_file['name'] = f_generate_chars(24,'CHARS','LOWER') . $this->_file['extension'];
				}
				$this->MoveUploadedFile();
				break;
			case 'rename':
				$copy = '';
				$n = 1;
				do {
					if ($this->_random_name === true) {
						$this->_file['name'] = f_generate_chars(24,'CHARS','LOWER') . $this->_file['extension'];
					} else {
						$this->_file['name'] = $this->_file['basename'] . $copy . $this->_file['extension'];
						$copy = $this->_copy_name_suffix . ($n++);
					}
				} while (file_exists($this->_destination_dir . "/" . $this->_file['name']));

				$this->MoveUploadedFile();
				break;
			default:
				if ($this->_random_name) {
					$this->_file['name'] = f_generate_chars(24,'CHARS','LOWER') . $this->_file['extension'];
				}
				if (file_exists($this->_destination_dir . "/" . $this->_file['name'])) {
					throw new Exception('Plik o takiej nazwie już istnieje. ('.$this->_file['name'].')');
				}
				$this->MoveUploadedFile();
		}
		$this->_original_file_names[$this->_file['name']] = $first_name;
		return true;
	}
}