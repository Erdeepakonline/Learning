<?php

class wishlist extends controller {

	function __construct() {

		parent::__construct();

		$this->cats['cats'] = $this->lib->getCats();
		$this->brand = $this->fetchAll("tbl_brand",array('act' => 'status=1' ));

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

	}

	public function index(){
		// print_r($_SESSION['tg_cart']);
		if($_SESSION[USER]['role'] == 'us') {
			$type = 1;
		}else {
			$type = 2;
		}

		$uid = $_SESSION[USER]['id'];

		// $q = $this->db->query("SELECT ")
		$data['wish'] = $this->fetchAll("tbl_wishlist",array("act"=>"user_id='$uid' and user_type='$type'","order"=>'id desc'));

		tamplate("head","");
		tamplate("header",$hd);
		echo '<br><br><br>';
		tamplate("wishlist",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}


}
