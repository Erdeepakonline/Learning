<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Planner extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model('mail_model');
	}

  public function save_planner() {

    // $title = $this->input->post('title');
    $ulid = $this->input->post('ulid');
    $title = $this->input->post('name');
    $mob = $this->input->post('mob');
    $eml = $this->input->post('email');
    $start = $this->input->post('sdate');
    $edate = $this->input->post('edate');
    $type = $this->input->post('type');
    $std = $this->input->post('studio');
    $arid = $this->input->post('arid');
    $mod = $this->input->post('mode');

    if(!$edate) {
      $edate = date('Y-m-d h:i:s', strtotime($start.' +1 hour'));
    }

    if(!empty($_SESSION[USER])) {
      if($title) {
        $post = [
          "user_type" => $type,
          "title" => $title,
          "mobile" => $mob,
          "start" => $start,
          "end" => $edate,
          "sdate" => date('Y-m-d', strtotime($start))
        ];

        if($type == 1) {
          $post['user_id'] = $_SESSION[USER]['id'];
          // $uinfo = $this->db->select("CONCAT(fname,' ',lname) as name, address")->where(["id"=> $_SESSION[USER]['id']])->get('artist')->row();
        } else {
          $post['user_id'] = $_SESSION[STUDIO]['id'];
          // $uinfo = $this->db->select('studio_name as name, address')->where(["id"=> $_SESSION[STUDIO]['id']])->get('studios')->row();
        }

        if($std) {
          $post['studio'] = $std;
        }

        if($mod) {
          $post['mode'] = $mod;
        }

        if($eml) {
          $post['email'] = $eml;
        }

        $this->db->insert('planner', $post);
        $id = $this->db->insert_id();

        if($arid>0) {
          $post['user_id'] = $arid;
          $post['user_type'] = 1;
          $post['studio'] = $_SESSION[STUDIO]['studio_name'];
          $this->db->insert('planner', $post);
          
          $pl_id = $this->db->insert_id();
          
          $apt = [
            'app_id' => appUniqCode(),
            'artist_id' => $arid,
            'app_type' => 2,
            'studio_id' => $_SESSION[STUDIO]['id'],
            'app_date' => $post['sdate'],
            'app_time' => date('H:i:s', strtotime($start)),
            'pay_amt' => 0,
            'pay_status' => 1,
            'customer_name' => $title,
            'email' => $eml,
            'mobile' => $mob,
            'planner_id' => $pl_id
          ];
          
          $this->db->insert('appointment', $apt);
          set_notification([
          	"user_type" => 1,
          	"user_id" => $arid,
          	"message" => "You have a new appointment #".$apt['app_id'],
          	"noti_type" => 1
          ]);
          
        }

        if($eml) {
          $this->mail_model->enthu_lead_mail([
            "name" => $title,
            "date" => date('d M Y', strtotime($start)),
            "time" =>  date('h:i A', strtotime($start)),
            "studio" => $std,
            // "address" => $uinfo->address,
            "email" => $eml
          ]);
        }
        
        enthuLeadSMS([
          "name" => $std,
          "date" => date('d M Y', strtotime($start)),
          "time" =>  date('h:i A', strtotime($start)),
          "mobile" => $mob
        ]);

        if($ulid > 0) {
          $this->db->where("id", $ulid)->update('user_lead', ['planner' => 1]);

        }
        echo json_encode(['status' => 1, 'id' => $id]);
      }
    }


  }



public function update_planner() {

    $id = $this->input->post('pid');
    $title = $this->input->post('title');
    $mob = $this->input->post('mob');
    $email = $this->input->post('email');
    $start = $this->input->post('sdate');
    $edate = $this->input->post('edate');
    $type = $this->input->post('type');
    $std = $this->input->post('studio');
    $mod = $this->input->post('mode');

    if(!empty($_SESSION[USER])) {
      if($title) {
        $post = [
          "title" => $title,
          "mobile" => $mob,
          "start" => $start,
          "end" => $edate,
          "sdate" => date('Y-m-d', strtotime($start))
        ];

        if($type == 1) {
          $uid = $_SESSION[USER]['id'];
          // $uinfo = $this->db->select("CONCAT(fname,' ',lname) as name, address")->where(["id"=> $_SESSION[USER]['id']])->get('artist')->row();
        } else {
          $uid = $_SESSION[STUDIO]['id'];
          // $uinfo = $this->db->select('studio_name as name, address')->where(["id"=> $_SESSION[STUDIO]['id']])->get('studios')->row();
        }

        if($std) {
          $post['studio'] = $std;
        }

        if($mod) {
          $post['mode'] = $mod;
        }

        if($email) {
          $post['email'] = $email;
        }
        // print_r(["id" => $id, "user_id" => $uid, "user_type" => $type ]);
        $this->db->where(["id" => $id, "user_id" => $uid, "user_type" => $type ])->update('planner', $post);

        if($email) {
          $this->mail_model->enthu_lead_schedule_mail([
            "name" => $title,
            "date" => date('d M Y', strtotime($start)),
            "time" =>  date('h:i A', strtotime($start)),
            "studio" => $std,
            // "address" => $uinfo->address,
            "email" => $email
          ]);
        }

        enthuLeadScheduleSMS([
          "name" => $std,
          "date" => date('d M Y', strtotime($start)),
          "time" =>  date('h:i A', strtotime($start)),
          "mobile" => $mob
        ]);

        echo json_encode(['status' => 1]);
      }
    }

  }



  public function get_planner() {

      $type = $this->input->post('type');

      if(!empty($_SESSION[USER])) {
        $this->db->select("id, calendarId, title, email, attendees, mobile, studio, category, start, end, mode");
        if($type == 1) {
          $this->db->where(['user_id' => $_SESSION[USER]['id'], 'user_type' => $type]);
        } elseif ($type == 2) {
          $this->db->where(['user_id' => $_SESSION[STUDIO]['id'], 'user_type' => $type]);
        }

        $data = $this->db->get('planner')->result_array();
        foreach ($data as $key => $val) {
          $atd[] =  $val['mobile'];

          if($val['email']) {
            $atd[] = $val['email'];
          }
          $val['attendees'] = $atd;
          $val['location'] = $val['studio'];
          $val['body'] = $val['mode'];
          $res[] = $val;
          unset($atd);
        }
        echo json_encode($res);

      }

  }


  public function del_planner() {
    $id = $this->input->post('sid');

    if(!empty($_SESSION[USER])){
       $this->db->where(["id"=> $id, "user_id" => $_SESSION[USER]['id'], "user_type" => 1])->delete("planner");
       echo json_encode(['status' => 1]);
    }

    if(!empty($_SESSION[STUDIO])){
       $this->db->where(["id"=> $id, "user_id" => $_SESSION[STUDIO]['id'], "user_type" => 2])->delete("planner");
       echo json_encode(['status' => 1]);
    }


  }

}
