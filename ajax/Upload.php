<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Upload extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}

	public function profile_image()
	{
	    
      if(!empty($_SESSION[USER])) {

        $this->load->library('awsloader');
        $bucket = 'thetattoopdbucket';
        
          if(strlen($_FILES['profile_pic']['name'])) {

            $file = $_FILES['profile_pic']['name'];
            $size= $_FILES['profile_pic']['size'];

            $ext = pathinfo($file);
            $ext = $ext['extension'];
            $allow_mime = array("jpg", "jpeg", "png", "JPG", "JPEG", "PNG");

            $new_name = "profile-pic-".time().".".$ext;

            if(in_array($ext, $allow_mime)) {
                if(($size/1024)/1024 < 5) {
                    $this->awsloader->upload('profile_pic', $bucket, 'artist/'.$new_name, 'img');
                //   move_uploaded_file($_FILES['profile_pic']['tmp_name'], "media/artist/".$new_name);
                  $this->db->where("id", $_SESSION[USER]['id'])->update("artist", array("profile_pic"=> $new_name));
                  echo json_encode(array("status"=>1, "msg" =>"Image Uploaded Successfully"));
                } else {
                  echo json_encode(array("status"=>0, "msg" =>"Please upload maximum 5mb image only."));
                }
            } else {
              echo json_encode(array("status"=>0, "msg" =>"Please upload JPG or PNG Image only."));
            }


          }
      }

    }


    public function user_profile_image()
    {
        if(!empty($_SESSION[CUSTOMER])) {

            if(strlen($_FILES['profile_pic']['name'])) {

             $config['upload_path']          = './media/customer/';
             $config['allowed_types']        = 'jpg|png';
             $config['max_size']             = 1024;
             $config['file_name']             = "user-profile-pic-".time();

             $this->load->library('upload', $config);

             if ( ! $this->upload->do_upload('profile_pic'))
             {
               echo json_encode(array("status"=>0, "msg" =>$this->upload->display_errors("","")));
             }
             else
             {
               $data = $this->upload->data();
               $this->db->where("id", $_SESSION[CUSTOMER]['id'])->update("customer", array("profile_pic"=> $data['file_name']));
               echo json_encode(array("status"=>1, "msg" =>"Image Uploaded Successfully"));
             }

            }
        }

      }


}
