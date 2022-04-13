<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(empty($_SESSION[USER])) { redirect('artist'); }
// 		validate_package();
        
	}

	public function index()
	{
	        $data['visitors'] = $this->db->where(array("user_id" => $_SESSION[SCHOOL]['id'], "type" => 3))->get("profile_views")->num_rows();
    	    $data['learner'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->get("school_enquiry")->num_rows();

    	    for($i=0; $i<=6; $i++) {
    	        
    	       $vis[] = $this->db->where(array("user_id" => $_SESSION[SCHOOL]['id'], "type" => 3))->where("DATE(created) = DATE('".date("Y-m-d", strtotime("-".$i." day"))."')")->get("profile_views")->num_rows();
    	     
    	       $lrn[] = $this->db->where(array("school_id"=> $_SESSION[SCHOOL]['id']))->where("DATE(created) = DATE('".date("Y-m-d", strtotime("-".$i." day"))."')")->get("school_enquiry")->num_rows();
    	
    	    }
    	   
    	   $data['vis'] = $vis;
    	   $data['lrn'] = $lrn;
    	   // print_r($lrn);
    	   $data['offer'] = $this->db->select("offer")->where("id", $_SESSION[SCHOOL]['id'])->get("school")->row()->offer;
    	   
		$this->load->view('theme/artist/head');
		$this->load->view('theme/school/header',$data);
		$this->load->view('theme/school/home');
		$this->load->view('theme/artist/footer');

	}

	public function offer() {

		$post = $this->input->post('data');
		if(!empty($post)) {
		    $post['ofr_sdate'] = ($post['ofr_sdate']) ? date("Y-m-d", strtotime( $post['ofr_sdate'])) : null;
		    $post['ofr_edate'] = ($post['ofr_edate']) ? date("Y-m-d", strtotime( $post['ofr_edate'])) : null;
		    
			$this->db->where("id", $_SESSION[SCHOOL]['id'])->update("school", $post);
		}
		
		$data['offer'] = $this->db->select('offer, ofr_sdate, ofr_edate')->where("id", $_SESSION[SCHOOL]['id'])->get("school")->row_array();
		
		$this->load->view('theme/artist/head');
		$this->load->view('theme/school/header',$data);
		$this->load->view('theme/school/make-offer');
		$this->load->view('theme/artist/footer');
	}

    public function info() {
        
        $data = $this->db->where("id", $_SESSION[SCHOOL]['id'])->get("school")->row_array();
        $data['city'] = $this->db->select("city")->where("id", $data['city'])->get("city")->row()->city;
        $data['state'] = $this->db->select("state")->where("id", $data['state'])->get("state")->row()->state;
        $data['country'] = $this->db->select("country")->where("id", $data['country'])->get("country")->row()->country;
        
        $data['cvs'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->get("school_files")->result_array();
        
		$this->load->view('theme/artist/head');
		$this->load->view('theme/school/header');
		$this->load->view('theme/school/school', $data);
		$this->load->view('theme/artist/footer');
    }
    
    
    public function update_school() {
        
        $this->load->library('awsloader');
        $bucket = 'school-curriculum';
        
        $post = $this->input->post("data");
        $fname = $this->input->post("filename");
        
		if(!empty($post)) {
        
        // $slug = strtolower(str_replace($post['studio_name']));
        // echo $post['school_name'];
        $post['slug'] = $this->getSlug($post['school_name']);
        if(strlen($_FILES['school_logo']['name'])) {
            
            $name = $_FILES['school_logo']['name'];
            $size= $_FILES['school_logo']['size'];
            
            $ext = pathinfo($name);
            $ext = $ext['extension'];
            
            $allow_ext = array("jpg", "JPG", "png", "PNG", "jpeg", "JPEG");
            $new_name = "shcool-logo-".time().".".$ext;
            
            if(in_array($ext, $allow_ext)) {
                
                if(($size/1024)/1024 < 5) {
                    
                  move_uploaded_file($_FILES['school_logo']['tmp_name'], "media/school/".$new_name);
                  $post['school_logo'] = $new_name;
 				  
 				  	$co = count($fname);
        			if($co>0) {
        	            $co--;
        	            for($i=0; $i<=$co; $i++) {
        	                
        	                 
                            $name = $_FILES["cvfile"]["name"][$i];
                			$ext = pathinfo($name);
                			$ext = $ext['extension'];
                			$newname = strtolower('curriculum-'.time().$i.'.'.$ext);
        	                $file_url = $this->awsloader->multi_upload($_FILES["cvfile"]["tmp_name"][$i], $bucket, $newname, 'pdf');
        	                
        	                $cv = [
        	                    "school_id" => $_SESSION[SCHOOL]['id'],
        	                    "title" => $fname[$i],
        	                    "file_name" => $newname,
        	                    "file_url" => $file_url];
        	                $this->db->insert("school_files", $cv );
        	            }
        			}	
        				
        			$this->db->where("id", $_SESSION[SCHOOL]['id'])->update("school", $post);
                    // $alert = '<div class="alert alert-success alert-dismissible fade show" role="alert">
        												// 			<strong>Congratulations!</strong> School Details Updated Successfully.
         											// 				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
         											// 					<span aria-hidden="true">&times;</span>
         											// 				</button>
         											// 			</div>';
         														
    				$this->session->set_flashdata('alert', '<div class="alert alert-success alert-dismissible fade show" role="alert">
    															<strong>Congratulations!</strong> School Details Updated Successfully.
    															<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    																<span aria-hidden="true">&times;</span>
    															</button>
    														</div>');
    				redirect("myschool");
    				
                } else {
                  $alert = '<div class="alert alert-danger alert-dismissible fade show" role="alert">
							<strong>Error found.</strong> Please upload maximum 5mb image only.
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						   </div>';
                }
                
            } else {
                $alert = '<div class="alert alert-danger alert-dismissible fade show" role="alert">
							<strong>Error found.</strong> Please upload jpeg or png image only.
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						   </div>';
            }
            
		
			} else {

                	$co = count($fname);
        			if($co>0) {
        	            $co--;
        	            for($i=0; $i<=$co; $i++) {
        	                
        	                 
                            $name = $_FILES["cvfile"]["name"][$i];
                			$ext = pathinfo($name);
                			$ext = $ext['extension'];
                			$newname = strtolower('curriculum-'.time().$i.'.'.$ext);
        	                $file_url = $this->awsloader->multi_upload($_FILES["cvfile"]["tmp_name"][$i], $bucket, $newname, 'pdf');
        	                
        	                $cv = [
        	                    "school_id" => $_SESSION[SCHOOL]['id'],
        	                    "title" => $fname[$i],
        	                    "file_name" => $newname,
        	                    "file_url" => $file_url];
        	                $this->db->insert("school_files", $cv );
        	            }
        			}	
        				
        			$this->db->where("id", $_SESSION[SCHOOL]['id'])->update("school", $post);
                    $alert = '<div class="alert alert-success alert-dismissible fade show" role="alert">
        															<strong>Congratulations!</strong> School Details Updated Successfully.
         															<button type="button" class="close" data-dismiss="alert" aria-label="Close">
         																<span aria-hidden="true">&times;</span>
         															</button>
         														</div>';

				redirect("myschool");
			}
		}
		if(!empty($post)) {
		    $data = $post;
		} else {
		    $data = $this->db->where("id", $_SESSION[SCHOOL]['id'])->get("school")->row_array();
		}
        $data['countries'] = $this->db->get("country")->result_array();
        
        if($data['state']>0) {    
          $data['states'] = $this->db->where("country_id", $data['country'])->get("state")->result_array();
        }
        
        if($data['city']>0) {
          $data['cities'] = $this->db->where("state_id", $data['state'])->get("city")->result_array();
        }
            
        $data['cvs'] = $this->db->where("school_id", $_SESSION[SCHOOL]['id'])->get("school_files")->result_array();
        
        $data['alert'] = $alert;
		$this->load->view('theme/school/head');
		$this->load->view('theme/school/header',$data);
		$this->load->view('theme/school/edit');
		$this->load->view('theme/artist/footer');
    }
    
    
    public function getSlug( $name, $sn=0 ) {
        if($sn > 0) {
            $name = $name.'-'.$sn;
        }
        // echo $name;
         $slug = strtolower(str_replace(' ', '-', str_replace("'", "", $name)));
         $chk = $this->db->where("slug", $slug)->get("school")->num_rows();
        if($chk == 0) {
            return $slug;
        } else {
            $sn++;
          return $this->getSlug( $name, $sn );
        }
    }
}
