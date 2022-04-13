<?php

class forget extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		if(empty($_SESSION[USER])):
			header("location".PATH);
		endif;
	}


	public function index() {

		$post = $this->post();

			if(!empty($post)) :

				$mob = $this->numRows("tbl_buyer","mobile='$post[mobile]'");
				if($mob == 0) {
					$mob = $this->numRows("tbl_distributor","mobile='$post[mobile]'");
				}

				if($mob>0){
					$_SESSION['mobile'] = $post['mobile'];
					$_SESSION['otp'] = $this->lib->sendOTP($post['mobile']);
					header("location:".PATH."forget/password");
				} else {
					$data['error'] = 1;
				}

			endif;

			$meta['title'] = "Forget Password | Tattoogizmo.com";
			$meta['keyword'] = '';
			$meta['desc'] = "Forget Password | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		tamplate("forget-pass",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	public function password() {

		$post = $this->post();
		$otp = $_SESSION['otp'];
		$mob = $_SESSION['mobile'];

		$usr = $this->fetch("tbl_buyer","mobile='$mob'");
		if(empty($usr)) :
			$usr = $this->fetch("tbl_distributor","mobile='$mob'");
			$role = 2;
		endif;

			if(!empty($post)) :
				if($otp == $post['otp']) {
					if($role==2) :
						$this->update("tbl_distributor",array('password' =>$post['password']),$usr['id']);
					else :
						$this->update("tbl_buyer",array('password' =>$post['password']),$usr['id']);
					endif;
					header("location:".PATH."forget/success");
				}
			endif;

			$meta['title'] = "Forget Password | Tattoogizmo.com";
			$meta['keyword'] = '';
			$meta['desc'] = "Forget Password | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		tamplate("reset-pass",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	public function resend_otp() {
		$_SESSION['otp'] = $this->lib->sendOTP($_SESSION['mobile']);
		header("location:".PATH."forget/password");
	}


	public function success() {

		$meta['title'] = "Forget Password | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Forget Password | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		tamplate("forget-success",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}

}
