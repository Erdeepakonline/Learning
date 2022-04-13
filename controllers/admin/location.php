<?php

class location extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function country(){


	$data['country'] = $this->fetchAll("tbl_country",array('act'=>"id>0",'order'=>"id asc"));

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav","",true);
		 tamplate("top-bar","",true);
		 tamplate("location/country",$data,true);
		 tamplate("footer",$alert,true);


 	}

 	public function state($url){

		$id = $url[0];
		$data['country'] = $this->fetch("tbl_country","id='$id'");
		$data['state'] = $this->fetchAll("tbl_state",array("act"=>"country_id='$id'",'order'=>'state asc'));

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("location/state",$data,true);
		tamplate("footer",$alert,true);
	}

	public function city($url){

		$cid = $url[0];
		$id = $url[1];

		$data['country'] = $this->fetch("tbl_country","id='$cid'");
		$data['state'] = $this->fetch("tbl_state","id='$id'");
		$data['city'] = $this->fetchAll("tbl_city",array("act"=>"state_id='$id'",'order'=>'city asc'));

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("location/city",$data,true);
		tamplate("footer",$alert,true);
	}



}
