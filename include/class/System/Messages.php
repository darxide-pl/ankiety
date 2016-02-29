<?php

class System_Messages extends Core
{
	private $_language;
	private $_action_code;
	private $_message;
	
	function __construct($action_code = null, $language = null, $title = '', $content = '') {
		
		# init Core
		parent::__construct();
		
		if ($action_code) {
			// set action
			$this->setCode($action_code, $language);
		} else {
			// add own template
			$this->setTitle($title);
			$this->setContent($content);
		}
	}
	
	function setCode($action_code, $language = null) {
		
		$this->_action_code = f_filter_inputs($action_code);
		
		if (!$language) {
			$language = Session::Instance()->get('language');
		}
		
		$this->_language = $language;
		
		$sql = "SELECT d.`title`, d.`content` FROM `system_message` m
			LEFT JOIN `system_action` a ON a.`id` = m.`action_id`
			LEFT JOIN `system_message_description` d ON d.`message_id` = m.`id` AND d.`lang` = '".$this->db->quote($language)."'
			WHERE a.`constant` = '".$this->db->quote($this->_action_code)."';";
			
		$result = $this->db->query($sql);
		if ( ! $result ) {
			throw new Exception('Nie ma takiego szablonu wiadomości e-mail.');
		} else {
			$this->_message = $result->fetch_assoc();
		}
	}
	
	function getTitle() {
		return $this->_message ['title'];
	}
	
	function getContent() {
		return $this->_message ['content'];
	}
	
	public function setTitle($title) {
		$this->_message['title'] = $title;
	}
	
	function getParsedTitle($parse_attributes) {
		
		$title = $this->getTitle();
		
		if (is_array($parse_attributes) && sizeof($parse_attributes)) {
			foreach ($parse_attributes as $var => $value) {
				$title = str_replace('{'.$var.'}', $value, $title);
			}
		}

		return $title;
	}
	
	public function setContent($content) {
		$this->_message['content'] = $content;
	}
	
	function getParsedContent($variables, $tpl = 'store') {

		$twig_loader = new Twig_Loader_String();
		$twig = new Twig_Environment($twig_loader,array(
			'cache' => false
		));
		
		$content = $this->getContent();
		
		if (is_array($variables) && sizeof($variables)) {
			foreach ($variables as $k => $v) {
				$content = str_replace('{'.$k.'}', $v, $content);
			}
		}
		
		if (strpos($content,'<p>') === false) {
			$content = htmlspecialchars_decode(nl2br($content));
		} else {
			
			$content = htmlspecialchars_decode($content);
			$content = $twig->render($content,$variables);
		}

		// Insert message content into email template
		return System_Messages_Templates::Parse($tpl, $content);
	}
}