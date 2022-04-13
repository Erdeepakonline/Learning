<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Artist extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}

	public function register()
	{
	    
    $post['fname'] =  $this->security->xss_clean($this->input->post('fname'));
    $post['lname'] =  $this->security->xss_clean($this->input->post('lname'));
    $post['gender'] = $this->security->xss_clean($this->input->post('gender'));
    $post['mobile'] = $this->security->xss_clean($this->input->post('mobile'));
    $post['email'] =  $this->security->xss_clean($this->input->post('email'));
    $post['password'] = $this->security->xss_clean($this->input->post('password'));
    
    if(!empty($post)) {
      $post['password'] = md5($post['password']);

      $this->db->insert("artist", $post);
      $uid = $this->db->insert_id();
      if($uid) {
        $otp = rand(11111,99999);
        $conf['msg'] = $otp." is your OTP for verification.";
        $conf['mobile'] = $post['mobile'];
        $_SESSION[USER]['id'] = $uid;
        $_SESSION[USER]['fname'] = $post['fname'];
        $_SESSION[USER]['lname'] = $post['lname'];
        $_SESSION[USER]['mobile'] = $post['mobile'];
        $_SESSION['otp'] = $otp;
        $this->main_model->sendSMS($conf);
        echo json_encode(array("status"=>1, "msg" => "Artist registered.".$otp));
      } else {
        echo json_encode(array("status"=>0, "msg" => "something went wrong."));
      }

    }

	}


  public function otp_verify() {
    $otp = $this->input->post("otp");
    if($otp) {
      if($otp == $_SESSION['otp']) {
        echo json_encode(array("status"=>1, "msg" => "OTP verified."));
      } else {
        echo json_encode(array("status"=>0, "msg" => "Invalid OTP."));
      }
    } else {
      echo json_encode(array("status"=>0, "msg" => "Invalid OTP."));
    }

  }


  public function artist_data() {
    // sleep(2);

    $row = $this->input->post('row');
    $cat = $this->input->post('cat');
    $loc = $this->input->post('loc');
    $cntry = $this->input->post('country');
    $name = $this->input->post('name');
    $state = trim($this->input->post('state'));
    
    // if(!is_numeric($loc)) { 
        $cty = $this->db->select("id, state_id")->where("city", trim($loc))->get("city")->row();
        $loc_id = $cty->id;
    // } else {
    //     $loc_id = $loc;
    // }
    
    
    $st_id = $this->db->select("id")->where("state", trim($state))->get("state")->row()->id;
    
    $this->db->select("ar.id, ar.slug, ar.code,CONCAT(fname, ' ', lname) as name, ar.profile_pic, ar.artist_bio, ct.city, st.state, cn.country");
    $this->db->from("artist ar, city ct, state st, artist_package ap, country cn");
    $this->db->where("ar.city=ct.id");
    $this->db->where("ar.state=st.id");
    $this->db->where("ap.artist_id=ar.id");
    $this->db->where("cn.id=ar.country");
    
    if($cat) {
      $this->db->where("FIND_IN_SET('".$cat."',ar.cats) <>",'0');
    }
    
    if(strlen($name)) {
      $this->db->like("ar.fname", $name);
    }

    if($loc_id) {
      $this->db->where("ar.city", $loc_id);
    }
      if($cntry) {
      $this->db->where("ar.country", $cntry);
    }
    
    if(!$loc_id && $st_id > 0) {
        $this->db->where("ar.state", $st_id);
    }
        
    
    $this->db->where("ar.status",1);
    $this->db->where("ap.status",1);
    $rows = $this->db->count_all_results('', false);
    $this->db->order_by('ar.list_order','desc');
    $this->db->order_by('ap.pack_id','desc');
    // $this->db->order_by('ap.amount','desc');
    $this->db->limit(12,$row);

    $data = $this->db->get()->result_array();
    
    if($loc_id > 0 && empty($data) && $row == 0) {
        
    $this->db->select("ar.id, ar.slug, ar.code,CONCAT(fname, ' ', lname) as name, ar.profile_pic, ar.artist_bio, ct.city, st.state, cn.country");
     $this->db->from("artist ar, city ct, state st, artist_package ap, country cn");
    $this->db->where("ar.city=ct.id");
    $this->db->where("ar.state=st.id");
    $this->db->where("ap.artist_id=ar.id");
     $this->db->where("cn.id=ar.country");
     
    if($cat) {
      $this->db->where("FIND_IN_SET('".$cat."',ar.cats) <>",'0');
    }

    if(strlen($name)) {
      $this->db->like("ar.fname", $name);
    }
    
    $this->db->where("ar.state", $cty->state_id);
        

    $this->db->where("ar.status",1);
    $this->db->where("ap.status",1);
    $rows = $this->db->count_all_results('', false);
    $this->db->order_by('ar.list_order','desc');
    $this->db->order_by('ap.pack_id','desc');
    $this->db->order_by('ap.amount','desc');
    $this->db->limit(12,$row);

    $data2 = $this->db->get()->result_array();
    
    }
    
    if(!empty($data)) {
        echo json_encode(["status"=>1, "data"=>$data]);
    } elseif(empty($data) && !empty($data2)) {
        echo json_encode(["status"=>1, "nearby"=>1, "data"=>$data2]);
    } else { 
        echo json_encode(["status" => 0]);
    }
        

    // $this->db->where();
  }

