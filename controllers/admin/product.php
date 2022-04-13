<?php

class product extends controller {

	function __construct() {

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'catalog',
	 	'pg' => 'product'
		);

	}


	 public function index(){

		 unset($_SESSION['scr']);

		 $rows =  $this->tblRows('tbl_product');
		 $pg_num = ceil($rows/20);
		 $paging['rows'] = $pg_num;
		 $paging['page'] = 1;
		 $paging['link'] = 'page';


	 	$prod = $this->fetchAll("tbl_product",array("act"=>"id>0","order"=>"id desc",'limit'=>20));

	 	foreach($prod as $key=> $val):

			$cat = $this->fetch("tbl_category","id='$val[category]'");
			$val['category'] = $cat['category'];
			$res[] = $val;

		endforeach;

	 $data['prods'] = $res;
	 $data['cats'] = $this->lib->getCats();
	 $data['status'] = 2;
	 $data['pg'] = $paging;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("product/view",$data,true);
	 tamplate("footer",'',true);


 }






 public function page($prm){

	$pg = $prm[0];
	$page = $pg;
	if($pg == NULL) { $pg = 0; $page = 1; } else { $pg--; }

	$lim = 20;
	$rows =  $this->tblRows('tbl_product');
	$pg_num = ceil($rows/$lim);
	$start_pg = $lim*$pg;

	$paging['rows'] = $pg_num;
	$paging['page'] = $page;
	$paging['link'] = 'page';
	$paging['srl'] = $start_pg;

 	$prod = $this->fetchAll("tbl_product",array("act"=>"id>0","order"=>"id desc",'limit'=>$start_pg .', '. $lim));

	foreach($prod as $key=> $val):

		$cat = $this->fetch("tbl_category","id='$val[category]'");

		$val['category'] = $cat['category'];

		$res[] = $val;

	endforeach;

 $data['prods'] = $res;
 $data['cats'] = $this->lib->getCats();
 $data['status'] = 2;
 $data['pg'] = $paging;

 tamplate("head","",true);
 tamplate("header","",true);
 tamplate("left-nav",$this->ntab,true);
 tamplate("top-bar","",true);
 tamplate("product/view",$data,true);
 tamplate("footer",'',true);


}

/*
*
*	-------------		Add Product Function : Start	------------------*
*
*/

 public function add(){

	 $post = $this->post();
	 $cap = $this->post('cap');
	 $needle = $this->post('ndl');
	 $cts = $this->post('cat');

	 if(!empty($post)) {
		$post['cats'] = implode(',',$cts);
	 	$id = $this->insert("tbl_product",$post);
		$co = count($_FILES['imgfile']['name']);

			if($post['type'] == 1):
				$this->insert("tbl_combination",array("product_id"=>$id));
			endif;

		if($co>0):

			$co--;
			for($i=0; $i<=$co; $i++):

			$img = $this->imgUpload($_FILES['imgfile']['tmp_name'][$i],$_FILES['imgfile']['name'][$i],"data-img/product",2000,true);
			$this->createThumb("product",$img,'80','70');
			$this->createThumb2("../theme/data-img/product/","../theme/data-img/product/medium/",$img,'350','370');

			$arr = array(
			"product_id" => $id,
			"image" => $img,
			"caption" => $cap[$i]
			);

			$this->insert("tbl_image",$arr);

			endfor;

		endif;


		//===================  Color Images Upload : Start  ===================//

		$cl = count($_FILES['colimg']['name']);
		$colr = $this->post('color');

		if($cl>0):

			$cl--;
			for($j=0; $j<=$cl; $j++):

				$img2 = $this->imgUpload($_FILES['colimg']['tmp_name'][$j],$_FILES['colimg']['name'][$j],"data-img/product/color",2000,true);
				$this->createThumb("product/color",$img2,'80','70');

			$arr = array(
			"product_id" => $id,
			"image" => $img2,
			"name" => $colr[$j]
			);

			$this->insert("tbl_color_image",$arr);

			endfor;

		endif;

		//=================  Color Images Upload : End  ==================//

		$data['alert'] = $id;

	 }


	 //=================  Needle Add Function : Start 	==============//

	 if($post['type'] == 3):

		 if(!empty($needle)):

			$ndl = implode(",",$needle);
			$this->update("tbl_product",array("needle_type"=>$ndl),$id);

		 endif;

	 endif;

	 $data['cat'] = $this->lib->getCats();
	 $data['needle'] = $this->fetchAll("tbl_needle_type",array('act'=>"status='1'",'order'=>'name asc'));
	 $data['brand'] = $this->fetchAll("tbl_brand",array("act"=>"status=1"));
	 $data['taxes'] = $this->fetchAll("tbl_taxes",array("act"=>"status=1"));

	 //print_r($data['needle']);

 	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("product/add",$data,true);
	 tamplate("footer",'',true);


 }

