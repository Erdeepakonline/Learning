	<?php

class giftcard extends controller {

	function __construct(){

		parent::__construct();

		$this->email = new email();

		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

	}

	public function index(){

		if(empty($_SESSION[USER])):
			header("location:".PATH."login/buyer");
			$_SESSION["link_back"] = 'giftcard';
		endif;

		$post = $this->post();

		if(!empty($post)) :

			$post['user_id'] = $_SESSION[USER]['id'];
			$post['gift_code'] = $this->giftcode();
			$post['expiry'] = date("Y-m-d", strtotime("+6 month"));

			if($_SESSION[USER]['role']=='us') :
				$post['role'] = 1;
			else:
				$post['role'] = 2;
			endif;

			$_SESSION["tg_gift"] = $post;
			header("location:".PATH."giftcard/payment");

		endif;


 	 tamplate("head","");
 	 tamplate("header",$this->cats);
	 echo '<br /><br /><br />';
 	 tamplate("giftcard",$data);
	 echo '<br /><br /><br />';
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

	 unset($_SESSION["link_back"]);

  	}

		public function success() {
			tamplate("head","");
			tamplate("header",$this->cats);
			echo '<br /><br /><br />';
			tamplate("giftcard-success",$data);
			echo '<br /><br /><br />';
			tamplate("footer-top",$this->foot);
			tamplate("footer",'');
		}


		public function giftcode() {

			$today = date("ymd");
			$rand = strtoupper(substr(uniqid(sha1(time())),0,4));
			$unique_order_number  = "TG".$today . $rand;

				$ord = 	$this->fetch("tbl_giftcards","gift_code='$unique_order_number'");

					if(empty($ord)) :
						return $unique_order_number;
					else:
						$id = $this->giftcode();
						return $id;
					endif;

		}


		public function payment()
		{

			if(empty($_SESSION[USER])) :
				header("location:".PATH.'login/buyer');
			endif;

			$uid = $_SESSION[USER]['id'];

			$qr = $this->db->query("SELECT
						tbl_address.*,
						tbl_city.city,
						tbl_state.state,
						tbl_country.country_name as country
						FROM tbl_address, tbl_city, tbl_state, tbl_country
						WHERE tbl_address.user_id='$uid'
						AND tbl_address.user_type='1'
						AND tbl_city.id=tbl_address.city
						AND tbl_state.id=tbl_address.state
						AND tbl_country.id=tbl_address.country ");
			$user = $qr->fetch(PDO::FETCH_ASSOC);

			include("helper/Crypto.php");

			$tid = str_shuffle(date('ynj').time());

			$_SESSION['gft_num'] = "GFT".time();

			// $opt['data'] = $_SESSION['addr'];

			$opt['data']['tid'] = $tid;
			$opt['data']['merchant_id'] = '11755';
			$opt['data']['order_id'] = "TG".time(	);
			$opt['data']['amount'] = $_SESSION['tg_gift']['amount'];
			$opt['data']['currency'] = strtoupper($_SESSION['curr']);
			$opt['data']['redirect_url'] = 'http://www.tattoogizmo.com/newtattoo/giftcard/payback';
			$opt['data']['cancel_url'] = 'http://www.tattoogizmo.com/newtattoo/giftcard/payback';
			$opt['data']['language'] = 'ENG';
			// $opt['data']['integration_type'] = 'iframe_normal';

			$opt['working_key'] = '67AC4E3B6C0C7A44B4E7A0185BD63082';
			$opt['access_code'] = 'JW2AZYOXTUUKDKU2';

			// Billing Details //
			$opt['data']['billing_name'] = $_SESSION[USER]['fname'];
			$opt['data']['billing_address'] = $user['address'];
			$opt['data']['billing_city'] = $user['city'];
			$opt['data']['billing_state'] = $user['state'];
			$opt['data']['billing_zip'] = $user['post_code'];
			$opt['data']['billing_country'] = $user['country'];
			$opt['data']['billing_tel'] = $user['mobile'];
			$opt['data']['billing_email'] = $_SESSION[USER]['email'];;

			$opt['data']['delivery_name'] = $_SESSION[USER]['fname'];
			$opt['data']['delivery_address'] = $user['address'];
			$opt['data']['delivery_city'] = $user['city'];
			$opt['data']['delivery_state'] = $user['state'];
			$opt['data']['delivery_zip'] = $user['post_code'];
			$opt['data']['delivery_country'] = $user['country'];
			$opt['data']['delivery_tel'] = $user['mobile'];
			// $opt['data']['delivery_email'] = $user['email'];

			// print_r($opt);
			$cook = encode_arr($_SESSION);
			setcookie('tgses', $cook, time()+3600);
			tamplate("ccavpay",$opt);

		}

		public function payback() {

					include("helper/Crypto.php");

					$workingKey='67AC4E3B6C0C7A44B4E7A0185BD63082';		//Working Key should be provided here.
					$encResponse=$_POST["encResp"];			//This is the response sent by the CCAvenue Server
					$rcvdString=decrypt($encResponse,$workingKey);

					$arr = explode('&',$rcvdString);

						foreach ($arr as $key => $val) {

							$str = explode("=",$val);
							$res[$str[0]] = $str[1];

						}

						// print_r($res);
					$_SESSION = decode_arr($_COOKIE['tgses']);

					if($res['order_status'] == 'Success') :

								// $_SESSION['pay_status'] = 1;
								// $_SESSION['pay_methode'] = 1;
								// $_SESSION['ref_no'] = $res['tracking_id'];
								// header("location:".PATH.'checkout/process/');
								// $db_ar["user_id"];

								$post = $_SESSION["tg_gift"];
								$post['pay_status'] = 1;
								$post['pay_methode'] = 1;
								$post['ref_no'] = $res['tracking_id'];

								$last_id = $this->insert("tbl_giftcards",$post);

									if($last_id>0) :

										$arr = array(
											"giftcode" =>$post['gift_code'],
											"price" => $post['amount'],
											"from" => $_SESSION[USER]['fname'].' '.$_SESSION[USER]['lname'],
											"to"	=> $post['cust_name'],
											"expiry" => date("d M Y",strtotime($post['expiry']))
										);

										$etemp = $this->lib->loadEmailTemp("theme/giftcard-email.php",$arr);
										$email['to'] = $_SESSION[USER]['email'];
										$email['from'] = "gift@tattoogizmo.com";
										$email['sub'] = "E-GIFT CARD | TATTOOGIZMO.COM";
										$email['msg'] = $etemp;
										$this->email->sgmail($email);

										header("location:".PATH."giftcard/success");
									endif;

					else :

								// $this->update("tbl_order", array("pay_status"=>2, "ref_no"=>$res['tracking_id']), $res["merchant_param1"]);
								header("location:".PATH.'checkout/pay_error');

					endif;

		}

}
