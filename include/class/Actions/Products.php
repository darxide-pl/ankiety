<?php

class Products_Actions extends Action_Script {
	
	public function _add() {
		
		$t = $this->rv->getVars('post');
		
		if ($this->pass()) {
			
			$o = Model_Product::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('customer_id',$t['customer_id'])
				->set('category_id',$t['category_id'])
				->set('alias',Routes::humanizeURL($t['name']))
				->set('serial',$t['serial'])
				->set('name',$t['name'])
				->set('description',$t['description'])
				->set('teamviewer_id',$t['teamviewer_id'])
				->set('active',$t['active'])
				->set('short',$t['short'])
				->set('price',$t['price'])
				->save();
			
			$this->msg('Zapisano urządzenie do bazy.');
			
			// create new attributes
			$this->_add_attributes($o->get('id'));
			
			// update existing attributes
			$this->_save_attributes($o->get('id'));
			
			$this->request->execute($this->link->Build(array('products','edit','oid'=>$o->get('id'))),true);
		}
	}
	
	public function _ajax_save_positions() {
		
		$this->mode = 'json';
		
		
		
		if ($this->rv->get('o')) {
			$o = $this->rv->get('o');
			
			foreach ($o as $pos => $id) {
				$this->db->update('product',array('pos'=>$pos),'`id` = '.$id.'');
			}
		}
	}
	
	public function _save() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora operacja zapisu przerwana.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Product($t['id']);
			
			$o	->set('add_date',date('Y-m-d H:i:s'))
				->set('customer_id',$t['customer_id'])
				->set('category_id',$t['category_id'])
				->set('serial',$t['serial'])
				->set('alias',Routes::humanizeURL($t['name']))
				->set('name',$t['name'])
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->set('description',$t['description'])
				->set('manual',$t['manual'])
				->set('functions',$t['functions'])
				->set('teamviewer_id',$t['teamviewer_id'])
				->set('active',$t['active'])
				->set('short',$t['short'])
				->set('price',$t['price'])
				->save();

			$this->msg('Zapisano zmiany w urządzeniu.');

			// create new attributes
			$this->_add_attributes($o->get('id'));

			// update existing attributes
			$this->_save_attributes($o->get('id'));
			
			// update existing strollers
			$this->_save_strollers($o->get('id'));
			
			// create new strollers
			$this->_add_strollers($o->get('id'));
			
			$this->_save_images($o->get('id'),'color');
			$this->_save_images($o->get('id'),'desc');
			$this->_save_images($o->get('id'),'top');
			$this->_save_images($o->get('id'),'main');
			
			$this->_save_accessories($o->get('id'));
			
			// update existing strollers
			$this->_save_movies($o->get('id'));
			
			// create new strollers
			$this->_add_movies($o->get('id'));
			
