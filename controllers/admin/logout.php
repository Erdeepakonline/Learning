<?php    
 
class logout extends controller {

public function index(){
	
		unset($_SESSION[ADMIN]);
		header("location:".PATH);
 	
		
	}
	 

}