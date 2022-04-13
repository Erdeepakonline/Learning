<?php

class index extends controller {

	function __construct() {

		parent::__construct();

		$this->cats['cats'] = $this->lib->getCats();
		$this->brand = $this->fetchAll("tbl_brand",array('act' => 'status=1',"order"=>"name asc" ));

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1 and url_type=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1 and url_type=1");

		$cok_co = count($_COOKIE['tg_cook']);

		if($_REQUEST['w'] != NULL) :
			setcookie("tg_cook[$cok_co]", $_REQUEST['w'], time() + (86400 * 30));
		endif;

	// $this->pdf = new mPDF();

	}


 public function index(){

	 $q1 = $this->db->query(
	 				"SELECT tbl_product.id, tbl_product.type, tbl_product.product_name, tbl_product.slug
					 FROM tbl_product, tbl_combination
					 WHERE tbl_product.status=1 AND tbl_product.slide1=1
					 AND tbl_combination.product_id=tbl_product.id AND tbl_combination.prime=1 ");
	 $ink = $q1->fetchAll(PDO::FETCH_ASSOC);

		$q2 = $this->db->query(
	 	 				"SELECT tbl_product.id, tbl_product.type, tbl_product.product_name, tbl_product.slug
	 					 FROM tbl_product, tbl_combination
	 					 WHERE tbl_product.status=1 AND tbl_product.slide2=1
	 					 AND tbl_combination.product_id=tbl_product.id AND tbl_combination.prime=1 ");
	 	 $needle = $q2->fetchAll(PDO::FETCH_ASSOC);

		 $q3 = $this->db->query(
						"SELECT tbl_product.id, tbl_product.type, tbl_product.product_name, tbl_product.slug
						 FROM tbl_product, tbl_combination
						 WHERE tbl_product.status=1 AND tbl_product.slide3=1
						 AND tbl_combination.product_id=tbl_product.id AND tbl_combination.prime=1 ");
		 $prod = $q3->fetchAll(PDO::FETCH_ASSOC);


		// 	$prod = $this->fetchAll("tbl_product",array("act"=>"type='1' and feature='1' and status='1'",order=>"id desc"));
		//  $needle = $this->fetchAll("tbl_product",array("act"=>"type='3' and feature='1' ",order=>"id desc"));


	 $res['ink'] = $this->setImages($ink);
	 $res['prod'] = $this->setImages($prod);
	 $res['needle'] = $this->setImages($needle);
	 $res['brands'] = $this->brand;
	 $res['banner'] = $this->fetchAll("tbl_banner",array("act"=>"status=1 and type=1"));
	 $res['deal'] = $this->fetchAll("tbl_deal",array("act"=>"status=1 and type=1","order"=>"sort_order asc"));
	 $res['deal2'] = $this->fetchAll("tbl_deal",array("act"=>"status=1 and type=2","order"=>"sort_order asc"));

	 $adm = $this->fetch("tbl_admin","id='1'");
	 $meta['title'] = $adm['meta_title'];
	 $meta['keyword'] = $adm['meta_keyword'];
	 $meta['desc'] = $adm['meta_desc'];

	 tamplate("head",$meta);
	 tamplate("header",$this->cats);
	 tamplate("index",$res);
	 tamplate("footer-top",$this->foot);
	 tamplate("footer",'');

 	}


/*
*	====================================================
*		This function for Category purpose or category page
*	=====================================================
*/
	public function categories($prm){

		$slg = $prm[0];
		$cat = $this->fetch("tbl_category","slug='$slg'");

		$data['cats'] = $this->fetchAll("tbl_category",array("act"=>"parent='$cat[id]'","order"=>"category asc"));

		tamplate("head","");
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("subcats",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}



	public function category($param){

		$brch = $this->post('brand');
		if($_POST['setvl']==1) :
			$_SESSION['brn'] = $brch;
		endif;
		if(!empty($_SESSION['brn'])) :
			$brnd = " and brand IN (" . implode(',',$_SESSION['brn']) . ") ";
		endif;

		$slg = $param[0];
		$pg = $param[1];

			if($pg == NULL) :
				$pnum = 0;
				$pg =1;
			else :
				$pnum = $pg-1;
			endif;

		$lim = 12;
		$num = $pnum*$lim;


		$cat = $this->fetch("tbl_category","slug='$slg'");

			$q = $this->db->query("SELECT * FROM tbl_product WHERE status='1' AND FIND_IN_SET('$cat[id]', `cats`) > 0 $brnd LIMIT $num, $lim ");
			$prod = $q->fetchAll(PDO::FETCH_ASSOC);

			foreach($prod as $key=>$val):
				if($val['type'] == 1):
					$comb = $this->fetch("tbl_combination","product_id='$val[id]'");
				else:
					$comb = $this->fetch("tbl_combination","product_id='$val[id]' and prime=1");
				endif;
				$val['comb'] = $comb;
				$res[] = $val;
			endforeach;

			$prod = $res;

			$data['prods'] = $this->setImages($prod);

			$data['cats'] = $this->lib->getCats();

			$q2 = $this->db->query("SELECT brand FROM tbl_product WHERE FIND_IN_SET('$cat[id]', `cats`) > 0");
			$brnd2 = $q2->fetchAll(PDO::FETCH_ASSOC);

			foreach ($brnd2 as $bk => $bv) {
					$res2[] = $bv['brand'];
			}

			$brnres = array_unique($res2);

			if(!empty($prod)) :
				$q3 = $this->db->query("SELECT * FROM tbl_brand WHERE id IN (".implode(',',$brnres).")");
				$data['brand'] = $q3->fetchAll(PDO::FETCH_ASSOC);
			endif;

			//---------- 	Pagination Function  -----------//

			$rows =  $this->numRows("tbl_product"," FIND_IN_SET('$cat[id]', `cats`) > 0 and status='1'");

			$data['row'] = ceil($rows/$lim);
			$data['pg_link'] = PATH . 'category/' . $slg . '/';
		 	$data['pg'] = $pg;

		 //======	SEO SECTION  =============//
 		 $meta['title'] = $cat['meta_title'];
 		 $meta['keyword'] = $cat['meta_keyword'];
 		 $meta['desc'] = $cat['meta_desc'];

		tamplate("head",$meta);
		tamplate("header",$this->cats);
		echo '<br><br><br>';
		tamplate("category",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	/*
	*==========================================
	*	This function for Ink Detail Page only.
	*==========================================
	*/

	public function details($param) {

		$post = $this->post();
		$qty = $this->post('qty');
		$pcol = $this->post('col');
		$pimg = $this->post('img');

		$c_name = $this->post('col_name');
		$c_price = $this->post("cprice");
		$u_price = $this->post("uprice");
		$d_price = $this->post("dprice");

			if(!empty($qty)) :

				$co = count($qty);
				$co--;

					for($i=0; $i<=$co; $i++):

						if($qty[$i]>0):

							$j=0;

							foreach ($_SESSION["tg_cart"] as $key => $val) {

								if($val['p_id'] == $post['pid'] && $val['c_id'] == $post['comb']):

									if($val['color'] == $pcol[$i]) :

										$colr = $this->fetch("tbl_comb_color","id='$val[color]'");
										$qt = $colr['qty']-$val['qty'];

										$j++;
										if($qty[$i]<=$qt) :
									  	$val['qty'] = $qty[$i]+$val['qty'];
										else:
											$qalt=1;
										endif;
									  $j;

									endif;

								endif;

								$res[] = $val;

							}
							$_SESSION["tg_cart"] = $res;
							unset($res);

							if($j == 0) :
								$icomb = $this->fetch("tbl_combination","id='".$post['comb']."'");

								$arr = array(
									"p_type"=>2,
									"p_id" => $post['pid'],
									"p_name" =>$post['pname'],
									"c_id" => $post['comb'],
									"c_name"=>$c_name[$i],
									"c_size"=>$icomb['size'],
									"c_img" =>$pimg[$i],
									"color" => $pcol[$i],
									"qty" => $qty[$i],
									"price"=>$c_price[$i],
									"usd"=>$u_price[$i],
									"dprice"=>$d_price[$i]
								);

							$_SESSION["tg_cart"][] = $arr;

						endif;

						endif;

					endfor;
					if($qalt == 0) :
						$ft['succ'] = 1;
					endif;

			endif;


		$slg = $param[0];
		$data = $this->fetch("tbl_product","slug='$slg'");

		$data['images'] = $this->fetchAll("tbl_image",array("act"=>"product_id='$data[id]'"));

		$comb = $this->fetchAll("tbl_combination",array('act' => "product_id='$data[id]' and status='1'"));
		$rel = $this->fetchAll("tbl_relative",array("act" => "product_id='$data[id]'"));

		foreach ($rel as $key => $val) {
			$prd = $this->fetch("tbl_product","id='$val[relative_id]'");
			$img = $this->fetchAll("tbl_image",array("act"=>"product_id='$val[relative_id]'"));
			$prd['image'] = $img[0]['image'];
			$res[] = $prd;
		}
		$data['rels'] = $res;
		$data['combs'] = $comb;
		$data['rcmb'] = $post['comb'];

		$hd = $this->cats;
		$hd['qalt'] = $qalt;

		//======	SEO SECTION  =============//

		$meta['title'] = $data['meta_title'];
		$meta['keyword'] = $data['meta_keyword'];
		$meta['desc'] = $data['meta_desc'];

		tamplate("head",$meta);
		tamplate("header",$hd);
		echo '<br><br><br>';
		tamplate("details2",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",$ft);

	}


/*
*==========================================================
*		This Function for Filtering Product by Brand
*		Using this on category page.
*==========================================================
*/

	public function brand($prm) {

		$slg = $prm[0];
		$br = $this->fetch("tbl_brand","slug='$slg'");
		$brand_id = $br['id'];
		// if(strlen($slg)>0) :
		// 	$_SESSION['brn'][0] = $br['id'];
		// endif;
		//
		// $brch = $this->post('brand');
		//
		// if($_POST['setvl']==1) :
		// 	$_SESSION['brn'] = $brch;
		// endif;
		//
		// if(!empty($_SESSION['brn'])) :
		// 	$brnd = " brand IN (" . implode(',',$_SESSION['brn']) . ") and";
		// endif;

		$pg = $prm[1];

			if($pg == NULL) :
				$pnum = 0;
				$pg =1;
			else :
				$pnum = $pg-1;
			endif;

		$lim = 9;
		$num = $pnum*$lim;

			$prod = $this->fetchAll("tbl_product",array("act"=>"brand='$brand_id' and status='1'",'limit'=>"$num, $lim"));

			foreach($prod as $key=>$val):
				if($val['type'] == 1):
					$comb = $this->fetch("tbl_combination","product_id='$val[id]'");
				else:
					$comb = $this->fetch("tbl_combination","product_id='$val[id]' and prime=1");
				endif;
				$val['comb'] = $comb;
				$res[] = $val;
			endforeach;

			$prod = $res;

			$data['prods'] = $this->setImages($prod);
			$data['cats'] = $this->lib->getCats();
			$data['brand'] = $this->brand;
			$data['brand_id'] = $brand_id;
			//---------- 	Pagination Function  -----------//

	  	$rows =  $this->numRows("tbl_product","brand='$brand_id' and status='1'");
			$data['row'] = ceil($rows/$lim);
			$data['pg_link'] = PATH . 'brand/' . $slg . '/';
			$data['pg'] = $pg;
			$br_info = $this->fetch("tbl_brand", "id='".$brand_id."'");
			//======	SEO SECTION  =============//

			if(strlen($br_info['meta_title'])) {
				$meta['title'] = $br_info['meta_title'];
			} else {
				$meta['title'] = "Popular brand tattoo product buy here | Tattoogizmo.com";
			}
			$meta['keyword'] = $br_info['meta_keyword'];
			$meta['desc'] = $br_info['description'];

			tamplate("head",$meta);
			tamplate("header",$this->cats);
			echo '<br><br><br>';
			tamplate("brand",$data);
			tamplate("footer-top",$this->foot);
			tamplate("footer",'');

	}


/*
*=============================================================
*		This function for Needle Details Page
*=============================================================
*/

	public function needle_details($param){
		// print_r($_SESSION['tg_cart']);

		$slg = $param[0];
		$data = $this->fetch("tbl_product","slug='$slg'");

		$post = $this->post();
		$qty = $this->post('qty');
		$comb = $this->post('comb');
		$c_price = $this->post("cprice");
		$u_price = $this->post("uprice");
		$d_price = $this->post("dprice");

		if(!empty($qty)) :

			$co = count($qty);
			$co--;

				for($i=0; $i<=$co; $i++):

					if($qty[$i]>0):

						$j=0;

						foreach ($_SESSION["tg_cart"] as $key => $val) {

							if($val['p_id'] == $post['pid'] && $val['c_id'] == $comb[$i]):
								$nco = $this->fetch("tbl_combination","id='$val[c_id]'");
								$qt = $nco['quantity']-$val['qty'];
								if($qty[$i]<=$qt) :
									$val['qty'] = $qty[$i]+$val['qty'];
								else:
									$qalt = 1;
								endif;
									$j++;

							endif;

							$res[] = $val;

						}
						$_SESSION["tg_cart"] = $res;
						unset($res);

						if($j == 0) :

							$nd_cmb_id = $comb[$i];
							$cmb = $this->fetch("tbl_combination","id='$nd_cmb_id'");

							$arr = array(
								"p_type"=>3,
								"p_id" => $data['id'],
								"p_name" =>$data['product_name'],
								"c_name" => $post['ntype'],
								"c_size" =>$cmb['size'],
								"c_id" => $comb[$i],
								"c_img" =>$post['nd_img'],
								"qty" => $qty[$i],
								"price"=>$c_price[$i],
								"usd" =>$u_price[$i],
								"dprice"=>$d_price[$i]
							);

						$_SESSION["tg_cart"][] = $arr;

					endif;

					endif;

				endfor;

				if($qalt == 0) :
					$ft['succ'] = 1;
				endif;

		endif;

	//================		Fetching Data for Detail page 	========================//

		$data['images'] = $this->fetchAll("tbl_image",array("act"=>"product_id='$data[id]'"));

		$ntype = explode(',',$data['needle_type']);

			foreach ($ntype as $key => $val) {

				$nv = $this->fetch("tbl_needle_type","id='$val'");

					$nres[] = $nv;

				}

		$data['type'] = $nres;


		//*****************			Relative Product Section : Start ********************//

		$rel = $this->fetchAll("tbl_relative",array("act" => "product_id='$data[id]'"));

		foreach ($rel as $key => $val) {
			$prd = $this->fetch("tbl_product","id='$val[relative_id]'");
			$img = $this->fetchAll("tbl_image",array("act"=>"product_id='$val[relative_id]'"));
			$prd['image'] = $img[0]['image'];
			$res[] = $prd;
		}
		$data['rels'] = $res;
		$data['ndls'] = $post['needle_type'];

		//****************		Relative Product Section : Start  **********************//

		$hd = $this->cats;
		$hd['qalt'] = $qalt;

		//======	SEO SECTION  =============//

		$meta['title'] = $data['meta_title'];
		$meta['keyword'] = $data['meta_keyword'];
		$meta['desc'] = $data['meta_desc'];

		tamplate("head",$meta);
		tamplate("header",$hd);
		echo '<br><br><br>';
		tamplate("details3",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",$ft);

	}




	/*
	*=============================================================
	*		This function for Equipment Details Page
	*=============================================================
	*/

		public function eq_details($param){

			//print_r($_SESSION['tg_cart']);

		//================		Fetching Data for Detail page 	========================//

			$slg = $param[0];
			$data = $this->fetch("tbl_product","slug='$slg'");
			$data['comb'] = $this->fetch("tbl_combination","product_id='$data[id]'");
			$data['images'] = $this->fetchAll("tbl_image",array("act"=>"product_id='$data[id]'"));

			$post = $this->post();

				if(isset($_POST['cart']) && $post['qty']>0) :

					$i=0;

					foreach ($_SESSION["tg_cart"] as $key => $val) :

							if($val['p_id'] == $data['id'] && $val['c_id']==$data['comb']['id']):

								$nqty = $data['comb']['quantity']-$val['qty'];

									if($post['qty']<=$nqty) :
										$val['qty'] = $post['qty']+$val['qty'];
									else:
										$qalt=1;
									endif;

									$i++;

							endif;

							$res[] = $val;

					endforeach;
					$_SESSION["tg_cart"] = $res;
					unset($res);


					if($i==0):

							$arr = array(
								"p_type"=>1,
								"p_id" => $data['id'],
								"p_name" => $data['product_name'],
								"c_id" => $data['comb']['id'],
								"c_img" => 'product/'.$data['images'][0]['image'],
								"qty" => $post['qty'],
								"price"=> $data['comb']['buyer_discount'],
								"usd" => $data['comb']['usd_discount'],
								"dprice" => $data['comb']['wh_discount']
							);

							$_SESSION["tg_cart"][] = $arr;

						endif;
						if($qalt == 0) :
							$ft['succ'] = 1;
						endif;
				endif;


				//*****************			Relative Product Section : Start ********************//

				$rel = $this->fetchAll("tbl_relative",array("act" => "product_id='$data[id]'"));

				foreach ($rel as $key => $val) {
					$prd = $this->fetch("tbl_product","id='$val[relative_id]'");
					$img = $this->fetchAll("tbl_image",array("act"=>"product_id='$val[relative_id]'"));
					$prd['image'] = $img[0]['image'];
					$res[] = $prd;
				}
				$data['rels'] = $res;

				//****************		Relative Product Section : Start  **********************//

				$hd = $this->cats;
				$hd['qalt'] = $qalt;

				//======	SEO SECTION  =============//

				$meta['title'] = $data['meta_title'];
				$meta['keyword'] = $data['meta_keyword'];
				$meta['desc'] = $data['meta_desc'];

				tamplate("head",$meta);
				tamplate("header",$hd);
				echo '<br><br><br>';
				tamplate("details",$data);
				tamplate("footer-top",$this->foot);
				tamplate("footer",$ft);
		}




/*
*===============================================================
*		This Function for Cart Page Only.
*		Update and Delete Cart Products.
*==============================================================
*/

	public function cart(){

	//	print_r($_SESSION['tg_cart']);
		//---------------		Cart Update Functions	: Start	----------------//

		if(isset($_POST['update'])) :

			$ptype = $this->post('ptype');
			$pid = $this->post('pid');
			$pname = $this->post('pname');
			$comb = $this->post('comb');
			$img = $this->post('img');
			$prc = $this->post('prc');
			$usd = $this->post('usd');
			$qty = $this->post('qty');

			$cname = $this->post('cname');
			$color = $this->post('color');

			$co = count($pid);
			$co--;

				for($i=0; $i<=$co; $i++):

					if($ptype[$i]==2){
							$colr = $this->fetch("tbl_comb_color","id='$color[$i]'");

							if($qty[$i]<=$colr['qty']) :
							$arr = array(
								"p_type"=>$ptype[$i],
								"p_id"=>$pid[$i],
								"p_name"=>$pname[$i],
								"c_id"=>$comb[$i],
								"c_name"=>$cname[$i],
								"c_img"=>$img[$i],
								"color"=>$color[$i],
								"qty"=>$qty[$i],
								"price"=>$prc[$i],
								"usd"=>$usd[$i]
							);
							$alt = 1;
							else:
								$qalt = 1;
							endif;

					}
					else
					{
						$qt = $this->fetch("tbl_combination","id='$comb[$i]'");

						if($qty[$i] <=$qt['quantity']) :
							$arr = array(
								"p_type"=>$ptype[$i],
								"p_id"=>$pid[$i],
								"p_name"=>$pname[$i],
								"c_id"=>$comb[$i],
								"c_img"=>$img[$i],
								"qty"=>$qty[$i],
								"price"=>$prc[$i],
								"usd"=>$usd[$i]
							);
							$alt = 1;
						else:
							$qalt[] = 1;
						endif;
					}
					$res[] = $arr;
				endfor;
				if($qalt == 0) :
					$_SESSION['tg_cart'] = $res;
				endif;
		endif;

		//---------------		Cart Update Function : End 	---------------//


		//---------------		Clear Cart Function  :  Start  ------------//

		if(isset($_POST['clear'])):
			unset($_SESSION['tg_cart']);
		endif;
		//---------------		Clear Cart Function  : End  -------------//

		// print_r($_SESSION['tg_cart']);
		$hd = $this->cats;
		$hd['qalt'] = $qalt;
		if($qalt==0) :
			$data['alrt'] = $alt;
		endif;

		//======	SEO SECTION  =============//

		$meta['title'] = "Shopping Cart | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Shopping Cart | Tattoogizmo.com";

		tamplate("head",$meta);
		tamplate("header",$hd);
		echo '<br><br><br>';
		tamplate("cart",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');
	}



/*
*=============================================
*		Checkout Page Function : Start
*=============================================
*/

	public function checkou2(){

		tamplate("head","");
		tamplate("header",$this->cats);
		tamplate("checkout",$data);
		tamplate("footer-top",$this->eve);
		tamplate("footer",'');

	}


	public function wishlist ($prm){

		$id = $prm[0];

		//-----------------------------------------------------//

			foreach($cook as $key =>$val):

				$prd = $this->fetch("tbl_product","id='$val'");
				$comb = $this->fetch("tbl_combination","product_id='$prd[id]' and prime=1");
				$prd['price'] = $comb['buyer_price'];
				$prd['usd'] = $comb['usd_price'];

				$prods[] = $prd;

			endforeach;

		$data['prod'] = $this->setImages($prods);

		tamplate("head","");
		tamplate("header",$this->cats);
		tamplate("wishlist",$data);
		tamplate("footer-top",$this->foot);
		tamplate("footer",'');

	}


	public function pdf(){
		$html = "<h1>My TattooGizmo </h1>";
		$this->pdf->WriteHTML($html);
		$this->pdf->Output();
	}


		public function mail2() {

		}



		public function geo() {

			echo '<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<title>Reverse Geocoding</title>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
  var geocoder;

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(successFunction, errorFunction);
}
//Get the latitude and the longitude;
function successFunction(position) {
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    codeLatLng(lat, lng)
}

function errorFunction(){
    alert("Geocoder failed");
}

  function initialize() {
    geocoder = new google.maps.Geocoder();



  }

  function codeLatLng(lat, lng) {

    var latlng = new google.maps.LatLng(lat, lng);
    geocoder.geocode({"latLng": latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
      console.log(results)
        if (results[1]) {
         //formatted address
         alert(results[0].formatted_address)
        //find country name
             for (var i=0; i<results[0].address_components.length; i++) {
            for (var b=0;b<results[0].address_components[i].types.length;b++) {

            //there are different types that might hold a city admin_area_lvl_1 usually does in come cases looking for sublocality type will be more appropriate
                if (results[0].address_components[i].types[b] == "administrative_area_level_1") {
                    //this is the object you are looking for
                    city= results[0].address_components[i];
                    break;
                }
            }
        }
        //city data
        alert(city.short_name + " " + city.long_name)


        } else {
          alert("No results found");
        }
      } else {
        alert("Geocoder failed due to: " + status);
      }
    });
  }
</script>
</head>
<body onload="initialize()">

</body>
</html> ';
		}




}
