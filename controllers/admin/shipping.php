<?php

class shipping extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}

	public function index(){

		$post = $this->post();

			if(!empty($post)):
				$data['alert'] = $this->insert("tbl_shipping",$post);
			endif;

			$data['shipp'] = $this->fetchAll("tbl_shipping",array('act'=>"id>0"));

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("shipping/add",$data,true);
		tamplate("footer",$alert,true);
	}

	public function edit($prm){

		$id = $prm[0];

		$post = $this->post();

			if(!empty($post)):
					$this->update("tbl_shipping",$post,$id);
					$data['alert'] = 1;
			endif;

			$data['edata'] = $this->fetch("tbl_shipping","id='$id'");
			$data['shipp'] = $this->fetchAll("tbl_shipping",array('act'=>"id>0"));
			$data['edt'] = 1;

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("shipping/add",$data,true);
		tamplate("footer",$alert,true);
	}
}
