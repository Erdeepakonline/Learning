<?php

class returns extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();
		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
		$this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");
	}

	public function index(){

		$meta['title'] = "Return & Exchange Policy | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Return & Exchange Policy  | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br/><br/>';
 	 tamplate("return",$data);
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}



}
