<?php

/*
 * Some complex actions to multiple use
 */

class Generic_Actions extends Action_Script {
	
	private $store;
	
	public function __construct($action = '', $store = false) {
		if (!$action) {
			parent::__construct('');
		} else {
			parent::__construct($action);
		}
		
		$this->_store = $store;
	}
	
	public function SaveToMultipleCategories(Generic_Object $O, $new_categories, $foreign_key_name, $foreign_class_name, $only_add_new = false) {
		
		if (!class_exists($foreign_class_name)) {
			throw new Exception('Klasa <b>'.$foreign_class_name.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$O2C = new $foreign_class_name;
		
		$foreign_table_name = Generic_Object::GetTableNameByObject($foreign_class_name);
		
		if ($new_categories) {

			try {
			
				if ($this->_store !== false) {
					$categories = $O2C->find(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `store` = '.(int)$this->_store));
				} else {
					$categories = $O2C->find(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID()));
				}
				
				if (!$categories) {
					$categories = array();
				} else {
					$categories = Generic_Object::ExtractObjectToList($categories, null, 'category_id');
				}
				
				if ($only_add_new == false) {

					$todelete = array_diff($categories,$new_categories);
					if (sizeof($todelete) > 0 && is_array($todelete)) {
						$todelete = implode(',',$todelete);
						$this->db->query('DELETE FROM `'.$foreign_table_name.'` WHERE `'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `category_id` IN ('.$todelete.');');
					}
				}
				
				foreach ($new_categories as $category_id) {
					if (!in_array($category_id,$categories)) {
						
						if ($this->_store !== false) {
							$this->db->query('INSERT INTO `'.$foreign_table_name.'` (`'.$foreign_key_name.'`, `category_id`, `store`) VALUES('.(int)$O->GetID().', '.$category_id.', '.(int)$this->_store.');');
						} else {
							$this->db->query('INSERT INTO `'.$foreign_table_name.'` (`'.$foreign_key_name.'`, `category_id`) VALUES('.(int)$O->GetID().', '.$category_id.');');
						}
					}
				}
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
			
		} else {
			try {
				$O2C->DeleteFound(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID()));
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
		}
	}
	
	public function SaveToMultipleCategoriesOrdered(Generic_Object $O, $new_categories, $foreign_key_name, $foreign_class_name, $only_add_new = false) {
		
		if (!class_exists($foreign_class_name)) {
			throw new Exception('Klasa <b>'.$foreign_class_name.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$O2C = new $foreign_class_name;
		
		$foreign_table_name = Generic_Object::GetTableNameByObject($foreign_class_name);
		
		if ($new_categories) {

			try {
			
				if ($this->_store !== false) {
					$categories = $O2C->find()->where('`'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `store` = '.(int)$this->_store)->fetch();
				} else {
					$categories = $O2C->find()->where('`'.$foreign_key_name.'` = '.(int)$O->GetID())->fetch();
				}
				
				if (!$categories) {
					$categories = array();
				} else {
					$categories = Generic_Object::ExtractObjectToList($categories, null, 'category_id');
				}
				
				
				if ($only_add_new == false) {
					$todelete = array_diff($categories,$new_categories);
					
					if (sizeof($todelete) > 0 && is_array($todelete)) {
						foreach ($todelete as $category_id) {
							
							# find realation
							$C = new $foreign_class_name;
							$C = $C->find()
								->where('`'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `category_id` = \''.(int)$category_id.'\'')
								->first();
							
							# move up every relations that are blow by one position
							$this->MoveUpEveryBelowOnOrderedList($C, $foreign_class_name, '`category_id` = \''.(int)$category_id.'\'');
							
							# delete relation
							$this->db->query('DELETE FROM `'.$foreign_table_name.'` WHERE `'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `category_id` = \''.(int)$category_id.'\';');
						}
					}
				}
				
				$new = array_diff($new_categories, $categories);
				
				foreach ($new as $category_id) {
					
					if ($this->_store !== false) {
						
						# get new position (max)
						$sql = "SELECT MAX(`pos`)+1 FROM `".$foreign_table_name."` WHERE `category_id` = ".(int)$category_id." AND `store` = ".(int)$this->_store.";";
						$position = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
					
						$this->db->query('INSERT INTO `'.$foreign_table_name.'` (`'.$foreign_key_name.'`, `category_id`, `pos`, `store`) VALUES(\''.(int)$O->GetID().'\', \''.(int)$category_id.'\', \''.(int)$position.'\',\''.(int)$this->_store.'\');');
						
					} else {
						# get new position (max)
						$sql = "SELECT MAX(`pos`)+1 FROM `".$foreign_table_name."` WHERE `category_id` = ".(int)$category_id.";";
						$position = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
					
						$this->db->query('INSERT INTO `'.$foreign_table_name.'` (`'.$foreign_key_name.'`, `category_id`, `pos`) VALUES(\''.(int)$O->GetID().'\', \''.(int)$category_id.'\', \''.(int)$position.'\');');
					}
				}
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
			
		} else {
			try {
				$O2C->DeleteFound(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID()));
			} catch (Exception $e) {
				$this->Error($e->getMessage());
			}
		}
	}
	
	public function MoveDownOnOrderedList(Generic_Object $O, $class_name_to_order, $order_conditions = null) {

		if (!class_exists($class_name_to_order)) {
			throw new Exception('Klasa <b>'.$class_name_to_order.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		if ($this->Pass()) {
			
			$object_name = Generic_Object::GetObjectNameByClass($class_name_to_order);
			
			if (!$order_conditions) {
				$order_conditions = ' AND '.$object_name.'.`parent_id` = '.(int)$O->GetParentId().' ';
			} else {
				$order_conditions = ' AND '.$order_conditions;
			}
			
			if ($this->_store !== false) {
				$order_conditions .= ' AND `store` = '.(int)$this->_store.' ';
			}
			
			$below = $O->find(array(
				'where' => '' . $object_name . '.`pos` > ' . (int)$O->GetPos() . $order_conditions,
				'order' => '' . $object_name . '.`pos` ASC',
				'limit' => 1
				)
			);
			
			if ($below) {
				$OBelow = $below[0];
			}

			if (!$OBelow) {
				$this->Error('Nie udało się pobrać pozycji znajdującej się niżej.');
			} else {
				$from_pos = $O->Get('pos');
				try {
					
					$O->SetField('pos', $OBelow->Get('pos'));
					
					$OBelow->SetField('pos', -1);
					
					if ($this->_store !== false) {
						$OBelow->Save(false);
						$O->Save(false);
					} else {
						$OBelow->Save();
						$O->Save();
					}
					
					$OBelow->SetField('pos', $from_pos);
					
					if ($this->_store !== false) {
						$OBelow->Save(false);
					} else {
						$OBelow->Save();
					}

					$this->Msg('Pozycja została przeniesiona niżej.');
				} catch(Exception $e) {
					$this->Error($e->getMessage());
				}
			}
		}
	}
	
	public function MoveUpOnOrderedList(Generic_Object $O, $class_name_to_order, $order_conditions = null) {
		
		if (!class_exists($class_name_to_order)) {
			throw new Exception('Klasa <b>'.$class_name_to_order.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		if ($this->Pass()) {
			
			$object_name = Generic_Object::GetObjectNameByClass($class_name_to_order);
			
			if (!$order_conditions) {
				$order_conditions = ' AND '.$object_name.'.`parent_id` = '.(int)$O->GetParentId().' ';
			} else {
				$order_conditions = ' AND '.$order_conditions;
			}
			
			if ($this->_store !== false) {
				$order_conditions .= ' AND `store` = '.(int)$this->_store.' ';
			}
			
			$above = $O->find(array(
				'where' => '' . $object_name . '.`pos` < ' . (int)$O->GetPos() . $order_conditions,
				'order' => '' . $object_name . '.`pos` DESC',
				'limit' => 1
				)
			);
			
			if ($above) {
				$OAbove = $above[0];
			}

			if (!$OAbove) {
				$this->Error('Nie udało się pobrać pozycji znajdującej się wyżej.');
			} else {
				$from_pos = $O->Get('pos');
				try {
					
					$O->SetField('pos', $OAbove->Get('pos'));
					
					$OAbove->SetField('pos', -1);
					if ($this->_store !== false) {
						$OAbove->Save(false);
						$O->Save();
					} else {
						$OAbove->Save();
						$O->Save();
					}

					$OAbove->SetField('pos', $from_pos);
					
					if ($this->_store !== false) {
						$OAbove->Save(false);
					} else {
						$OAbove->Save();
					}
					
					$this->Msg('Pozycja została przeniesiona wyżej.');
				} catch(Exception $e) {
					$this->Error($e->getMessage());
				}
			}
		}
	}
	
	public function MoveUpEveryBelowOnOrderedList(Generic_Object $O, $class_name_to_order, $order_conditions) {
		
		if (!class_exists($class_name_to_order)) {
			throw new Exception('Klasa <b>'.$class_name_to_order.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
	
		$object_name = Generic_Object::GetObjectNameByClass($class_name_to_order);
		
		if (!$order_conditions) {
			$order_conditions = ' AND '.$object_name.'.`parent_id` = '.(int)$O->GetParentId().' ';
		} else {
			$order_conditions = ' AND '.$order_conditions;
		}
		
		if ($this->_store !== false) {
			$order_conditions .= ' AND `store` = '.(int)$this->_store.' ';  
		}
		
		$table = Generic_Object::GetTableNameByObject($object_name);
		$sql = "UPDATE `".$table."` ".$object_name . " SET ".$object_name . ".`pos` = ".$object_name . ".`pos` - 1
			WHERE ".$object_name . ".`pos` > " . (int)$O->GetPos() . $order_conditions.";";
		Db::Instance()->query($sql);		

	}
	
	/**
	 * $O - object to insert
	 * $O2 - object to insert after
	 * $conditions - when updating i need conditions
	 */
	public function InsertAfterPositionOnOrderedList(Generic_Object $O, Generic_Object $O2, $conditions) {
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		if (!$O2->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$table_name = Generic_Object::GetTableNameByObject( get_class($O) );
		
		if ($conditions) {
			$conditions = ' AND '.$conditions;
		}
		
		if ($this->_store !== false) {
			$conditions .= ' AND `store` = '.(int)$this->_store.' ';
		}
		
		# move records between down
		$sql = "UPDATE `".$table_name."` SET `pos` = `pos` + 1 WHERE `pos` > ".(int)$O2->GetPos()." AND `pos` <= ".(int)($O->GetPos()-1) . $conditions;
		$this->db->query($sql,'GenericActions->InsertAfterPositionOnOrderedList');
		
		# move object to empty position between moved down records and upper record
		$O->SetField('pos',$O2->GetPos()+1);
		$O->SetField('store',(int)$this->_store);
		
		if ($this->_store !== false) {
			$O->Save(false);
		} else {
			$O->Save();
		}
	}
	
	/**
	 * $O - object to insert
	 * $O2 - object to insert after
	 * $conditions - when updating i need conditions
	 */
	public function InsertOnPositionOnOrderedList(Generic_Object $O, $position, $conditions) {
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$table_name = Generic_Object::GetTableNameByObject( get_class($O) );
		
		if ($this->_store !== false) {
			if ($conditions) {
				$conditions = ' `store` = '.(int)$this->_store.' AND '.$conditions;
			} else {
				$conditions = ' `store` = '.(int)$this->_store;
			}
		}
		
		if ($conditions) {
			
			# find last position query
			$sql = "SELECT MAX(`pos`) FROM `".$table_name."` WHERE ".$conditions.";";
			
			$conditions = ' AND '.$conditions;
		} else {
			# find last position query
			$sql = "SELECT MAX(`pos`) FROM `".$table_name."`;";
		}
		
		# find last position 
		$last_position = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
		
		# check if first position keyword used
		if (strcmp($position,'beginning') == 0) {
			$position = 0;
		}
		
		# check if last position keyword used
		if (strcmp($position,'end') == 0) {
			$position = $last_position;
		# if position bigger than available
		} else if ($position > $last_position) {
			$position = $last_position;
		}
		
		# if position smaller than available
		if ($position < 0) {
			$position = 0;
		}

		# move upper
		if ($O->GetPos() > $position) {
		
			# move records between down
			$sql = "UPDATE `".$table_name."` SET `pos` = `pos` + 1 WHERE `pos` >= ".$position." AND `pos` < ".(int)$O->GetPos() . $conditions;
			$this->db->query($sql,'GenericActions->InsertOnPositionOnOrderedList');
			
			# move object to empty position between moved records
			$O->SetField('pos',$position);
			$O->SetField('store',(int)$this->_store);
			
			if ($this->_store !== false) {
				$O->Save(false);
			} else {
				$O->Save();
			}
			
		# move lower
		} else if ($O->GetPos() < $position) {
			
			# move records between up
			$sql = "UPDATE `".$table_name."` SET `pos` = `pos` - 1 WHERE `pos` <= ".$position." AND `pos` > ".(int)$O->GetPos() . $conditions;
			$this->db->query($sql,'GenericActions->InsertOnPositionOnOrderedList');
			
			# move object to empty position between moved records
			$O->SetField('pos',$position);
			$O->SetField('store',(int)$this->_store);
			
			if ($this->_store !== false) {
				$O->Save(false);
			} else {
				$O->Save();
			}
		}
	}
	
	public function MoveUpOnOrderedListBySteps(Generic_Object $O, $steps, $conditions = '') {
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$table_name = Generic_Object::GetTableNameByObject( get_class($O) );
		
		if ($O->GetPos() - $steps < 0) {
			$steps = $O->GetPos();
		}
		
		self::InsertOnPositionOnOrderedList($O,$O->GetPos() - $steps,$conditions);
	}
	
	public function MoveDownOnOrderedListBySteps(Generic_Object $O, $steps, $conditions = '') {
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		$table_name = Generic_Object::GetTableNameByObject( get_class($O) );
		
		if ($this->_store !== false) {
			if ($conditions) {
				$conditions = ' `store` = '.(int)$this->_store.' AND '.$conditions;
			} else {
				$conditions = ' `store` = '.(int)$this->_store;
			}
		}
		
		if ($conditions) {
			# find last position query
			$sql = "SELECT MAX(`pos`) FROM `".$table_name."` WHERE ".$conditions.";";
		} else {
			# find last position query
			$sql = "SELECT MAX(`pos`) FROM `".$table_name."`;";
		}
		
		# find last position 
		$last_position = $this->db->FetchRecord($sql,DB_FETCH_ARRAY_FIELD);
		
		if ($O->GetPos() + $steps > $last_position) {
			$steps = $last_position - $O->GetPos();
		}
		
		self::InsertOnPositionOnOrderedList($O,$O->GetPos() + $steps,$conditions);
	}
	
	public function MoveToOtherCategoryOnOrderedList(Generic_Object $O, $foreign_key_name, $foreign_class_name,  $from_category_id, $to_category_id, $remove_from_source_category = true) {
		
		if (!class_exists($foreign_class_name)) {
			throw new Exception('Klasa <b>'.$foreign_class_name.'</b> nie istnieje.');
		}
		
		if (!$O->GetID()) {
			throw new Exception('Dane obiektu nie zostały przekazane.');
		}
		
		if ((!$from_category_id && $remove_from_source_category) || !$to_category_id) {
			throw new Exception('Nie podano kategorii do której należy przenieść produkt, lub z której kategorii należy przenieść.');
		}
		
		$O2C = new $foreign_class_name;

		try {
			# get all object actual categories
			if ($this->_store !== false) {
				$categories = $O2C->find(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID().' AND `store` = '.(int)$this->_store));
			} else {
				$categories = $O2C->find(array('where'=>'`'.$foreign_key_name.'` = '.(int)$O->GetID()));
			}
			
			if ($categories) {

				$categories = Generic_Object::ExtractObjectToList($categories, null, 'category_id');
				
				# remove source category (operation: MOVE)
				if ($remove_from_source_category) {
					$k = array_search($from_category_id, $categories);
					unset($categories[$k]);
				}
				# else: dont remove source category (operation: COPY)
				
				# add new category
				$categories[] = $to_category_id;
				
				$this->SaveToMultipleCategoriesOrdered($O,$categories,$foreign_key_name,$foreign_class_name);
			}

		} catch(Exception $e) {
			$this->Error($e->getMessage());
		}
		
	}
}