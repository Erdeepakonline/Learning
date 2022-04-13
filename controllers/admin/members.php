<?php

class members extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index(){

		$this->error_404();
	}


 public function buyer(){

	 	$data['user'] = $this->fetchAll("tbl_buyer",array('act'=>"id>0",'order'=>"id desc"));

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("members/by_view",$data,true);
		 tamplate("footer",$alert,true);


 }

 public function dist(){

	 $data['dist'] = $this->fetchAll("tbl_distributor",array('act'=>"id>0",'order'=>"id desc"));

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("members/wh_view",$data,true);
		tamplate("footer",$alert,true);
 }

}
