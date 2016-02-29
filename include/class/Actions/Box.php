<?php

class Box_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Box();
			$o->set('add_date',date('Y-m-d H:i:s'));
			$o->set('add_user_id',$this->auth->user['id']);
			
			// save page
			
			$o	->set('title',$t['title'])
				->set('text',$t['text'])
				->set('url',$t['url'])
				->set('type',$t['type'])
				->save();
			
			$this->msg('Box został zapisany.');
			
			$this->request->execute($this->link->Build(array('box','edit','oid'=>$o->get('id'))), true);
		}
	}
	
	public function _update() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Box($t['id']);
			
			// save page
			
			$o	->set('title',$t['title'])
				->set('url',$t['url'])
				->set('text',$t['text'])
				->set('type',$t['type'])
				->set('publish',$t['publish'])
				->save();
			
			$this->msg('Box został zapisany.');
			
			$sql = "DELETE FROM `page_box` WHERE `box_id` = ".(int)$o->get('id').";";
			$this->db->query($sql);
			
			if ($t['p']) {
				foreach ($t['p'] as $page_id) {
					$this->db->insert('page_box',array('page_id'=>$page_id,'box_id'=>$o->get('id')));
				}
			}
		}
		
		$this->request->execute($this->link->Build(array('box','edit','oid'=>$t['id'])),true);
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('get');
		
		if ($t['id'] < 1) {
			$this->error('Nie podano identyfikatora.');	
		}
		
		if ($this->pass()) {
			try {
				
				$O = new Model_Box($t['id']);
				$O->delete();

				$this->msg('Box <b>'.$O->get('title').'</b> została usunięta.');
				
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
			$this->Error('Nie podano identyfikatora.');
		}
		
		if ($this->Pass()) {
			
			try {
				
				$O = new Model_Box($t['id']);
				$O->set('publish', !$O->get('publish'));
				
				$O->save();
				
				$this->msg('Box został '.($O->get('publish') ? 'opublikowany' : 'ukryty').'.');
				
				# used in ajax request
				$this->output['publish'] = (int)$O->get('publish');
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
		}
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
		
		$id = (int)$t['id'];
		
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
			
			$dir = DIR_UPLOAD . 'box/';
			
			if (!file_exists( $dir )) {
				@mkdir($dir,0777,true);
			}

			$filename = (int)$id;
			$extension = strtolower(substr($fileName,strrpos($fileName,'.')+1));
			
			$i = 0;
			while (file_exists( $dir . $filename . '-' . $i . '.' . $extension)) {
				$i++;
			}
			$filename .= '-'.$i.'.'.$extension;
			
			copy( $filePath, $dir . $filename );
			@unlink( $filePath );
			
			$img = new ImageHandler( $dir . $filename );
			$img->height(300)
				->width(300)
				->scale(false, false)
				->save();
			
			$object = new Model_Box($id);
			
			// remove old image
			if (file_exists($dir.$object->get('image_filename'))) {
				@unlink($dir.$object->get('image_filename'));
			}
			
			// save image
			$object->set('image_filename',$filename)->save();
			
			die(DIR_UPLOAD_ABSOLUTE.'/box/'.$filename);
		}
		
		// Return JSON-RPC response
		die('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
	}
}