<?php

class career extends controller {

	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}


  public function index(){

	  $data['car'] = $this->fetchAll("tbl_career",array("act"=>"id>0","order"=>"id desc"));

	  tamplate("head","",true);
	  tamplate("header","",true);
	  tamplate("left-nav","",true);
	  tamplate("top-bar","",true);
	  tamplate("career/view",$data,true);
	  tamplate("footer",'',true);

 }



	 public function add(){

		 $post = $this->post();

		 		if(!empty($post)):

					$data['alert'] = $this->insert("tbl_career",$post);

				endif;



		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("career/add",$data,true);
		 tamplate("footer",'',true);


		}




		public function edit($url){

			$id = $url[0];

			$post = $this->post();

				if(!empty($post)):
					$this->update("tbl_career",$post,$id);
				endif;

			$data['info'] = $this->fetch("tbl_career","id='$id'");

		 tamplate("head","",true);
 		 tamplate("header","",true);
 		 tamplate("left-nav","",true);
 		 tamplate("top-bar","",true);
 		 tamplate("career/add",$data,true);
 		 tamplate("footer",'',true);

	}




}
