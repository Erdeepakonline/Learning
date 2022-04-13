<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Action extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
    $this->load->model('mail_model');
    $this->load->helper('shop_mail');
	}


  public function set_package() {
    $id = $this->input->post('id');
    $row = $this->db->where("id", $id)->get("package")->row_array();
    // print_r($row);
    if(!empty($row)) {
      $_SESSION['pack_id'] = $row['id'];
      echo json_encode(array("status"=>1, "msg"=>"Package Verified"));
    } else {
      echo json_encode(array("status"=>0, "msg"=>"Package not found."));
    }
  }


  public function set_plan () {
    unset($_SESSION['pw']);
    unset($_SESSION['pay']);
    unset($_SESSION['wlt']);
    $plan = $this->input->post('plan');
    if($plan) {
      $_SESSION['pack_type'] = $plan;
      echo json_encode(array("status"=>1, "msg"=>"Package Verified"));
    } else {
      echo json_encode(array("status"=>0, "msg"=>"Package not found."));
    }

  }

  //   public function forgetpass()
  //   {
  //
  //     // $this->load->model("adm_model");
  //   		$email = $this->input->post('email');
  //
  //   		if( strlen($email) ) {
  //   				$row = $this->db->where("email",$email)->get("customer")->row_array();
  //   				if(!empty($row)) {
  //   					$otp = rand(111111,999999);
  //   					$_SESSION[CUSTOMER]['id'] = $otp;
  //   					$msg = $otp." is your OTP for password reset.";
  //   					$this->main_model->sendSMS($msg, $row['mobile']);
  //   					redirect("reset");
  //   				} else {
  //   					$data['alert'] = 1;
  //   				}
  //   		}
  //
  //
  // }

    public function check_user() {

        if(!empty($_SESSION[CUSTOMER])) {
            echo json_encode(array("valid"=>1));
        } else {
            echo json_encode(array("valid"=>0));
        }

    }



    public function addtocollection() {
      $id = $this->input->post("id");

      if(!empty($_SESSION[CUSTOMER])) {
        $row = $this->db->where(array("portfolio_id" => $id, "user_id" =>$_SESSION[CUSTOMER]['id']))->get("img_collection")->row_array();
        if(empty($row)) {
          $pr = $this->db->where(array("id" => $id,))->get("artist_portfolio")->row_array();
          if($pr['artist_id']) {
              $post['code'] = $this->db->select('code')->where("id", $pr['artist_id'])->get("artist")->row()->code;
          } elseif($pr['studio_id']) {
              $post['code'] = $this->db->select('code')->where("id", $pr['studio_id'])->get("studios")->row()->code;
          }

          $post['portfolio_id'] = $id;
          $post['user_id'] = $_SESSION[CUSTOMER]['id'];
          $this->db->insert("img_collection", $post);
            
          if($this->db->insert_id()) {
            echo json_encode(array("status"=>1));
          }
        } else {
          echo json_encode(array("status"=>2));

        }

      }

    }


    public function subscribe() {

     $email = $this->input->post('email');

        if( $email ) {
            $row = $this->db->where("email", $email)->get('subscribe')->num_rows();
            if(!$row) {
                $this->db->insert("subscribe", array("email"=>$email));
                echo json_encode(array("status" => 1));
            } else {
                echo json_encode(array("status" => 2));
            }
        }
    }

    public function pay_by_pw () {

    if(!empty($_SESSION[USER])) {

        $pay = $this->security->xss_clean($this->input->post("payble"));
        $amt = $_SESSION['pay']['amt'];

        $pw_amt = $this->db->select("pedia_wallet")->where("id", $_SESSION[USER]['id'])->get("artist")->row()->pedia_wallet;

        if($pay > 0) {

          if(empty($_SESSION['wlt'])) {
            if($amt > $pw_amt)  {
                $pwamt = $amt-$pw_amt;
                $_SESSION['pw']['payble'] = $pwamt;
                $_SESSION['pw']['redeem'] = ceil($pw_amt);
                $_SESSION['pay']['payble'] = $pwamt+$_SESSION['pay']['tax'];
            } elseif($amt <= $pw_amt) {
                $_SESSION['pw']['payble'] = $_SESSION['pay']['tax'];
                $_SESSION['pw']['redeem'] = $amt;
                $_SESSION['pay']['payble'] = $_SESSION['pay']['tax'];
            }
          } else {
            $amt = $_SESSION['pay']['payble'];
            if($amt > $pw_amt)  {
                $pwamt = $amt-$pw_amt;
                $_SESSION['pw']['payble'] = $pwamt;
                $_SESSION['pw']['redeem'] = ceil($pw_amt);
                $_SESSION['pay']['payble'] = $pwamt;
            } elseif($amt <= $pw_amt) {
                $_SESSION['pw']['payble'] = 0;
                $_SESSION['pw']['redeem'] = $amt;
                $_SESSION['pay']['payble'] = 0;
            }
          }
        } else {
          unset($_SESSION['wlt']);
          unset($_SESSION['pay']);
          unset($_SESSION['pw']);
        }
        echo json_encode(array("status"=>1));
        } else {
         echo json_encode(array("status"=>0));
        }

    }

    public function pay_by_wallet () {

    if(!empty($_SESSION[USER])) {
        $pay = $this->security->xss_clean($this->input->post("payble"));
        $amt = $_SESSION['pay']['payble'];
        $wlt_amt = $this->db->select("wallet")->where("id", $_SESSION[USER]['id'])->get("artist")->row()->wallet;

        if($pay > 0) {
          if($amt > $wlt_amt)  {
              $wamt = $amt-$wlt_amt;;
              $_SESSION['wlt']['payble'] = $wamt;
              $_SESSION['wlt']['redeem'] = ceil($wlt_amt);
              $_SESSION['pay']['payble'] = $wamt;
          } elseif($amt <= $wlt_amt) {
              $_SESSION['wlt']['payble'] = 0;
              $_SESSION['wlt']['redeem'] = $amt;
              $_SESSION['pay']['payble'] = 0;
          }
        } else {
            unset($_SESSION['wlt']);
            unset($_SESSION['pay']);
            unset($_SESSION['pw']);
        }
        echo json_encode(array("status"=>1));
        } else {
         echo json_encode(array("status"=>0));
        }

    }

    public function del_offer() {
        $act = $this->input->post("act");
        if($act == "artist") {
           $this->db->where("id", $_SESSION[USER]['id'])->update("artist", array("artist_offer"=>"" ));
        } elseif($act == "studio") {
          $this->db->where("id", $_SESSION[STUDIO]['id'])->update("studios", array("studio_offer"=>"" ));
        } elseif( $act == "school") {
          $this->db->where("id", $_SESSION[SCHOOL]['id'])->update("school", array("offer"=>"" ));
        }

    }


	public function complete_appointment() {


		$id = $this->input->post("app_id");

		$row = $this->db->where(["id"=> $id, "status"=>0])->get("appointment")->row_array();
        $cus = $this->db->select("fname, mobile, email")->where("id", $row['user_id'])->get("customer")->row();

		if(!empty($row)) {

		    if(!empty($_SESSION[USER])) {

			    if($row['artist_id'] == $_SESSION[USER]['id']) {
				    $this->db->where("id", $row['id'])->update("appointment", array("status"=>1));

            if($row['cpn_type'] != 1) {
                
                // update_cash_wallet($id, 1);
                // update_pedia_wallet($id, 1);
                // debit_commisson([
                //   'uid' => $row['artist_id'],
                //   'app_id' => $row['id'],
                //   'app_code' => $row['app_id'],
                //   'amount' => $row['pay_amt']
                // ]);
                // $coin = $this->db->select("amount")->where("app_id", $id)->get('pedia_wallet_log')->row()->amount;
                // $this->mail_model->artistPWCreditMail([
                //   "coin" => $coin,
                //   "for" => "Online Appointment Booking",
                //   "email" => $_SESSION[USER]['email']
                // ]);
                
            }
            send_sms([
              "msg" => 'Artist '.$_SESSION[USER]['fname'].' has completed your tattoo. Thankyou for choosing The TattooPedia ',
              "mobile" => $cus->mobile
            ]);
            $this->mail_model->artistAppCompleteMail([
              "name" => $cus->fname,
              "arname" =>$_SESSION[USER]['fname'],
              "date" => date("d M Y", strtotime($row['app_date'])),
              "email" => $cus->email
            ]);
            set_notification([
              "user_type" => 1,
              "user_id" => $_SESSION[USER]['id'],
              "message" => "Congratulations! You have completed tattoo appointment for date ".date("d M Y", strtotime($row['app_date'])),
              "noti_type" => 1
            ]);
            
            setActivityLog([
              "act_desc" => "Appointment ".$row['app_id'].' Completed by Artist',
              "type" => 1
            ]);
            
            setUserNotification([
                "user_id" => $row['user_id'],
                "title" => 'Appointment Completed!',
                "noti_desc" => "Your Appointment #".$row['app_id']." Completed by Artist",
                "type" => 1
                ]);
                
            echo json_encode(array("status"=>1));
			    }

			} else {
			    echo json_encode(array("status"=>0));
			}
		} else {
		    echo json_encode(array("status"=>0));
		}

	}

	public function cancel_appointment() {

		$id = $this->input->post("app_id");
    $utype = $this->input->post("utype");
    $msg = $this->input->post("msg");

		$row = $this->db->where("id", $id)->get("appointment")->row_array();
    $cus = $this->db->select("fname, mobile, email")->where("id", $row['user_id'])->get("customer")->row();
    $usr = $this->db->select("fname, mobile, email")->where("id", $row['artist_id'])->get("artist")->row();

		$post = [
    		    "status" => 2,
    		    "remark" => $msg
    		    ];

		if(!empty($row)) {

      if(strlen($msg)) {
		    if(!empty($_SESSION[USER])) {

			    if($row['artist_id'] == $_SESSION[USER]['id']) {
			        $post['cancel_by'] = $utype;
				    $this->db->where("id", $row['id'])->update("appointment", $post);

            update_cash_wallet($id, 2);
            update_pedia_wallet($id, 2);

            send_sms([
              "msg" => 'Artist '.$usr->fname.' has cancelled tattoo appointment for date '.date("d M Y", strtotime($row['app_date'])).'. The TattooPedia',
              "mobile" => $cus->mobile
            ]);
            
            setActivityLog([
              "act_desc" => "Appointment ".$row['app_id'].' Cancelled by Artist',
              "type" => 2
            ]);
            
           
            
            $this->mail_model->artistAppCancelMail([
              "name" => $cus->fname,
              "arname" => $usr->fname,
              "date" => date("d M Y", strtotime($row['app_date'])),
              "email" => $cus->email
            ]);

            $this->mail_model->artistAppCancelMail2([
              "name" => $usr->fname,
              "date" => date("d M Y", strtotime($row['app_date'])),
              "email" => $usr->email
            ]);
            set_notification([
              "user_type" => 1,
              "user_id" => $_SESSION[USER]['id'],
              "message" => "Attention! You appointment with ". $cus->fname ." for date " . $cus->fname . " has cancelled",
              "noti_type" => 2
            ]);
            
              setUserNotification([
                "user_id" => $row['user_id'],
                "title" => 'Appointment Cancelled!',
                "noti_desc" => "Your Appointment #".$row['app_id']." Cancelled by Artist",
                "type" => 2
                ]);
                
				    echo json_encode(array("status"=>1));
			    }

			} elseif(!empty($_SESSION[CUSTOMER])) {

			    if( $row['user_id'] == $_SESSION[CUSTOMER]['id'] ) {
		        $post['cancel_by'] = $utype;
			    $this->db->where("id", $row['id'])->update("appointment", $post);
                
                  setActivityLog([
                    "act_desc" => "Appointment ".$row['app_id'].' Cancelled by Customer',
                    "type" => 2
                  ]);
                // update_cash_wallet($id, 2);
            // update_pedia_wallet($id, 2);
            $this->mail_model->userAppCancelMail([
              "name" => $usr->fname,
              "date" => date("d M Y", strtotime($row['app_date'])),
              "email" => $usr->email
            ]);
            
              setUserNotification([
                "user_id" => $row['user_id'],
                "title" => 'Appointment Cancelled!',
                "noti_desc" => "Your Appointment #".$row['app_id']." Cancelled.",
                "type" => 2
                ]);
				    echo json_encode(array("status"=>1));
			    }
			}
    } else {
       echo json_encode(array("status"=>0));
    }

		} else {
		    echo json_encode(array("status"=>0));
		}

	}

 public function set_quiz_time() {
     $time = $this->input->post("time");
     echo $_SESSION['qz_time'] = $time;
 }


 public function cancel_order() {

    $str = $this->input->post('str');
    $post = explode( '|', base64_decode( $str ) );

    $ord = $this->db->where("id", $post[2])->get('shop_order_products')->row_array();
    
    $this->db->select("ord.order_id, st.store_name as name, st.owner_id, st.owner_type");
    $this->db->from("store st, shop_orders ord");
    $this->db->where('ord.id', $ord['order_id']);
    $this->db->where('st.id', $ord['shop_id']);
    $row = $this->db->get()->row_array();
    
    if(!empty($row)) {
      if($row['owner_type'] == 1) {
          $usr = $this->db->select("email, mobile")->where("id", $row['owner_id'])->get("artist")->row();
      } else {
          $usr = $this->db->select("email, mobile")->where("id", $row['owner_id'])->get("customer")->row();
      }
      
    if( !empty($_SESSION[USER]) || !empty($_SESSION[CUSTOMER]) ) {
       $this->db->where("id", $post[2])->update("shop_order_products",
         [
           'status' => 4,
           'cancel_status' => 1,
           'cancel_reason' => $post[1],
           'cancel_by' => 1
         ]
       );

       $this->db->insert("shop_order_log", [
         "order_id" => $ord['order_id'],
         "product_id" => $ord['product_id'],
         "ord_pr_id" => $ord['id'],
         "status" => 4
       ]);

        
        SELLER__orderCancelledByBuyer_mail([
         'name' => $row['name'],
         'order_id' => $row['order_id'],
         'cancel_reason' => $post[1],
         'email' => $usr->email
       ]);

       SELLER_orderCancelleldByBuyer_sms([
         'order_id' => $row['order_id'],
         'cancel_reason' => $post[1],
         'mobile' => $usr->mobile
       ]);

       Buyer_orderCancelledByBuyer_sms([
         'order_id' => $row['order_id'],
         'mobile' => $_SESSION[CUSTOMER]['mobile']
       ]);

       BUYER__orderCancelledByBuyer_mail([
         'name' => $_SESSION[CUSTOMER]['fname'],
         'order_id' => $row['order_id'],
         'cancel_reason' => $post[1],
         'email' => $_SESSION[CUSTOMER]['email']
       ]);
       
       setActivityLog([
                "act_desc" => "Order #".$row['order_id'].' Cancelled by Customer',
                "type" => 2
              ]);
        
         setUserNotification([
            "user_id" => $row['user_id'],
            "title" => 'Order Cancelled!',
            "noti_desc" => "Your Order #".$row['order_id']." Cancelled.",
            "type" => 2
            ]);
            
	    setShopNotification([
            'shop_id' => $ord['shop_id'],
            "title" => 'Order #'.$row['order_id'].' Cancelled.',
            "noti_desc" => "Order #".$row['order_id'] ." has been cancelled by user",
            "type" => 2
        ]);
                
       echo json_encode(['status' => 1]);
    }
    
    }
 }

 public function order_filtr() {
 	$act = $this->input->post('act');
 	$src = $this->input->post('src');

 	if($act == 'order') {
 		$_SESSION['user-ord_src'] = $src;
 		echo json_encode(['status' => 1]);
 	}

 }


public function get_cities() {
    $cn = $this->input->post('cn_id');

    $qry = $this->db->query("SELECT GROUP_CONCAT(id) as states from adv_state st WHERE st.country_id='".$cn."'");
    $sts = $qry->row_array();
    $states = explode(',', $sts['states']);


      $data = $this->db->select('id, city')->where_in("state_id" , $states)->order_by('city', 'asc')->get('city')->result_array();
      echo json_encode(['status' => 1, 'data' => $data]);
 

}

public function blog_like() {
    
    $bid = $this->input->post('blog_id');
    
    $usr = getCurrentUser();
    
    $row = $this->db->where([
            'user_id' => $usr['uid'],
            'user_type' => $usr['type'],
            'blog_id' => $bid
            ])->get('blog_like')->num_rows();
        
        if($row == 0) {
            
            $this->db->insert('blog_like', [
                        'user_id' => $usr['uid'],
                        'user_type' => $usr['type'],
                        'blog_id' => $bid
                    ]);
        // setActivityLog([
        //     "act_desc" => "Order #".$row['order_id'].' Cancelled by Customer',
        //     "type" => 2
        //   ]);
            echo json_encode(['status' => 1]);
             
        } else {
            
           echo json_encode(['status' => 0]);
        }
}

}
