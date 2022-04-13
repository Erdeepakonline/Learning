<?php

class combination extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

		$this->ntab = array (
		"nav" =>'catalog',
	 	'pg' => 'product'
		);


	}


	public function index(){

		$this->error_404();
	}



 public function ink($url){

 	$id= $url[0];

	if($id !== NULL):

	$post = $this->post('comb');
	$imgs = $this->post('colid');
	$qty = $this->post('qty');
	$co = count($qty);
	$co--;

	//=======  Function for Insert Combination : Start ==========//

	if(!empty($post)):

		$post['product_id'] = $id;
		$cid = $this->insert("tbl_combination",$post);

		if($cid>0):

			for($i=0; $i<=$co; $i++):

				$arr = array(
				"comb_id"=>$cid,
				"color_id"=>$imgs[$i],
				"qty"=>$qty[$i]
				);

				$data['alert'] = $this->insert("tbl_comb_color",$arr);

			endfor;

		endif;

	endif;

	// ========== Function for Insert Combination : Start ========//



	 $data['info'] = $this->fetch("tbl_product","id='$id'");

	 $data['combs'] = $this->fetchAll("tbl_combination",array("act"=>"product_id='$id'"));



		// =========  Combination Fetch : End =============//

		$data['color'] =$this->fetchAll("tbl_color_image",array("act"=>"product_id='$id'"));


	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("combination/add",$data,true);
	 tamplate("footer",'',true);

	 else:

	 	$this->error_404();

	 endif;

 }

 //===============================  Combination Edit Function : Start  ==========================//


 public function inkEdit($url){

 	$id= $url[0];
	$cid= $url[1];

	if($cid != NULL):

	$post = $this->post('comb');
	$imgs = $this->post('colid');
	$cmb_col = $this->post('cmb_col');
	$qty = $this->post('qty');
	$co = count($qty);
	$co--;


	//=======  Function for Insert Combination : Start ==========//

	if(!empty($post)):

		$this->update("tbl_combination",$post,$cid);

		$data['alert'] = 1;

			for($i=0; $i<=$co; $i++):

				$arr = array(
				"comb_id"=>$cid,
				"color_id"=>$imgs[$i],
				"qty"=>$qty[$i]
				);

				$row = $this->numRows('tbl_comb_color',"id='$cmb_col[$i]'");

				if($row>0) :
					$this->update("tbl_comb_color",$arr,$cmb_col[$i]);
				else :
					$this->insert("tbl_comb_color",$arr);
				endif;

				$data['alert'] =  1;

			endfor;

		// endif;

	endif;

	// ========== Function for Insert Combination : End ========//


	 $colors =$this->fetchAll("tbl_color_image",array("act"=>"product_id='$id'"));

	 foreach($colors as $key=>$val):

	 	$qty = $this->fetch("tbl_comb_color","comb_id='$cid' and color_id='$val[id]'");

	 	$val['qty'] = $qty['qty'];
		$val['cmb_col'] = $qty['id'];
	 	$res[] = $val;

	 endforeach;

	 $data['color'] = $res;
	 $data['combs'] = $this->fetchAll("tbl_combination",array("act"=>"product_id='$id'"));

	 $data['edata'] = $this->fetch("tbl_combination","id='$cid'");
	 $data['info'] = $this->fetch("tbl_product","id='$id'");


	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("combination/add",$data,true);
	 tamplate("footer",'',true);

	 else:

	 	$this->error_404();

	 endif;

 }


 	public function needle($url){

		$id = $url[0];

		$post = $this->post('comb');

			if(!empty($post)):

				$post['product_id'] = $id;

				$data['alert'] = $this->insert("tbl_combination",$post);

			endif;

		$data['info'] = $this->fetch("tbl_product","id='$id'");
		$ndl = explode(',',$data['info']['needle_type']);

			foreach ($ndl as $key => $val) {
				$res[] = $this->fetch("tbl_needle_type","id='$val'");
			}

		$data['needle'] = $res;

 	 	$comb = $this->fetchAll("tbl_combination",array("act"=>"product_id='$id'"));

			foreach ($comb as $key => $val) {
				$cndl = $this->fetch("tbl_needle_type","id='$val[needle]'");
				$val['needle'] = $cndl['name'];
				$res2[] = $val;

			}

			$data['combs'] = $res2;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav",$this->ntab,true);
	 tamplate("top-bar","",true);
	 tamplate("combination/needle",$data,true);
	 tamplate("footer",'',true);

	}


	public function ndledit($url){

		$id = $url[0];
		$cid = $url[1];

		$post = $this->post('comb');

			if(!empty($post)):

				$this->update("tbl_combination",$post,$cid);
				$data['alert'] = 1;
				$data['step'] = 1;

			endif;



		//===============		Data Array : Start	====================//

		$data['info'] = $this->fetch("tbl_product","id='$id'");
		$ndl = explode(',',$data['info']['needle_type']);

			foreach ($ndl as $key => $val) {
				$res[] = $this->fetch("tbl_needle_type","id='$val'");
			}

		$data['needle'] = $res;

		$comb = $this->fetchAll("tbl_combination",array("act"=>"product_id='$id'"));

			foreach ($comb as $key => $val) {
				$cndl = $this->fetch("tbl_needle_type","id='$val[needle]'");
				$val['needle'] = $cndl['name'];
				$res2[] = $val;

			}

			$data['combs'] = $res2;
			$data['edata'] = $this->fetch("tbl_combination","id='$cid'");
		//==================  Data Array : End	================//

			$data['info'] = $this->fetch("tbl_product","id='$id'");

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav",$this->ntab,true);
		tamplate("top-bar","",true);
		tamplate("combination/needle",$data,true);
		tamplate("footer",'',true);

	}

	public function equip($url){

		$pid = $url[0];
		$comb = $this->fetch("tbl_combination","product_id='$pid'");

		$post = $this->post('comb');

			if(!empty($post)):
				$post['prime'] = 1;
				$this->update("tbl_combination",$post,$comb['id']);
				$data['alert'] = 1;
			endif;

		$data['info'] = $this->fetch("tbl_product","id='$pid'");
		$data['edata'] = $this->fetch("tbl_combination","product_id='$pid'");

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav",$this->ntab,true);
		tamplate("top-bar","",true);
		tamplate("combination/equip",$data,true);
		tamplate("footer",'',true);
	}

}