/*
+------------------------------------------------------------------
*																																	*
*				Product Edit Function : Start 														*
*-----------------------------------------------------------------*/

 public function edit($url){

	 $id = $url[0];

	 $post = $this->post();
	 $cap = $this->post('cap');
	 $cts = $this->post('cat');
	 $capupt = $this->post('capupt');
	 $imgid = $this->post('imgid');

	 $needle = $this->post('ndl');

	 // ==========  Update Function Start  ===================///

	 if(!empty($post)) {
		$post['cats'] = implode(',',$cts);
	 	$this->update("tbl_product",$post,$id);
		$data['alert'] = 1;

		//============  New Image Update Function : Start ==========//

		$co = count($_FILES['imgfile']['name']);

		if($co>0):

			$co--;
			for($i=0; $i<=$co; $i++):

			$img = $this->imgUpload($_FILES['imgfile']['tmp_name'][$i],$_FILES['imgfile']['name'][$i],"data-img/product",2000,true);
			$this->createThumb("product",$img,'80','70');
			$this->createThumb2("../theme/data-img/product/","../theme/data-img/product/medium/",$img,'350','370');

			$arr = array(
			"product_id" => $id,
			"image" => $img,
			"caption" => $cap[$i]
			);

			$this->insert("tbl_image",$arr);

			endfor;

		endif;

		//============  New Image Update Function : End =============//


		// ============== Old Image Update Function Start  ===========//

		$num = count($_FILES['imgupt']['name']);

		for($j=0; $j<=$num; $j++):

		$img2 = $this->imgUpload($_FILES['imgupt']['tmp_name'][$j],$_FILES['imgupt']['name'][$j],"data-img/product",2000,true);

			if($img2 !== 0):

			$this->createThumb("product",$img2,'80','70');
			$this->createThumb2("../theme/data-img/product/","../theme/data-img/product/medium/",$img2,'350','370');

			$arr = array(
			"product_id" => $id,
			"image" => $img2,
			"caption" => $capupt[$j]
			);

			$this->update("tbl_image",$arr,$imgid[$j]);
			endif;

		endfor;

		//=============== Old Image Update Function : End  =============//

	 }


	 	//============  New Colors Image Update Function : Start ==========//

		$cl = count($_FILES['colimg']['tmp_name']);
		$colr = $this->post('color');
		$cname = $this->post("cname");
		$colrid = $this->post("colrid");

		if($cl>0):

			$cl--;
			for($n=0; $n<=$cl; $n++):

			$img = $this->imgUpload($_FILES['colimg']['tmp_name'][$n],$_FILES['colimg']['name'][$n],"data-img/product/color",2000,true);
			$this->createThumb("product/color",$img,'80','70');

			$arr = array(
			"product_id" => $id,
			"image" => $img,
			"name" => $colr[$n]
			);

			$this->insert("tbl_color_image",$arr);

			endfor;

		endif;

		//============  New Image Update Function : End =============//


		// ============== Old Image Update Function Start  ===========//

		$num = count($_FILES['colupt']['name']);

		for($j=0; $j<=$num; $j++):

		$img2 = $this->imgUpload($_FILES['colupt']['tmp_name'][$j],$_FILES['colupt']['name'][$j],"data-img/product/color",2000,true);

			if($img2 !== 0):

			$this->createThumb("product/color",$img2,'80','70');

			$arr = array(
			"product_id" => $id,
			"image" => $img2,
			"name" => $cname[$j]
			);

			$this->update("tbl_color_image",$arr,$colrid[$j]);
			endif;

		endfor;

		//=============== Old Image Update Function : End  =============//




		//=================  Color Images Upload : End  ==================//


		//=================  Needle Add Function : Start 	==============//

 	 if($post['type'] == 3):

 		 if(!empty($needle)):

 		 	$ndl = implode(",",$needle);
 			$this->update("tbl_product",array("needle_type"=>$ndl),$id);

 		 endif;

 	 endif;


	 $data['cat'] = $this->lib->getCats();
	 $data['edata'] = $this->fetch("tbl_product","id='$id'");
	 $data['image'] = $this->fetchAll("tbl_image",array("act"=>"product_id='$id'"));
	 $data['subcat'] = $this->fetchAll("tbl_category",array("act"=>"parent='".$data['edata']['category']."' and status='1'"));

	 $data['color'] = $this->fetchAll("tbl_color_image",array("act"=>"product_id='".$data['edata']['id']."'"));
	 $data['needle'] = $this->fetchAll("tbl_needle_type",array('act'=>"status='1'",'order'=>'name asc'));
	 $data['pndl'] = explode(',',$data['edata']['needle_type']);

	 $data['brand'] = $this->fetchAll("tbl_brand",array("act"=>"status=1"));
	 $data['taxes'] = $this->fetchAll("tbl_taxes",array("act"=>"status=1"));

	 //print_r($data['subcat']);
	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("product/add",$data,true);
	 tamplate("footer",'',true);


 }


 public function relative($url){

 	$id = $url[0];

	$post = $this->post();
	$rel = $this->post('rel');

	if(!empty($rel)) :
		foreach ($rel as $key => $vl) {
		  $data['alert'] = 	$this->insert("tbl_relative",array("product_id"=>$id,"relative_id"=>$vl));
		}
	endif;

	// $imgs = $this->post('img');
	//
	$data['cat'] = $this->lib->getCats();
	// $data['info'] = $this->fetch("tbl_product","id='$id'");
	//
	// $rel = $this->fetchAll("tbl_relative",array("act"=>"product_id='$id'"));
	//
	// 	foreach($rel as $key => $val):
	//
	// 		$pdata = $this->fetch('tbl_product',"id='$val[product_id]'");
	// 		$cat = $this->fetch("tbl_category","id='$pdata[category]'");
	//
	// 	$arr[] = array(
	// 	"id" => $val['id'],
	// 	"product_code" => $pdata['product_code'],
	// 	"product_name" => $pdata['product_name'],
	// 	"category" => $cat['category'],
	// 	"product_status" => $pdata['status'],
	// 	"created" => $val['created'],
	// 	"status" => $val['status']
	// 	);
	//
	// 	endforeach;
	//
	// 	$data['rel'] = $arr;
	//=======  Function for Insert Combination : Start ==========//

	if(!empty($post)):
		extract($post);

		if($keys !=NULL) :
			$ps1 = " and product_name like '%$keys%' ";
		endif;
		if($cat !=NULL) :
			$ps2 = " and category ='$cat' ";
		endif;
		$q = 'SELECT * FROM tbl_product WHERE id>0 ' . $ps1 . $ps2;
		$res = $this->db->query($q);
		$data['prod'] = $res->fetchAll(PDO::FETCH_ASSOC);
	endif;

	$qs = $this->db->query("SELECT relative_id FROM tbl_relative WHERE product_id='$id'");
	$rid = $qs->fetchAll(PDO::FETCH_ASSOC);
	foreach ($rid as $keys => $vls) :
		$rids[] = $vls['relative_id'];
	endforeach;
	$data['rids'] = $rids;

	$q = $this->db->query("SELECT tbl_product.product_name, tbl_product.product_code, tbl_product.status AS pstatus, tbl_category.category, tbl_relative.* FROM tbl_relative, tbl_category, tbl_product WHERE tbl_relative.product_id = '$id' AND tbl_product.id = tbl_relative.relative_id AND tbl_category.id=tbl_product.category");
	$rls = $q->fetchAll(PDO::FETCH_ASSOC);
	$data['rls'] = $rls;

	// ========== Function for Insert Combination : Start ========//

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("product/rel",$data,true);
	 tamplate("footer",'',true);

 }


 public function info($url){

	$id = $url[0];

	$data = $this->fetch("tbl_product","id='$id'");
	$img = $this->fetch("tbl_image","product_id='$data[id]' and feature='1'");

	$data['image'] = $img['image'];

	$data['images'] = $this->fetchAll("tbl_image",array("act"=>"product_id='$data[id]'"));

	$data['combs'] = $this->fetchAll("tbl_combination",array("act"=>"product_id='$data[id]'"));


	$rel = $this->fetchAll("tbl_relative",array("act"=>"product_id='$data[id]'"));

		foreach($rel as $key=>$val):

			$prd = $this->fetch("tbl_product","id='$val[relative_id]'");
			$prd['rid'] = $val['id'];
			$prd['rstatus'] = $val['status'];
			$res[] = $prd;

		endforeach;
		//print_r($res);
	$data['rel'] = $res;

  	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("product/info",$data,true);
	 tamplate("footer",'',true);


 }


