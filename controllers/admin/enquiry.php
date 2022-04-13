<?php

class enquiry extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
	}



	 public function index(){

		 $data['encs'] = $this->fetchAll("tbl_enquiry",array("act"=>"id>0"));

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("enquiry/view",$data,true);
		 tamplate("footer",'',true);
	}

}
