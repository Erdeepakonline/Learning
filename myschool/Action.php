<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Action extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER]) && empty($_SESSION[STUDIO])) { redirect('artist'); }
		validate_package();
	}

	public function del_conv()
	{
		$id = $this->input->post("cid");
		if(!empty($_SESSION[USER])) {
			if($id>0) {
				$this->db->where(array("user_id"=> $_SESSION[USER]['id'], "id"=>$id))->delete("convention");
			}
		}
	}

	public function del_awd() {
		$id = $this->input->post("cid");
		if(!empty($_SESSION[USER])) {
			if($id>0) {
				$this->db->where(array("user_id"=> $_SESSION[USER]['id'], "id"=>$id))->delete("award");
			}
		}
	}


	public function get_studios() {

		$src = $this->input->post('src');
		$url = base_url().'media/studio/';

		if(!empty($_SESSION[USER])) {

			$std = array_column($this->db->select("studio_id")->where("artist_id", $_SESSION[USER]['id'])->get("artist_studio")->result_array(),"studio_id");

			$this->db->select("st.id, CONCAT('$url','',st.studio_logo) as logo, st.studio_name, ct.city, sts.state, cn.country");
			$this->db->from("studios st, city ct, state sts, country cn");
			$this->db->where("st.city=ct.id");
			$this->db->where("st.state=sts.id");
			$this->db->where("st.country=cn.id");
			$this->db->where("st.owner_id !=", $_SESSION[USER]['id']);

			if($std) {
				$this->db->where_not_in('st.id',$std);
			}

			$this->db->like("st.studio_name", $src);
			$data = $this->db->get()->result_array();
			if(!empty($data)){
			    
			    echo json_encode(array("status"=>1, "data"=>$data));
			} else {
			    echo json_encode(array("status"=>0, "msg"=>"no Data"));
			}

		}

	}


	public function del_studio()
	{
		$id = $this->input->post("cid");
		if(!empty($_SESSION[USER])) {
			if($id>0) {
				$this->db->where(array("artist_id"=> $_SESSION[USER]['id'], "id"=>$id))->delete("artist_studio");
			}
		}
	}


	public function del_pimg()
	{   
	    $this->load->library('awsloader');
        $bucket = 'thetattoopdbucket';
        
		$id = $this->input->post("id");
			if($id>0) {
					$img = $this->db->select("image")->where("id", $id)->get("artist_portfolio")->row()->image;
					$this->db->where(array("id"=>$id))->delete("artist_portfolio");
					$this->awsloader->delete("portfolio/".$img, $bucket);
				// 	unlink("media/portfolio/".$img);
			}
	}


	public function allow_artist() {

		$id = $this->input->post("id");

		if(!empty($_SESSION[STUDIO])) {
			$row = $this->db->where(array("id"=>$id, "studio_id" => $_SESSION[STUDIO]['id']))->get("artist_studio")->row_array();
			if(!empty($row)) {
				$this->db->where("id", $row['id'])->update("artist_studio", array("status"=>1));
				echo json_encode(array("status"=>1));
			}
		}

	}

	public function decline_artist() {

		$id = $this->input->post("id");

		if(!empty($_SESSION[STUDIO])) {
			$row = $this->db->where(array("id"=>$id, "studio_id" => $_SESSION[STUDIO]['id']))->get("artist_studio")->row_array();
			if(!empty($row)) {
				$this->db->where("id", $row['id'])->delete("artist_studio");
				echo json_encode(array("status"=>1));
			}
		}

	}
    
	public function ses_studio() {
		$code = $this->input->post('code');
		if($code) {
			$row = $this->db->select("*")->where(array("code"=> $code, "owner_id" => $_SESSION[USER]['id']))->get("studios")->row_array();
			if(!empty($row)) {
				$_SESSION[STUDIO] = $row;
				echo json_encode(array("status"=>1, "msg"=>"Login Success"));
			} else {
				echo json_encode(array("status"=>0, "msg"=>"Login Failed"));
			}
		} else {
				echo json_encode(array("status"=>0, "msg"=>"Login Failed"));
		}
	}


	public function del_video() {

		$vid_id = $this->input->post('vid_id');
		
        $this->load->library('awsloader');
        $bucket = 'thetattoopd-videos';
        $this->awsloader->delete($vid_id, $bucket);
		$this->db->where("video_name", $vid_id)->delete("videos");
		
// 		$ch = curl_init();

// 		curl_setopt($ch, CURLOPT_URL, CF_UPLOAD_URL.'/'.$vid_id);
// 		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
// 		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');


// 		$headers = array();
// 		$headers[] = 'X-Auth-Key: '.CF_API_KEY;
// 		$headers[] = 'X-Auth-Email: '.CF_ACCOUNT_ID;
// 		$headers[] = 'Content-Type: application/json';
// 		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

// 		$result = curl_exec($ch);

// 		if (curl_errno($ch)) {
// 		    echo 'Error:' . curl_error($ch);
// 		}
// 		curl_close($ch);
		// print_r($result);
	}
	
	public function save_studio() {
	    $name = $this->input->post("name");
	    
	    if(!empty($_SESSION[USER])) {
	        $this->db->insert("artist_studio_tmp", array("artist_id"=>$_SESSION[USER]['id'], "studio_name"=>$name));
	        echo json_encode(array("status"=>1));
	        $_SESSION['s_alert'] = 1;
	    }
	}
}
