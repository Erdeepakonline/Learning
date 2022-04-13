	<?php

class complain extends controller {

	function __construct(){

		parent::__construct();
		$this->cats['cats'] = $this->lib->getCats();

		$this->foot['eve1'] = $this->fetch("tbl_events","type=1 and status=1");
 	  $this->foot['eve2'] = $this->fetch("tbl_events","type=2 and status=1");

	}

	public function index(){

		if(empty($_SESSION[USER])) :
			header("location:".PATH.'login/buyer/');
			$_SESSION["link_back"] = 'complain';
		endif;

		$post = $this->post();
			if(!empty($post)) :

				$post['customer_id'] = $_SESSION[USER]['id'];
				$last_id = $this->insert("tbl_complain",$post);
					if($last_id>0) {
						header("location:".PATH."complain/success");
					}
			endif;

		$qr = $this->db->query("SELECT id, name FROM tbl_brand ORDER BY name ASC");
		$data['brand'] = $qr->fetchAll(PDO::FETCH_ASSOC);

		$meta['title'] = "Raise Complaint | Tattoogizmo.com";
		$meta['keyword'] = '';
		$meta['desc'] = "Raise Complaint | Tattoogizmo.com";

 	 tamplate("head",$meta);
 	 tamplate("header",$this->cats);
	 echo '<br /><br /><br />';
 	 tamplate("complain",$data);
	 echo '<br /><br /><br />';
 	 tamplate("footer-top",$this->foot);
 	 tamplate("footer",'');

  	}

		public function success() {

			$meta['title'] = "Raise Complaint | Tattoogizmo.com";
			$meta['keyword'] = '';
			$meta['desc'] = "Raise Complaint | Tattoogizmo.com";

			tamplate("head",$meta);
			tamplate("header",$this->cats);
			echo '<br /><br /><br />';
			tamplate("repair-success",$data);
			echo '<br /><br /><br />';
			tamplate("footer-top",$this->foot);
			tamplate("footer",'');
		}



}
