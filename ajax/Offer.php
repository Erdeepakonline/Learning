<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Offer extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
    $this->db->query('SET SESSION sql_mode = ""');
	}


      public function offer_data() {
        // sleep(2);

        $row = $this->input->post('row');
        $type = $this->input->post('type');
        $cntry = $this->input->post('country');
        $city = $this->input->post('city');
        $ctype = $this->input->post('ctype');

        if($ctype == 1) {
            $sctyp = " AND st.certified = 1 ";

        }

        if($ctype == 2) {
            $sctyp = " AND st.certified = 0 ";

        }

        if($type == 1) {
            $st = " AND st.id = 0 ";
            $sp = " AND sp.id = 0 ";
        }


        if($type == 2) {
            $ar = " AND ar.id = 0 ";
            $sp = " AND sp.id = 0 ";
        }

        if($type == 3) {
            $ar = " AND ar.id = 0 ";
            $st = " AND st.id = 0 ";
        }


	    if($city > 0) {
	        $act = "AND ar.city = '".$city."'";
	        $sct = "AND st.city = '".$city."'";
	    }

      if($cntry > 0) {
	        $act2 = "AND ar.country = '".$cntry."'";
	        $sct2 = "AND st.country = '".$cntry."'";
	    }

	    if($ctype > 0) {

        	        if($ctype == 1) {
        	            $this->db->select(" st.code, st.slug,
      						st.studio_name as name,
      						IF (st.studio_logo != '', CONCAT('".base_url()."media/studio','/',st.studio_logo), '' ) as image,
      						st.studio_logo as img,
      						st.studio_offer as offer,
      						('studio-info') as url,
      						sc.id as cid");
            			$this->db->from("studios st, studio_certification sc");
            			$this->db->where("st.status", 1);
            			$this->db->where("st.studio_offer !=' '");
            			$this->db->where("DATE(st.ofr_sdate) <= DATE('".date("Y-m-d")."')");
            			$this->db->where("DATE(st.ofr_sdate) >= DATE('".date('Y-m-d')."')");
            			$this->db->where("st.id=sc.studio_id");
            			$this->db->where("DATE(sc.expiry_date) > DATE()");
            			$this->db->limit(9, $row);
            			$res = $this->db->get()->result_array();

	        }else{
                  $this->db->select(" st.code, st.slug,
                        st.studio_name as name,
                        IF (st.studio_logo != '', CONCAT('".base_url()."media/studio','/',st.studio_logo), '' ) as image,
                        st.studio_logo as img,
                        st.studio_offer as offer,
                        ('studio-info') as url,
                        sc.id as cid");
                  $this->db->from("studios st, studio_certification sc");
                  $this->db->where("st.status", 1);
                  $this->db->where("st.studio_offer !=' '");
                  $this->db->where("DATE(st.ofr_sdate) <= DATE('".date("Y-m-d")."')");
    			  $this->db->where("DATE(st.ofr_sdate) >= DATE('".date('Y-m-d')."')");
                  $this->db->where("st.id != sc.studio_id");
                  $this->db->group_by('st.code');
                  // $this->db->where("DATE(sc.expiry_date) > DATE('".date("Y-m-d")."')");
                  $this->db->limit(9, $row);

                  $res = $this->db->get()->result_array();
               }

	    } else {

	            $qry = $this->db->query("SELECT ar.code, ar.slug,
							CONCAT(ar.fname,' ', ar.lname) as name,
							IF (ar.profile_pic != '', CONCAT('".AWS_IMG_URL."300x300/artist','/',ar.profile_pic), ' ' ) as image,
							ar.profile_pic as img,
							ar.artist_offer as offer,
							('artist-info') as url,
              ('tattoo') as type
							FROM adv_artist ar
							WHERE ar.artist_offer != ' ' 
							AND DATE(ar.ofr_sdate) <= DATE('".date('Y-m-d')."')
							AND DATE(ar.ofr_edate) >= DATE('".date('Y-m-d')."')
							AND ar.status = 1 ".$ar . $act . $act2 ."
						 	UNION
							SELECT st.code, st.slug,
							st.studio_name as name,
							IF (st.studio_logo != '', CONCAT('".base_url()."media/studio','/',st.studio_logo), ' ' ) as image,
							st.studio_logo as img,
							st.studio_offer as offer,
							('studio-info') as url,
              ('tattoo') as type
							FROM adv_studios st
							WHERE st.studio_offer != ' ' 
							AND DATE(st.ofr_sdate) <= DATE('".date('Y-m-d')."')
							AND DATE(st.ofr_edate) >= DATE('".date('Y-m-d')."')
							AND st.status = 1  ".$st . $sct . $sct2 . $sctyp ."
              UNION
              SELECT sp.code, sp.store_name as slug,
              sp.store_name as name,
              IF (sp.store_img != '', CONCAT('".base_url()."media/store','/',sp.store_img), ' ' ) as image,
              sp.store_img as img,
              cpn.title as offer,
              ('shop/info') as url,
              ('shop') as type
              FROM adv_store sp, adv_shop_coupon cpn
              WHERE cpn.status = 1 AND cpn.off_show = 1 AND cpn.shop_id = sp.id AND DATE(cpn.start_date) <= DATE('".date('Y-m-d')."') AND DATE(cpn.end_date) >= DATE('".date('Y-m-d')."') ".$sp."
							LIMIT $row, 9");

        $res = $qry->result_array();
        
         $qry2 = $this->db->query("SELECT ar.code, ar.slug,
							CONCAT(ar.fname,' ', ar.lname) as name,
							IF (ar.profile_pic != '', CONCAT('".AWS_IMG_URL."300x300/artist','/',ar.profile_pic), ' ' ) as image,
							ar.profile_pic as img,
							ar.artist_offer as offer,
							('artist-info') as url,
              ('tattoo') as type
							FROM adv_artist ar
							WHERE ar.artist_offer != ' ' 
							AND DATE(ar.ofr_sdate) <= DATE('".date('Y-m-d')."')
							AND DATE(ar.ofr_edate) >= DATE('".date('Y-m-d')."')
							AND ar.status = 1 ".$ar . $act . $act2 ."
						 	UNION
							SELECT st.code, st.slug,
							st.studio_name as name,
							IF (st.studio_logo != '', CONCAT('".base_url()."media/studio','/',st.studio_logo), ' ' ) as image,
							st.studio_logo as img,
							st.studio_offer as offer,
							('studio-info') as url,
              ('tattoo') as type
							FROM adv_studios st
							WHERE st.studio_offer != ' ' 
							AND DATE(st.ofr_sdate) <= DATE('".date('Y-m-d')."')
							AND DATE(st.ofr_edate) >= DATE('".date('Y-m-d')."')
							AND st.status = 1  ".$st . $sct . $sct2 . $sctyp ."
              UNION
              SELECT sp.code, sp.store_name as slug,
              sp.store_name as name,
              IF (sp.store_img != '', CONCAT('".base_url()."media/store','/',sp.store_img), ' ' ) as image,
              sp.store_img as img,
              cpn.title as offer,
              ('shop/info') as url,
              ('shop') as type
              FROM adv_store sp, adv_shop_coupon cpn
              WHERE cpn.status = 1 AND cpn.off_show = 1 AND cpn.shop_id = sp.id AND DATE(cpn.start_date) <= DATE('".date('Y-m-d')."') AND DATE(cpn.end_date) >= DATE('".date('Y-m-d')."') ".$sp);
							
	    }
         $row = $qry2->num_rows();
        
        echo json_encode(["data"=>$res, "row" => $row]);

      }

}
