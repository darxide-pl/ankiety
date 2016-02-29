<?php

class Paginator {

	protected $_params;

	protected $_amount;

	protected $_pages;
	
	protected $_offset;

	protected $_actual_on_page;

	protected $_result;

	protected $_rows;

	/**
	 * 
	 * @global type $db
	 * @param type $sql
	 * @param type $params (page_nr, on_page, link)
	 * @return type
	 */
	public function populate($sql, $params = array()) {

		$db = Db::Instance();
		
		$this->_params = array(
			'page_nr' => $params['page_nr'] ? $params['page_nr'] : 1,
			'on_page' => $params['on_page'] ? $params['on_page'] : 30,
			'link' => $params['link'] ? $params['link'] : '',
		);

		$this->_result = $db->query($sql);

		$this->_amount = (int) $this->_result->num_rows; // count amount

		if ($this->_amount) {

			$this->_pages = ceil($this->_amount / $this->_params['on_page']);

			if ($this->_params['page_nr'] < 1) {
				$this->_params['page_nr'] = 1;
			}
			if ($this->_params['page_nr'] > $this->_pages) {
				$this->_params['page_nr'] = $this->_pages;
			}

			$this->_offset = ( $this->_params['page_nr'] - 1 ) * $this->_params['on_page'];

			if ( $this->_amount > $this->_offset + $this->_params['on_page'] ) { # not last
				$this->_actual_on_page = $this->_params['on_page'];
			} else if ( $this->_offset > 0 ) { # last
				$this->_actual_on_page = $this->_amount % $this->_offset;
			} else { # first
				$this->_actual_on_page = $this->_amount;
			}

			if ($this->_offset > 0) {
				$this->_result->data_seek($this->_offset);
			}

			$i = 1;
       		while ($row = $this->_result->fetch_assoc()) {
        		$this->_rows []= $row;
        		$i++;
        		if ($this->_params['on_page'] > 0 && $i > $this->_params['on_page']) {
        			break;
        		}
        	}

			return $this->_rows;
		}
	}
	
	public function getActualOnPage() {
		return (int)$this->_actual_on_page;
	}
	
	public function getOnPage() {
		return (int)$this->_params['on_page'];
	}
	
	public function getAmount() {
		return (int)$this->_amount;
	}
	
	public function getPagesNum() {
		return (int)$this->_pages;
	}
	
	public function getPageNumber() {
		return (int)$this->_params['page_nr'];
	}
	
	public function getOffset() {
		return (int)$this->_offset;
	}
	
	public function getPopulation() {
		return $this->_rows;
	}
	
	public function getLink() {
		return $this->_params['link'];
	}
	
	public function showPaginator($tpl = 'default') {

		if (!$tpl) { 
			$tpl = 'default';
		}
		
		$tpl_path = APPLICATION_PATH.'/include/tpl/_paginator/'.$tpl.'.tpl';
		
		if (!file_exists($tpl_path)) {
			throw new Exception('Szablon nawigacji listy "'.$tpl.'" nie istnieje.');
		}
		
		include($tpl_path);
	}
}