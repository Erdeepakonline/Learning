<?php

class complain extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {

		$qr = $this->db->query("SELECT tbl_complain.*, tbl_brand.name as brand_name FROM tbl_complain, tbl_brand WHERE tbl_complain.brand=tbl_brand.id ORDER BY id DESC LIMIT 25");
		$data['repaire'] = $qr->fetchAll(PDO::FETCH_ASSOC);
		// $data['repaire'] = $this->fetchAll("tbl_repairs",array("act"=>"id>0","order"=>"id desc"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("complain/view",$data,true);
 	 tamplate("footer",$alert,true);

	}

	public function details( $prm ) {

		$id = $prm[0];
		$data = $this->fetch("tbl_complain", "id='$id'");
		$cs = $this->fetch("tbl_buyer", "id='".$data['id']."'");
		$br = $this->fetch("tbl_brand", "id='".$data['brand']."'");

		$data['email'] = $cs['email'];
		$data['mobile'] = $cs['mobile'];
		$data['brand_name'] = $br['name'];
		// print_r($data);

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("complain/add",$data,true);
		tamplate("footer",$alert,true);
	}



}
