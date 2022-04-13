<?php

class city extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}



 public function index(){

	 $post = $this->post();

	 	if(!empty($post)) :
			$post['slug'] = str_replace(' ','-',strtolower(trim($post['name'])));
			$data['alert'] = $this->insert("tbl_cities",$post);
		endif;

		$data['city'] = $this->fetchAll("tbl_cities",array('act'=>"id>0"));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("city/add",$data,true);
	 tamplate("footer",'',true);


 }



 public function edit($url){

	 $id = $url[0];
	 $post = $this->post();

	 	if(!empty($post)) :
			$post['slug'] = str_replace(' ','-',strtolower(trim($post['name'])));
			$this->update("tbl_cities",$post,$id);
			$alt = 1;
		endif;

	 $data = $this->fetch('tbl_cities',"id='$id'");
	 $data['city'] = $this->fetchAll("tbl_cities",array('act'=>"id>0"));
	 $data['alert'] = $alt;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("city/add",$data,true);
	 tamplate("footer",'',true);


 }



}
