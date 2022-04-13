<?php

class employee extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'member',
	 	'pg' => 'employee'
		);
	}


	 public function index(){

	 $data['emps'] = $this->fetchAll("tbl_employee",array("act"=>"id>0","order"=>"id desc"));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("employee/view",$data,true);
	 tamplate("footer",'',true);

 }


 public function add(){

	 $data = $this->post();

	 if(!empty($data)) {
			$cat['alert'] = $this->insert("tbl_employee",$data);
			// $alert = 1;
	 }

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("employee/add",$cat,true);
	 tamplate("footer",$alert,true);


 }



 public function edit($url){

	 $id = $url[0];

	 $data = $this->post();

	 if(!empty($data)) {
		$this->update("tbl_employee",$data,$id);
		$alert = 1;
	 }

	 $edata = $this->fetch("tbl_employee","id='$id'");
	 $edata['alert'] = $alert;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("employee/add",$edata,true);
	 tamplate("footer",'',true);


 }



}
