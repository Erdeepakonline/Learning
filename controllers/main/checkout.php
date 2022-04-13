<?php

class checkout extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();
		$this->brand = $this->fetchAll("tbl_brand",array('act' => 'status=1' ));

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

		$this->email = new email();

		$q = $this->db->query("SELECT email, phone, ship_charge, ship_limit FROM tbl_admin WHERE id>0");
		$this->admin = $q->fetch(PDO::FETCH_ASSOC);
	}


	public function index(){

		// print_r($_SESSION['tg_cart']);

		if(empty($_SESSION[USER])) :
			header("location:".PATH.'login/buyer/');
			$_SESSION["link_back"] = 'checkout';
		endif;

		if(empty($_SESSION['tg_cart'])):
			header("location:".PATH);
		endif;

		 	$uid = $_SESSION[USER]['id'];

				$bill = $this->fetch("tbl_address","user_id='$uid' and type = 1");

				$city = $this->fetch("tbl_city","id='$bill[city]'");
				$state = $this->fetch("tbl_state","id='$bill[state]'");
				$cont = $this->fetch("tbl_country","id='$bill[country]'");


				$bill['city'] = $city['city'];
				$bill['state'] = $state['state'];
				$bill['country'] = $cont['country_name'];

				$ship = $this->fetch("tbl_address","user_id='$uid' and type = 2");

				$city = $this->fetch("tbl_city","id='$ship[city]'");
				$state = $this->fetch("tbl_state","id='$ship[state]'");
				$cont = $this->fetch("tbl_country","id='$ship[country]'");

				$ship['city'] = $city['city'];
				$ship['state'] = $state['state'];
				$ship['country'] = $cont['country_name'];



		$data['bill'] = $bill;
		$data['ship'] = $ship;

		if($_SESSION['role'] == 'ds'):
			$data['role'] = 'distributor';
		else:
			$data['role'] = 'buyer';
		endif;

		$meta['title'] = "Checkout | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Checkout | Tattoogizmo.com";

		$data['ship_charge'] = $this->admin['ship_charge'];
		$data['ship_limit'] = $this->admin['ship_limit'];

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("checkout2",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


/*
--------		Order process		------------//
*/

	public function process($prm){

		$pay_opt = $prm[0];

		if(empty($_SESSION[USER])) :
			header("location:".PATH.'login/buyer/');
			$_SESSION["link_back"] = 'checkout';
		endif;

		if(empty($_SESSION['tg_cart'])):
			header("location:".PATH);
		endif;

		echo 'Please wait.....';

		foreach ($_SESSION['tg_cart'] as $key => $val) :

			if($_SESSION[USER]['role'] == 'us'):

				$type = 1;

				if($_SESSION['curr'] == 'inr'):
					$sum[] = $val['price']*$val['qty'];
				else:
					$sum[] = $val['usd']*$val['qty'];
				endif;

			else:

				$type = 2;
				if($_SESSION['curr'] == 'inr'):
					$sum[] = $val['dprice']*$val['qty'];
				else:
					$sum[] = $val['usd']*$val['qty'];
				endif;

			endif;



		endforeach;

		$total = array_sum($sum);


		//----		Order Section : Start  ------//

		$uoid = $this->makeOrderIdByDB();

		$ord = array(
			"code" => $uoid,
			"user_id" =>  $_SESSION[USER]['id'],
			"user_type"=>$type,
			"amount" => $total,
			"currency" =>$_SESSION['curr']
		);


		if($pay_opt == 1) :
			$ord['pay_methode'] = 1;
		endif;

		if(!empty($_SESSION["cpn"])) {

				if($_SESSION['cpn']['val_type']==2) {
					$prc = $total/100*$_SESSION['cpn']['cpn_val'];
				} else {
					$prc = $_SESSION['cpn']['cpn_val'];
				}

				$pay_amt = $total-$prc;

				$ord['cpn_code'] = $_SESSION['cpn']['cpn_code'];
				$ord['discount'] = $prc;

				$this->insert("tbl_coupon_apply",
					array(
						"cpn_code"=>$ord['cpn_code'],
						"user_id"=>$ord['user_id'],
						"user_type"=>$type,
					)
				);

			} else {
				$pay_amt = $total;
			}

			if($pay_amt < $this->admin['ship_limit']) {
				$ship_amt =  $this->admin['ship_charge'];
			} else {
				$ship_amt = 0;
			}

			$gst = $pay_amt/100*18;
			$pay_amt = $pay_amt+$gst+$ship_amt;

			$ord['gst'] = $gst;
			$ord['total'] = $pay_amt;
			$ord['shipping'] = $ship_amt;

			unset($_SESSION['cpn']);

			$ord_id = $this->insert("tbl_order",$ord);

//----		Order Section : End  ------//


//----		Order Product Insert Section : Start  ------//

				foreach ($_SESSION['tg_cart'] as $keys => $vals) :

					// -----	Stock Update 	---------- //

					if($vals['p_type'] == 2) :

						$cmb = $this->fetch("tbl_combination","id='$vals[c_id]'");
						$col = $this->fetch("tbl_comb_color","id='$vals[color]'");
						$qty = $col['qty']-$vals['qty'];
						$this->update("tbl_comb_color",array("qty"=>$qty),$vals['color']);

					else:

						$cmb = $this->fetch("tbl_combination","id='$vals[c_id]'");
						$qty = $cmb['quantity']-$vals['qty'];
						$this->update("tbl_combination",array("quantity"=>$qty),$vals['c_id']);

					endif;

					if($qty <= $cmb['stock_alert']) :

							$stck_alt = $this->fetch("tbl_stock","product_id='$vals[p_id]' and comb_id='$vals[c_id]'");

							if(empty($stck_alt)) :
								$this->insert("tbl_stock",array("product_id"=>$vals['p_id'],"comb_id"=>$vals['c_id']));
							endif;

					endif;
					//	-------		Update Order Product	--------//

						if($_SESSION[USER]['role'] == 'us'):
							$price = $vals['price'];
						else:
							$price = $vals['dprice'];
						endif;


						$ord_prd = array(
							"order_id" => $ord_id,
							"product_id"=> $vals['p_id'],
							"comb_id" => $vals['c_id'],
							"quantity" => $vals['qty'],
							"price" =>	$price,
							"total_price" => $price*$vals['qty'],
							"image" => PATH . 'theme/data-img/' . $vals['c_img'],
							"pname" => $vals['p_name'] .' - '. $vals['c_name'],
						);

						if(strlen($vals['color'])>0) {
						$ord_prd["color"] = $vals['color'];
						}

						if(strlen($vals['c_size'])>0) {
						$ord_prd["size"] = $vals['c_size'];
						}

						$this->insert("tbl_order_product",$ord_prd);

						$htm .= '<tr>
									<td>'.$sn.'</td>
									<td>'.$vals['p_name'].'</td>
									<td>Rs. '.$ord_prd['price'].'</td>
									<td>'.$ord_prd['quantity'].'</td>
									<td>Rs. '.$ord_prd['total_price'].'</td>
								</tr>';

				endforeach;

				//--------	Address Update in Order  --------------//
				// echo "user_id ='$ord[user_id]' and user_type='$type' and type='1'";
				$addr1 = $this->fetch("tbl_address","user_id ='$ord[user_id]' and user_type='$type' and type='1'");
				$addr2	=	$this->fetch("tbl_address","user_id ='$ord[user_id]' and user_type='$type' and type='2'");

				$this->insert("tbl_order_address",
					array(
						"order_id" => $ord_id,
						"type" => 1,
						"name" => $addr1['name'],
						"mobile" => $addr1['mobile'],
						"address" => $addr1['address'],
						"landmark" => $addr1['landmark'],
						"city" => $addr1['city'],
						"state" => $addr1['state'],
						"country"	=> $addr1['country'],
						"post_code" => $addr1['post_code']
					));


					$shp = array(
						"order_id" => $ord_id,
						"type" => 2,
						"name" => $addr2['name'],
						"mobile" => $addr2['mobile'],
						"address" => $addr2['address'],
						"landmark" => $addr2['landmark'],
						"city" => $addr2['city'],
						"state" => $addr2['state'],
						"country"	=> $addr2['country'],
						"post_code" => $addr2['post_code']
					);

					$this->insert("tbl_order_address",$shp);

					$ordinfo = $this->fetch("tbl_order","id='$ord_id'");

					 $htm .= '<tr><td colspan="4" align="right"><strong> Total &nbsp; :</strong></td><th> Rs. '.$total.'</th></tr>';
					 $htm .= '<tr><td colspan="4" align="right"><strong> GST &nbsp; :</strong></td><th> Rs. '.$gst.'</th></tr>';
					 if($disc) :
					 $htm .= '<tr><td colspan="4" align="right"><strong> Discount &nbsp; :</strong></td><th> -Rs. '.$disc.'</th></tr>';
				 	 endif;
					 $htm .= '<tr><td colspan="4" align="right"><strong> Grand Total &nbsp; :</strong></td><th> Rs. '.$pay_amt.'</th></tr>';

					 $email['to'] = $_SESSION[USER]['email'];
					 $email['from'] = 'noreply@tattoogizmo.com';
					 $email['fname'] = 'Tattoo Gizmo';
					 $email['sub'] = "Order Confirmation | Tattoogizmo.com";

						$arr = array(
							"order_id" => $ord['code'],
							"product_data" => $htm,
						);

						$email['msg'] = $this->lib->loadEmailTemp('theme/email/order.html',$arr);

						$msg = "Thank you for shopping at Tattoogizmo.com. Your order " .$ord['code']. " created succesfully. Track your order at Tattoogizmo.com";
						$msg2 = "Dear sir a new order posted at Tattoogizmo.com.  Order ID is " .$ord['code']. ", Amount ".$pay_amt.", posted by ".$_SESSION[USER]['fname'].' - '.$email['to'].".";

						$email2['to'] = $this->admin['email'];
						$email2['from'] = 'noreply@tattoogizmo.com';
						$email2['fname'] = 'Tattoo Gizmo';
						$email2['sub'] = "#".$ord['code']." New Order Posted | Tattoogizmo.com";
						$email2['msg'] = $msg2;

						unset($_SESSION['tg_cart']);

						if($pay_opt == 1) :

								$_SESSION["ord"]["id"] = $ord_id;
								$_SESSION["ord"]["code"] = $ord['code'];
								$_SESSION["ord"]["total"] = $ord['total'];
								header("location:".PATH."checkout/payonline/");

							else :

								$this->email->sgmail($email);
								$this->lib->sendSMS($msg,trim($usrinfo['mobile']));

								$this->email->sgmail($email2);
								$this->lib->sendSMS($msg2,trim($this->admin['phone']));

								header("location:".PATH."checkout/order_success/".$ordinfo['code']);

						endif;

	}




	public function success($prm){

		$data['code'] = $prm[0];

		$meta['title'] = "Payment | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Payment | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("online-success",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	public function order_success($prm){

		$data['code'] = $prm[0];

		$meta['title'] = "Payment | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Payment | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("offline-success",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	public function pay_error(){

		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("pay-error",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}

	public function payonline()
	{
		// error_reporting(-1);
		// ini_set('display_errors', 'On');
		if(empty($_SESSION[USER])) :
			header("location:".PATH.'login/');
		endif;

		$uid = $_SESSION[USER]['id'];

		if($_SESSION[USER]['role'] == 'us') :
			$tbl = "tbl_buyer";
			$role = 1;
		else :
			$tbl = "tbl_distributor";
			$role = 2;
		endif;



		$qr = $this->db->query("SELECT
					tbl_address.*,
					tbl_city.city,
					$tbl.email,
					tbl_state.state,
					tbl_country.country_name as country
					FROM $tbl, tbl_address, tbl_city, tbl_state, tbl_country
					WHERE tbl_address.user_id='$uid'
					AND $tbl.id='$uid'
					AND tbl_address.user_type='$role'
					AND tbl_address.type='1'
					AND tbl_city.id=tbl_address.city
					AND tbl_state.id=tbl_address.state
					AND tbl_country.id=tbl_address.country ");
		$user = $qr->fetch(PDO::FETCH_ASSOC);

		include("helper/Crypto.php");

		$tid = str_shuffle(date('ynj').time());
		$param = encode_arr($_SESSION[USER]);

		$opt['data']['tid'] = $tid;
		$opt['data']['merchant_id'] = '11755';
		$opt['data']['order_id'] = $_SESSION['ord']['code'];
		$opt['data']['amount'] = $_SESSION['ord']['total'];
		$opt['data']['currency'] = strtoupper($_SESSION['curr']);
		$opt['data']['redirect_url'] = 'http://www.tattoogizmo.com/checkout/payback';
		$opt['data']['cancel_url'] = 'http://www.tattoogizmo.com/checkout/payback';
		$opt['data']['language'] = 'ENG';
		$opt['data']['merchant_param1'] = $_SESSION['ord']['id'];
		$opt['data']['merchant_param2'] = $param;

		$opt['working_key'] = '67AC4E3B6C0C7A44B4E7A0185BD63082';
		$opt['access_code'] = 'JW2AZYOXTUUKDKU2';

		// Billing Details //
		$opt['data']['billing_name'] = $user['name'];
		$opt['data']['billing_address'] = $user['address'];
		$opt['data']['billing_city'] = $user['city'];
		$opt['data']['billing_state'] = $user['state'];
		$opt['data']['billing_zip'] = $user['post_code'];
		$opt['data']['billing_country'] = $user['country'];
		$opt['data']['billing_tel'] = $user['mobile'];
		$opt['data']['billing_email'] = $user['email'];

		tamplate("ccavpay",$opt);

	}


	public function payback() {

				if(empty($_SESSION[USER])) :
					header("location:".PATH.'login/buyer/');
				endif;

				include("helper/Crypto.php");

				$workingKey='67AC4E3B6C0C7A44B4E7A0185BD63082';		//Working Key should be provided here.
				$encResponse=$_POST["encResp"];			//This is the response sent by the CCAvenue Server
				$rcvdString=decrypt($encResponse,$workingKey);

				$arr = explode('&',$rcvdString);

					foreach ($arr as $key => $val) {
						$str = explode("=",$val);
						$res[$str[0]] = $str[1];
					}

				$_SESSION = decode_arr($res['merchant_param2']);

				if($res['order_status'] == 'Success') :

							$ordinfo = $this->fetch("tbl_order","id='".$res["merchant_param1"]."'");

							if($ordinfo['user_type'] == 1) { $tbl = 'tbl_buyer'; } else { $tbl = 'tbl_distributer'; }

							$usrinfo = $this->fetch($tbl,"id='".$ordinfo["user_id"]."'");

							$this->update("tbl_order", array("pay_status"=>1, "ref_no"=>$res['tracking_id']), $res["merchant_param1"]);

							$htm = $this->getOrderHTML($ordinfo['id']);

							$email['to'] = $usrinfo['email'];
							$email['from'] = 'noreply@tattoogizmo.com';
							$email['fname'] = 'Tattoo Gizmo';
							$email['sub'] = "Order Confirmation | Tattoogizmo.com";

							 $arr = array(
								 "order_id" => $res['order_id'],
								 "product_data" => $htm,
							 );

							 $email['msg'] = $this->lib->loadEmailTemp('theme/email/order.html',$arr);

							 $msg = "Thank you for shopping at Tattoogizmo.com. Your order " .$res['order_id']. " created succesfully. Track your order at Tattoogizmo.com";
							 $msg2 = "Dear sir a new order posted at Tattoogizmo.com.  Order ID is " .$res['order_id'] ." posted by ".$email['to'].".";


							 $email2['to'] = $this->admin['email'];
							 $email2['from'] = 'noreply@tattoogizmo.com';
							 $email2['fname'] = 'Tattoo Gizmo';
							 $email2['sub'] = "#".$res['order_id']." New Order Posted | Tattoogizmo.com";
							 $email2['msg'] = $msg2;

							$this->email->sgmail($email);
							$this->lib->sendSMS($msg,trim($usrinfo['mobile']));

							$this->email->sgmail($email2);
							$this->lib->sendSMS($msg2,trim($this->admin['phone']));

							header("location:".PATH.'checkout/success/'.$res['order_id']);

				else :
							$this->update("tbl_order", array("pay_status"=>2, "ref_no"=>$res['tracking_id']), $res["merchant_param1"]);
							header("location:".PATH.'checkout/pay_error');
				endif;

	}




	public function getOrderHTML($id) {
		// $id = $prm[0];
		$ord = $this->fetch("tbl_order","id='$id'");
		$products = $this->fetchAll("tbl_order_product",array("act"=>"order_id='$id'"));
		$htm;
		$sn=0;
					foreach ($products as $key => $val) { $sn++;
						$htm .= '<tr>
											<td>'.$sn.'</td>
											<td>'.$val['pname'].'</td>
											<td>Rs. '.$val['price'].'</td>
											<td>'.$val['quantity'].'</td>
											<td>Rs. '.$val['total_price'].'</td>
										</tr>';
					}

					$htm .= '<tr><td colspan="4" align="right"><strong> Total &nbsp; :</strong></td><th> Rs. '.$ord['amount'].'</th></tr>';
					$htm .= '<tr><td colspan="4" align="right"><strong> GST &nbsp; :</strong></td><th> Rs. '.$ord['gst'].'</th></tr>';
					if($disc) :
					$htm .= '<tr><td colspan="4" align="right"><strong> Discount &nbsp; :</strong></td><th> -Rs. '.$ord['discount'].'</th></tr>';
					endif;
					$htm .= '<tr><td colspan="4" align="right"><strong> Grand Total &nbsp; :</strong></td><th> Rs. '.$ord['total'].'</th></tr>';

		  return $htm;
	}



	public function makeOrderIdByDB() {
		$query = $this->db->query("select id from tbl_order order by id desc limit 1");
		$res = $query->fetch(PDO::FETCH_ASSOC);
		$id = $res['id'];
		$id++;
		$num = 15000+$id;
		$sn = "TG".$num;
		return $sn;
	}

}
