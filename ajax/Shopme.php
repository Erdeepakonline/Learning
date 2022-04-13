<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Shopme extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}

	public function check_shop() {

    if(!empty($_SESSION[USER])) {

      $row = $this->db->select('id, store_name, owner_name, status')->where(["owner_id" => $_SESSION[USER]['id'], "owner_type" => 1])->get('store')->row_array();

      if(!empty($row)) {

        if($row['status'] == 1) {
          $_SESSION[SHOP] = $row;
          $data = ['shop_login'=>1];
        } else {
          $data = ['shop_login'=>2];
        }

      } else {
          $data = ['no_shop'=>1];
      }

    } elseif (!empty($_SESSION[CUSTOMER])) {
      $row = $this->db->select('id, store_name, owner_name, status')->where(["owner_id" => $_SESSION[CUSTOMER]['id'], "owner_type" => 2])->get('store')->row_array();

      if(!empty($row)) {

        if($row['status'] == 1) {
          $_SESSION[SHOP] = $row;
          $data = ['shop_login'=>1];
        } else {
          $data = ['shop_login'=>2];
        }

      } else {
          $data = ['no_shop'=>1];
      }

    }

    echo json_encode($data);
	}


  public function get_section_list() {

    		$this->db->select('id, shop_section');
    		$this->db->from('shop_section');
        $this->db->where("shop_id", $_SESSION[SHOP]['id']);
    		$this->db->order_by('shop_section','asc');
    		$this->db->limit(10);
    		$rows = $this->db->get()->result_array();

    		echo json_encode(['status' => 1, 'data' => $rows]);

  }


  function delete_cart_item() {

    $id = $this->input->post("id");

    $this->db->where("id", $id);
    $data= $this->db->delete('cart');
    unset($_SESSION['CART_CPN']);
        if(!empty($data)) {
          echo json_encode(array(
            "status" => 1,
            "items"=>getAllCartData(),
          ));
        }

  }


  function delete_wish_item() {

    $id = $this->input->post("id");

    $this->db->where("id", $id);
    $data= $this->db->delete('wishlist');

        if(!empty($data)) {
          echo json_encode(array(
            "status" => 1,
          ));
        }

  }

  public function add_section()
  {
  $name =  $this->input->post('shop_section');
  $data['status'] = 0;

    if(strlen($name)) {
      $this->db->insert('shop_section', [
        "shop_section" => $name,
        "shop_id" => $_SESSION[SHOP]['id'],
        "status" => 0
      ]);
      $data['status'] = 1;
    }
    echo json_encode($data);
  }

  public function quick_edit() {
    $val = $this->input->post('edit_val');
    $_SESSION[SHOP]['qedit'] = $val;
    echo json_encode(['status' =>1]);
  }



	public function get_attribute() {
		$id = $this->input->post('id');

		if($id>0) {
			$data = $this->db->select('id, value as name, ')->where("att_group_id", $id)->order_by('order')->get("attributes")->result_array();
			echo json_encode(["status"=>1, "data" => $data]);
		}
	}

  public function prod_deactive() {
    $id = $this->input->post('pid');
    $val = $this->input->post('val');
    $this->db->where("id", $id)->update("shop_product", ['status'=>$val]);

    $this->session->set_flashdata('status_update', '  <div class="alert alert-success">
        <i class="far fa-check-circle"></i>&nbsp; Product Updated Successfully
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>');
    echo json_encode(['status' => 1]);
  }


  public function update_section() {
    $id = $this->input->post('pid');
    $val = $this->input->post('val');
    $this->db->where("id", $id)->update("shop_product", ["section" => $val]);
    $this->session->set_flashdata('status_update', '  <div class="alert alert-success">
        <i class="far fa-check-circle"></i>&nbsp; Section Updated Successfully
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>');
    echo json_encode(['status' => 1]);
  }



  public function pmoveto() {
    $id = $this->input->post('id');
    $act = $this->input->post('act');

    if($id > 0) {
      if($act == 'cart') {
        $row = $this->db->where("id", $id)->get("wishlist")->row_array();
        unset($row['id']);
        unset($row['created']);
        // $chk = $this->db->where($row)->get("cart")->num_rows();
        if(!$chk) {
            $this->db->insert("cart", $row);
          }
          $this->session->set_flashdata('wish_alert', 1);
        $this->db->where("id", $id)->delete("wishlist");

      } elseif($act == 'wish') {
        $row = $this->db->where("id", $id)->get("cart")->row_array();
        unset($row['id']);
        unset($row['created']);
        $chk = $this->db->where($row)->get("wishlist")->num_rows();
        if(!$chk) {
          $this->db->insert("wishlist", $row);
        }
        $this->session->set_flashdata('cart_alert', 1);
        $this->db->where("id", $id)->delete("cart");
      }
    }
      echo json_encode(['status'=>1]);
  }


  public function check_coupon() {

    $code = $this->input->post('cpn');
    $date = date('Y-m-d');

    $row = $this->db->where(["code"=> $code, "status" => 1])->where("DATE(start_date) <= DATE('".$date."')")->where("DATE(end_date) >= DATE('".$date."')")->get("shop_coupon")->row_array();
    $total = getCartTotal();
    $usr = getCurrentUser();

    $ord = $this->db->where(['user_id'=> $usr['uid'], "user_type" => $usr['type'], 'cpn_code' => $code])->get("shop_orders")->num_rows();

    if(!empty($row)) {
      if($total >= $row['cart_limit']) {
        if($ord == 0) {

        if($row['shop_id'] > 0) {

          $total = $this->db->where(['user_id'=> $usr['uid'], "user_type" => $usr['type']])->get("cart")->num_rows();
          $ptotal = $this->db->where(['user_id'=> $usr['uid'], "user_type" => $usr['type'], "shop_id" => $row['shop_id']])->get("cart")->num_rows();

          if($total > $ptotal) {
            echo json_encode(["status" => 0, "msg" => 'Some product in your cart not eligible for this coupon.']);

          } else {
            $_SESSION['CART_CPN'] = $row;
            echo json_encode(["status" => 1]);

          }


        } else {
          $_SESSION['CART_CPN'] = $row;
          echo json_encode(["status" => 1]);
        }

      } else {
        echo json_encode(["status" => 0, "msg" => 'You have already redeemed this coupon']);
      }

      } else {
        echo json_encode(["status" => 0, "msg" => 'Your cart amount not eligible for this coupon']);
      }

    } else {
      echo json_encode(["status" => 0, "msg" => 'Coupon Code invalid or expired']);
    }

  }
  
}
