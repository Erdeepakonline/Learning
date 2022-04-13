<?php

class settings extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}


	 public function index(){

		 $post = $this->post();

		 if(!empty($post)) :
			 $this->update('tbl_admin',$post,1);
		 endif;
	 $data['edata'] = $this->fetch("tbl_admin","id>0");

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("setting/add",$data,true);
	 tamplate("footer",'',true);


 }



}
