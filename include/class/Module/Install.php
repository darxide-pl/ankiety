<?php 

class Module_Install extends Modules_Handler {
	
	public function __construct() {
		parent::__construct();
	}

	public function index() {

		// check is there superadmin
		$sql = "SELECT * FROM `user` WHERE `super_admin` = 1;";
		$superadmin = $this->db->first($sql);

		if ($superadmin) {

			$this->msg('Aplikacja już została zainstalowana.');

			$this->redirect('index',array('page'=>'login'));
		}

		$t = $this->rv->getVars('post');

		if ($t['login'] && $t['password']) {

			// create groups
			$this->db->insert('user_group',array(
				'code' => 'programers',
				'name' => 'Developer',
				'color' => '#aaa',
				'hidden' => 1
			));

			$programers_group_id = $this->db->insert_id;

			$this->db->insert('user_group',array(
				'code' => 'admin',
				'name' => 'Admin',
				'color' => 'red'
			));

			$admin_group_id = $this->db->insert_id;

			$this->db->insert('user_group',array(
				'code' => '__anonymous',
				'name' => 'Gość',
				'color' => 'blue',
				'hidden' => 1
			));

			// create superuser
			$password = f_generate_hash(sha1($t['password']));

			$this->db->insert('user',array(
				'name' => 'Super',
				'lastname' => 'Admin',
				'password' => $password,
				'email' => trim($t['login']),
				'active' => 1,
				'language' => 'pl',
				'add_date' => date("Y-m-d H:i:s"),
				'group_id' => $programers_group_id,
				'super_admin' => 1
			));

			// create admin
			$password = f_generate_hash(sha1('admin@admin.pl'));

			$this->db->insert('user',array(
				'name' => 'Admin',
				'lastname' => '1',
				'password' => $password,
				'email' => 'admin@admin.pl',
				'active' => 1,
				'language' => 'pl',
				'add_date' => date("Y-m-d H:i:s"),
				'group_id' => $admin_group_id,
				'super_admin' => 0
			));
		}
	}
}