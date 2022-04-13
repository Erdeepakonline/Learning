<?php

class register extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		if(!empty($_SESSION[USER])):
			$this->go_back();
		endif;
	}

	public function index(){
		$this->error_404();
	}

 public function buyer(){

	 $data['country'] = $this->fetchAll("tbl_country",array("act"=>"status='1'"));

	 $post = $this->post();

		 if(!empty($post)):

			 $email = trim($post['email']);
			 $mobile = trim($post['mobile']);

				$res = $this->numRows("tbl_buyer","email='$email'");
				$mob = $this->numRows("tbl_buyer","mobile='$mobile'");

			 if($res>0) :
				 $data['alert'] = '<div class="alert alert-danger"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Sorry ! this email already exists.</div>';
			 elseif($mob>0) :
				 $data['alert'] = '<div class="alert alert-danger"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Sorry ! this mobile number already exists.</div>';
			 else :
						$id = $this->insert("tbl_buyer",$post);

					 //========	Address Data snmp_set_enum_print	==========//

						if($id>0) :

									$adr = array(
										"user_id"=>$id,
										"user_type"=>1,
										"type"=>1,
										"name"=>$post['fname'] . ' ' . $post['lname'],
										"mobile" => $post['mobile'],
										"address" => $post['address'],
										"landmark" => '',
										"city" => $post['city'],
										"state" => $post['state'],
										"country" => $post['country'],
										"post_code" => $post['post_code'],
									);

									$this->insert("tbl_address",$adr);
									$adr['type'] = 2;
									$this->insert("tbl_address",$adr);

									$_SESSION['uid'] = $id;
									$_SESSION['mobile'] = $post['mobile'];
									$_SESSION['role'] = "us";
									$_SESSION['otp'] = $this->lib->sendOTP($post['mobile']);
									header("location:".PATH."verification/");

							endif;
					//  $data['alert'] = '<div class="msg-alert-success"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Thank You! You are registered successfully.</div>';

			 endif;


		 endif;

	$data['reg'] = $post;

	$meta['title'] = "Buyer Registeration | Tattoogizmo.com";
	$meta['keyword'] = '';
	$meta['desc'] = "Buyer Registeration  | Tattoogizmo.com";

	 tamplate("head",$meta);
	 tamplate("header",$this->cats);
	 tamplate("buy-register",$data);
	 tamplate("footer-top",$this->foot);
	 tamplate("footer",'');

 	}


/*
	-------		Distributor Registration	-----
*/

	public function distributor(){

 	 $data['country'] = $this->fetchAll("tbl_country",array("act"=>"status='1'"));

	 	$post = $this->post();

			if(!empty($post)):

				$email = $post['email'];
				$res = $this->numRows("tbl_distributor","email='$email'");

				if($res>0) :

					  $data['alert'] = '<div class="msg-alert-danger"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Sorry ! this email already exists.</div>';
				else :
						$id = $this->insert("tbl_distributor",$post);

							//========	Address Data snmp_set_enum_print	==========//
							if($id>0) :

										$adr = array(
											"user_id"=>$id,
											"user_type"=>2,
											"type"=>1,
											"name"=>$post['fname'] . ' ' . $post['lname'],
											"mobile" => $post['mobile'],
											"address" => $post['address'],
											"landmark" => $post['landmark'],
											"city" => $post['city'],
											"state" => $post['state'],
											"country" => $post['country'],
											"post_code" => $post['post_code'],
										);

										$this->insert("tbl_address",$adr);
										$adr['type'] = 2;
										$this->insert("tbl_address",$adr);

										$_SESSION['uid'] = $id;
										$_SESSION['mobile'] = $post['mobile'];
										$_SESSION['role'] = "ds";
										$_SESSION['otp'] = $this->lib->sendOTP($post['mobile']);
										header("location:".PATH."verification/");

								endif;

						// $data['alert'] = '<div class="msg-alert-success"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Thank You! You are registered successfully.</div>';
				endif;


			endif;

			$meta['title'] = "Distributor Registeration | Tattoogizmo.com";
		 	$meta['keyword'] = '';
		 	$meta['desc'] = "Distributor Registeration  | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
 	 tamplate("dist-register",$data);
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}


		public function success() {

			$meta['title'] = "Buyer Registeration | Tattoogizmo.com";
			$meta['keyword'] = '';
			$meta['desc'] = "Buyer Registeration  | Tattoogizmo.com";

			tamplate("head",$meta);
			tamplate("header",$this->cats);
			tamplate("verify-success",$data);
			tamplate("footer-top",$this->foot);
			tamplate("footer",'');
		}

}
