<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Portfolio extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
		validate_package();
	}

	public function index()
	{   
	    $this->load->library('awsloader');
        $bucket = 'thetattoopdbucket';
		$post =$this->input->post('data');
        
		if(!empty($post)) {
		    
		    $check_activity = schoolActivityValidate('Portfolio', $_SESSION[SCHOOL]['id']);
		    
		     if($check_activity == 1) {

                if(strlen($_FILES["portfolio_image"]["name"]) > 0) {
                
                    $name = $_FILES["portfolio_image"]["name"];
        			$ext = pathinfo($name);
        			$ext = $ext['extension'];
        			
        			$size = ($_FILES["portfolio_image"]["size"]/1024)/1024;
        			
        			$allow_mime = array("jpg", "JPG", "jpeg", "JPEG", "png", "PNG", "bmp", "BMP");
        		    
        		    if($size < 20) {	
            			if(in_array($ext, $allow_mime)) { 
            			    
                			$newname = strtolower($_SESSION[USER]['fname'].'-school-image-'.time().'.'.$ext);
                			
                        	$this->awsloader->upload('portfolio_image', $bucket, 'school/'.$newname, 'img');
                        	
        					$post['image'] = $newname;
        				// 	$post['img_tags'] = implode(",", $this->input->post('tags'));
                			$post['artist_id'] = $_SESSION[USER]['id'];
                			$post['school_id'] = $_SESSION[SCHOOL]['id'];
                // 			print_r($post);
        					$this->db->insert("school_portfolio", $post);
            				$_SESSION['port_img_status'] = 1;
    					    redirect("myschool/portfolio");
            			
            			} else {
            			    $data['alert'] = 2; 
            			    $data['msg'] = "Error! Invalid image format. Please upload jpg, png or bmp image only";
            			}
        		    } else {
        		        $data['alert'] =3; 
        		        $data['msg'] = "Error! File size limit exceeded. Please upload maximum 20mb image only";
        		    }
                } else {
    				$data = $post;
    				$data['alert'] = 4;
    				$data['msg'] = "Please upload portfolio image";
    			}
    			
		     } elseif($check_activity == 2) {
			
                $data = $post;
				$data['alert'] = 5;
				$data['msg'] = "Your portfolio image upload limit exceeded.";
				
		    } elseif($check_activity == 3) {
		        
                $data = $post;
				$data['alert'] = 6;
				$data['msg'] = "Your package expired. Please upgrade your package.";
		    }   
		    
			
		}
		$data['images'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->get("school_portfolio")->result_array();
		
		$data['cats'] = getCats();

		$this->load->view("theme/artist/head");
		$this->load->view("theme/school/header");
		$this->load->view("theme/school/portfolio", $data);
		$this->load->view("theme/artist/footer");
	}

	public function upload_image()
	{
			if(!empty($_SESSION[USER])) {

					if(strlen($_FILES['portfolio_image']['name'])) {

					 $config['upload_path']          = './media/portfolio/';
					 $config['allowed_types']        = 'jpg|png|jpeg';
					 $config['max_size']             = 20480;
					 $config['file_name']             = "portfolio-image-".time();

					 $this->load->library('upload', $config);

						 if ( ! $this->upload->do_upload('portfolio_image'))
						 {
							 return (object) array("status"=>0, "msg" =>$this->upload->display_errors("",""));
						 }
						 else
						 {
							 $data = $this->upload->data();
							 return (object) array("status"=>1, "file_name" =>$data['file_name']);
						 }

					 } else {
						 return (object) array("status"=>2, "file_name" =>$data['file_name']);
					 }
			}

		}

}
