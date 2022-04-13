<?php

class stock extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
	}



	 public function index(){

		 unset($_SESSION['src']);

			$q = $this->db->query("SELECT tbl_product.id, tbl_product.product_name, tbl_product.type, tbl_product.product_code, tbl_stock.id AS sid FROM tbl_product, tbl_stock WHERE tbl_product.id = tbl_stock.product_id");
			$prod = $q->fetchAll(PDO::FETCH_ASSOC);


			$i =0;

			foreach($prod as $key => $val){

				$prd[$i]["id"] = $val['id'];
				$prd[$i]["sid"] = $val['sid'];
				$prd[$i]["product_name"] = $val['product_name'];
				$prd[$i]["product_code"] = $val['product_code'];
				$prd[$i]["type"] = $val['type'];
				$comb = $this->fetchAll("tbl_combination",array("act"=>"status=1 and product_id = ". $val['id']));

					$j =0;
					foreach($comb as $skey => $sval){

						$prd[$i]["comb"][$j]["id"] = $sval["id"];
						$prd[$i]["comb"][$j]["size"] = $sval["size"];
						$prd[$i]["comb"][$j]["weight"] = $sval["weight"];
						$prd[$i]["comb"][$j]["quantity"] = $sval["quantity"];

						if($val['type']==2):

						$col = $this->fetchAll("tbl_comb_color",array("act"=>"comb_id='$sval[id]'"));

							$k = 0;
							foreach($col as $sskey => $ssval){

								$color = $this->fetch("tbl_color_image","id='$ssval[color_id]'");

								$prd[$i]["comb"][$j]["color"][$k]["id"] = $ssval["id"];
								$prd[$i]["comb"][$j]["color"][$k]["qty"] = $ssval["qty"];
								$prd[$i]["comb"][$j]["color"][$k]["image"] = $color["image"];
								$k++;

							}
						endif;
						$j++;
					}
				$i++;
			}

		$data['stock'] = $prd;
		$data['cats'] = $this->lib->getCats();

	 	tamplate("head","",true);
	 	tamplate("header","",true);
	 	tamplate("left-nav","",true);
		tamplate("top-bar","",true);
	 	tamplate("product/stock2",$data,true);
	 	tamplate("footer",'',true);

 	}




	public function search(){

		$post = $this->post();
		extract($post);

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


		$prod = $this->fetchAll("tbl_product",array("act"=>"id>0 " . $qprd . $qcat . $qtype . $qsts, "order"=>"id desc"));


		$i =0;

		foreach($prod as $key => $val){

			$prd[$i]["id"] = $val['id'];
			$prd[$i]["product_name"] = $val['product_name'];
			$prd[$i]["product_code"] = $val['product_code'];
			$prd[$i]["type"] = $val['type'];
			$comb = $this->fetchAll("tbl_combination",array("act"=>"status=1 and product_id = ". $val['id']));

				$j =0;
				foreach($comb as $skey => $sval){

					$prd[$i]["comb"][$j]["id"] = $sval["id"];
					$prd[$i]["comb"][$j]["size"] = $sval["size"];
					$prd[$i]["comb"][$j]["weight"] = $sval["weight"];
					$prd[$i]["comb"][$j]["quantity"] = $sval["quantity"];

					if($val['type']==2):

					$col = $this->fetchAll("tbl_comb_color",array("act"=>"comb_id='$sval[id]'"));

						$k = 0;
						foreach($col as $sskey => $ssval){

							$color = $this->fetch("tbl_color_image","id='$ssval[color_id]'");

							$prd[$i]["comb"][$j]["color"][$k]["id"] = $ssval["id"];
							$prd[$i]["comb"][$j]["color"][$k]["qty"] = $ssval["qty"];
							$prd[$i]["comb"][$j]["color"][$k]["image"] = $color["image"];
							$k++;

						}
					endif;
					$j++;
				}
			$i++;
		}


		$data['stock'] = $prd;

		$data['cats'] = $this->lib->getCats();

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("product/stock2",$data,true);
		tamplate("footer",'',true);
	}


	public function equipment() {

		$q = $this->db->query("SELECT tbl_product.id, tbl_product.product_name, tbl_product.type, tbl_product.product_code, tbl_combination.id as cid, tbl_combination.quantity AS qty FROM tbl_product, tbl_combination WHERE tbl_product.id = tbl_combination.product_id AND  tbl_product.type = '1' AND tbl_combination.quantity = '0'");
		$data['prod'] = $q->fetchAll(PDO::FETCH_ASSOC);
		// print_r($prod);

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("product/stock3",$data,true);
		tamplate("footer",'',true);
	}

}
