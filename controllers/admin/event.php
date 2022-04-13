<?php

class event extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {
		$data['eve'] = $this->fetchAll("tbl_events",array("act"=>"id>0"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("event/view",$data,true);
 	 tamplate("footer",$alert,true);

	}




 public function edit($url){

	 $id = $url[0];

	 $data = $this->post();

		if(strlen($_FILES['imgfile']['name'])>0):

	 		$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/event",800,true);
			$this->createThumb("event",$img,"60","60");
			$data['image'] = $img;
			endif;


	 if(!empty($data)) {
		$this->update("tbl_events",$data,$id);
		$alert = 1;
	 }

	 $edata = $this->fetch("tbl_events","id='$id'");
	 $edata['alert'] = $alert;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("event/add",$edata,true);
	 tamplate("footer",'',true);


 }



}
