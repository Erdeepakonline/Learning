<?php

class password extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();
	}



	 public function index(){

		 $data = $this->fetch("tbl_admin","id>0");

		 $post = $this->post();

		 if(!empty($post)) :
			 	if($data['password'] == $post['cpass']) :
			 		$this->update('tbl_admin',array( 'password' => $post['npass'] ), 1 );
					$alt['alert'] = 1;
				else:
					$alt['alert'] = 2;
		 		endif;
		 endif;

	 tamplate("head","",true);
	 tamplate("header","",true);
	 tamplate("left-nav","",true);
	 tamplate("top-bar","",true);
	 tamplate("setting/password",$alt,true);
	 tamplate("footer",'',true);


 	}


}
