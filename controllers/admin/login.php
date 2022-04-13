<?php

class login extends controller {
	function __construct(){
		if(!empty($_SESSION[ADMIN])){
			header('location:'.PATH.'index.html/dashboard');
		}
		parent::__construct();
	}

 public function index(){

	 $post = $this->post();

	 // $data['log'] = $this->adminAuth($post);
	 //
	 // if($data['log'] != 1 and $data['log'] != 0):
	 //
	 // 	$_SESSION[ADMIN] = $data['log'];
		// header('location:'.PATH.'index.html/dashboard');
	 //
	 // endif;

	 if(!empty( $post )) :
	 $row = $this->fetch("tbl_admin","username ='" . $post['username'] . "'");

	 print_r( $row );

	 if(!empty($row)) {
		 
		 if($row['password'] == $post['password']) {
			 $_SESSION[ADMIN] = $row;
			 $_SESSION[ADMIN]['role'] = 1;
			 header('location:'.PATH.'index.html/dashboard');
		 } else {
			 $data['log'] = 1;
		 }

	 } else {
		 $row = $this->fetch("tbl_employee","username ='" . $post['username'] . "'");

		 if(!empty($row)) {

			 if($row['password'] == $post['password']) {
				 $_SESSION[ADMIN] = $row;
				 $_SESSION[ADMIN]['role'] = 2;
				 header('location:'.PATH.'index.html/dashboard');
			 } else {

				 $data['log'] = 1;
			 }

		 } else {
			 $data['log'] = 1;
		 }
	 }
 endif;
	 tamplate("head","",true);
	 tamplate("login",$data,true);


 	}



}
