<?php

class trash extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
		// $this->pdf = new mPDF();
	}

	public function index(){

		// $rows =  $this->tblRows('tbl_order');
		$rows =  $this->numRows('tbl_order',"trash='1'");

		$pg_num = ceil($rows/20);
		$paging['rows'] = $pg_num;
		$paging['page'] = 1;
		$paging['link'] = 'page';

		$post = $this->post();
		$ship = $this->post('ship');
		$ord_id = $this->post('oid');

			if(!empty($post)) :
				$post['pay_status'] = 1;
				$this->update("tbl_order",$post,$ord_id);
				$data['alert'] = 1;
			endif;

			if(!empty($ship)) :
				$post['pay_status'] = 1;

				$url = $ship['url'].$ship['track_code'];

				$this->update("tbl_order",array("track_url"=>$url),$ord_id);
				$data['alert'] = 1;

			endif;

		$order = $this->fetchAll("tbl_order",array("act"=>"id>0 and trash='1'","order"=>"id desc","limit"=>20));

			foreach ($order as $key => $val) :

				$uinfo = $this->fetch('tbl_buyer',"id='$val[user_id]'");
				$val['email'] = $uinfo['email'];
				$res[] = $val;

			endforeach;

		$data['order'] = $res;
		$data['shipp'] = $this->fetchAll("tbl_shipping",array("act"=>"status='1'","order"=>"name asc"));
	//	print_r($res);
		$data['pg'] = $paging;

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("orders/trash-view",$data,true);
		tamplate("footer",$alert,true);

	}


	//--------		Order Products -------------//

	public function products($param){

		$id = $param[0];

			$ord = $this->fetch("tbl_order","id='$id'");

			$prod = $this->fetchAll("tbl_order_product",array("act"=>"order_id='$id'"));

				foreach ($prod as $key => $val) :
					// $prd = $this->fetch("tbl_product","id='$val[product_id]'");
					$comb = $this->fetch("tbl_combination","id='$val[comb_id]'");
					$colr = $this->fetch("tbl_color_image","id='$val[color]'");

					// $val['color_name'] = $colr['name'];
					$val['product'] = $prd['product_name'];
					$val['size'] = $comb['size'];
					$val['weight'] = $comb['weight'];

					$res[] = $val;
				endforeach;
			$data = $ord;
			$data['prd'] = $res;
			$data['curr'] = $ord['currency'];

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("orders/products",$data,true);
		tamplate("footer",$alert,true);

	}



	public function page($prm) {

			$pg = $prm[0];
			$page = $pg;
			if($pg == NULL) { $pg = 0; $page = 1; } else { $pg--; }

			$lim = 20;
			$rows =  $this->numRows('tbl_order',"trash='1'");
			$pg_num = ceil($rows/$lim);
			$start_pg = $lim*$pg;

			$paging['rows'] = $pg_num;
			$paging['page'] = $page;
			$paging['link'] = 'page';
			$paging['srl'] = $start_pg;

		 	$order = $this->fetchAll("tbl_order",array("act"=>"id>0 and trash='1'","order"=>"id desc",'limit'=>$start_pg .', '. $lim));

			foreach ($order as $key => $val) :

				$uinfo = $this->fetch('tbl_buyer',"id='$val[user_id]'");
				$val['email'] = $uinfo['email'];
				$res[] = $val;

			endforeach;

			$data['order'] = $res;
			$data['shipp'] = $this->fetchAll("tbl_shipping",array("act"=>"status='1'","order"=>"name asc"));
		 	$data['pg'] = $paging;

		 tamplate("head","",true);
		 tamplate("header","",true);
		 tamplate("left-nav",$this->ntab,true);
		 tamplate("top-bar","",true);
		 tamplate("orders/trash-view",$data,true);
		 tamplate("footer",'',true);

	}

}
