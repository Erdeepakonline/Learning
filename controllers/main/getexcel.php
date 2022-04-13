<?php

class getexcel extends controller {

	function __construct(){

		parent::__construct();

	}

	public function index(){

	// $qry = $this->db->query("SELECT
	// 				tbl_product.product_name,
	// 				tbl_product.product_code,
	// 				tbl_combination.size,
	// 				tbl_combination.weight,
	// 				tbl_combination.buyer_price,
	// 				tbl_combination.buyer_discount,
	// 				tbl_combination.wh_price,
	// 				tbl_combination.wh_discount,
	// 				tbl_combination.usd_price,
	// 				tbl_combination.usd_discount,
	// 				tbl_combination.npr_price,
	// 				tbl_combination.npr_discount
	// 				FROM tbl_product, tbl_combination
	// 				WHERE tbl_combination.product_id=tbl_product.id
	// 				 ");

					 $qry = $this->db->query("SELECT
				 					tbl_product.product_name,
				 					tbl_product.product_code
				 					FROM tbl_product
				 					WHERE NOT EXISTS
									(SELECT * FROM tbl_combination
										WHERE tbl_combination.product_id=tbl_product.id)
				 					 ");

				 $res['data'] = $qry->fetchAll(PDO::FETCH_ASSOC);
				 tamplate("excel",$res);
	}

}
