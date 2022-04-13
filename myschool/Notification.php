<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Notification extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		$this->load->helper("app");
	}

	public function index()
	{
		$data['notify'] = $this->db->where("user_id", $_SESSION[USER]['id'])->get("notification")->result_array();
// 		print_r($data);
		$this->load->view("theme/artist/head");
		$this->load->view("theme/artist/header");
		$this->load->view("theme/artist/notification", $data);
		$this->load->view("theme/artist/footer");
	}

}
