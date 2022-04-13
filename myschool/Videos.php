<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Videos extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		validate_package();
	}

	public function index()
	{
	    $this->load->library('awsloader');
        $bucket = 'thetattoopd-videos';
        
		if(!empty($_FILES)) {
		    
		    $check_activity = schoolActivityValidate('Video', $_SESSION[SCHOOL]['id']);
		    
		    if($check_activity == 1) {
		        
		    $name = $_FILES["myvideo"]["name"];
			$ext = pathinfo($name);
			$ext = $ext['extension'];
			
			$size = ($_FILES["myvideo"]["size"]/1024)/1024;
			
			$allow_mime = array("mp4", "MP4", "avi", "AVI", "wmv", "WMV", "mkv", "MKV", "webm");
		    
		    if($size < 50) {	
    			if(in_array($ext, $allow_mime)) { 
    			    
        			$newname = strtolower($_SESSION[USER]['fname'].'-school-video-'.time().'.'.$ext);
        			
                	$vid_url = $this->awsloader->upload('myvideo', $bucket, $newname);
                	
        			$post['artist_id'] = $_SESSION[USER]['id'];
        			$post['school_id'] = $_SESSION[SCHOOL]['id'];
        			$post['video_id'] = $vid_url;
        			$post['video_name'] = $newname;
                    $this->db->insert("school_video", $post);
        			$data['alert'] = 1;
    			
    			} else {
    			    $data['alert'] = 2; 
    			}
		    } else {
		        $data['alert'] =3; 
		    }
		  } elseif($check_activity == 2) {
		      $data['alert'] = 4;
		  } elseif($check_activity == 3) {
		     $data['alert'] = 5; 
		  }
		  
		}
		$data['videos'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->order_by("id","desc")->get("school_video")->result_array();
		$this->load->view("theme/artist/head");
		$this->load->view("theme/school/header");
		$this->load->view("theme/school/videos", $data);
		$this->load->view("theme/artist/footer");
	}


}
