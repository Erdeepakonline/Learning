<?php

class store extends controller {

	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index() {

		// $q = $this->db->query("SELECT tbl_store.*, tbl_cities.name as city FROM tbl_store, tbl_cities WHERE tbl_cities.id=tbl_store.city");
		$data['store'] = $this->fetchAll("tbl_store",array("act"=>"id>0"));
		// print_r($data)
	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("store/view",$data,true);
 	 tamplate("footer",$alert,true);

	}

	public function add(){

		$post = $this->post();

			if(!empty($post)) :
				$data['alert'] = $this->insert('tbl_store',$post);
			endif;

		$data['cty'] = $this->fetchAll('tbl_cities', array("act"=>"status=1"));

	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav","",true);
 	 tamplate("top-bar","",true);
 	 tamplate("store/add",$data,true);
 	 tamplate("footer",'',true);

	}



 public function edit($prm){
	 $id = $prm[0];

	 $post = $this->post();

		if(!empty($post)) :
			$this->update("tbl_store",$post,$id);
			$alert =1;
		endif;

	 $data = $this->fetch("tbl_store","id='$id'");
	 $data['alert'] = $alert;
	 $data['cty'] = $this->fetchAll('tbl_cities', array("act"=>"status=1"));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("store/add",$data,true);
	 tamplate("footer",'',true);


 }



}
