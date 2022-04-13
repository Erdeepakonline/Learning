<?php

class brand extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index(){

		$post = $this->post();

			if(!empty($post)):

					if(strlen($_FILES['imgfile']['name'])>0):

						$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/brand",800,true);
						$this->createThumb("brand",$img,130,120);
						$post['image'] = $img;

					endif;
					$post['slug'] = str_replace(' ', '-', trim(strtolower($post['name'])));
					$edata[alert] = $this->insert("tbl_brand",$post);

			endif;

			$edata['brand'] = $this->fetchAll("tbl_brand",array('act' => "id>0", 'order'=>'id desc'));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("brand/add",$edata,true);
	 tamplate("footer",'',true);


 }


 public function edit($url){

	 $id = $url[0];
	 $post = $this->post();

		 if(!empty($post)):

				 if(strlen($_FILES['imgfile']['name'])>0):

					 $img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/brand",800,true);
					 $this->createThumb("brand",$img,130,120);
					 $post['image'] = $img;

				 endif;

				 $post['slug'] = str_replace(' ', '-', trim(strtolower($post['name'])));

			 $this->update("tbl_brand",$post,$id);
			 $edata[alert] = 1;

		 endif;

		 $edata['info'] = $this->fetch("tbl_brand","id='$id'");

		 $edata['brand'] = $this->fetchAll("tbl_brand",array('act' => "id>0", 'order'=>'id desc'));

	tamplate("head","",true);
	tamplate("header","",true);
	tamplate("left-nav","",true);
	tamplate("top-bar","",true);
	tamplate("brand/add",$edata,true);
	tamplate("footer",'',true);


}



}
