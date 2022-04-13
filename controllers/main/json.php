<?php

class json extends controller {

	function __construct(){

		parent::__construct();

	}

	public function index(){
		
		$q = $this->db->query("SELECT * FROM tbl_store");
		$data = $q->fetchAll(PDO::FETCH_ASSOC);
		echo json_encode($data);


		// Parameters
		// $lat = floatval($_REQUEST['lat']);
		// $lng = floatval($_REQUEST['lng']);
		// if( !$lat || !$lng )
		// {
		// 	$protocol = (isset($_SERVER['SERVER_PROTOCOL']) ? $_SERVER['SERVER_PROTOCOL'] : 'HTTP/1.0');
		// 	header("$protocol 400 Bad Request");
		// 	die(json_encode(array('error' => "Wrong values for 'lat' and/or 'lng' parameters.")));
		// }
		//
		//
		// $q = $this->db->query("SELECT id, name, address, zip, city, state, country, latitude, longitude,
		// 			((ACOS(SIN($lat * PI() / 180) * SIN(latitude * PI() / 180) + COS($lat * PI() / 180) * COS(latitude * PI() / 180) * COS(($lng - longitude) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance
		// 		FROM tbl_store
		// 		HAVING distance <= 10
		// 		ORDER BY distance ASC");
		//
		// 	$store = $q->fetchAll(PDO::FETCH_ASSOC);
		//
		// 	foreach ($store as $key => $val) {
		//
		// 		$val['distance-kilometers'] = round($val['distance']) . ' km';
		// 		$val['distance-miles'] = round($val['distance'] / 1.6) . ' mi';
		//
		// 		$nearbyStores[] = $val;
		//
		// 	}
		//
		// 	echo json_encode($nearbyStores);

}

}
