<?php

class page extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}


  public function index(){

  $data['page'] = $this->fetchAll("tbl_page",array("act"=>"id>0","order"=>"id desc"));

  tamplate("head","",true);
  tamplate("header","",true);
  tamplate("left-nav","",true);
  tamplate("top-bar","",true);
  tamplate("page/view",$data,true);
  tamplate("footer",'',true);


 }

	 public function add(){

		 $post = $this->post();

		 		if(!empty($post)):

					$data['alert'] = $this->insert("tbl_page",$post);

				endif;

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("page/add",$data,true);
		 tamplate("footer",'',true);


		}

		public function edit($url){

			$id = $url[0];

			$post = $this->post();

				if(!empty($post)):
					$this->update("tbl_page",$post,$id);
				endif;
				
			$data['info'] = $this->fetch("tbl_page","id='$id'");


		 tamplate("head","",true);
 		 tamplate("header","",true);
 		 tamplate("left-nav","",true);
 		 tamplate("top-bar","",true);
 		 tamplate("page/add",$data,true);
 		 tamplate("footer",'',true);

	}


}
