<?php

class banner extends controller {
	function __construct(){
	
		parent::__construct(); 
		
		$this->chkAdmin();	
		
	}
	
	
	/* public function index(){
	
	 $cat = $this->fetchAll("tbl_category",array("act"=>"id>0","order"=>"id desc"));
	 
	 	foreach($cat as $key=> $val):
			
			if($val['parent'] != 0):
			
			$par = $this->fetch("tbl_category","id='$val[parent]'");
			$val['parent'] = 'Home &nbsp;<i class="fa fa-angle-double-right"></i> &nbsp;'.$par['category'];
			else:
			$val['parent'] = 'Home';
			endif;
			$data['cat'][] = $val;
		
		endforeach;
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("banner/view",$data,true);
	 tamplate("footer",'',true);
	 
	 
 }*/
 
 
 public function index(){
	
	 $data = $this->post();
	 
	 $order = $this->tblRows("tbl_banner");
	 
	 if(!empty($data)) {
	 
		if(strlen($_FILES['imgfile']['name'])>0):
	 	$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/banner",800,true);
		$this->createThumb("banner",$img,"80","70");
				
		$data['image'] = $img;
		endif;		
		
		$data['sort_order'] = $order+1;
	
		$ban['alert'] = $this->insert("tbl_banner",$data);
		
	 }
	 
	 $ban['banner'] = $this->fetchAll("tbl_banner",array("act"=>"id>0","order"=>"id desc"));
	 
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("banner/add",$ban,true);
	 tamplate("footer",$alert,true);
	 
	 
 }
 

 
 
 public function edit($url){
	
	 $id = $url[0];
	 
	 $data = $this->post();
	 	
		if(strlen($_FILES['imgfile']['name'])>0):
		
	 		$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/banner",800,true);		
			$this->createThumb("banner",$img,"80","70");
			$data['image'] = $img;
			endif;
	 
	 
	 if(!empty($data)) {
	 
	 	
		$this->update("tbl_banner",$data,$id);
		
		$alert = 1;
	 }
	 
	 $edata = $this->fetch("tbl_banner","id='$id'");
	 $edata['alert'] = $alert;
	  
	 $edata['banner'] = $this->fetchAll("tbl_banner",array("act"=>"id>0","order"=>"id desc"));
	 
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("banner/add",$edata,true);
	 tamplate("footer",'',true);
	 
	 
 }
 
 
	
}