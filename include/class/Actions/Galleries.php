<?php

class Galleries_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if ($this->pass()) {
			
			$o = Model_Gallery::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('customer_id',$t['customer_id'])
				->set('alias',Routes::humanizeURL($t['name']))
				->set('name',$t['name'])
				->set('description',$t['description'])
				->save();
			
			$this->msg('Zapisano galerię do bazy.');
			
			$this->request->execute($this->link->Build(array('galleries','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _ajax_save_positions() {
		
		$this->mode = 'json';

		if ($this->rv->get('o')) {
			$o = $this->rv->get('o');
			
			foreach ($o as $pos => $id) {
				$this->db->update('gallery',array('pos'=>$pos),'`id` = '.$id.'');
			}
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora operacja zapisu przerwana.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Gallery($t['id']);
			
			$o	->set('add_date',date('Y-m-d H:i:s'))
				->set('alias',Routes::humanizeURL($t['name']))
				->set('name',$t['name'])
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->set('description',$t['description'])
				->save();

			$this->msg('Zapisano zmiany w gallerii.');

			$this->_save_images($o->get('id'),'color');

			$this->request->refresh();
		}
	}
	
	private function _save_images($gallery_id,$type) {
		
		$colors = $this->rv->get($type);
		
		if ($colors) {
			$k = 0;
			foreach ($colors as $id => $color) {
				$this->db->Update('gallery_image',array(
					'title' => $color['title'],
					'pos' => $k++
				),'`id` = '.(int)$id.' AND `type` = \''.$type.'\'');
			}
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora urządzenia operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Gallery($t['id']);
			$o->remove();
			
			$this->msg('Urządzenie zostało usunięte.');
		}
	}
	
	public function _toggle_active() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Proszę wybrać galerię.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Gallery($t['id']);
			
			$o	->set('active',$o->get('active') == 1 ? 0 : 1)
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->save();
			
			$this->output['update_date'] = $o->get('update_date');
			
			$this->msg('Zmieniono status');
		}
	}
	
	public function _upload_image() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->getVars('request');
		
		if ($this->auth->checkRight('admin|programers')) {
			// from post
		} else {
			$t['user_id'] = $this->auth->user['id'];
		}
		
		$dir = APPLICATION_PATH.'/upload/gallery/'.$t['id'].'/';
		
		if (!file_exists($dir)) {
			@mkdir($dir,0777,true);
		}
		
		$gallery = new Model_Gallery($t['id']);
		
		$upload = new Helper_Plupload();
		$upload_result = $upload->Upload($dir);
		
		if ($upload_result !== false) {
			
			if (file_exists($upload_result)) {
				
				$filename = basename($upload_result);
				$extension = strtolower(substr($filename,strrpos($filename,'.')+1));
				
				// rewrite filename
				$count = 0;
				do {
					$image_filename = $gallery->get('alias') . ( $count > 0 ? '-'.$count : '' ) . '.' . $extension;
					$count ++;
				} while (file_exists($dir . $image_filename));
				
				// rename file
				rename($upload_result, $dir . $image_filename);

				// get next position
				$sql = "SELECT MAX(`pos`) FROM `gallery_image` WHERE `gallery_id` = ".(int)$t['id']." AND `type` = '".$this->db->quote($t['type'])."';";
				$pos = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
				$pos++;
				
				$image_title = '';
				
				if ($t['type'] == 'color') {
					$image_title = $this->rv->get('original_name');
					$image_title = str_replace('.jpg','',$image_title);
					$image_title = str_replace('.png','',$image_title);
					$image_title = str_replace('.gif','',$image_title);
					$image_title = str_replace('.JPG','',$image_title);
					$image_title = str_replace('.PNG','',$image_title);
					$image_title = str_replace('.GIF','',$image_title);
				}

				$file = new Model_Gallery_Image();
				$file
					->set('add_date',date('Y-m-d H:i:s'))
					->set('add_user_id',$this->auth->user['id'])
					->set('gallery_id',$t['id'])
					->set('filename',$image_filename)
					->set('type',$t['type'])
					->set('title',$image_title)
					->set('pos',$pos)
					->save();


						
				mkdir($dir.'/d1000',0777,true);
						
				$img = new ImageHandler($dir.$image_filename);

				$img->width(1000) // set dimensions
					->height(1000)
					->scaleToBox(false)
					->save($dir.'/d1000/'.$image_filename);

				$img = new ImageHandler($dir.$image_filename);

				$img->width(200) // set dimensions
					->height(140)
					->scaleToBox(true)
					->save();
				
				// return url
				die('{"id":"'.$file->get('id').'","path":"'.DIR_UPLOAD_ABSOLUTE.'/gallery/'.$t['id'].'/'.$image_filename.'","filename":"'.$image_filename.'","title":"'.$image_title.'"}');
			}
		}

		die();
	}
	
	public function _remove_image() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Proszę wybrać zdjęcie.');
		}
		
		if ($this->pass()) {
			
			$image = new Model_Gallery_Image($t['id']);
			
			switch ($t['type']) {
				default:
					unlink(APPLICATION_PATH.'/upload/gallery/'.$image->get('gallery_id').'/'.$image->get('filename'));
					unlink(APPLICATION_PATH.'/upload/gallery/'.$image->get('gallery_id').'/d1000/'.$image->get('filename'));
					
			}
			
			$image->remove();
			
			$this->msg('Zdjęcie zostało usunięte.');
		}
	}
	
	public function _upload_category_image() {
		
		$this->_redirect_after_success = false;
		
		$t = $this->rv->getVars('request');
		
		if ($this->auth->checkRight('admin|programers')) {
			// from post
		} else {
			$t['user_id'] = $this->auth->user['id'];
		}
		
		$dir = APPLICATION_PATH.'/upload/categories/';
		
		if (!file_exists($dir)) {
			@mkdir($dir,0777,true);
		}
		
		$o = new Model_Category((int)$t['id']);
		
		$upload = new Helper_Plupload();
		$upload_result = $upload->Upload($dir);
		
		if ($upload_result !== false) {
			
			if (file_exists($upload_result)) {
				
				$filename = basename($upload_result);
				$extension = substr($filename,strrpos($filename,'.')+1);
				
				// rewrite filename
				$count = 0;
				do {
					$image_filename = $o->get('alias') . ( $count > 0 ? '-'.$count : '' ) . '.' . $extension;
					$count ++;
				} while (file_exists($dir . $image_filename));
				
				// remove old image
				if (file_exists($dir.$o->get('image_filename'))) {
					@unlink($dir.$o->get('image_filename'));
				}
				
				// rename file
				rename($upload_result, $dir . $image_filename);
				
				$o	->set('image_filename',$image_filename)
					->save();
						
				$img = new Image_Handler($dir.$image_filename);

				$img->width(280) // set dimensions
					->height(280)
					->scaleToBox(true)
					->save();
				
				// return url
				die(DIR_UPLOAD_ABSOLUTE.'/categories/'.$image_filename);
			}
		}

		die();
	}
}