<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Report extends CI_Controller {
    
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
    $this->load->model('mail_model');
    $this->load->helper('shop_mail');
	}


  public function clear_src() {
        unset($_SESSION['src']);
        echo json_encode(["status" => 1]);
  }

}
