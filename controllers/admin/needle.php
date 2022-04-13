<?php

class needle extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'catalog',
	 	'pg' => 'needle'
		);
	}


	 public function index(){

		 $post = $this->post();

		 if(!empty($post)) :

			 $arr = array('name' => $post['needle'] );
			 $data["alert"] = $this->insert("tbl_needle_type",$arr);

		 endif;

		 $data['needle'] = $this->fetchAll("tbl_needle_type",array("act"=>"id>0", 'order'=>'id desc'));

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav",$this->ntab,true);
		 tamplate("top-bar","",true);
		 tamplate("needle/add",$data,true);
		 tamplate("footer",'',true);


 }

 public function edit($url){

	 $id = $url[0];

	 $post = $this->post();

	 if(!empty($post)) :

		  $arr = array('name' => $post['needle'] );
			$this->update("tbl_needle_type",$arr,$id);

			$data["alert"] = 1;

		endif;

		 $data['info'] = $this->fetch("tbl_needle_type","id='$id'");
		 $data['needle'] = $this->fetchAll("tbl_needle_type",array("act"=>"id>0", 'order'=>'id desc'));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("needle/add",$data,true);
	 tamplate("footer",'',true);


 }



}
