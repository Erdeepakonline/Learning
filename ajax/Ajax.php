<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Ajax extends CI_Controller {
  function __construct() {
		parent::__construct();
        $this->load->model("main_model");

	}

  function get_country() {
    $data = $this->db->select("id, country")->where("status", 1)->order_by("country")->get("country")->result_array();
    echo json_encode($data);
  }


	function get_state() {
    $id = $this->input->post("cid");
    $data = $this->db->select("id, state")->where("country_id", $id)->order_by("state")->get("state")->result_array();
    echo json_encode($data);
  }


  function get_city() {
    $ids = $this->input->post("cid");
    $id = explode(',', $ids);
    $data = $this->db->select("id, city")->where_in("state_id", $id)->order_by("city")->get("city")->result_array();
    echo json_encode($data);
  }

  public function store_data(){
    $row=$this->input->post("row");
   $data =$this->db->select("*")->where("status=1")->order_by("id","desc")->limit(4, $row)->get("store")->result_array();
   echo json_encode($data);
  }

  public function school_data(){
    $row=$this->input->post("row");
    $data =$this->db->select("*")->where("status=1")->order_by("id","desc")->limit(2, $row)->get("school")->result_array();
    echo json_encode($data);
  }

  public function check_ref(){
    $code = $this->input->post("refc");
    if($code) {
      $row = $this->db->where("ref_code", $code)->get("ref_code")->row_array();
      if(!empty($row)) {
        echo json_encode(array(
          "status" => 1,
          "msg"=>"Validated Successfully"
        ));

      } else {
        echo json_encode(array(
          "status" => 0,
          "msg"=>"Invalid Referral Code."
        ));
      }
    }
  }

  public function resend_otp() {
    $this->load->model("mail_model");
    $conf['msg'] = $_SESSION['otp']." is your OTP for verification.";
    $conf['mobile'] = $_SESSION[USER]['mobile'];
    $this->mail_model->artistOtpMail($_SESSION[USER]['fname'], $_SESSION[USER]['email'], $_SESSION['otp']);
    $this->main_model->sendSMS($conf);
    echo json_encode(array("status"=>1, "msg"=> "OTP sent Successfully"));
  }



    public function search() {

    $src = $this->input->post("src");
    $url = base_url();
    // $qry = $this->db->query("SELECT ar.slug,
				// 				CONCAT(ar.fname,' ', ar.lname) as name,
				// 				IF (ar.profile_pic != '', CONCAT('".AWS_IMG_URL."100x100/artist','/',ar.profile_pic), '".$url."media/default-logo.png' ) as image,
    //             ('".$url."artist-info/') as url,
    //               SUBSTRING(ar.artist_bio, 1, 150) as udesc,
				// 				('Artist') as type
				// 				FROM adv_artist ar
				// 				WHERE ar.status = 1
    //             AND CONCAT(ar.fname,' ', ar.lname) like '%".$src."%'
    //             AND ar.city > 0

				// 				UNION
				// 				SELECT st.slug,
				// 				st.studio_name as name,
				// 				IF (st.studio_logo != '', CONCAT('".$url."media/studio','/',st.studio_logo), '".$url."media/default-logo.png' ) as image,
				// 				('".$url."studio-info/') as url,
    //             SUBSTRING(st.studio_bio,1, 150) as udesc,
    //         		('Studio') as type
				// 				FROM adv_studios st
				// 				WHERE st.status = 1
    //             AND st.studio_name like '%".$src."%'

				// 				UNION
    //             SELECT sc.slug,
    //             sc.school_name as name,
    //             IF (sc.school_logo != '', CONCAT('".$url."media/school','/',sc.school_logo), '".$url."media/default-logo.png' ) as image,
    //             ('".$url."school-details/') as url,
    //             SUBSTRING(sc.school_desc,1, 150) as udesc, 
    //         	('School') as type
    //             FROM adv_school sc
    //             WHERE sc.status = 1 
    //             AND (SELECT COUNT(*) FROM adv_school_video vid WHERE vid.school_id = sc.id) >= 3 
    //             AND (SELECT COUNT(*) FROM adv_school_portfolio prt WHERE prt.school_id = sc.id) >= 3 
    //             AND sc.school_name like '%".$src."%'

    //             UNION
    //             SELECT cat.slug,
    //             cat.category_name as name,
    //             IF (cat.image != '', CONCAT('".$url."media/category','/',cat.image), '".$url."media/default-logo.png' ) as image,
    //             ('".$url."design-detail/') as url,
    //             SUBSTRING(cat.cat_desc,1, 150) as udesc, 
    //         	('Design') as type
    //             FROM adv_category cat
    //             WHERE cat.status = 1
    //             AND cat.category_name like '%".$src."%'

    //             UNION
    //             SELECT st.store_name as slug,
    //             st.store_name as name,
    //             IF (st.store_img != '', CONCAT('".$url."media/store','/',st.store_img), '".$url."media/default-logo.png' ) as image,
    //             ('".$url."shop/info/') as url,
    //             SUBSTRING(st.about_shop, 1, 150) as udesc,
    //             ('Shop') as type
    //             FROM adv_store st
    //             WHERE st.status = 1 
    //             AND st.store_name like '%".$src."%'

    //             UNION
    //             SELECT sp.slug,
    //             sp.product_name as name,
    //             (SELECT  CONCAT('".AWS_IMG_URL."shop','/',img.product_image) FROM adv_shop_product_image img WHERE img.product_id=sp.id LIMIT 1 ) AS image,
    //             ('".$url."shop/product/') as url,
    //             SUBSTRING(sp.product_desc, 1, 150) as udesc,
    //             ('Product') as type
    //             FROM adv_shop_product sp, adv_store st
    //             WHERE sp.status = 1 AND sp.shop_id = st.id AND st.status = 1 
    //             AND sp.adm_status = 1  AND sp.trash = 0 
    //             AND sp.product_name like '%".$src."%'

    //             UNION
    //             SELECT bg.slug,
    //             bg.title as name,
    //             IF (bg.image != '', CONCAT('".$url."media/blog','/',bg.image), '".$url."media/default-logo.png') as image,
    //             ('".$url."blog-detail/') as url,
    //             SUBSTRING(bg.meta_desc,1, 150) as udesc,
    //             ('Blog') as type
    //             FROM adv_blog bg
    //             WHERE bg.status = 1
    //             AND bg.title like '%".$src."%'

    //             UNION
    //             SELECT
    //             IF (ap.type=1, (SELECT ar.slug FROM adv_artist ar WHERE ar.id=ap.artist_id), (SELECT st.slug FROM adv_studios st WHERE st.id=ap.studio_id)) AS slug,
    //             ap.title as name,
    //             CONCAT('".AWS_IMG_URL."90x90/portfolio','/',ap.image)  as image,
    //             IF (ap.type=1, '".$url."artist-info/', '".$url."studio-info/' ) as url,
    //             SUBSTRING(ap.img_desc,1, 150) as udesc,
    //             ('Portfolio') as type
    //             FROM adv_artist_portfolio ap
    //             WHERE ap.title like '%".$src."%'
    //             AND ap.img_tags like '%".$src."%'
				// 				LIMIT 0, 9");

    //   $data = $qry->result_array();
    
      if($src) {
        $data['artist'] = $this->getArtistResult( $src );
        $data['studio'] = $this->getStudioResult( $src );
        $data['design'] = $this->getDesign( $src );
        $data['blogs'] = $this->getBlogs( $src );
        $data['products'] = $this->getProducts( $src );
      }
      
      echo json_encode($data);
    }



  public function findCity() {

    $city = trim($this->input->post("city"));
    $state = trim($this->input->post("state"));

    $row = $this->db->where(array("city"=>$city, "status"=>1))->get("city")->num_rows();

    if($row) {
      echo json_encode(array("city_exist"=>true));
    } else {
      echo json_encode(array("city_exist"=>false));
    }

  }


  public function check_email () {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

    $email = $this->input->post('email');
    if($email) {
        $row = $this->db->where("email", $email)->get("artist")->num_rows();
        if($row)  {
          echo json_encode(array('status'=>true));
        } else {
          echo json_encode(array('status'=>false));
        }
    }

  }

  public function check_user_email() {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

    $email = $this->input->post('email');
    if($email) {
        $row = $this->db->where("email", $email)->get("customer")->num_rows();
        if($row)  {
          echo json_encode(array('status'=>true));
        } else {
          echo json_encode(array('status'=>false));
        }
    }

  }



  public function cred_validation() {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

    $act = $this->input->post('act');
    $val = $this->input->post('val');

    if($act == 'mobile') {

        if(is_numeric($val)) {
            if(strlen($val) == 10) {
                $row = $this->db->where("mobile", $val)->get("customer")->num_rows();
                if($row)  {
                  echo json_encode(array('status'=>true, "msg" => "This mobile number is already registered"));
                } else {
                  echo json_encode(array('status'=>false));
                }
            } else {
                echo json_encode(array('status'=>true, "msg"=> "Mobile number should be 10 digit only"));
            }
        }  else {
            echo json_encode(array('status'=>true, "msg"=> "Mobile number should be numeric only"));
        }

    } elseif($act == 'email') {
        if (filter_var($val, FILTER_VALIDATE_EMAIL)) {
            $row = $this->db->where("email", $val)->get("customer")->num_rows();
            if($row)  {
              echo json_encode(array('status'=>true, "msg" => "This email is already registered"));
            } else {
                echo json_encode(array('status'=>false));
            }
        } else {
          echo json_encode(array('status'=>true, "msg" => "Please enter valid email address"));
        }
    }

  }


  public function check_shop_name() {
    $name = $this->input->post("shop_name");
    if(strlen($name)) {
      $row =   $this->db->where("store_name", $name)->get("store")->num_rows();
      if($row) {
        $data = ['status' => 1];
      } else {
        $data = ['status' => 0];
      }
      echo json_encode($data);
    }
  }
  
  
  
  // =====================================================//
  // *************** Search Query Functions *************//
  //====================================================//

  public function getArtistResult($src='') {

    $url = base_url();
    $qry =  $this->db->query("SELECT ar.slug, ar.cats,
		 						CONCAT(ar.fname,' ', ar.lname) as name, ct.city, cn.country,
		 						IF (ar.profile_pic != '', CONCAT('".AWS_IMG_URL."100x100/artist','/',ar.profile_pic), '".$url."media/default-logo.png' ) as image,
                 ('".$url."artist-info/') as url,
                   SUBSTRING(ar.artist_bio, 1, 150) as udesc
		 						FROM adv_artist ar, adv_city ct, adv_country cn
		 						WHERE ar.status = 1
                 AND CONCAT(ar.fname,' ', ar.lname) like '%".$src."%'
                 AND ar.city = ct.id AND ar.country = cn.id
                 OR ct.city like '%".$src."%'
                 AND ar.city = ct.id AND ar.country = cn.id LIMIT 10");
    $rows = $qry->result_array();

    if(empty($rows)) {

      $cid = $this->db->like('category_name', $src)->get('category')->row()->id;
      if($cid) {

          $qry2 =  $this->db->query("SELECT ar.slug, ar.cats,
                      CONCAT(ar.fname,' ', ar.lname) as name, ct.city, cn.country,
                      IF (ar.profile_pic != '', CONCAT('".AWS_IMG_URL."100x100/artist','/',ar.profile_pic), '".$url."media/default-logo.png' ) as image,
                      ('".$url."artist-info/') as url,
                      SUBSTRING(ar.artist_bio, 1, 150) as udesc
                      FROM adv_artist ar, adv_city ct, adv_country cn
                      WHERE ar.status = 1
                      AND FIND_IN_SET('".$cid."', ar.cats) <> 0
                      AND ar.city = ct.id AND ar.country = cn.id LIMIT 10");
          $rows = $qry2->result_array();

      }

  }


    if(!empty($rows)) {
      foreach ($rows as $key => $val) {
        $cats = $this->db->select('category_name, slug')->where_in("id", explode(',', $val['cats']))->get('category')->result_array();
        $htm = '';
        if(!empty($cats)) {
            foreach ($cats as $key => $val2) {
              $htm .= '<a href="'.base_url().'design-detail/'.$val2['slug'].'"><span class="tag2">'.$val2['category_name'].'</span></a>';
            }
        }
        $val['cats'] = $htm;
        $res[] = $val;
      }
    }

    $row = $res;
    return $row;
  }


  public function getStudioResult($src='') {

    $url = base_url();
    $qry =  $this->db->query("SELECT st.slug,
		 						st.studio_name as name, ct.city, cn.country,
		 						IF (st.studio_logo != '', CONCAT('".$url."media/studio','/',st.studio_logo), '".$url."media/default-logo.png' ) as image,
		 						('".$url."studio-info/') as url,
                 SUBSTRING(st.studio_bio,1, 150) as udesc
		 						FROM adv_studios st, adv_city ct, adv_country cn
								WHERE st.status = 1
                AND st.studio_name like '%".$src."%'
                AND st.city = ct.id AND st.country = cn.id
                OR ct.city like '%".$src."%'
                AND st.city = ct.id AND st.country = cn.id LIMIT 10");
    $rows = $qry->result_array();

    return $rows;
  }

  public function getDesign($src='') {

    $url = base_url();

    $cat = $this->db->select('slug, category_name')->like('category_name', $src)->get('category')->row();
    $cid = $cat->category_name;
    
    if($cid) {
      $qry =  $this->db->query("SELECT
              IF (ap.type=1, (SELECT ar.slug FROM adv_artist ar WHERE ar.id=ap.artist_id), (SELECT st.slug FROM adv_studios st WHERE st.id=ap.studio_id)) AS slug,
              ap.title as name, CONCAT(ar.fname, ' ', ar.lname) as ar_name,
              CONCAT('".AWS_IMG_URL."90x90/portfolio','/',ap.image)  as image,
              IF (ap.type=1, '".$url."artist-info/', '".$url."studio-info/' ) as url,
              ('".$cat->slug."') as slug2,
              ('".$url."design-detail/') as url2
              FROM adv_artist_portfolio ap, adv_artist ar
              WHERE FIND_IN_SET('".$cid."', ap.img_tags) <> 0
              AND ap.artist_id = ar.id
              LIMIT 0, 8");
    } else {
        $qry =  $this->db->query("SELECT
                IF (ap.type=1, (SELECT ar.slug FROM adv_artist ar WHERE ar.id=ap.artist_id), (SELECT st.slug FROM adv_studios st WHERE st.id=ap.studio_id)) AS slug,
                ap.title as name, CONCAT(ar.fname, ' ', ar.lname) as ar_name,
                CONCAT('".AWS_IMG_URL."90x90/portfolio','/',ap.image)  as image,
                IF (ap.type=1, '".$url."artist-info/', '".$url."studio-info/' ) as url,
                ('".$cat->slug."') as slug2,
                ('".$url."design-detail/') as url2
                FROM adv_artist_portfolio ap, adv_artist ar
                WHERE ap.title like '%".$src."%'
                AND ap.img_tags like '%".$src."%'
                AND ap.artist_id = ar.id
		 						LIMIT 0, 8");

    }

    $rows = $qry->result_array();
    return $rows;

  }


  public function getBlogs($src='') {
    $url = base_url();
    $qry =  $this->db->query("SELECT bg.slug,
                             bg.title as name,
                             IF (bg.image != '', CONCAT('".$url."media/blog','/',bg.image), '".$url."media/default-logo.png') as image,
                             ('".$url."blog-detail/') as url,
                             SUBSTRING(bg.meta_desc,1, 150) as udesc
                             FROM adv_blog bg
                             WHERE bg.status = 1
                             AND bg.title like '%".$src."%' LIMIT 10");
    $rows = $qry->result_array();
    return $rows;
  }


  public function getProducts($src='') {
    $url = base_url();
    $qry =  $this->db->query("SELECT sp.slug,
                 sp.product_name as name, sp.price, sp.sell_price,
                 (SELECT  CONCAT('".AWS_IMG_URL."shop','/',img.product_image) FROM adv_shop_product_image img WHERE img.product_id=sp.id LIMIT 1 ) AS image,
                 ('".$url."shop/product/') as url,
                 SUBSTRING(sp.product_desc, 1, 150) as udesc
                 FROM adv_shop_product sp, adv_store st
                 WHERE sp.status = 1 AND sp.shop_id = st.id AND st.status = 1
                 AND sp.adm_status = 1  AND sp.trash = 0
                 AND sp.product_name like '%".$src."%' LIMIT 8");
    $rows = $qry->result_array();
    return $rows;
  }


}
