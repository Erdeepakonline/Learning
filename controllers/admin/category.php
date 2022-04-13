<?php

class category extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'catalog',
	 	'pg' => 'category'
		);
	}


	 public function index(){

		 $rows =  $this->tblRows('tbl_category');
		 $pg_num = ceil($rows/20);
		 $paging['rows'] = $pg_num;
		 $paging['page'] = 1;
		 $paging['link'] = 'page';

	 $cat = $this->fetchAll("tbl_category",array("act"=>"id>0","order"=>"sort_order asc","limit"=>20));

	 	foreach($cat as $key=> $val):

			if($val['parent'] != 0):

			$par = $this->fetch("tbl_category","id='$val[parent]'");
			$val['parent'] = 'Home &nbsp;<i class="fa fa-angle-double-right"></i> &nbsp;'.$par['category'];
			else:
			$val['parent'] = 'Home';
			endif;
			$res[] = $val;
		endforeach;

		$data['cat'] = $res;
		$data['cats'] = $this->lib->getCats();
		$data['status'] = 2;
		$data['pg'] = $paging;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("category/view",$data,true);
	 tamplate("footer",'',true);


 }



 	 public function page( $prm ){

	 $pg = $prm[0];
	 $page = $pg;
	 if($pg == NULL) { $pg = 0; $page = 1; } else { $pg--; }

	 $lim = 20;
	 $rows =  $this->tblRows('tbl_category');
	 $pg_num = ceil($rows/$lim);
	 $start_pg = $lim*$pg;

	 $paging['rows'] = $pg_num;
	 $paging['page'] = $page;
	 $paging['link'] = 'page';
	 $paging['srl'] = $start_pg;

 	 $cat = $this->fetchAll("tbl_category",array("act"=>"id>0","order"=>"sort_order asc",  'limit'=>$start_pg .', '. $lim));

 	 	foreach($cat as $key=> $val):

			if($val['parent'] != 0) :

 			$par = $this->fetch("tbl_category","id='$val[parent]'");
 			$val['parent'] = 'Home &nbsp;<i class="fa fa-angle-double-right"></i> &nbsp;'.$par['category'];
 			else:
 			$val['parent'] = 'Home';
 			endif;
 			$res[] = $val;
 		endforeach;

		$data['cat'] = $res;
	  $data['cats'] = $this->lib->getCats();
	  $data['status'] = 2;
	  $data['pg'] = $paging;

 	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav",$this->ntab,true);
 	 tamplate("top-bar","",true);
 	 tamplate("category/view",$data,true);
 	 tamplate("footer",'',true);


  }

 public function add(){

	 $data = $this->post();

	 $order = $this->tblRows("tbl_category");

	 if(!empty($data)) {

		if(strlen($_FILES['imgfile']['name'])>0):
	 	$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/category",800,true);
		$this->createThumb("category",$img,"80","70");

		$data['image'] = $img;
		endif;

		//$data['slug'] = strtolower(str_replace(' ','_',$data['category']));
		//$data['sort_order'] = $order;

		$sql = $this->db->query("SELECT MAX(sort_order) AS num	FROM tbl_category");
		$sort = $sql->fetch(PDO::FETCH_ASSOC);

	 $post['sort_order'] = $sort['num'];

		$cat['alert'] = $this->insert("tbl_category",$data);

	 }

	 $cat['cat'] = $this->lib->getCats();

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("category/add",$cat,true);
	 tamplate("footer",$alert,true);


 }




 public function edit($url){

	 $id = $url[0];

	 $data = $this->post();

		if(strlen($_FILES['imgfile']['name'])>0):

	 		$img = $this->imgUpload($_FILES['imgfile']['tmp_name'],$_FILES['imgfile'],"data-img/category",800,true);		$this->createThumb("category",$img,"80","70");
			$data['image'] = $img;
			endif;


	 if(!empty($data)) {


		$this->update("tbl_category",$data,$id);
		$alert = 1;
	 }

	 $edata = $this->fetch("tbl_category","id='$id'");
	 $edata['alert'] = $alert;
	 $edata["cat"] = $cat['cat'] = $this->lib->getCats();

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("category/add",$edata,true);
	 tamplate("footer",'',true);


 }



}
