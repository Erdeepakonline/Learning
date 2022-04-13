<?php

class taxes extends controller {

	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}


  public function index(){

		$post = $this->post('data');

		if(!empty($post)) {
			$alert = $this->insert("tbl_taxes", $post);
		}

		$data['taxes'] = $this->fetchAll("tbl_taxes", array("act"=>"id>0", "order"=>"tax asc"));

	  tamplate("head","",true);
	  tamplate("header","",true);
	  tamplate("left-nav","",true);
	  tamplate("top-bar","",true);
	  tamplate("taxes/add",$data,true);
	  tamplate("footer",'',true);

 }

public function edit ($prm) {

	$id = $prm[0];
	$post = $this->post('data');

	if(!empty($post)) {
		$alert = $this->update("tbl_taxes", $post, $id);
		$alert = 1;
	}

	$data['taxes'] = $this->fetchAll("tbl_taxes", array("act"=>"id>0", "order"=>"tax asc"));
	$data['alert'] = $alert;
	$data['info'] = $this->fetch("tbl_taxes","id='$id'");
	
	tamplate("head","",true);
	tamplate("header","",true);
	tamplate("left-nav","",true);
	tamplate("top-bar","",true);
	tamplate("taxes/add",$data,true);
	tamplate("footer",'',true);


}



}
