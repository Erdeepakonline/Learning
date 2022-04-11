# Learning
My Learning Project

Pagination in :
-------------

<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pagination extends CI_Controller {

	public function __construct(){
		parent::__construct();
		check_login();
		$this->load->library('pagination');
		// $this->load->model('pagination_model');
	}

	public function welcome()
	{
		$config = [
			'base_url'=>base_url('admin/pagination'),
			'per_page'=>2,
			'total_rows'=>$this->db->get("enquiry")->num_rows(),
		];
		$this->pagination->initialize($config);

		$data['record']=$this->db->limit($limit,$offset)->get("enquiry",$config['per_page'],$this->uri->segment(3))->result_array();
		$this->load->view('admin/header');
		$this->load->view('admin/prct/paging',$data);
	}


}

?>




pagination viw:
---------------

<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pagination extends CI_Controller {

	public function __construct(){
		parent::__construct();
		check_login();
		$this->load->library('pagination');
		// $this->load->model('pagination_model');
	}

	public function welcome()
	{
		$config = [
			'base_url'=>base_url('admin/pagination'),
			'per_page'=>2,
			'total_rows'=>$this->db->get("enquiry")->num_rows(),
		];
		$this->pagination->initialize($config);

		$data['record']=$this->db->limit($limit,$offset)->get("enquiry",$config['per_page'],$this->uri->segment(3))->result_array();
		$this->load->view('admin/header');
		$this->load->view('admin/prct/paging',$data);
	}


}

?>
