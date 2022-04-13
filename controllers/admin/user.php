<?php

class user extends controller {
	function __construct(){
		
		parent::__construct(); 	
	
		$this->chkAdmin();
	}
	
	
	
	 public function index(){
	
	 $data['user'] = $this->fetchAll("tbl_user",array("act"=>"id>0"));
	 
	 	tamplate("head","",true);
	 	tamplate("header","",true);
	 	tamplate("left-nav","",true);
	 	tamplate("user-view",$data,true);
	 	tamplate("footer",'',true);
	 
 	}
	
	public function details($url){
	
	$id = $url[0];
	
	$data['user'] = $this->fetch("tbl_user","id='$id'");
	$state = $this->fetch('tbl_state',"id='".$data['user']['state']."'");
	$city = $this->fetch('tbl_district',"id='".$data['user']['city']."'");	
	$bar = $this->fetch('tbl_statebar',"id='".$data['user']['state_bar']."'");
	$law = $this->fetch('tbl_law_areas',"id='".$data['user']['law_area']."'");
	
		$data['user']['city'] = $city['district'];
		$data['user']['state'] = $state['state'];
		$data['user']['state_bar'] = $bar['title'];
		$data['user']['law_area'] = $law['title'];
		
		tamplate("head","",true);
	 	tamplate("header","",true);
	 	tamplate("left-nav","",true);
	 	tamplate("user-details",$data,true);
	 	tamplate("footer",'',true);
		
			
	}
}