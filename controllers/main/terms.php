<?php

class terms extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();
		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
		$this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");
	}

	public function index(){

		$meta['title'] = "Terms & Conditions  | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Terms & Conditions  | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br/><br/>';
 	 tamplate("terms",$data);
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}



}
