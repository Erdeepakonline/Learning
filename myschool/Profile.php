<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Profile extends CI_Controller {
	function __construct() {

		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		$this->pstep = $this->db->select("profile_step")->where("id", $_SESSION[USER]['id'])->get("artist")->row()->profile_step;
		unset($_SESSION['pro_step']);
		validate_package();
	}

	public function index()
	{
		$post = $this->input->post('data');
		if(!empty($post)) {
			$post['dob'] = date("Y-m-d", strtotime($post['dob']));
			$this->db->where("id", $_SESSION[USER]['id'])->update("artist", $post);
			$_SESSION[USER] = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
			$alert = 1;
		}
		
		$data = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
		$data['countries'] = $this->db->order_by("country")->get("country")->result_array();
		$data['states'] = $this->db->where("country_id", $data['country'])->order_by("state")->get("state")->result_array();
		$data['cities'] = $this->db->where("state_id", $data['state'])->order_by("city")->get("city")->result_array();
		$data['alert'] = $alert;

		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/profile');
		$this->load->view('theme/artist/footer');

	}

	public function pro_info(){
		$post = $this->input->post('data');

		if(!empty($post)) {

			if($this->pstep < 2 ) {
				$post['profile_step'] = 2;
			}
			$this->db->where("id", $_SESSION[USER]['id'])->update("artist", $post);
			$_SESSION[USER] = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
			$alert =1;
		}

		$data = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
		$data['alert'] = $alert;

		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/proinfo');
		$this->load->view('theme/artist/footer');
	}


	public function art_info() {
		$post = $this->input->post('data');
		$cat = $this->input->post('cat');
		if(!empty($post)) {
			if($this->pstep < 3 ) {
				$post['profile_step'] = 3;
			}
			$post['cats'] = implode(",", $cat);
			$this->db->where("id", $_SESSION[USER]['id'])->update("artist", $post);
			$_SESSION[USER] = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
			$alert = 1;
		}

		$data = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
		$cats = $this->db->select("id, category_name")->where("parent",0)->get("category")->result_array();
		foreach ($cats as $key => $val) {
			$val['subs'] = $this->db->select("id, category_name")->where("parent", $val['id'])->get("category")->result_array();
			$res[] = $val;
		}
		$data['category'] = $res;
		$data['alert'] = $alert;

		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/artinfo');
		$this->load->view('theme/artist/footer');

	}


	public function conv_info() {

		$conv = $this->input->post('conv');
		$year = $this->input->post('year');
		$loc = $this->input->post('loc');
		$attd = $this->input->post('attd');

		if(!empty($_POST)) {
			$co = count($conv);
			if($co) {
				for($i=0; $i<=$co; $i++) {
					$post = array(
						"user_id" => $_SESSION[USER]['id'],
						"conv_name" => $conv[$i],
						"year" => $year[$i],
						"location" => $loc[$i],
						"attd" => $attd[$i],
					);
					$this->db->insert("convention", $post);
				}
				$alert = 1;
			}

			if($this->pstep < 4 ) {
				$this->db->where("id", $data['id'])->update("artist", array("profile_step"=>4));
			}
		}

		$data = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
		$data['alert'] = $alert;
		$data['convs'] = $this->db->where("user_id", $_SESSION[USER]['id'])->get("convention")->result_array();
		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/convention');
		$this->load->view('theme/artist/footer');

	}

	public Function awards() {

		$awd = $this->input->post('awd');
		$eve = $this->input->post('eve');
		$year = $this->input->post('year');
		$loc = $this->input->post('loc');

		if(!empty($_POST)) {
			$co = count($awd);
			if($co) {
				for($i=0; $i<=$co; $i++) {
					$post = array(
						"user_id" => $_SESSION[USER]['id'],
						"award_name" => $awd[$i],
						"event_name" => $eve[$i],
						"year" => $year[$i],
						"location" => $loc[$i],
					);
					$this->db->insert("award", $post);
				}
				$alert = 1;
			}

				if($this->pstep < 5 ) {
					$this->db->where("id", $data['id'])->update("artist", array("profile_step"=>5));
				}

		}

		$data = $this->db->where("id", $_SESSION[USER]['id'])->get("artist")->row_array();
		$data['awards'] = $this->db->where("user_id", $_SESSION[USER]['id'])->get("award")->result_array();
		$data['alert'] = $alert;
		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/awards');
		$this->load->view('theme/artist/footer');
	}

	public function changepassword()
	{
		$id=$_SESSION[USER]['id'];

		$post = $this->input->post('data');
			if($post) {
				$this->db->where("id", $id)->update("artist", array("password"=>md5($post['newpass'])));
				$msg = 1;
			} else {
				// $msg = 2;
			}
			$data['msg']=$msg;
		$this->load->view('theme/artist/head');
		$this->load->view('theme/artist/header',$data);
		$this->load->view('theme/artist/changepassword');
		$this->load->view('theme/artist/footer');
	}

}
