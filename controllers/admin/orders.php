<?php

class orders extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
		// $this->pdf = new mPDF();
	}

	public function index(){

		$rows =  $this->numRows('tbl_order',"trash='0'");

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

		$order = $this->fetchAll("tbl_order",array("act"=>"id>0 and trash='0'","order"=>"id desc","limit"=>20));

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

			$adm = $this->fetch("tbl_admin","id='1'");

			$ord['adm_addr'] = $adm['address'];
			$ord['adm_city'] = $adm['city'];
			$ord['adm_pincode'] = $adm['pincode'];
			$ord['adm_mob'] = $adm['phone'];
			$ord['adm_email'] = $adm['email'];
			$ord['adm_tax_id'] =$adm['tax_id'];

			if($ord['user_type'] == 1 ) {
				$user = $this->fetch("tbl_buyer", "id='".$ord['user_id']."'");
			} else {
				$user = $this->fetch("tbl_distributor", "id='".$ord['user_id']."'");
			}

			$ord['gst_no'] = $user['gst_no'];

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

			$ord['tax_id'] = $adm['tax_id'];
			$ord['address'] = $adm['address'];
			$ord['today'] = date('d-m-Y', strtotime($ord['created']));

			if($ord['discount']>0) :
					$ord['discount'] = '<tr>
																<td colspan="3" align="right"><b>Discount</b></td>
																<td>- '.$ord['discount'].'</td>
															</tr>';

		 endif;

		 if($ord['shipping']) { $ord['shipamt'] = $ord['shipping']; } else { $ord['shipamt'] = 'Free'; }

			$qry2 = $this->db->query("SELECT tbl_order_product.*, tbl_product.product_code as pro_code FROM tbl_product, tbl_order_product WHERE tbl_product.id=tbl_order_product.product_id AND tbl_order_product.order_id='$id'");

			$prod = $qry2->fetchAll(PDO::FETCH_ASSOC);
			$ord['page_title'] = "Tattoo Gizmo Sales Invoice No - " .$ord['code'];

			if($ord['gst'] > 0) {

				if($ship['state'] == 10 && strlen($user['gst_no'])>0 ) {

					$ord['gst_amt'] =   '<tr>
																<td colspan="3" align="right"> <b>CGST</b></td>
																<td>'.($ord['gst']/2).'</td>
															</tr>
															<tr>
																<td colspan="3" align="right"> <b>SGST</b></td>
																<td>'.($ord['gst']/2).'</td>
															</tr>';
				} else {

					$ord['gst_amt'] =   '<tr>
																<td colspan="3" align="right"> <b>IGST</b></td>
																<td>'.$ord['gst'].'</td>
															</tr>';
				}

			}

			$qpdf = new qpdf();
			$qpdf->htmlPDF($ord['code']."- INVOICE",'orders/invoice.php',$ord,$prod);

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



	public function page($prm) {
		$rows =  $this->numRows('tbl_order',"trash='0'");

		$pg = $prm[0];
		$lim = 20;

		if($pg>0) :
			$pg--;
			$start = $pg*$lim;
		else:
			$start = 0;
		endif;

		$pg_num = ceil($rows/$lim);
		$paging['rows'] = $pg_num;
		$paging['page'] = 1;
		$paging['link'] = 'page';
		$paging['page'] = $prm[0];
		$paging['srl'] = $start;

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

		$order = $this->fetchAll("tbl_order",array("act"=>"id>0 and trash='0'","order"=>"id desc","limit"=>$start.", ".$lim));

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
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("orders/view",$data,true);
		tamplate("footer",$alert,true);
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

			$code = $_SESSION['osrc']['code'];
			$pmode = $_SESSION['osrc']['pmode'];
			$pay_status = $_SESSION['osrc']['psts'];
			$ord_status = $_SESSION['osrc']['osts'];
			$date = $_SESSION['osrc']['date'];


			if(strlen($code)>0) :
				$str1 = " and code ='$code' ";
			endif;

			if($pmode != 2):
				$str2 = " and pay_methode ='$pmode' ";
			endif;

			if($pay_status != 3):
				$str3 = " and pay_status= '$pay_status' ";
			endif;

			if($ord_status != 4):
				$str4 = " and status= '$ord_status' ";
			endif;

			if(strlen($date)>0):
			  $str5 = " and date(created)= '".date("Y-m-d",strtotime($date))."' ";
			endif;

			$pg = $prm[0];
			$page = $pg;
			if($pg == NULL) { $pg = 0; $page = 1; } else { $pg--; }

			$lim = 20;
			$rows =  $this->numRows('tbl_order','id>0 '. $str1 . $str2 . $str3 . $str4 . $str5);
			$pg_num = ceil($rows/$lim);
			$start_pg = $lim*$pg;

			$paging['rows'] = $pg_num;
			$paging['page'] = $page;
			$paging['link'] = 'search';
			$paging['srl'] = $start_pg;

			$prod = $this->fetchAll("tbl_order",array("act"=>"id>0 " . $str1 . $str2 . $str3 . $str4 . $str5,"order"=>"id desc",'limit'=>$start_pg .', '. $lim));

			//  	foreach($prod as $key=> $val):
			//
	 	// 		$cat = $this->fetch("tbl_category","id='$val[category]'");
	 	// 		$val['category'] = $cat['category'];
	 	// 		$res[] = $val;
			//
			// 	endforeach;

	 	 $data['order'] = $prod;
		 $data['cats'] = $this->lib->getCats();
		 $data['cat_id']= $cat_id;
		 $data['status'] = $sts;
		 $data['pg'] = $paging;

	 	 tamplate("head","",true);
	 	 tamplate("header","",true);
	 	 tamplate("left-nav",$this->ntab,true);
	 	 tamplate("top-bar","",true);
	 	 tamplate("orders/view",$data,true);
	 	 tamplate("footer",'',true);


		}






}