			$this->request->refresh();
		}
	}
	
	public function _save_category() {
		
		$t = $this->rv->getVars('post');
		
		if (!$t['oid']) {
			$this->error('Proszę wybrać kategorię');
		}
		
		if (!$t['name']) {
			$this->error('Proszę podać nazwę kategorii');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Category($t['oid']);
			$o	->set('name',$t['name'])
				->set('alias',Routes::humanizeURL($t['name']))
				->set('description',$t['description'])
				->save();
			
			$this->msg('Kategoria została zapisana.');
			
			$this->request->execute($this->link->Build(array('products','settings')),true);
		}
	}
	
	private function _save_accessories($product_id) {
		
		$list = $this->rv->get('accessories');
		
		if (!$list) {
			$sql = "DELETE FROM `product_relation` WHERE `product_id` = ".(int)$product_id.";";
			$this->db->query($sql);
		} else {
			$sql = "DELETE FROM `product_relation` WHERE `product_id` = ".(int)$product_id." AND `related_id` NOT IN (".implode(',',$list).");";
			$this->db->query($sql);
		}
		
		if ($list) {
			foreach ($list as $item_id) {
				
				$this->db->insert('product_relation',array(
					'product_id'=>$product_id,
					'related_id'=>$item_id
				));
			}
		}
	}
	
	private function _save_images($product_id,$type) {
		
		$colors = $this->rv->get($type);
		
		if ($colors) {
			$k = 0;
			foreach ($colors as $id => $color) {
				$this->db->Update('product_image',array(
					'title' => $color['title'],
					'pos' => $k++
				),'`id` = '.(int)$id.' AND `type` = \''.$type.'\'');
			}
		}
	}
	
	public function _copy() {
		
		$id = (int)$this->rv->get('id');
		
		if ($id < 1) {
			$this->error('Proszę wybrać urządzenie do skopiowania.');
		}
		
		if ($this->pass()) {
			
			$sql = "SELECT * FROM `product` WHERE `id` = ".(int)$id.";";
			$product = $this->db->first($sql);
			
			if (!$product) {
				$this->error('Produkt nie istnieje.');
			}
		}
		
		if ($this->pass()) {
			
			// reset product id (autoincrement = null)
			$product['id'] = null;
			$product['serial'] = '';
			
			$new_id = $this->db->insert('product',$product);
			
			$sql = "SELECT p.* FROM `product_attribute` p "
				. "LEFT JOIN `attribute` a ON a.`id` = p.`attribute_id` "
				. "WHERE p.`product_id` = ".(int)$id." AND a.`allow_copy` = 1;";
			$result = $this->db->query($sql);
			
			if ($result) {
				while ($attribute = $result->fetch_assoc()) {
					
					// set new product id
					$attribute['product_id'] = $new_id;
					
					$this->db->insert('product_attribute',$attribute);
				}
			}
			
			$this->msg('Produkt został skopiowany.');
			
			$this->request->execute($this->link->Build(array('products','edit','oid'=>$new_id)));
		}
		
	}
	
	private function _add_attributes($product_id = 0) {

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
				
				$a = Model_Attribute::NewInstance()
					->set('name',$name)
					->set('add_date',date('Y-m-d H:i:s'))
					->set('category_id',(int)$t['category_id'])
					->set('pos',(int)$new_positions[$k])
					->save();
				
				if ($product_id) {
					$this->db->Insert('product_attribute',array(
						'product_id' => $product_id,
						'attribute_id' => $a->get('id'),
						'value' => $t['atvalue'][$k]
					));
				}
			}
		}
	}
	
	private function _save_attributes($product_id) {
		
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
			
			if ($at_list) {
				$sql = "DELETE FROM `product_attribute` WHERE `product_id` = ".(int)$product_id." AND `attribute_id` NOT IN (".implode(',',$at_list).");";
				$this->db->query($sql);
			}
			
			foreach ($t['at'] as $aid => $at) {
				
				if ($at['name'] == '') {
					// remove attribute
					$this->db->query('DELETE FROM `attribute` WHERE `id` = '.(int) $aid.';');
					$this->db->query('DELETE FROM `product_attribute` WHERE `attribute_id` = '.(int)$aid.';');
					
				} else {
					
					// update attribute
					$a = new Model_Attribute($aid);
					$a	->set('name',$at['name'])
						->set('pos',(int)$positions[$aid])
						->set('allow_copy',$at['allow_copy'])
						->save();

					// update product attribute value
					if ($product_id) {
						$this->db->query("REPLACE INTO `product_attribute` VALUES (".(int)$product_id.",".(int)$aid.",'".$this->db->quote($at['value'])."')");
					}
				}
			}
		}
	}
	
	private function _add_strollers($product_id = 0) {

		$t = $this->rv->getVars('post');
		
		if ($t['stbrand']) {
			foreach ($t['stbrand'] as $k => $brand) {
				
				Model_Product_Stroller::NewInstance()
					->set('brand',$brand)
					->set('name',$t['stname'][$k])
					->set('add_date',date('Y-m-d H:i:s'))
					->set('product_id',(int)$product_id)
					->save();
			}
		}
	}
	
	private function _save_strollers($product_id) {
		
		$t = $this->rv->getVars('post');

		if ($t['st']) {
			
			$at_list = array();
			
			foreach ($t['st'] as $aid => $at) {
				$at_list[] = $aid;
			}
			
			if ($at_list) {
				$sql = "DELETE FROM `product_stroller` WHERE `product_id` = ".(int)$product_id." AND `id` NOT IN (".implode(',',$at_list).");";
				$this->db->query($sql);
			}
			
			foreach ($t['st'] as $aid => $at) {
				
				if ($at['brand'] == '') {
					// remove stroller
					$this->db->query('DELETE FROM `product_stroller` WHERE `id` = '.(int)$aid.';');
					
				} else {
					
					// update stroller
					$a = new Model_Product_Stroller($aid);
					$a	->set('name',$at['name'])
						->set('brand',$at['brand'])
						->save();
				}
			}
		}
	}
	
	private function _add_movies($product_id = 0) {

		$t = $this->rv->getVars('post');
		
		if ($t['movtitle']) {
			
			$pos = (int)$this->db->first("SELECT MAX(`pos`) FROM `product_movie` WHERE `product_id` = ".(int)$product_id.";",DB_FETCH_ARRAY_FIELD);
			
			foreach ($t['movtitle'] as $k => $title) {
				
				Model_Product_Movie::NewInstance()
					->set('title',$title)
					->set('url',$t['movurl'][$k])
					->set('add_date',date('Y-m-d H:i:s'))
					->set('product_id',(int)$product_id)
					->set('pos',$pos++)
					->save();
			}
		}
	}
	
	private function _save_movies($product_id) {
		
		$t = $this->rv->getVars('post');

		if ($t['mov']) {
			
			$at_list = array();
			
			foreach ($t['mov'] as $aid => $at) {
				$at_list[] = $aid;
			}
			
			if ($at_list) {
				$sql = "DELETE FROM `product_movie` WHERE `product_id` = ".(int)$product_id." AND `id` NOT IN (".implode(',',$at_list).");";
				$this->db->query($sql);
			}
			
			$pos = 0;
			
			foreach ($t['mov'] as $aid => $at) {
				
				if ($at['title'] == '') {
					
					// remove movie
					$this->db->query('DELETE FROM `product_movie` WHERE `id` = '.(int)$aid.';');
					
				} else {
					
					// update movie
					$a = new Model_Product_Movie($aid);
					$a	->set('title',$at['title'])
						->set('url',$at['url'])
						->set('pos',$pos++)
						->save();
				}
			}
		}
	}
	
	public function _remove() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora urządzenia operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$o = new Model_Product($t['id']);
			$o->remove();
			
			$this->msg('Urządzenie zostało usunięte.');
		}
	}
	
	public function _add_category() {
		
		$t = $this->rv->getVars('post');
		
		if ($t['name'] == '') {
			$this->error('Brakuje nazwy.');
		}
		
		if ($this->pass()) {
			
			$sql = "SELECT MAX(`pos`) FROM `category` WHERE `parent_id` = ".(int)$t['parent_id'].";";
			$pos = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
			$pos++;
			
			Model_Category::NewInstance()
				->set('add_date',date('Y-m-d H:i:s'))
				->set('name',$t['name'])
				->set('alias',Routes::humanizeURL($t['name']))
				->set('parent_id',(int)$t['parent_id'])
				->set('pos',$pos)
				->save();
			
			$this->msg('Kategoria została utworzona.');
			
			$this->request->execute($this->link->Build(array('products','settings')),true);
		}
	}
	
	public function _remove_category() {
		
		$t = $this->rv->getVars('all');
		
		if (!$t['id']) {
			$this->error('Brakuje identyfikatora grup operacja usunięcia została przerwana.');
		}
		
		if ($this->pass()) {
			$sql = "SELECT COUNT(*) FROM `product` WHERE `category_id` = ".(int)$t['id'].";";
			$products = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
			if ($products > 0) {
				$this->error('Grupa nie jest pusta i nie może zostać usunięta.');
			}
		}
		
		if ($this->pass()) {
			$sql = "SELECT COUNT(*) FROM `category` WHERE `parent_id` = ".(int)$t['id'].";";
			$products = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
			if ($products > 0) {
				$this->error('Grupa nie jest pusta i nie może zostać usunięta.');
			}
		}
		
		if ($this->pass()) {
			$o = new Model_Category($t['id']);
			$o->remove();
			
			$this->msg('Urządzenie zostało usunięte.');
		}
		
	}
	
	public function _update_categories() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		$order = json_decode($t['order'],true);
		
		foreach ($order[0] as $k => $c) {
			
			$o = new Model_Category($c['id']);
			$o	->set('pos',$k)
				->set('parent_id',0)
				->save();
			
			if ($c['children'][0]) {
				
				foreach ($c['children'][0] as $k2 => $c2) {
					
					$o = new Model_Category($c2['id']);
					$o	->set('pos',$k2)
						->set('parent_id',$c['id'])
						->save();
				}
			}
			
		}
		
	
		
		if ($t['c']) {
			$pos = 0;
			foreach ($t['c'] as $id => $c) {
				$o = new Model_Category($id);
				$o	//->set('name',$c['name'])
					//->set('alias',Routes::humanizeURL($c['name']))
					->set('pos',$pos++)
					->save();
			}
			$this->msg('Zmiany zostały zapisane.');
		} else {
			$this->msg('Brak danych do zapisania. Prawdopodobnie nie posiadasz grup.');
		}
	}
	
	public function _toggle_active() {
		
		$this->mode = 'json';
		
		$t = $this->rv->getVars('post');
		
		if (!$t['id']) {
			$this->error('Proszę wybrać urządzenie.');
		}
		
		if ($this->pass()) {
			
			$o = new Model_Product($t['id']);
			
			$o	->set('active',$o->get('active') == 1 ? 0 : 1)
				->set('update_date',date('Y-m-d H:i:s'))
				->set('update_user_id',$this->auth->user['id'])
				->save();
			
			$this->output['update_date'] = $o->get('update_date');
			
			$this->msg('Zmieniono status');
		}
	}
	
	public function _check_serial() {
	
		$this->mode = 'json';
		
		$t = $this->rv->getVars('all');
		
		if (!$t['serial']) {
			$this->error('Proszę podać ID urządzenia.');
		}
		
		if ($this->pass()) {
			
			$sql = "SELECT COUNT(*) FROM `product` WHERE `serial` = '".$this->db->quote($t['serial'])."' AND `id` != ".(int)$t['id'].";";
			$exists = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
			
			if ($exists) {
				$this->error('ID: '.$t['serial'].' jest już zajęte.');
			} else {
				$this->msg('ID jest wolne.');
			}
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
		
		$dir = APPLICATION_PATH.'/upload/products/'.$t['id'].'/';
		
		if (!file_exists($dir)) {
			@mkdir($dir,0777,true);
		}
		
		$product = new Model_Product($t['id']);
		
		$upload = new Helper_Plupload();
		$upload_result = $upload->Upload($dir);
		
		if ($upload_result !== false) {
			
			if (file_exists($upload_result)) {
				
				$filename = basename($upload_result);
				$extension = substr($filename,strrpos($filename,'.')+1);
				
				// rewrite filename
				$count = 0;
				do {
					$image_filename = $product->get('alias') . ( $count > 0 ? '-'.$count : '' ) . '.' . $extension;
					$count ++;
				} while (file_exists($dir . $image_filename));
				
				// rename file
				rename($upload_result, $dir . $image_filename);

				// get next position
				$sql = "SELECT MAX(`pos`) FROM `product_image` WHERE `product_id` = ".(int)$t['id']." AND `type` = '".$this->db->quote($t['type'])."';";
				$pos = $this->db->first($sql,DB_FETCH_ARRAY_FIELD);
				$pos++;
				
				$image_title = '';
				
				if ($t['type'] == 'color') {
					$image_title = str_replace(array($product->get('alias').'-','.jpg','_lightbox'),'',$this->rv->get('original_name'));
					$image_title = str_replace('-',' ',$image_title);
					$image_title = ucwords($image_title);
				}

				$file = new Model_Product_Image();
				$file
					->set('add_date',date('Y-m-d H:i:s'))
					->set('add_user_id',$this->auth->user['id'])
					->set('product_id',$t['id'])
					->set('filename',$image_filename)
					->set('type',$t['type'])
					->set('title',$image_title)
					->set('pos')
					->save();

				switch ($t['type']) {
					
					case 'top':
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(700) // set dimensions
							->height(250)
							->scaleToBox(true)
							->save();
						
						break;
					
					case 'desc':
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(220) // set dimensions
							->height(220)
							->scaleToBox(true)
							->save();
						
						break;
					
					case 'color':
						
						@mkdir($dir.'/d800',0777,true);
						//@mkdir($dir.'/d150',0777,true);
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(800) // set dimensions
							->height(800)
							->scaleToBox(true)
							->save($dir.'/d800/'.$image_filename);
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(150) // set dimensions
							->height(150)
							->scaleToBox(true)
							->save();
						
						break;
					
					default:
						
						@mkdir($dir.'/d340',0777,true);
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(336) // set dimensions
							->height(336)
							->scaleToBox(true)
							->save($dir.'/details/'.$image_filename);
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(1200) // set dimensions
							->height(800)
							->scaleToBox(false)
							->save($dir.'/max/'.$image_filename);
						
						$img = new ImageHandler($dir.$image_filename);
						
						$img->width(191) // set dimensions
							->height(147)
							->scaleToBox(true)
							->save();
				}
				
				// return url
				die('{"id":"'.$file->get('id').'","path":"'.DIR_UPLOAD_ABSOLUTE.'/products/'.$t['id'].'/'.$image_filename.'","filename":"'.$image_filename.'","title":"'.$image_title.'"}');
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
			
			$image = new Model_Product_Image($t['id']);
			
			switch ($t['type']) {
				case 'top':
					unlink(APPLICATION_PATH.'/upload/products/'.$image->get('product_id').'/'.$image->get('filename'));
					break;
				default:
					unlink(APPLICATION_PATH.'/upload/products/'.$image->get('product_id').'/'.$image->get('filename'));
					unlink(APPLICATION_PATH.'/upload/products/'.$image->get('product_id').'/d340/'.$image->get('filename'));
					
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