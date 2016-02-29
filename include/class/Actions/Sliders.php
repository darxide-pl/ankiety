<?php

class Sliders_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if ($this->pass()) {
			
			$o = new Model_Slider();

			# get new position
			$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `slider`;",DB_FETCH_ARRAY_FIELD);
			
			$o->set('pos', $position+1)
				->set('add_date',date('Y-m-d H:i:s'))
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('user_id',$this->auth->user['id'])
				->set('name',$t['name'])
				->set('publish',$t['publish'])
				->set('description',$t['description'])
				->set('url',$t['url'])
				->set('parent_id',$t['parent_id'])
				->save();
			
			$this->msg('Baner został zapisany.');
			
			$this->request->execute($this->link->Build(array('sliders','edit','oid'=>$o->get('id'))), true);
		}
	}
	
	public function _update() {
		
		$t = $this->rv->getVars('post');

		if ($this->pass()) {
			
			$o = new Model_Slider($t['id']);
			
			// change parent, move to new position and calculate new brunch position in tree
			if ($t['parent_id'] != $o->get('parent_id')) {
				
				$o->set('parent_id',$t['parent_id']);
				
				# move elements below in this brunch up one level
				$ga = new Generic_Actions();
				$ga->MoveUpEveryBelowOnOrderedList($o, get_class($o), "`parent_id` = '".$o->get('parent_id')."'");
				
				# get new position
				$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `slider` WHERE `parent_id` = '".$t['parent_id']."';", DB_FETCH_ARRAY_FIELD);
				
				$o->set('pos', $position+1 );
			}
			
			// save page
			
			$o	->set('name',$t['name'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('publish',$t['publish'])
				->set('description',$t['description'])
				->set('url',$t['url'])
				->set('parent_id',$t['parent_id'])
				->save();
			
			$this->msg('Baner został zapisany.');
		}
		
		$this->request->execute($this->link->Build(array('sliders','edit','oid'=>$t['id'])),true);
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('get');
		
		if ($t['id'] < 1) {
			$this->error('Nie podano identyfikatora banera.');	
		}
		
		if ($this->pass()) {
			
			try {
				
				$object = new Model_Slider($t['id']);
				$object->delete();

				$this->msg('Baner <b>'.$object->get('name').'</b> został usunięty.');
				
				// remove old image
				if (file_exists(DIR_UPLOAD . 'slider/'.$object->get('image_filename'))) {
					unlink(DIR_UPLOAD . 'slider/'.$object->get('image_filename'));
					unlink(DIR_UPLOAD . 'slider/'.'thumbs/'.$object->get('image_filename'));
					unlink(DIR_UPLOAD . 'slider/'.'grey/'.$object->get('image_filename'));
				}
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
			
			$this->request->refresh();
		}
	}
	
	function _switch_publish() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('request');
		
		if ($t['id'] < 1) {
			$this->Error('Nie podano identyfikatora banera.');
		}
		
		if ($this->Pass()) {
			
			try {
				
				$O = new Model_Slider($t['id']);
				$O->set('publish', !$O->get('publish'));
				
				# always set this data
				$O->set('modify_date',date('Y-m-d H:i:s'));
				
				# change modifier only if not superadmin
				if (!$this->auth->isSuperadmin()) {
					$O->set('modify_user_id',$this->auth->user['id']);
				}
				
				$O->save();
				
				$this->msg('Baner został '.($O->get('publish') ? 'opublikowany' : 'ukryty').'.');
				
				# used in ajax request
				$this->output['publish'] = (int)$O->get('publish');
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
		}
	}
	
	public function _ajax_save_positions() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		$order = $t['o'];
		
		Helper_Sliders::Update_Order($order);
	}
	
	public function _upload_image() {
		
		/**
		 * Copyright 2009, Moxiecode Systems AB
		 * Released under GPL License.
		 *
		 * License: http://www.plupload.com/license
		 * Contributing: http://www.plupload.com/contributing
		 */
		
		// HTTP headers for no cache etc
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
		header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
		header("Cache-Control: no-store, no-cache, must-revalidate");
		header("Cache-Control: post-check=0, pre-check=0", false);
		header("Pragma: no-cache");
		
		// Grab request data
		$t = $this->rv->getVars('get');
		
		$oid = (int)$t['id'];
		
		// Hijack session :-( the saddest part of this script
		session_id($t['sid']);
		
		// Check is user loged (session authorization)
		if (!$this->auth->isLoged()) {
			die('{"jsonrpc" : "2.0", "error" : {"code": 200, "message": "No authorization for upload action."}, "id" : "id"}');
		}
		
		// Settings
		$targetDir = APPLICATION_PATH.'/upload/tmp/';
		
		if (!file_exists($targetDir)) {
			mkdir($targetDir, 0777, true);
		}
		
		$cleanupTargetDir = true; // Remove old files
		$maxFileAge = 5 * 3600; // Temp file age in seconds
		// 5 minutes execution time
		@set_time_limit(5 * 60);

		// Get parameters
		$chunk = isset($_REQUEST["chunk"]) ? intval($_REQUEST["chunk"]) : 0;
		$chunks = isset($_REQUEST["chunks"]) ? intval($_REQUEST["chunks"]) : 0;
		$fileName = isset($_REQUEST["name"]) ? $_REQUEST["name"] : '';

		// Clean the fileName for security reasons
		$fileName = preg_replace('/[^\w\._]+/', '_', $fileName);

		// Make sure the fileName is unique but only if chunking is disabled
		if ($chunks < 2 && file_exists($targetDir . DIRECTORY_SEPARATOR . $fileName)) {
			$ext = strrpos($fileName, '.');
			$fileName_a = substr($fileName, 0, $ext);
			$fileName_b = substr($fileName, $ext);

			$count = 1;
			while (file_exists($targetDir . DIRECTORY_SEPARATOR . $fileName_a . '_' . $count . $fileName_b))
				$count++;

			$fileName = $fileName_a . '_' . $count . $fileName_b;
		}

		$filePath = $targetDir . DIRECTORY_SEPARATOR . $fileName;

		// Remove old temp files	
		if ($cleanupTargetDir && is_dir($targetDir) && ($dir = opendir($targetDir))) {
			while (($file = readdir($dir)) !== false) {
				$tmpfilePath = $targetDir . DIRECTORY_SEPARATOR . $file;

				// Remove temp file if it is older than the max age and is not the current file
				if (preg_match('/\.part$/', $file) && (filemtime($tmpfilePath) < time() - $maxFileAge) && ($tmpfilePath != "{$filePath}.part")) {
					@unlink($tmpfilePath);
				}
			}

			closedir($dir);
		} else
			die('{"jsonrpc" : "2.0", "error" : {"code": 100, "message": "Failed to open temp directory."}, "id" : "id"}');


		// Look for the content type header
		if (isset($_SERVER["HTTP_CONTENT_TYPE"]))
			$contentType = $_SERVER["HTTP_CONTENT_TYPE"];

		if (isset($_SERVER["CONTENT_TYPE"]))
			$contentType = $_SERVER["CONTENT_TYPE"];

		// Handle non multipart uploads older WebKit versions didn't support multipart in HTML5
		if (strpos($contentType, "multipart") !== false) {
			if (isset($_FILES['file']['tmp_name']) && is_uploaded_file($_FILES['file']['tmp_name'])) {
				// Open temp file
				$out = fopen("{$filePath}.part", $chunk == 0 ? "wb" : "ab");
				if ($out) {
					// Read binary input stream and append it to temp file
					$in = fopen($_FILES['file']['tmp_name'], "rb");

					if ($in) {
						while ($buff = fread($in, 4096))
							fwrite($out, $buff);
					} else
						die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
					fclose($in);
					fclose($out);
					@unlink($_FILES['file']['tmp_name']);
				} else
					die('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
			} else
				die('{"jsonrpc" : "2.0", "error" : {"code": 103, "message": "Failed to move uploaded file."}, "id" : "id"}');
		} else {
			// Open temp file
			$out = fopen("{$filePath}.part", $chunk == 0 ? "wb" : "ab");
			if ($out) {
				// Read binary input stream and append it to temp file
				$in = fopen("php://input", "rb");

				if ($in) {
					while ($buff = fread($in, 4096))
						fwrite($out, $buff);
				} else
					die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');

				fclose($in);
				fclose($out);
			} else
				die('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
		}

		// Check if file has been uploaded
		if (!$chunks || $chunk == $chunks - 1) {
			
			// Strip the temp .part suffix off 
			rename("{$filePath}.part", $filePath);			
			
			$destination_dir = DIR_UPLOAD . 'slider/';
			
			if (!file_exists( $destination_dir )) {
				@mkdir($destination_dir,0777,true);
				@mkdir($destination_dir.'thumbs/',0777,true);
				@mkdir($destination_dir.'grey/',0777,true);
			}

			$filename = (int)$oid;
			$extension = strtolower(substr($fileName,strrpos($fileName,'.')+1));
			
			$i = 0;
			while (file_exists( $destination_dir . '/'.$filename.'-'.$i.'.'.$extension)) {
				$i++;
			}
			$filename .= '-'.$i.'.'.$extension;
			
			copy( $filePath, $destination_dir . $filename);
			@unlink( $filePath );
			
			$img = new ImageHandler($destination_dir . $filename);
			$img->width(Config::get('slider.width_thumb'))
				->height(Config::get('slider.height_thumb'))
				->scaleToBox(true)
				->save($destination_dir.'thumbs/'.$filename);
			
			$img = new ImageHandler($destination_dir . $filename);
			$img->width(Config::get('slider.width'))
				->height(Config::get('slider.height'))
				->scaleToBox(true)
				->save($destination_dir.$filename);
			
			$object = new Model_Slider($oid);
			
			// remove old image
			if ($object->get('image_filename') != '' && file_exists($destination_dir.$object->get('image_filename'))) {
				@unlink($destination_dir.$object->get('image_filename'));
				@unlink($destination_dir.'thumbs/'.$object->get('image_filename'));
			}
			
			// save image
			$object ->set('image_filename',$filename)
					->set('modify_date',date('Y-m-d H:i:s'))
					->save();
			
			die(DIR_UPLOAD_ABSOLUTE.'/slider/'.$filename);
		}
		
		// Return JSON-RPC response
		die('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
	}
}
