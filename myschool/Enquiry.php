<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Enquiry extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		$this->load->helper("app");
	}

	public function index()
	{
		$this->db->where("school_id", $_SESSION[SCHOOL]['id'])->update("school_enquiry", array("msg_read"=>1));
		$data['enquiry'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->order_by("id","desc")->limit(20)->get("school_enquiry")->result_array();
		$data['rows'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->get("school_enquiry")->num_rows();
		
// 		print_r($data);

		$this->load->view("theme/artist/head");
		$this->load->view("theme/school/header");
		$this->load->view("theme/school/enquiry", $data);
		$this->load->view("theme/artist/footer");
		

	}

}
