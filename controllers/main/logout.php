<?php

class logout extends controller {

	function __construct(){

		parent::__construct();

		if(empty($_SESSION[USER])):
			header("location:".PATH);
		endif;
	}

	public function index(){

		if($_SESSION[USER]['role'] == 'ds') :
			$act = "distributor";
		else:
			$act = "buyer";
		endif;

		unset($_SESSION[USER]);
		unset($_SESSION['tg_cart']);
		header('location:'.PATH.'login/'.$act);
	}

}
