<?php

class orders extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
		$this->pdf = new mPDF();
	}

	public function index(){

		$order = $this->fetchAll("tbl_order",array("act"=>"id>0","order"=>"id desc","limit"=>50));

			foreach ($order as $key => $val) :

				if($val['user_type'] == 1) :
					$tbl = "tbl_buyer";
				else :
					$tbl = "tbl_distributor";
				endif;

				$uinfo = $this->fetch($tbl,"id='$val[user_id]'");
				$val['email'] = $uinfo['email'];
				$res[] = $val;

			endforeach;

		$data['order'] = $res;
		$data['shipp'] = $this->fetchAll("tbl_shipping",array("act"=>"status='1'","order"=>"name asc"));
		
	//	print_r($res);
		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("orders/view",$data,true);
		tamplate("footer",$alert,true);

	}


	//--------		Order Products -------------//

	public function products($param){

		$id = $param[0];

			$data = $this->fetch("tbl_order","id='$id'");

			$prod = $this->fetchAll("tbl_order_product",array("act"=>"order_id='$id'"));

				foreach ($prod as $key => $val) :
					$prd = $this->fetch("tbl_product","id='$val[product_id]'");
					$comb = $this->fetch("tbl_combination","id='$val[comb_id]'");

					$val['product'] = $prd['product_name'];
					$val['comb'] = $comb['size'];

					$res[] = $val;
				endforeach;

			$data['prd'] = $res;

		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("orders/products",$data,true);
		tamplate("footer",$alert,true);

	}

	public function invoice ($prm){
			$id = $prm[0];
			$ord = $this->fetch("tbl_order","id='$id'");

			$bill = $this->fetch("tbl_order_address","order_id='$id' and type='1'");
			$ship = $this->fetch("tbl_order_address","order_id='$id' and type='2'");

			$ord['bill_name'] = $bill['name'];
			$ord['bill_mob'] = $bill['mobile'];
			$ord['bill_addr'] = $bill['address'];
			$ord['bill_lm'] = $bill['landmark'];
			$ord['bill_pc'] = $bill['post_code'];

			$city = $this->fetch("tbl_city","id='$bill[city]'");
			$state = $this->fetch("tbl_state","id='$bill[state]'");
			$contr = $this->fetch("tbl_country","id='$bill[country]'");

			$ord['bill_city'] = $city['city'];
			$ord['bill_state'] = $state['state'];
			$ord['bill_country'] = $contr['country_name'];


			//----------------------------------------------------//

			$ord['ship_name'] = $ship['name'];
			$ord['ship_mob'] = $ship['mobile'];
			$ord['ship_addr'] = $ship['address'];
			$ord['ship_lm'] = $ship['landmark'];
			$ord['ship_pc'] = $ship['post_code'];

			$city = $this->fetch("tbl_city","id='$ship[city]'");
			$state = $this->fetch("tbl_state","id='$ship[state]'");
			$contr = $this->fetch("tbl_country","id='$ship[country]'");

			$ord['ship_city'] = $city['city'];
			$ord['ship_state'] = $state['state'];
			$ord['ship_country'] = $contr['country_name'];


			$prod = $this->fetchAll("tbl_order_product",array("act"=>"order_id='$id'"));

			$ord['page_title'] = "Tattoo Gizmo Sales Invoice No - " .$ord['code'];


			$qpdf = new qpdf();

			$qpdf->htmlPDF(PATH.'orders/invoice.php',$ord,$prod);



		// 	$htm = $this->getFromFIle('orders/invoice.php',$ord,$prod);
		 //
		//  $this->pdf->WriteHTML($htm);
		//  $this->pdf->Output();


	}




	public function getFromFIle($file, $data, $arr = array()){

		$htm = file_get_contents(PATH . $file);

			if(!empty($data)):

				$co = count($data);
				$num = 0;

				foreach($data as $key => $val) : $num++;
					$pat = '{'.$key.'}';
					$htm  = str_replace($pat,$val, $htm);
				endforeach;

			endif;


			if(!empty($arr)) :

				$start_point = strpos($htm,'{foreach}')+9;
				$end_point = strpos($htm,'{endforeach}');

				$length = $end_point-$start_point;
				$htm2 = $htm;

				$strval = substr($htm2,$start_point,$length);

				$i =0;
					 foreach($arr as $ky => $vl) : $i++;
						 $arhtm = $strval;

						 foreach ($vl as $k => $v) {
							 //echo $v;
						 	$pt = '{'.$k.'}';
							if($k == 'sn') :
								$arhtm = str_replace($pt,$i,$arhtm);
							else:
								$arhtm = str_replace($pt,$v,$arhtm);
							endif;
						 }

						 $arr_res[] = $arhtm;
					 endforeach;

					 $new_str = implode(' ',$arr_res);

					$htm = substr_replace($htm,$new_str,$start_point,$length);
			endif;

			return $htm;

	}

}
