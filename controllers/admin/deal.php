<?php

class deal extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {
		$data['deal'] = $this->fetchAll("tbl_deal",array("act"=>"id>0"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("deal/view",$data,true);
 	 tamplate("footer",$alert,true);

	}

 public function add(){

	 $data = $this->post();

	 $order = $this->tblRows("tbl_deal");

	 if(!empty($data)) {

		if(strlen($_FILES['imgfile']['name'])>0):
	 	$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/deals/",800,true);
		$this->createThumb("deals",$img,"60","60");

		$data['image'] = $img;
		endif;

		$data['sort_order'] = $order+1;
		$ban['alert'] = $this->insert("tbl_deal",$data);

	 }

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("deal/add",$ban,true);
	 tamplate("footer",$alert,true);

 }


 public function edit($url){

	 $id = $url[0];

	 $data = $this->post();

		if(strlen($_FILES['imgfile']['name'])>0):

	 		$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/deals",800,true);
			$this->createThumb("deals",$img,"60","60");
			$data['image'] = $img;
			endif;


	 if(!empty($data)) {
		$this->update("tbl_deal",$data,$id);
		$alert = 1;

	 }

	 $edata = $this->fetch("tbl_deal","id='$id'");
	 $edata['alert'] = $alert;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("deal/add",$edata,true);
	 tamplate("footer",'',true);


 }



}
