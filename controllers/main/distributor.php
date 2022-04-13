<?php

class distributor extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();
		$this->id = $_SESSION[USER]['id'];

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		if($_SESSION[USER]['role'] != 'ds'):
			header("location:" . PATH . 'login/distributor/');
		endif;

	}

	public function index(){
		$this->error_404();
	}

 public function profile(){

	 //===========	Profile Information		=============//

	 $data = $this->fetch("tbl_distributor","id='$this->id'");

	 $con = $this->fetch("tbl_country","id='$data[country]'");
	 $sts = $this->fetch("tbl_state","id='$data[state]'");
	 $cit = $this->fetch("tbl_city","id='$data[city]'");

	 $data['country']	= $con['country_name'];
	 $data['state']	=	$sts['state'];
	 $data['city']	= $cit['city'];


	 //==========		Billing Information 	==============//

	 $bill = $this->fetch("tbl_address","user_id='$this->id' and type='1'");

	 $con = $this->fetch("tbl_country","id='$bill[country]'");
	 $sts = $this->fetch("tbl_state","id='$bill[state]'");
	 $cit = $this->fetch("tbl_city","id='$bill[city]'");

	 $bill['country']	= $con['country_name'];
	 $bill['state']	=	$sts['state'];
	 $bill['city']	= $cit['city'];


	 //==========		Shipping Information 	==============//

	$ship = $this->fetch("tbl_address","user_id='$this->id' and type='2'");

	$con = $this->fetch("tbl_country","id='$ship[country]'");
	$sts = $this->fetch("tbl_state","id='$ship[state]'");
	$cit = $this->fetch("tbl_city","id='$ship[city]'");

	$ship['country']	= $con['country_name'];
	$ship['state']	=	$sts['state'];
	$ship['city']	= $cit['city'];

	//-----------------------------------------------------------//

		$data['bill'] = $bill; $data['ship'] = $ship;
		$data['role']	= "distributor";

	 tamplate("head","");
 	 tamplate("header",$this->cats);
 	 echo '<br><br><br>';
	 tamplate("left-nav",'');
 	 tamplate("profile",$data);
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}

		public function edit_profile(){

			$post = $this->post();

				if(!empty($post)):
						$this->update("tbl_distributor",$post,$this->id);
						$alert = '<div class="msg-alert-success"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Your profile updated successfully.</div><br>';
				endif;


			$data = $this->fetch("tbl_distributor","id='$this->id'");
			$data['alert'] = $alert;
			$data['cont'] = $this->fetchAll("tbl_country", array("act"=>"status ='1'"));
			$data['sts'] = $this->fetchAll("tbl_state", array("act"=>"status ='1' and country_id='$data[country]'"));
			$data['cty'] = $this->fetchAll("tbl_city", array("act"=>"status ='1' and state_id='$data[state]'"));
			$data['role'] = "distributor";

			tamplate("head","");
			tamplate("header",$this->cats);
			echo '<br><br><br>';
			tamplate("left-nav",'');
			tamplate("edit-profile",$data);
			tamplate("footer-top",'');
			tamplate("footer",$this->foot);
		}


	public function edit_address($param) {

		$id = $param[0];

		$post = $this->post();

			if(!empty($post)):
					$this->update("tbl_address",$post,$id);
					$alert = '<div class="msg-alert-success"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Your address updated successfully.</div><br>';
			endif;

		$data = $this->fetch("tbl_address","id='$id'");
		$data['alert'] = $alert;

		$data['role'] = "distributor";
		$data['cont'] = $this->fetchAll("tbl_country", array("act"=>"status ='1'"));
		$data['sts'] = $this->fetchAll("tbl_state", array("act"=>"status ='1' and country_id='$data[country]'"));
		$data['cty'] = $this->fetchAll("tbl_city", array("act"=>"status ='1' and state_id='$data[state]'"));

		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("left-nav",'');
		tamplate("edit-address",$data);
		tamplate("footer-top",'');
		tamplate("footer",$this->foot);
	}


/*
*=======================================
*		Password Change Function
*======================================
*/

	public function change_password(){

		$id = $_SESSION[USER]['id'];
		$udata = $this->fetch("tbl_distributor","id='$id'");

		$post = $this->post();

			if(!empty($post)) :

				extract($post);

				if($old_pass == $udata['password']) :

					$this->update('tbl_distributor',array("password"=>$new_pass),$id);
					$alert = '<div class="alert alert-success"><i class="fa fa-check-circle fa-lg"></i> &nbsp; Your password changed successfully.</div><br>';

				else:
					$alert = '<div class="alert alert-danger"><i class="fa fa-times-circle fa-lg"></i> &nbsp; Sorry your old password not matched.</div><br>';

				endif;

			endif;

			$data['alert'] = $alert;

		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("left-nav",'');
		tamplate("change-pass",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}


	/*
	*=======================================
	*		Order View Function
	*======================================
	*/
	public function orders(){

		$uid = $_SESSION[USER]['id'];

		$ord = $this->fetchAll("tbl_order",array("act"=>"user_id='$uid'","order"=>"id desc"));

		foreach ($ord as $key => $val) {

			$ship = $this->fetch("tbl_order_address","order_id='$val[id]' and type=2");
			$city = $this->fetch("tbl_city","id='$ship[city]'");
			$state = $this->fetch("tbl_state","id='$ship[state]'");

			$val['ship'] = $ship;
			$val['city'] = $city['city'];
			$val['state'] = $state['state'];

			$res[] = $val;
		}

	$data['ord'] = $res;

	// print_r($_SESSION);

		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("left-nav",'');
		tamplate("order",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}


	public function order_view($prm) {
		$code = $prm[0];
		$data = $this->fetch("tbl_order","code='$code'");
		$data['product'] = $this->fetchAll("tbl_order_product",array("act" => "order_id='$data[id]'"));
		// print_r($data);
		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("left-nav",'');
		tamplate("order-view",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}
	/*
	*=======================================
	*		Wishlist Function
	*======================================
	*/
	public function wishlist(){

		tamplate("head","");
		tamplate("header",$this->cats);
	 	echo '<br><br><br>';
		tamplate("left-nav",'');
		tamplate("wishlist",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}

}
