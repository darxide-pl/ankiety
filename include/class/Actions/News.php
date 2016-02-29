<?php

class News_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		$language = $t['l'] != '' ? $t['l'] : 'pl';
		$group_id = (int)$t['g'];
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}

		$alias_tmp = trim(Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['title']));
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `news` WHERE `alias` = '".$this->db->quote($alias_tmp)."' AND `group_id` = ".(int)$group_id.";";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp;
		
		if ($this->pass()) {
			
			$o = new Model_News();
			$o->set('add_date',date('Y-m-d H:i:s'));
			$o->set('user_id',$this->auth->user['id']);
			
			// save page
			
			$o	->set('title',$t['title'])
				->set('alias',$t['alias'])
				->set('text',$t['text'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('url',$t['url'])
				->set('language',$language)
				->set('group_id',$group_id)
				->save();
			
			$this->msg('Aktualność została zapisana.');
			
			$this->request->execute($this->link->Build(array('news','edit','oid'=>$o->get('id'))), true);
		}
	}
	
	public function _update() {
		
		$t = $this->rv->getVars('post');
		
		$language = $t['l'] != '' ? $t['l'] : 'pl';
		$group_id = (int)$t['g'];
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}

		$alias_tmp = Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['title']);
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `news` WHERE `alias` = '".$this->db->quote($alias_tmp)."' AND `id` != ".(int)$t['id']." AND `group_id` = ".(int)$group_id.";";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp;
		
		if ($this->pass()) {
			
			$o = new Model_News($t['id']);
			
			// save page copy
			
			if ($t['title'] != $o->get('title') ||
				$t['alias'] != $o->get('alias') ||
				$t['text'] != $o->get('text') ||
				$t['lead'] != $o->get('lead') ||
				$t['meta_title'] != $o->get('meta_title') ||
				$t['meta_keywords'] != $o->get('meta_keywords') ||
				$t['meta_description'] != $o->get('meta_description')
			) {
				
				Model_News_Copy::NewInstance()
					->set('add_date',date('Y-m-d H:i:s'))
					->set('title',$o->get('title'))
					->set('alias',$o->get('alias'))
					->set('text',$o->get('text'))
					->set('lead',$o->get('lead'))
					->set('meta_title',$t['meta_title'])
					->set('meta_keywords',$o->get('meta_kewords'))
					->set('meta_description',$o->get('meta_description'))
					->set('news_id',$o->get('id'))
					->set('user_id',$this->auth->user['id'])
					->set('group_id',$group_id)
					->save();
			}
			
			// save page
			
			$o	->set('title',$t['title'])
				->set('alias',$t['alias'])
				->set('text',$t['text'])
				->set('lead',$t['lead'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('add_date',$t['add_date'])
				->save();
			
			$this->msg('Strona została zapisana.');
		}
		
		if ($t['gi']) {
			$ipos = 1;
			foreach ($t['gi'] as $id => $image) {
				$this->db->Update('gallery_image',array(
					'title' => $image['title'],
					'pos' => $ipos ++
				),'`id` = '.(int)$id);
			}
		}
		
		$this->request->execute($this->link->Build(array('news','edit','oid'=>$t['id'])),true);
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('get');
		
		if ($t['id'] < 1) {
			$this->error('Nie podano identyfikatora aktualności.');	
		}
		
		if ($this->pass()) {
			try {
				
				$O = new Model_News($t['id']);
				$O->delete();

				$this->msg('Aktualność <b>'.$O->get('title').'</b> została usunięta.');
				
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
			$this->Error('Nie podano identyfikatora aktualności.');
		}
		
		if ($this->Pass()) {
			
			try {
				
				$O = new Model_News($t['id']);
				$O->set('publish', !$O->get('publish'));
				
				# always set this data
				$O->set('modify_date',date('Y-m-d H:i:s'));
				
				# change modifier only if not superadmin
				if (!$this->auth->isSuperadmin()) {
					$O->set('modify_user_id',$this->auth->user['id']);
				}
				
				$O->save();
				
				$this->msg('Aktualność została '.($O->get('publish') ? 'opublikowana' : 'ukryta').'.');
				
				# used in ajax request
				$this->output['publish'] = (int)$O->get('publish');
				
			} catch (Exception $e) {
				$this->error($e->getMessage());
			}
		}
	}
	
	public function _revive_copy() {
		
		$copy_id = (int)$this->rv->get('rid');
		$id = (int)$this->rv->get('oid');
		
		if (!$copy_id) {
			$this->error('Proszę podać identyfikator kopii.');
		}
		
		if (!$id) {
			$this->error('Proszę podać identyfikator.');
		}
		
		if ($this->pass()) {
			
			# load copy to revive and actual page
			
			$copy = new Model_News_Copy($copy_id);
			$o = new Model_News($id);
			
			if (!$copy->get('id')) {
				$this->error('Kopia o podanym identyfikatorze nie istnieje.');
			}
			
			if (!$o->get('id')) {
				$this->error('Aktualność o podanym identyfikatorze nie istnieje.');
			}
		}
		
		if ($this->pass()) {
			
			Model_News_Copy::NewInstance()
					->set('title',$o->get('title'))
					->set('text',$o->get('text'))
					->set('alias',$o->get('alias'))
					->set('meta_keywords',$o->get('meta_keywords'))
					->set('meta_description',$o->get('meta_description'))
					->set('meta_title',$o->get('meta_title'))
					->set('add_date',date('Y-m-d H:i:s'))
					->set('user_id',$this->auth->user['id'])
					->set('news_id',$o->get('id'))
					->set('group_id',$o->get('group_id'))
					->save();
			
			$o->set('text',$copy->get('text'))
				->save();
			
			$this->msg('Aktualność została przywrócona.');
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
		
		$news_id = (int)$t['id'];
		
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
			
			$destination_dir = DIR_UPLOAD . 'news/';
			
			if (!file_exists( $destination_dir )) {
				@mkdir($destination_dir,0777,true);
			}
			
			if (!file_exists( $destination_dir.'max/' )) {
				@mkdir($destination_dir.'max/',0777,true);
			}
			
			if (!file_exists( $destination_dir.'min/' )) {
				@mkdir($destination_dir.'min/',0777,true);
			}

			$filename = (int)$news_id;
			$extension = strtolower(substr($fileName,strrpos($fileName,'.')+1));
			
			$i = 0;
			while (file_exists( $destination_dir . '/'.$filename.'-'.$i.'.'.$extension)) {
				$i++;
			}
			$filename .= '-'.$i.'.'.$extension;
			
			copy( $filePath, $destination_dir . $filename );
			copy( $filePath, $destination_dir . 'max/' . $filename );
			
			$img = new ImageHandler( $destination_dir . $filename );
			$img->height(160)
				->width(160)
				->scaleToBox(false,false)
				->save( $destination_dir . 'min/' . $filename );
			
			$img = new ImageHandler( $destination_dir . $filename );
			$img->height(1400)
				->width(700)
				->scaleToBox(false,false)
				->save();
			
			$news = new Model_News($news_id);
			
			// remove old image
			if (file_exists($destination_dir.$news->get('image_filename'))) {
				@unlink($destination_dir.$news->get('image_filename'));
				@unlink($destination_dir.'max/'.$news->get('image_filename'));
				@unlink($destination_dir.'min/'.$news->get('image_filename'));
			}
			
			// save image
			$news->set('image_filename',$filename)->save();
			
			die(DIR_UPLOAD_ABSOLUTE.'/news/min/'.$filename);
		}
		
		// Return JSON-RPC response
		die('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
	}
}