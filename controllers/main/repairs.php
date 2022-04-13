	<?php

class repairs extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

	}

	public function index(){

		$post = $this->post();

			if(!empty($post)) :
				$last_id = $this->insert("tbl_repairs",$post);
					if($last_id>0) {
						header("location:".PATH."repairs/success");
					}
			endif;

		$qr = $this->db->query("SELECT id, name FROM tbl_brand");
		$data['brand'] = $qr->fetchAll(PDO::FETCH_ASSOC);

		$meta['title'] = "Repair  | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Repair  | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br /><br /><br />';
 	 tamplate("repairs",$data);
	 echo '<br /><br /><br />';
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}

		public function success() {

			$meta['title'] = "Repair  | Tattoogizmo.com";
			$meta['keyword'] = '';
			$meta['desc'] = "Repair  | Tattoogizmo.com";

			tamplate("head",$meta);
			tamplate("header",$this->cats);
			echo '<br /><br /><br />';
			tamplate("repair-success",$data);
			echo '<br /><br /><br />';
			tamplate("footer-top",$this->foot);
			tamplate("footer",'');
		}



}
