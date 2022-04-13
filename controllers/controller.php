<?php

class controller extends sql {

 public function __construct(){

        parent::__construct();

		$this->lib = new library();

    $this->last_action = $_SERVER['HTTP_REFERER'];

 }

 public function post($data = 'data'){

	$data = $_POST[$data];
	return $data;
	}

	public function files($name){

  	$data = $_FILES[$name];
  	return $data;
	}

	//================  Parent Category  ================//

	public function getCategory($data,$col){

		foreach($data as $key => $val):

			$cat = $this->fetch("tbl_category","id = '$val[$col]'");

			$val["getcat"] = $cat['category'];
			$res[] = $val;

		endforeach;

	return $res;

	}



	public function createThumb($folder , $name , $widt , $heigh , $adm=true)

		{
 				if($adm == false){
				$sourcepath =  'theme/data-img/' . $folder . '/' . $name;
				$targetpath =  'theme/data-img/' . $folder . '/thumb/';
				}else{

				$sourcepath =  '../theme/data-img/' . $folder . '/' . $name;
				$targetpath =  '../theme/data-img/' . $folder . '/thumb/';
				}


				$img = $sourcepath ;
				$handle = fopen ($img, "rb");
				$org = fread ($handle, filesize ($img));
				fclose ($handle);
				$img = imagecreatefromstring( $org );
				$w = imagesx( $img );
				$h = imagesy( $img );
				$nw =$widt;
				$nh =$heigh;

			$img2 = imagecreatetruecolor( $nw, $nh );
			imagecopyresampled ( $img2, $img, 0, 0, 0 , 0, $nw, $nh, $w, $h );
			//$fimg = $name.'.'.'jpg';
		 	$fimg = $name;
			$real_tpath = realpath ($targetpath);
			$file = $real_tpath . "/" . $fimg;

		imagejpeg( $img2, $file );
		imagegif( $img2, $file );
		imagepng( $img2, $file );
		return $file;


	}


  public function createThumb2($src , $targetpath, $name , $widt , $heigh )
		{

        $sourcepath =  $src . $name;

				$img = $sourcepath ;
				$handle = fopen ($img, "rb");
				$org = fread ($handle, filesize ($img));
				fclose ($handle);
				$img = imagecreatefromstring( $org );
				$w = imagesx( $img );
				$h = imagesy( $img );
				$nw =$widt;
				$nh =$heigh;

			$img2 = imagecreatetruecolor( $nw, $nh );
			imagecopyresampled ( $img2, $img, 0, 0, 0 , 0, $nw, $nh, $w, $h );
			//$fimg = $name.'.'.'jpg';
		 	$fimg = $name;
			$real_tpath = realpath ($targetpath);
			$file = $real_tpath . "/" . $fimg;

		imagejpeg( $img2, $file );
		imagegif( $img2, $file );
		imagepng( $img2, $file );
		return $file;


	}

	public function error_404(){

		echo "<h1>404 Not Found</h1><p>The requested URL was not found on this server.</p>";

	}


	public function setAccessData(){
	/*
	$date = data('d/m/Y');

	$ip = $this->lib->getipInfo();
	$chkIp = $this->fetch("tbl_traffic","ip='$ip[ip]");

	if(empty($chkIp)):

		$data = array(
			"ip" => $ip['ip'],
			"country_code"=>$ip['country_code'],
			"region_code" =>$ip['region_code'],
			"city" =>
		);*/


	}

	public function setAds(){

		$sql = $this->fetchAll("tbl_advertise",array("act"=>"status='1' and ad_imp > '0'"));

			shuffle($sql);

			$ads = array_slice($sql,0,4);

			foreach($ads as $key => $val):

				$imp = $val['ad_imp'];
				$v = $imp-1;
				$this->update("tbl_advertise",array("ad_imp"=>$v),$val['id']);

				$res[] = $val;

			endforeach;

	return $res;
}


	public function setImages($data){

		foreach($data as $key => $val) :
			$img = $this->fetch("tbl_image","product_id='$val[id]' and feature=1");
			$val['image'] = $img['image'];

			$res[] = $val;
		endforeach;
		return $res;
	}

}
