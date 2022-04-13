<?php

class dashboard extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
	}


 public function index(){

	 $data['new_order'] = $this->numRows("tbl_order","status='0'");
	 $data['tot_order'] = $this->tblRows("tbl_order");
	 $data['buyer'] = $this->tblRows("tbl_buyer");
	 $data['distributor'] = $this->tblRows("tbl_distributor");

	 $data['orders'] = $this->fetchAll("tbl_order",array("act"=>"id>0 and trash='0'","order"=>"id desc", "limit"=>10));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("dashboard",$data,true);
	 tamplate("footer","",true);
 }


}
