<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Studio extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}

  public function studio_data() {

    $row = $this->input->post('row');
    $loc = $this->input->post('loc');
    $cnt = $this->input->post('scont');
    $ctype = $this->input->post('ctype');
    $name = $this->input->post('name');
    
    $state = trim($this->input->post('state'));
    
    $cty = $this->db->select("id, state_id")->where("city", trim($loc))->get("city")->row();
    $loc_id = $cty->id;
    
    $st_id = $this->db->select("id")->where("state", trim($state))->get("state")->row()->id;

    $this->db->select("st.id, st.code,  st.slug, st.studio_name as name, st.studio_logo, st.facebook,  st.instagram, ct.city, sts.state, cn.country");
    $this->db->from("studios st, city ct, state sts, studio_package sp, country cn");
    
    if($ctype == 1) {
        // $this->db->where("sc.studio_id = st.id");
        $this->db->join("studio_certification sc", "st.id=sc.studio_id");
    } elseif($ctype == 2) {
        // $this->db->where("sc.studio_id != st.id");
        $this->db->join("studio_certification sc", "st.id != sc.studio_id");
        $this->db->group_by("st.id");
    }

    $this->db->where("st.state=sts.id");
    $this->db->where("st.country=cn.id");
    $this->db->where("st.city=ct.id");
    $this->db->where("sp.studio_id=st.id");

    if(strlen($name)) {
      $this->db->like("st.studio_name", $name);
    }

    if($loc_id) {
      $this->db->where("st.city", $loc_id);
    }
    
    if($cnt) {
      $this->db->where("st.country", $cnt);
    }
    
    
    if(!$loc_id && $st_id > 0) {
        $this->db->where("st.state", $st_id);
    }
     

    $this->db->where("st.status",1);
    $this->db->where("sp.status",1);
	$this->db->order_by("st.list_order", "DESC");
	$this->db->order_by("sp.pack_id", "DESC");
	$this->db->order_by("sp.amount", "DESC");
    $this->db->limit(8,$row);
    $data = $this->db->get()->result_array();
    
      if($loc_id > 0 && empty($data) && $row == 0) {

        
            $this->db->select("st.id, st.code, st.slug, st.studio_name as name, st.studio_logo, st.facebook,  st.instagram, ct.city, sts.state");
            $this->db->from("studios st, city ct, state sts, studio_package sp");
            
            if($ctype == 1) {
                // $this->db->where("sc.studio_id = st.id");
                $this->db->join("studio_certification sc", "st.id=sc.studio_id");
            } elseif($ctype == 2) {
                // $this->db->where("sc.studio_id != st.id");
                $this->db->join("studio_certification sc", "st.id != sc.studio_id");
                
            }

        
            $this->db->where("st.state=sts.id");
            $this->db->where("st.city=ct.id");
            $this->db->where("sp.studio_id=st.id");
        
            if(strlen($name)) {
              $this->db->like("st.studio_name", $name);
            }
        
            $this->db->where("st.state", $cty->state_id);
        
            $this->db->where("st.status",1);
            $this->db->where("sp.status",1);
            
            $this->db->group_by("st.id");
        	
        	$this->db->order_by("st.list_order", "DESC");
        	$this->db->order_by("sp.pack_id", "DESC");
        	$this->db->order_by("sp.amount", "DESC");
        	
            $this->db->limit(8,$row);
            $data2 = $this->db->get()->result_array();
          
      }
      
    if(!empty($data)) {
     foreach ($data as $key => $val) {
        $val['certify'] = $this->db->where(["studio_id"=> $val['id'], "status" => 1])->where("DATE(expiry_date) >= DATE('".date('Y-m-d')."')")->get("studio_certification")->num_rows();
        $res[] = $val;
      }
        echo json_encode(["status"=>1, "data"=>$res]);
    } elseif(empty($data) && !empty($data2)) {
        foreach ($data2 as $key => $val) {
            $val['certify'] = $this->db->where(["studio_id"=> $val['id'], "status" => 1])->where("DATE(expiry_date) >= DATE('".date('Y-m-d')."')")->get("studio_certification")->num_rows();
            $res[] = $val;
          }
        echo json_encode(["status"=>1, "nearby"=>1, "data"=>$res]);
    } else { 
        echo json_encode(["status" => 0]);
    }
      

    // $this->db->where();
  }


 public function set_package() {
     $pid = $this->security->xss_clean($this->input->post('pack_id'));
     if($pid>0){
         $pack = $this->db->where("id", $pid)->get("package")->row_array();
        if(!empty($pack)){
            if($pack['price'] == 0) {
                $data = array(
                    "studio_id" => $_SESSION[STUDIO]['id'],
                    "pack_id" => $pack['id'],
                    "ex_date" => date("Y-m-d", strtotime("+ 10 year")),
                    "free_pack" => 1,
                    "status" => 1
                    );
                $this->db->insert("studio_package", $data);
                $res = array("status" => 2);
            } else {
                $_SESSION['pack_id'] = $pack['id'];
                $res = array("status" => 1);
            }
        } else {
            $res = array("status" => 0);
        }

     } else {
         $res = array("status" => 0);
     }

     echo json_encode($res);
 }


    public function certify_studio() {

        $row = $this->db->where("id", $_SESSION[STUDIO]['id'])->get("studios")->row_array();
        // print_r($row);
        if($row['certified'] == 0) {

            $amt = STUDIO_CERTIFY_AMT;
            $gst = ($amt/100)*18;
            $_SESSION['crt_studio']['studio_id'] = $_SESSION[STUDIO]['id'];
            $_SESSION['crt_studio']['amount'] = $amt;
            $_SESSION['crt_studio']['gst'] = $gst;
            $_SESSION['crt_studio']['total'] = $amt+$gst;
            $_SESSION['crt_studio']['payble'] = $amt+$gst;
            unset($_SESSION['crt_wlt']);
            echo json_encode(array("status"=>1));
        } else {
            echo json_encode(array("status"=>0));
        }
    }


    public function wallet_pay () {

      $pay = $this->input->post("payble");
      $wlt = $this->db->select("wallet")->where("id", $_SESSION[USER]['id'])->get("artist")->row()->wallet;

      if($pay > 0) {
        if($wlt >= $_SESSION['crt_studio']['total'] ) {
          $_SESSION['crt_studio']['payble'] = 0;
          $_SESSION['crt_wlt']['redeem'] = $_SESSION['crt_studio']['total'];
        } else {
          $_SESSION['crt_studio']['payble'] = $_SESSION['crt_studio']['total']-$wlt;
          $_SESSION['crt_wlt']['redeem'] = $wlt;
        }
      } else {
        $_SESSION['crt_studio']['payble'] = $_SESSION['crt_studio']['total'];
         unset($_SESSION['crt_wlt']);
      }

      echo json_encode(['status' => 1]);
    }
    
    
    public function renew_pack_info() {
      $id = $this->input->post("pid");
      if($id>0) {
        $pack = $this->db->where(array("id"=> $id))->get("studio_package")->row_array();
        $_SESSION['ren_pack'] = $pack;
        $_SESSION['pack_id'] = $pack['pack_id'];
        echo json_encode(["status" => 1]);
      } else {
        echo json_encode(["status" => 0]);
      }

    }

}
