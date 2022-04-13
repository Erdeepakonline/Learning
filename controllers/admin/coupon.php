<?php

class coupon extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index(){


	 	$data['cpn'] = $this->fetchAll("tbl_coupon",array('act'=>"id>0",'order'=>"id asc"));

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("coupon/view",$data,true);
		 tamplate("footer",$alert,true);


 }


 public function add(){

	 	$post = $this->post();

		if(!empty($post)) :
			$data['alert'] = $this->insert("tbl_coupon",$post);
		endif;

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("coupon/add",$data,true);
		tamplate("footer",$alert,true);


}


public function edit($param){

	 $id = $param[0];
	 $post = $this->post();

	 if(!empty($post)) :
		 $this->update("tbl_coupon",$post,$id);
		 $alt = 1;
	 endif;

	 $data = $this->fetch("tbl_coupon","id='$id'");
	 $data['alert'] =  $alt;
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("coupon/add",$data,true);
	 tamplate("footer",$alert,true);


}


}
