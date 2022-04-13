<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Package extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		$this->load->helper("app");
	}


	public function index()
	{
	    
        $this->db->where("DATE(ex_date) >= DATE('".date("Y-m-d")."')");
		$data = $this->db->where(array("school_id"=> $_SESSION[SCHOOL]['id'], "status"=>1))->get("school_pacakge")->row_array();
		$data['school'] = $this->db->where("id", $_SESSION[SCHOOL]['id'])->get("school")->row_array();

		$data['pack'] = $this->db->where(array("id"=> $data['pack_id']))->get("sch_pack")->row_array();
		$data['rem_days'] =  $this->getRemDays(date('Y-m-d'), $data['ex_date']);

        $data['pre_packs'] = $res;
		$this->load->view("theme/artist/head");
		$this->load->view("theme/school/header");
		$this->load->view("theme/school/package-view", $data);
		$this->load->view("theme/artist/footer");
	}


	public function getRemDays($date1, $date2) {

		$earlier = new DateTime($date1);
		$later = new DateTime($date2);

		$diff = $later->diff($earlier)->format("%a");
		return $diff;
	}
	
	
	public function upgrade() {

		$pack = $this->db->where("type",1)->where("price > 0")->get("package")->result_array();

		foreach ($pack as $key => $val) {
			$this->db->select(" pc.title, pcl.val");
			$this->db->from("package_cols pc, pcols pcl");
			$this->db->where("pcl.package_id", $val['id']);
			$this->db->where("pcl.col_id=pc.id");
			$val['cols'] = $this->db->get()->result_array();
			$res[] = $val;
		}

		$data['packs'] = $res;

		$this->load->view("theme/artist/head");
		$this->load->view("theme/artist/header");
		$this->load->view("theme/artist/upgrade", $data);
		$this->load->view("theme/artist/footer");
	}

}
