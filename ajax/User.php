<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}

	public function user_login() {
	    
	    $this->load->model("main_model");
	    
	    $str = $this->input->post("logstr");
	    $post = explode("|", base64_decode($str));
	    if(!empty($post)) {
	        $row = $this->db->where("email",$post[0])->get("customer")->row_array();
	        if(!empty($row)) {
	            
             if($row['verified'] == 1) {
	            if(md5($post[1]) == $row['password']) {
	                $_SESSION[CUSTOMER] = $row;
	                
	                unset($_SESSION[USER]);
	                unset($_SESSION[SHOP]);
	                
	                $res =array(
	                "log_status" => 1,
	                "msg" => "Login Success."
	                );
	            } else {
	                $res =array(
	                "log_status" => 0,
	                "msg" => "Invalid email or password."
	                );
	            }
             } else {
                 
                 	$otp = rand(111111,999999);
    				$conf['msg'] = $otp." is your OTP for verification.";
    				$conf['mobile'] = $row['mobile'];
    				$_SESSION['cust_otp'] = $otp;
    				$this->main_model->sendSMS($conf);
    				
                    $res =array(
    	                "log_status" => 2,
    	                "msg" => "Mobile number not verified."
	                );
	                
             }
	        } else {
	            $res =array(
	                "log_status" => 0,
	                "msg" => "Email id not registered."
	                );
	        }
	       // $this->db->where("email",$post[1])->get("customer")->row_array();
	       echo json_encode($res);
	    }

	}

    public function check_user() {

        if(!empty($_SESSION[CUSTOMER])) {
            echo json_encode(array("valid"=>1));
        } else {
            echo json_encode(array("valid"=>0));
        }

    }
    
    public function check_user_any() {

        if(!empty($_SESSION[CUSTOMER]) || !empty($_SESSION[USER])) {
            echo json_encode(array("valid"=>1));
        } else {
            echo json_encode(array("valid"=>0));
        }

    }
    
    public function reset_password() {

     $this->load->model("mail_model");
     $email = $this->input->post("email");
     $_SESSION['forg_user_otp'] = rand(111111,999999);
     $_SESSION['forg_user_email'] = $email;
     if($email) {
         $row = $this->db->where("email", $email)->get("customer")->row_array();
         if(!empty($row)) {
             $this->mail_model->userFoegetMail($row['fname'], $row['email'],  $_SESSION['forg_user_otp']);
                $sms['mobile'] = $row['mobile'];
                $sms['msg'] = $_SESSION['forg_user_otp'].' is your OTP for reset Password. TheTattooPedia';
                $this->main_model->sendSMS($sms);
             echo json_encode(array("status" => 1, "msg"=> "Recovery mail sent"));
         } else {
              echo json_encode(array("status" => 0, "msg"=> "Email not registered"));
         }
     }
  }


    public function update_password() {
        $this->load->model("mail_model");
      $str = $this->input->post("str");
      $post = explode("|", base64_decode($str));

      if($_SESSION['forg_user_otp'] == $post[0]) {
        $this->db->where("email", $_SESSION['forg_user_email'])->update("customer", array("password" => md5($post[1])));
        $row = $this->db->where("email", $_SESSION['forg_user_email'])->get("customer")->row_array();
        $this->mail_model->userResetMail($row['fname'], $row['email']);
        echo json_encode(array("status" => 1, "msg" => "Password Updated" ));
      } else {
        echo json_encode(array("status" => 0, "msg" => "Invalid Verification Code." ));
      }
    }
    
    
    public function test() {
        
        $datetime1 = new DateTime();
        $datetime2 = new DateTime('2020-11-03 17:13:00');
        $interval = $datetime1->diff($datetime2);
        
        if($interval->y > 0) {
            $str = $interval->format('%y year ago');
        } elseif($interval->m > 0) {
            $str = $interval->format('%m month ago');
        } elseif($interval->d > 0) {
            $str = $interval->format('%d day ago');
        } elseif($interval->h > 0) {
            $str = $interval->format('%h hr ago');
        } elseif($interval->i > 0) {
            $str = $interval->format('%d min ago');
        } elseif($interval->s > 0) {
            $str = $interval->format('%s sec ago');
        }
print_r($interval);
$elapsed = $interval->format('%y years %m months %a days %h hours %i minutes %s seconds');
echo $elapsed;
    // echo $interval->format("Days = %a Time = %H:%I:%S .");
    }
}
