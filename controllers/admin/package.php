<?php

class package extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'package',
	 	'pg' => 'package'
		);
	}


	 public function index(){

	 $data['package'] = $this->fetchAll("tbl_package",array("act"=>"id>0"));

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("package/view",$data,true);
	 tamplate("footer",'',true);


 }


 public function add(){

	$post = $this->post();
	$prd = $this->post('prd');

	$data['cat'] = $this->lib->getCats();
	$data['info'] = $this->fetch("tbl_product","id='$id'");



	if(!empty($post)):

		$post['product'] = implode(",",$prd);
		$data['alert'] = $this->insert("tbl_package",$post);

	endif;


	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("package/rel",$data,true);
	 tamplate("footer",'',true);

 }




 public function edit($url){

	 $id = $url[0];

	 $post = $this->post();
	 $prd = $this->post('prd');


	 if(!empty($post)):

		 $post['product'] = implode(",",$prd);
		 $this->update("tbl_package",$post,$id);
		 $alert = 1;
	 endif;

	 $data = $this->fetch("tbl_package","id='$id'");

	 $p_arr = explode(",",$data['product']);

	 	foreach ($p_arr as $key => $val) {

			$q = $this->db->query("SELECT product_name, product_code,category FROM tbl_product WHERE id='$val'");
			$r = $q->fetch(PDO::FETCH_ASSOC);

			$q2 = $this->db->query("SELECT category as cat FROM tbl_category WHERE id='$r[category]'");
			$r2 = $q2->fetch(PDO::FETCH_ASSOC);

			$r['category'] = $r2['cat'];
			$r['pid'] = $val;

			$res[] = $r;
 	 	}

		$data['products'] = $res;
		$data['alert'] = $alert;
		$data['cat'] = $this->lib->getCats();
		// $data['info'] = $this->fetch("tbl_product","id='$id'");

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("package/rel",$data,true);
	 tamplate("footer",'',true);


 }



}
