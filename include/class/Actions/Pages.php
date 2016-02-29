<?php

class Pages_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		$language = $t['l'] != '' ? $t['l'] : 'pl';
		$group_id = (int)$t['g'];
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}
		
		// check alias is unique and if not add appendix
		
		$alias_tmp = Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['title']);
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `page` WHERE `alias` = '".$this->db->quote($alias_tmp)."' AND `group_id` = ".(int)$group_id.";";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp; 

		if ($this->pass()) {
			
			$o = new Model_Page();
			$o->set('add_date',date('Y-m-d H:i:s'));				
			$o->set('parent_id',$t['parent_id']);
			$o->set('user_id',$this->auth->user['id']);
			$o->set('type',$t['type']);
			
			# get new position
			$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `page` WHERE `parent_id` = '".$t['parent_id']."' AND `language` = '".$language."' AND `group_id` = ".(int)$group_id.";",
														DB_FETCH_ARRAY_FIELD);
			$o->set('pos', $position+1 );
			
			// save page
			
			if ($this->auth->isSuperadmin()) {
				$o->set('homepage',$t['homepage']);
			}
			
			$o	->set('title',$t['title'])
				->set('alias',$t['alias'])
				->set('lead',$t['lead'])
				->set('text',$t['text'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('target',$t['target'])
				->set('page_type',$t['page_type'])
				->set('url',$t['url'])
				->set('language',$language)
				->set('group_id',$group_id)
				->set('access',$t['access'])
				->save();
			
			$this->msg('Strona została zapisana.');
			
			// update existing attributes
			$this->_save_attributes($o->get('id'));
			
			// create new attributes
			$this->_add_attributes($o->get('id'));
			
			$this->request->execute($this->link->Build(array('pages','index')), true);
		}
	}
	
	public function _update() {
		
		$t = $this->rv->getVars('post');
		
		$language = $t['l'] != '' ? $t['l'] : 'pl';
		$group_id = (int)$t['g'];
		
		if (!$t['title']) {
			$this->error('Brak tytułu.');
		}
		
		// check alias is unique and if not add appendix
		
		$alias_tmp = Routes::humanizeURL($t['alias'] ? $t['alias'] : $t['title']);
		$i = 2;
		do {
			$sql = "SELECT COUNT(*) FROM `page` WHERE `alias` = '".$this->db->quote($alias_tmp)."' AND `id` != ".(int)$t['id']." AND `group_id` = ".(int)$group_id.";";
			$alias_count = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			$alias_tmp = $alias_count > 0 ? $alias_tmp.'-'.$i : $alias_tmp ;
			$i ++;
		} while($alias_count > 0);
		
		$t['alias'] = $alias_tmp;

		if ($this->pass()) {
			
			$o = new Model_Page($t['id']);
			
			// change parent, move to new position and calculate new brunch position in tree
			if ($t['parent_id'] != $o->get('parent_id')) {
				
				$o->set('parent_id',$t['parent_id']);
				
				# move elements below in this brunch up one level
				$ga = new Generic_Actions();
				$ga->MoveUpEveryBelowOnOrderedList($o, get_class($o), "`parent_id` = '".$o->get('parent_id')."' AND `language` = '".$language."' AND `group_id` = ".(int)$group_id."");
				
				# get new position
				$position = (int) $this->db->FetchRecord("SELECT MAX(`pos`) FROM `page` WHERE `parent_id` = '".$t['parent_id']."' AND `language` = '".$language."' AND `group_id` = ".(int)$group_id.";",
															DB_FETCH_ARRAY_FIELD);
				
				$o->set('pos', $position+1 );

			}
			
			// save page
			
			if ($this->auth->isSuperadmin()) {
				$o->set('homepage',$t['homepage']);
				$o->set('system_key',$t['system_key']);
			}
			
			$o	->set('title',$t['title'])
				->set('alias',$t['alias'])
				->set('lead',$t['lead'])
				->set('text',$t['text'])
				->set('publish',$t['publish'])
				->set('meta_title',$t['meta_title'])
				->set('meta_keywords',$t['meta_keywords'])
				->set('meta_description',$t['meta_description'])
				->set('modify_date',date('Y-m-d H:i:s'))
				->set('target',$t['target'])
				->set('page_type',$t['page_type'])
				->set('url',$t['url'])
				->set('access',$t['access'])
				->save();
			
			$this->msg('Strona została zapisana.');
			
			// update existing attributes
			$this->_save_attributes($o->get('id'));
			
			// create new attributes
			$this->_add_attributes($o->get('id'));
			
			$this->request->execute($this->link->Build(array('pages','index')));
		}
	}
	
	public function _ajax_save_positions() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		$order = $t['o'];
		
		Helper_Pages::Update_Order($order);
	}
	
	public function _delete() {
		
		$t = $this->rv->getVars('get');
		
		if ($t['id'] < 1) {
			$this->error('Nie podano identyfikatora strony.');	
		}
		
		if ($this->pass()) {

			// find children
			$sql = "SELECT COUNT(*) FROM `page` WHERE `parent_id` = ".(int)$t['id'].";";
			$children = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
			
			if ($children > 0) {
				// prevent removing if children found
				$this->error('Najpierw usuń podstrony.');
			}
		}
		
		if ($this->pass()) {
			try {
				
				$O = new Model_Page($t['id']);
				$O->delete();

				$this->msg('Strona <b>'.$O->get('title').'</b> została usunięta.');
				
				// move pages below up by one position
				$sql = "UPDATE `page` SET `pos` = `pos` - 1 WHERE `pos` > ".(int)$O->get('pos')." AND `parent_id` = ".(int)$O->get('parent_id')." AND `language` = '".$this->db->quote($O->get('language'))."';";
				$this->db->query($sql);
				
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
			$this->Error('Nie podano identyfikatora strony.');
		}
		
		if ($this->Pass()) {
			
			try {
				
				$O = new Model_Page($t['id']);
				$O->set('publish', !$O->get('publish'));
				
				# always set this data
				$O->set('modify_date',date('Y-m-d H:i:s'));
				
				# change modifier only if not superadmin
				if (!$this->auth->isSuperadmin()) {
					$O->set('modify_user_id',$this->auth->user['id']);
				}
				
				$O->save();
				
				$this->msg('Strona została '.($O->get('publish') ? 'opublikowana' : 'ukryta').'.');
				
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
			$this->error('Proszę podać identyfikator kopii strony.');
		}
		
		if (!$id) {
			$this->error('Proszę podać identyfikator strony.');
		}
		
		if ($this->pass()) {
			
			# load copy to revive and actual page
			
			$copy = new Model_Page_Copy($copy_id);
			$o = new Model_Page($id);
			
			if (!$copy->get('id')) {
				$this->error('Kopia o podanym identyfikatorze nie istnieje.');
			}
			
			if (!$o->get('id')) {
				$this->error('Strona o podanym identyfikatorze nie istnieje.');
			}
		}
		
		if ($this->pass()) {
			
			Model_Page_Copy::NewInstance()
					->set('title',$o->get('title'))
					->set('text',$o->get('text'))
					->set('alias',$o->get('alias'))
					->set('meta_keywords',$o->get('meta_keywords'))
					->set('meta_description',$o->get('meta_description'))
					->set('meta_title',$o->get('meta_title'))
					->set('add_date',date('Y-m-d H:i:s'))
					->set('user_id',$this->auth->user['id'])
					->set('page_id',$o->get('id'))
					->set('group_id',$o->get('group_id'))
					->save();
			
			$o->set('text',$copy->get('text'))
				->save();
			
			$this->msg('Strona została przywrócona.');
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
			
			$destination_dir = DIR_UPLOAD . 'pages/';
			
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
			@unlink( $filePath );
			
			$img = new ImageHandler( $destination_dir . $filename );
			$img->height(160)
				->width(160)
				->scale(true)
				->save( $destination_dir . 'min/' . $filename );
			
			$img = new ImageHandler( $destination_dir . $filename );
			$img->height(460)
				->width(460)
				->scale(true,false)
				->save();
			
			$news = new Model_Page($news_id);
			
			// remove old image
			if (file_exists($destination_dir.$news->get('image_filename'))) {
				@unlink($destination_dir.$news->get('image_filename'));
				@unlink($destination_dir.'max/'.$news->get('image_filename'));
				@unlink($destination_dir.'min/'.$news->get('image_filename'));
			}
			
			// save image
			$news->set('image_filename',$filename)->save();
			
			die(DIR_UPLOAD_ABSOLUTE.'/pages/min/'.$filename);
		}
		
		// Return JSON-RPC response
		die('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
	}
	
	private function _add_attributes($page_id = 0) {

		$t = $this->rv->getVars('post');
		
		if ($t['save_positions']) {
			$new_positions = array();
			foreach ($t['pos'] as $pos => $id) {
				if ($id == 'new') {
					$new_positions []= $pos;
				}
			}
		}
		
		if ($t['atname']) {
			
			foreach ($t['atname'] as $k => $name) {
				
				Model_Page_Faq::NewInstance()
					->set('question',$name)
					->set('answer',$t['atvalue'][$k])
					->set('add_date',date('Y-m-d H:i:s'))
					->set('page_id',$page_id) 
					->set('pos',(int)$new_positions[$k])
					->save();
			}
		}
	}
	
	private function _save_attributes($page_id) {
		
		$t = $this->rv->getVars('post');

		if ($t['save_positions']) {
			$positions = array();
			foreach ($t['pos'] as $pos => $id) {
				if ($id != 'new') {
					$positions [$id]= $pos;
				}
			}
		}
		
		if ($t['at']) {
			
			$at_list = array();
			
			foreach ($t['at'] as $aid => $at) {
				$at_list[] = $aid;
			}
			
			// remove selected attributes
			if ($at_list) {
				$sql = "DELETE FROM `page_faq` WHERE `page_id` = ".(int)$page_id." AND `id` NOT IN (".implode(',',$at_list).");";
				$this->db->query($sql);
			}
			
			foreach ($t['at'] as $aid => $at) {
				
				if ($at['question'] == '') {
					
					// remove attribute
					$this->db->query('DELETE FROM `page_faq` WHERE `id` = '.(int) $aid.';');
					
				} else {
					
					// update attribute
					$a = new Model_Page_Faq($aid);
					
					$a	->set('question',$at['question'])
						->set('answer',$at['answer'])
						->set('pos',(int)$positions[$aid])
						->save();
				}
			}
		}
	}
}