// =============================================//
//========    Artist Ajax Login Code ==========//
//============================================//

    public function user_login() {
      $str = $this->input->post("logstr");
      $post = explode("|", base64_decode($str));
      if(!empty($post)) {
        // print_r($post);
        $row = $this->db->where("email", $post[0])->get("customer")->row_array();
        $type = 2;

         if(empty($row)) {
            $type = 1;
            $row = $this->db->where("email", $post[0])->get("artist")->row_array();
          }

          if(!empty($row)) {
              if(md5($post[1]) == $row['password']) {

                if($type == 1) {
                  $_SESSION[USER] = $row;
                } elseif($type == 2) {
                  $_SESSION[CUSTOMER] = $row;
                }

                if($row['verified'] == 1) {

                  if( $type == 1 ) {

                    $pack = $this->db->where("artist_id", $row['id'])->get("artist_package")->num_rows();

                      if($pack>0) {
                        $res =array(
                          "log_status" => 1,
                          "type" => $type,
                          "msg" => "Login Success."
                        );
                      } else {
                        $res =array(
                          "log_status" => 3,
                          "msg" => "Package not selected."
                        );
                      }

                    } elseif ( $type == 2 ) {
                      $res =array(
                        "log_status" => 1,
                        "type" => $type,
                        "msg" => "Login Success."
                      );
                    }

                  } else {

          		    $otp = rand(111111,999999);
      				    $conf['msg'] = $otp." is your OTP for verification.";
      				    $_SESSION['otp'] = $otp;
      				    $conf['mobile'] = $row['mobile'];
      				    $this->main_model->sendSMS($conf);

                       $res =array(
                        "log_status" => 2,
                        "msg" => "Verify your mobile number."
                        );
                  }

              } else {
                  $res =array(
                  "log_status" => 0,
                  "msg" => "Invalid email or password."
                  );
              }
          } else {
              $res =array(
                  "log_status" => 0,
                  "msg" => "Email id not registered."
                  );
          }
         echo json_encode($res);
      }

  }




  public function otp_login() {
      $mob = $this->input->post("mob");

      if(is_numeric($mob) && strlen($mob) == 10) {
        // print_r($post);
        $row = $this->db->where("mobile", $mob)->get("customer")->row_array();
        $type = 2;

         if(empty($row)) {
            $type = 1;
            $row = $this->db->where("mobile", $mob)->get("artist")->row_array();
          }

          $otp = rand(111111,999999);

          $conf['msg'] = $otp." is your OTP for verification. TheTattooPedia";
          $conf['mobile'] = $mob;
          $this->main_model->sendSMS($conf);

          if(!empty($row)) {


                  $_SESSION['otp'] = $otp;
                  $_SESSION['log_uid'] = $row['id'];
                  $_SESSION['log_type'] = $type;
                  $_SESSION['log_mobile'] = $row['mobile'];
                  $_SESSION['log_act'] = 1;

                   $res =array(
                    "status" => 1,
                    "msg" => "OTP sent successfully."
                    );

            }  else {

              $post['code'] = userUniqCode();
              $post['mobile'] =   $mob;

              $this->db->insert('customer', $post);

              $_SESSION['otp'] = $otp;
              $_SESSION['log_uid'] = $this->db->insert_id();
              $_SESSION['log_type'] = 2;
              $_SESSION['log_mobile'] = $post['mobile'];
              $_SESSION['log_act'] = 2;

              $res =array(
               "status" => 1,
               "msg" => "OTP sent successfully."
               );
                // $res =array(
                // "status" => 0,
                // "msg" => "Mobile Number is not registered."
                //   //  "msg" => "Your current password expired. Please set new password using forget password option."
                // );
            }
          } else {
              $res =array(
                  "status" => 0,
                  "msg" => "You Entered Invalid Mobile Number."
                  );
          }
         // $this->db->where("email",$post[1])->get("customer")->row_array();
         echo json_encode($res);
      }


      public function otp_login_verify() {

          $otp = $this->input->post("otp");

            if($_SESSION['otp'] == $otp) {

              if( $_SESSION['log_type'] == 1 ) {
                $row = $this->db->where("id", $_SESSION['log_uid'] )->get("artist")->row_array();
                if($row['verified'] == 0) {
                  $this->db->where("id", $row['id'] )->update("artist", ['verified' => 1]);
                  $row['verified'] = 1;
                }
                $_SESSION[USER] = $row;

              } elseif( $_SESSION['log_type'] == 2 ) {
                $row = $this->db->where("id", $_SESSION['log_uid'] )->get("customer")->row_array();
                if($row['verified'] == 0) {
                  $this->db->where("id", $row['id'] )->update("customer", ['verified' => 1]);
                  $row['verified'] = 1;
                }
                $_SESSION[CUSTOMER] = $row;
              }



                if($_SESSION['log_act'] == 1) {
                  $res = array (
                    "status" => 1,
                    "type" => $_SESSION['log_type'],
                  );
                  unset($_SESSION['otp']);
                  unset($_SESSION['log_uid']);
                  unset($_SESSION['log_type']);
                  unset($_SESSION['log_mobile']);
                  unset($_SESSION['log_act']);
              } else if( $_SESSION['log_act'] == 2 ) {
                $res = array (
                  "status" => 2,
                  "type" => $_SESSION['log_type']
                );
              } else {
                  $res =array(
                    "status" => 0,
                    "msg" => "You Entered Invalid OTP."
                  );
              }

             echo json_encode($res);
          }

}

