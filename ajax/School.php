<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class School extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}



  public function school_data() {
    // sleep(2);

    $row = $this->input->post('row');
    $ar_id = $this->input->post('ar_id');
    $loc = $this->input->post('loc');
    $name = $this->input->post('name');

    $loc_id = $this->db->select("id")->where("city", trim($loc))->get("city")->row()->id;

			
    // $this->db->select("sc.*, ct.city, st.state");
    // $this->db->from("school sc, city ct, state st");
    // $this->db->where("sc.city=ct.id");
    
    $src = '';
    
    if($ar_id) {
    //   $this->db->where("sc.artist_id",$ar_id);
        $src .= " AND artist_id = '".$ar_id."' ";
    }

    if(strlen($name)) {
    //   $this->db->like("sc.school_name", $name);
      $src .= " AND school_name like '%".$name."%' ";
    }

    if($loc_id) {
    //   $this->db->where("sc.city", $loc_id);
        $src .= " AND city = '".$loc_id."' ";
    }

    // $this->db->where("sc.state=st.id");
    // $this->db->where("sc.status",1);
    // $this->db->order_by("sc.id", "desc");
    // $this->db->limit(12,$row);
    // $data = $this->db->get()->result_array();
    
	$qry = $this->db->query("SELECT * FROM adv_school WHERE  (SELECT COUNT(*) FROM adv_school_video WHERE adv_school_video.school_id = adv_school.id) >= 3 AND (SELECT COUNT(*) FROM adv_school_portfolio WHERE adv_school_portfolio.school_id = adv_school.id) >= 3 AND school_name != '' $src AND status = 1 ORDER BY id DESC LIMIT $row, 12 ");
	$school = $qry->result_array();
	
	foreach( $school as $key => $val ) {
	    $val['city'] = $this->db->select("city")->where("id", $val['city'])->get("city")->row()->city;
	    $val['state'] = $this->db->select("state")->where("id", $val['state'])->get("state")->row()->state;
	    $data[] = $val;
	}
    // print_r($data);
    
    echo json_encode($data);

  }


	public function del_pimg()
	{
	    $this->load->library('awsloader');
        $bucket = 'thetattoopdbucket';

		$id = $this->input->post("id");
			if($id>0) {
					$img = $this->db->select("image")->where("id", $id)->get("artist_portfolio")->row()->image;
					$this->db->where(array("id"=>$id))->delete("artist_portfolio");
					$this->awsloader->delete("school/".$img, $bucket);
				// 	unlink("media/portfolio/".$img);
			}
	}


	public function del_cv()
	{
	    $this->load->library('awsloader');
        $bucket = 'school-curriculum';

		$id = $this->input->post("id");
			if($id>0) {
					echo $file = $this->db->select("file_name")->where("id", $id)->get("school_files")->row()->file_name;
					$this->db->where(array("id"=>$id))->delete("school_files");
					$this->awsloader->delete($file, $bucket);
			}
	}


    public function get_enquiry() {

        $date = $this->security->xss_clean($this->input->post("src"));
        $row = $this->security->xss_clean($this->input->post("row"));
        $sort = $this->security->xss_clean($this->input->post("sort"));

        if(!empty($_SESSION[SCHOOL])) {

            $this->db->where("school_id", $_SESSION[SCHOOL]['id']);
            $this->db->order_by("id", $sort);
            $this->db->limit(20, $row);
            $data = $this->db->get("school_enquiry")->result_array();
            // echo json_encode($data);

            if(!empty($data)) {
                foreach($data as $key => $val) {
                    $val['date'] = date("d-m-Y", strtotime($val['created']));
                    $res[] = $val;
                }

                echo json_encode(["status" => 1, "data"=> $res]);
            } else {
                echo json_encode(["status" => 0, "data"=> '']);
            }
        }

    }


    public function wallet_pay() {
      $pay = $this->input->post("payble");
      $wlt = $this->db->select("wallet")->where("id", $_SESSION[USER]['id'])->get("artist")->row()->wallet;
      if($pay > 0) {
        if($wlt > $_SESSION['sch']['payble']) {
        //   $amt = $wlt-$_SESSION['sch']['payble'];
          $_SESSION['sch_wlt']['redeem'] = $_SESSION['sch']['payble'];
          $_SESSION['sch']['payble'] = 0;
        } else {
          $_SESSION['sch']['payble'] = $_SESSION['sch']['payble']-$wlt;
          $_SESSION['sch_wlt']['redeem'] = $wlt;
        }
      } else {
        unset($_SESSION['sch']);
        unset($_SESSION['sch_wlt']);
      }
      echo json_encode(["status" => 1, "data"=> $res]);
    }
    
    
    
    public function set_package() {

      $pid = $this->input->post('pid');
      $row = $this->db->where("id", $pid)->get("sch_pack")->row_array();

      if(!empty($row)) {

        unset($_SESSION['pay']);
        unset($_SESSION['pw']);
        unset($_SESSION['wlt']);
        unset($_SESSION['ren_pack']);

        $_SESSION['sch_pack_id'] = $pid;
        $_SESSION['pack_type'] = 1;

        if($row['price'] == 0) {
          echo json_encode(["status" =>1, "free_pack" => 1]);
        } else {
          echo json_encode(["status" =>1]);
        }

      }

    }



    public function renew_pack_info() {
      $id = $this->input->post("pid");
      if($id>0) {
        $pack = $this->db->where(array("id"=> $id))->get("school_pacakge")->row_array();
        $_SESSION['ren_pack'] = $pack;
        $_SESSION['sch_pack_id'] = $pack['pack_id'];
        echo json_encode(["status" => 1]);
      } else {
        echo json_encode(["status" => 0]);
      }

    }
    
}
