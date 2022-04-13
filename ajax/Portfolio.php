<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Portfolio extends CI_Controller {
  function __construct() {
		parent::__construct();
    $this->load->model("main_model");
	}


  public function img_data() {
    // sleep(2);

    $row = $this->input->post('row');
    $type = $this->input->post('type');
    $code = $this->input->post('code');
    
    if($type == 1) {
        $id = $this->db->select("id")->where("code", $code)->get("artist")->row()->id;
    	$data = $this->db->where(array("artist_id"=> $id))->limit(3, $row)->get("artist_portfolio")->result_array();
    } else {
        $id = $this->db->select("id")->where("code", $code)->get("studios")->row()->id;
	    $data = $this->db->where(array("studio_id"=> $id))->limit(9, $row)->get("artist_portfolio")->result_array();
    }

    foreach($data as $key => $val) {
        $tags = explode(",", $val['img_tags']);
        $tg = '';
        foreach ($tags as $key => $tag) { 
            $tg .= "<a href='".getCatUrl($tag)."'>".$tag."</a>";
        }
        $val['img_tags'] = $tg;
        $res[] = $val;
    }
    echo json_encode($res);

  }

    
    public function user_collection() {
        
        $row = $this->input->post('row');
    	$qry = $this->db->query("SELECT ic.*, ap.type, ap.image, ap.title, ap.img_desc, ap.img_tags, ap.placement,
                        IF (ap.type =1,
                        (SELECT CONCAT(fname, ' ', lname) FROM adv_artist WHERE id = ap.artist_id),
                        (SELECT studio_name FROM adv_studios WHERE id = ap.studio_id)) as name,
                        IF (ap.type =1,
                        (SELECT slug FROM adv_artist WHERE id = ap.artist_id),
                        (SELECT slug FROM adv_studios WHERE id = ap.studio_id)) as slug
                        FROM adv_img_collection ic, adv_artist_portfolio ap 
                        WHERE ic.portfolio_id=ap.id AND user_id ='".$_SESSION[CUSTOMER]['id']."' ORDER BY ic.id DESC LIMIT $row, 9");

		$data = $qry->result_array();
	    foreach($data as $key => $val) {
            $tags = explode(",", $val['img_tags']);
            $tg = '';
            foreach ($tags as $key => $tag) { 
                $tg .= "<a href='".getCatUrl($tag)."'>".$tag."</a>";
            }
            $val['img_tags'] = $tg;
            $val["artag"] = "<a class='golden-font' href='".base_url()."artist-info/".$val['slug']."'>".$val['name']."</a>";
            $res[] = $val;
        }
		 echo json_encode($res);
    }
    
}
