<?php

class verification extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		if(!empty($_SESSION[USER])):
			$this->go_back();
		endif;
	}

	public function index() {
		$uid = $_SESSION['uid'];
		$mob = $_SESSION['mobile'];
		$otp = $_SESSION['otp'];

		$post = $this->post("chk");
			if(!empty($post)) :
				if($otp == $post['otp']) :
					if($_SESSION['role']=='us') :
						$this->update("tbl_buyer",array("verified"=>1),$uid);
					else :
						$this->update("tbl_distributor",array("verified"=>1),$uid);
					endif;

					header("location:".PATH."register/success");
				else:
					$data['error'] = 1;
				endif;
			endif;

		tamplate("head","");
		tamplate("header",$this->cats);
		tamplate("verify-otp",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}



	public function resend_otp() {
		$_SESSION['otp'] = $this->lib->sendOTP($_SESSION['mobile']);
		header("location:".PATH."verification/");
	}


	public function success() {
		tamplate("head","");
		tamplate("header",$this->cats);
		tamplate("verify-success",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}

}
