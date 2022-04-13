<?php

class giftcards extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {

		$data["gifts"] = $this->fetchAll("tbl_giftcards",array("act"=>"id>0"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("giftcard/view",$data,true);
 	 tamplate("footer",$alert,true);

	}


}