public function resend_login_otp() {

    $conf['msg'] = $_SESSION['otp']." is your OTP for verification. TheTattooPedia";
    $conf['mobile'] = $_SESSION['log_mobile'];
    $this->main_model->sendSMS($conf);
    echo json_encode(['status' => 1]);

}


public function update_log_profile() {
    $post = $this->input->post('log');
    if(!empty($post)) {
        $this->db->where(['id'=> $_SESSION['log_uid']])->update("customer", $post);
        $_SESSION[CUSTOMER]['fname'] = $post['fname'];
        $_SESSION[CUSTOMER]['lname'] = $post['lname'];
        echo json_encode([
          'status' => 1,
          'msg' => 'Profile Updated'
        ]);
    }
  }



public function check_artist() {

    if(!empty($_SESSION[USER])) {
        echo json_encode(array("valid"=>1));
    } else {
        echo json_encode(array("valid"=>0));
    }

}

  public function reset_password() {

   $this->load->model("mail_model");
   $email = $this->input->post("email");
   $_SESSION['forg_artist_otp'] = rand(111111,999999);
   $_SESSION['forg_artist_email'] = $email;
   if($email) {
       $row = $this->db->where("email", $email)->get("artist")->row_array();
       if(!empty($row)) {
           $row = $this->db->where("email", $email)->get("artist")->row_array();
            $this->mail_model->artistForgetMail($row['fname'], $row['email'],  $_SESSION['forg_artist_otp']);
            $sms['mobile'] = $row['mobile'];
            $sms['msg'] = $_SESSION['forg_artist_otp'].' is your OTP for reset Password. TheTattooPedia';
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

  if($_SESSION['forg_artist_otp'] == $post[0]) {
    $this->db->where("email", $_SESSION['forg_artist_email'])->update("artist", array("password" => md5($post[1])));
    $row = $this->db->where("email", $_SESSION['forg_artist_email'])->get("artist")->row_array();
    $this->mail_model->artistResetMail($row['fname'], $row['email']);
    echo json_encode(array("status" => 1, "msg" => "Password Updated" ));
  } else {
    echo json_encode(array("status" => 0, "msg" => "Invalid Verification Code." ));
  }
}



public function book_appointment() {

    $arid = $this->input->post("artist_id");
    $sid = $this->input->post("studio_id");
    $date = $this->input->post("date");
    $time = $this->input->post("time");
    
    if(!empty($_SESSION[CUSTOMER])) {

        $data['app_id'] = appUniqCode();
        $data['artist_id'] = $arid;
        $data['studio_id'] = $sid;
        $data['user_id'] = $_SESSION[CUSTOMER]['id'];
        $data['app_date'] = date("Y-m-d", strtotime($date));
        $data['app_time'] = $time;
        // print_r($data);
        $this->db->insert("appointment", $data);
        $id = $this->db->insert_id();
        if($id>0) {
          $_SESSION['app_id']  = $id;
          $_SESSION['app_artist_id'] = $arid;
          echo json_encode(array("status" => 1));
        } else {

          echo json_encode(array("status" => 0));
        }

    }

}


public function cancel_appointment() {
  $app_id = $this->input->post("app_id");
  $row = $this->db->where("app_id", $app_id)->get("appointment")->row_array();
  if(!empty($_SESSION[CUSTOMER]) && !empty($row)) {
    $this->db->where("app_id", $app_id)->delete("appointment");
    unset($_SESSION['app_id']);
    echo json_encode(array("status"=>1));
  } else {
    echo json_encode(array("status"=>0));
  }

}


public function search_by_name() {
    // $name = $this->input->post("name");
    // if($name) {
    //     $this->db->select("CONCAT(fname, ' ', lname) as name");
    //     $this->db->like("fname", $name);
    //     $this->db->or_like("lname", $name);
    //     $this->db->limit(5);
    //     $data = $this->db->get("artist")->result_array();
        
    //     if(!empty($data)) {
    //         echo json_encode(array("status" => 1, "data" => $data ));
    //     } else {
    //         echo json_encode(array("status" => 0));
    //     }
            
    // }
    
    
        $this->db->select("CONCAT(fname, ' ', lname) as name");
        $names = $this->db->get("artist")->result_array();
        
        $names = array_column($names,"name");
        $data = array_unique($names);
        echo json_encode($data);
        
}


public function get_appointment() {
   
   $row = $this->input->post("row");
   $src = $this->input->post("src");
   $sort = $this->input->post("sort");
   
	if($src) {
	        
	    if($src != 'All') {
           $date = date("Y-m-d", strtotime("-".$src));
	    }
	    
	} else {
	    $date = date("Y-m-d");
	}
//   echo $date;
    if(!empty($_SESSION[USER])) {
        
        $this->db->select("ap.*, CONCAT(cs.fname,' ', cs.lname) as name, cs.mobile");
		$this->db->from("appointment ap, customer cs");
		$this->db->where("ap.user_id=cs.id");
		$this->db->where("ap.artist_id", $_SESSION[USER]['id']);
		$this->db->where("ap.pay_status", 1);
		
		if($src != 'All') {
    	    $this->db->where("DATE(ap.app_date) < DATE('".date("Y-m-d")."')");
    	    $this->db->where("DATE(ap.app_date) >= DATE('".$date."')");
		}
		
	    if($sort) {
		    $this->db->order_by("ap.app_date", $sort);
	    }
	        
		$apps = $this->db->get()->result_array();
		
        foreach( $apps as $key => $val) {
            $val['app_date'] = date("d M Y", strtotime($val['app_date']));
            if($val['studio_id']) {
             $std = $this->db->select("studio_name, studio_logo, code as scode, city")->where("id", $val['studio_id'])->get("studios")->row_array();
             $val['studio_name'] = $std['studio_name'];
             $val['studio_logo'] = $std['studio_logo'];
             $val['scode'] = $std['scode'];
             $val['city'] = $this->db->select("city")->where("id", $std['city'])->get("city")->row()->city;
            } else {
                $val['studio_name'] = '';
                $val['studio_logo'] = '';
                $val['scode'] = '';
                $val['city'] = $this->db->select("city")->where("id", $val['city_id'])->get("city")->row()->city;
            }
            $res[] = $val;
            
        }
        
    	echo json_encode($res);
    	
    }
}


}
