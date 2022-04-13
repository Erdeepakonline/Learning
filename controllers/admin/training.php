<?php

class training extends controller {

	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {

		$data['tcs'] = $this->fetchAll("tbl_training",array("act"=>"id>0",'order'=>'id desc'));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("training/view",$data,true);
 	 tamplate("footer",$alert,true);

	}

	public function add(){

		$post = $this->post();

			if(!empty($post)) :
				$data['alert'] = $this->insert('tbl_training',$post);
			endif;

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("training/add",$data,true);
 	 tamplate("footer",'',true);

	}



 public function edit($prm){
	 $id = $prm[0];

	 $post = $this->post();

		if(!empty($post)) :
			$this->update("tbl_training",$post,$id);
			$alert =1;
		endif;

	 $data = $this->fetch("tbl_training","id='$id'");
	 $data['alert'] = $alert;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("training/add",$data,true);
	 tamplate("footer",'',true);


 }



}
