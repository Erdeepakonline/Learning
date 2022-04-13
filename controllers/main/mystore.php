<?php

class mystore extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();
		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
		$this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");
	}

	public function index(){

		$q = $this->db->query("SELECT city FROM tbl_store ORDER BY city ASC");
	 	$city = $q->fetchAll(PDO::FETCH_COLUMN);
		// print_r($city);
		// $data['cities'] = $city;
		$data['cities'] = array_unique($city);

 	 tamplate("head","");
 	 tamplate("header",$this->cats);
	 echo '<br/><br/><br/>';
 	 tamplate("store",$data);
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}



}