/*
*
*
----------------------------------------------------------
						Product Search Function
----------------------------------------------------------
*
*
*/

	public function search($prm){

		$code = $_SESSION['src']['code'];
		$cat_id = $_SESSION['src']['cat'];
		$type = $_SESSION['src']['type'];
		$sts = $_SESSION['src']['status'];



		if(strlen($code)>0) :
			$qprd = " and product_code ='$code' ";
		endif;

		if($cat_id>0):
				$qcat = " and FIND_IN_SET('$cat_id', `cats`) > 0 ";
		endif;

		if($type>0):
			$qtype = " and type= '$type' ";
		endif;

		if($sts != 2):
			$qsts = " and status= '$sts' ";
		endif;

		$pg = $prm[0];
		$page = $pg;
		if($pg == NULL) { $pg = 0; $page = 1; } else { $pg--; }

		$lim = 20;
		$rows =  $this->numRows('tbl_product','id>0 '. $qprd . $qtype . $qcat . $qsts);
		$pg_num = ceil($rows/$lim);
		$start_pg = $lim*$pg;

		$paging['rows'] = $pg_num;
		$paging['page'] = $page;
		$paging['link'] = 'search';
		$paging['srl'] = $start_pg;

		$prod = $this->fetchAll("tbl_product",array("act"=>"id>0 " . $qprd . $qcat . $qtype . $qsts,"order"=>"id desc",'limit'=>$start_pg .', '. $lim));

 	 	foreach($prod as $key=> $val):

 			$cat = $this->fetch("tbl_category","id='$val[category]'");
 			$val['category'] = $cat['category'];
 			$res[] = $val;

 		endforeach;

 	 $data['prods'] = $res;
	 $data['cats'] = $this->lib->getCats();
	 $data['cat_id']= $cat_id;
	 $data['status'] = $sts;
	 $data['pg'] = $paging;

 	 tamplate("head","",true);
 	 tamplate("header","",true);
 	 tamplate("left-nav",$this->ntab,true);
 	 tamplate("top-bar","",true);
 	 tamplate("product/view",$data,true);
 	 tamplate("footer",'',true);


	}

}
