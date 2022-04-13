<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Lead extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
    $this->load->model('mail_model');
    $this->load->helper('shop_mail');
	}

  public function lead_action() {
     $id = $this->input->post('lead_id');
     $act = $this->input->post('act');
     $utype = $this->input->post('utype');

    if($act == 'accept') {
      $val = 1;
    } elseif($act == 'reject') {
      $val = 2;
    }


    if($utype == 'art') {
      if(!empty($_SESSION[USER]) && $id > 0) {
        $this->db->where(['id' => $id, 'user_id' => $_SESSION[USER]['id']])->update('user_lead', ['status' => $val]);
        echo json_encode(['status' => 1]);
      }
    }

    if($utype == 'std') {
      if(!empty($_SESSION[STUDIO]) && $id > 0) {
        $this->db->where(['id' => $id, 'user_id' => $_SESSION[STUDIO]['id']])->update('user_lead', ['status' => $val]);
      }
    }

  }


  public function add_planner () {
    $id = $this->input->post('id');

  }

}
