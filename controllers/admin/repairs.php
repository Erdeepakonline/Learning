<?php

class repairs extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {

		$qr = $this->db->query("SELECT tbl_repairs.*, tbl_brand.name as brand_name FROM tbl_repairs, tbl_brand WHERE tbl_repairs.brand=tbl_brand.id ORDER BY id DESC LIMIT 25");
		$data['repaire'] = $qr->fetchAll(PDO::FETCH_ASSOC);
		// $data['repaire'] = $this->fetchAll("tbl_repairs",array("act"=>"id>0","order"=>"id desc"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("repairs/view",$data,true);
 	 tamplate("footer",$alert,true);

	}


}
