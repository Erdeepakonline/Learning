<?php

class contact extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
		$this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");
	}

	public function index(){
		$post = $this->post();

		if(!empty($post)) :
			$data['alert'] = $this->insert("tbl_contact",$post);
		endif;

	 $meta['title'] = "Contact | Tattoogizmo.com";
 	 $meta['keyword'] = '';
 	 $meta['desc'] = "Contact | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br /><br /><br />';
 	 tamplate("contact",$data);
	 echo '<br /><br /><br />';
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}



}
