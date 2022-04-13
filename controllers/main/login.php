<?php

class login extends controller {

	function __construct(){

		parent::__construct();

		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		if(!empty($_SESSION[USER])) { header("location:".PATH); }

	}

	public function index(){
		$this->error_404();
	}

 public function buyer(){

	 $post = $this->post('login');

	 	if(!empty($post)) :

			extract($post);

			$data['username'] = $username;

			if(is_numeric($username)) :
				$udata = $this->fetch("tbl_buyer","mobile='$username'");
			else :
				$udata = $this->fetch("tbl_buyer","email='$username'");
			endif;

				if(!empty($udata)) :

					if($udata['status'] == 1) {

						if($password == $udata['password']) {

							if($udata['verified'] == 1) :

									$_SESSION[USER]['id'] = $udata['id'];
									$_SESSION[USER]['email'] = $udata['email'];
									$_SESSION[USER]['fname'] = $udata['fname'];
									$_SESSION[USER]['lname'] = $udata['lname'];
									$_SESSION[USER]['mobile'] = $udata['mobile'];
									$_SESSION[USER]['role'] = 'us';

									if($_SESSION['link_back'] == NULL) :
										header("location:".PATH . 'buyer/profile/');
									else:
										header("location:".PATH . $_SESSION['link_back']);
									endif;

								else:

										$_SESSION['uid'] = $udata['id'];
										$_SESSION['role'] = 'us';
										$_SESSION['mobile'] = $udata['mobile'];

										$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Your account is not verified. <a href="'.PATH.'verification/resend_otp" style="color:#A94442;"><u><b>Click Here</b></u></a> to verify it.</div><br>';

								endif;

							} else {
								$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! your email or password does not matched.</div><br>';
							}

						} else {
								$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! your account temporary blocked. Please contact admin.</div><br>';
					}

				else:
					$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! this email is not registered with us.</div><br>';

				endif;

		endif;

		$meta['title'] = "Buyer Login | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Buyer Login | Tattoogizmo.com";

	 tamplate("head",$meta);
	 tamplate("header",$this->cats);
	 echo '<br><br><br>';
	 tamplate("login",$data);
	 echo '<br><br>';
	 tamplate("footer-top",$this->foot);
	 tamplate("footer",'');

 	}

	public function distributor(){

		$post = $this->post('login');

 	 	if(!empty($post)) :
 			extract($post);

 			$data['email'] = $email;

 			$udata = $this->fetch("tbl_distributor","email='$email'");

 				if(!empty($udata)) :

					if($udata['status'] == 1) :

		 					if($password == $udata['password']) :

								if($udata['verified'] == 1) :

									$_SESSION[USER]['id'] = $udata['id'];
		 							$_SESSION[USER]['email'] = $udata['email'];
		 							$_SESSION[USER]['fname'] = $udata['fname'];
		 							$_SESSION[USER]['lname'] = $udata['lname'];
									$_SESSION[USER]['mobile'] = $udata['mobile'];

									$_SESSION[USER]['role'] = 'ds';

									if($_SESSION['link_back'] == NULL) :
		 								header("location:".PATH . 'distributor/profile/');
									else:
										header("location:".PATH . $_SESSION['link_back']);
									endif;

								else:

									$_SESSION['uid'] = $udata['id'];
									$_SESSION['role'] = 'ds';
									$_SESSION['mobile'] = $udata['mobile'];

										$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Your account is not verified. <a href="'.PATH.'verification/resend_otp" style="color:#A94442;"><u><b>Click Here</b></u></a> to verify it.</div><br>';

								endif;

							else:
		 						$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! your email or password does not matched.</div><br>';

		 					endif;

					else:
							$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! your account temporary blocked. Please contact admin.</div><br>';

					endif;

 			else:
 					$data['alert'] = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry ! this email is not registered with us.</div><br>';

 			endif;

 	endif;

	 $data['pg'] = "ds";

	 $meta['title'] = "Distributor Login | Tattoogizmo.com";
	 $meta['keyword'] = '';
	 $meta['desc'] = "Distributor Login | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br><br><br>';
 	 tamplate("login",$data);
	 echo '<br><br>';
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}



}
