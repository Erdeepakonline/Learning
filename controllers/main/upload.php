<?php

class upload extends controller {

	function __construct(){

		parent::__construct();

	}

	public function index(){

		load('reader');
		$exc = new Spreadsheet_Excel_Reader();

		$post = $this->post();
		//print_r($_POST);
		if(!empty($post)) :
			$tbl="tbl_userdetails";
			$tbl = $this->db->query("SHOW COLUMNS FROM $tbl");
			$col = $tbl->fetchAll(PDO::FETCH_ASSOC);
			//print_r($col);
			$fname = $_FILES['excel']['name'];
			if(strlen($fname)>0):
				move_uploaded_file($_FILES['excel']['tmp_name'],'excel/'.$fname);
				$exc->read('excel/'.$fname);
				$edata = $exc->sheets[0];
				//print_r($edata);
				$t=0;
				foreach ($edata['cells'] as $key => $val)
				{
					$t++;
					if($t!=1)
					{
						$i=0;
						foreach ($val as $ky => $vl)
						{
							$i++;
							$cols[$col[$i]['Field']] = $vl;
						}
						/*$maxid = $this->db->query("SELECT max( id ) FROM tbl_userdetails");
						$maxid2 = $maxid->fetchAll(PDO::FETCH_ASSOC);
						$mid=$maxid2[0]['max( id )']+1;
						$rol= 'NSSO-'.'00000000'.$mid;
						$cols['roll_no']=$rol;*/
						$cols['status']=1;
						$cols['created_date']=date('Y-m-d');
						$cols['created_time']=date('g:i A');
						//print_r($cols);
						$data['alert'] = $this->userdetails->insert($cols);
						unset($cols);
					}
				}
				unlink('excel/'.$fname);
			endif;
		endif;

		//$data['sc'] = $this->servicepoint->fetchAll(array("act"=>"status='1'"));
		//$data['bc'] = $this->branches->fetchAll(array("act"=>"status='1'"));
		//print_r($data);

	}

}
