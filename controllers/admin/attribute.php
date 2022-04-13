<?php

class attribute extends controller {
	function __construct(){
	
		parent::__construct(); 
		
		$this->chkAdmin();	
		
		$this->ntab = array (
		"nav" =>'catalog',
	 	'pg' => 'attribute'
		);
	}
	
	
	 public function index(){
	
	 $data['atr'] = $this->fetchAll("tbl_attribute",array("act"=>"id>0","order"=>"id desc"));
	 
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("attribute/view",$data,true);
	 tamplate("footer",'',true);
	 
	 
 }
 
 
 public function add(){
	
	 $post = $this->post();
	 $vals = $this->post('atrval');
	 
	 
	 
	 if(!empty($post)) {
	 
		$id = $this->insert("tbl_attribute",$post);
		
		if($id>0):
		
			foreach($vals as $key=> $val):
				
				$arr = array(
				"attribute_id" => $id,
				"name" => $val
				);
				
				$this->insert("tbl_attribute_value",$arr);
			
			endforeach;
			
		endif;
		
	 }
	 
	 $alert['alert'] = $id;
	  
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("attribute/add",$alert,true);
	 tamplate("footer",'',true);
	 
	 
 }
 

 
 
 public function edit($url){
	
	 $id = $url[0];
	 
	 $post = $this->post();
	 $vals = $this->post('atrval');
	  	
	 if(!empty($post)) {
	 
		$this->update("tbl_attribute",$post,$id);
			
		if(!empty($vals)):
		
			foreach($vals as $key=> $val):
				
				$arr = array(
				"attribute_id" => $id,
				"name" => $val
				);
				
				$this->insert("tbl_attribute_value",$arr);
			
			endforeach;
		
		endif;
		
		$edata["alert"] = 1;
	 }
	 
	 $edata['info'] = $this->fetch("tbl_attribute","id='$id'");
	 $edata["vals"] = $this->fetchAll("tbl_attribute_value",array("act"=>"attribute_id='$id'"));
	  
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("attribute/add",$edata,true);
	 tamplate("footer",'',true);
	 
	 
 }
 
 
	
}