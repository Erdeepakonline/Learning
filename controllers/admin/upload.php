<?php

class upload extends controller {

	function __construct(){

		parent::__construct();

	}

	public function index(){

		load('reader');
		$exc = new Spreadsheet_Excel_Reader();

		$post = $this->post();
		// print_r($_FILES);
		//print_r($_POST);
		if(!empty($_FILES)) :
			// $tbl="tbl_userdetails";
			// $tbl = $this->db->query("SHOW COLUMNS FROM $tbl");
			// $col = $tbl->fetchAll(PDO::FETCH_ASSOC);
			//print_r($col);
			$fname = $_FILES['excel']['name'];
			if(strlen($fname)>0):
				move_uploaded_file($_FILES['excel']['tmp_name'],'excel/'.$fname);
				$exc->read('excel/'.$fname);
				$edata = $exc->sheets[0];
				// print_r($edata['cells']);
				$i=0;
				foreach ($edata['cells'] as $key => $val) { $i++;
					if($i>1) :
					// print_r($val);
						$code = trim($val[3]);
						$prod = $this->fetch("tbl_product","product_code='$code'");

						$pid = $prod['id'];
						$upd[] = "buyer_price='".$val[6]."'";
						$upd[] = "buyer_discount='".$val[7]."'";
						$upd[] = "wh_price='".$val[8]."'";
						$upd[] = "wh_discount='".$val[9]."'";
						$upd[] = "usd_price='".$val[10]."'";
						$upd[] = "usd_discount='".$val[11]."'";
						$upd[] = "npr_price='".$val[12]."'";
						$upd[] = "npr_discount='".$val[13]."'";

						// "UPDATE tbl_combination SET ".implode(',',$upd)." WHERE product_id='$pid' AND weight='$wgt'";
						if($val[5]>0) :
							$wgt = $val[5];
							$this->db->query("UPDATE tbl_combination SET ".implode(',',$upd)." WHERE product_id='$pid' AND weight='$wgt'");
						else :
							$this->db->query("UPDATE tbl_combination SET ".implode(',',$upd)." WHERE product_id='$pid'");
						endif;
						// print_r($prod);
					endif;
				}

				unlink('excel/'.$fname);

			endif;
		endif;

		//$data['sc'] = $this->servicepoint->fetchAll(array("act"=>"status='1'"));
		//$data['bc'] = $this->branches->fetchAll(array("act"=>"status='1'"));
		//print_r($data);

		tamplate("head","");
		echo '<form method="post" enctype="multipart/form-data">
					<input type="file" name="excel">
					<input type="submit" name="submit" value="Upload" />
					</form>
					';
		tamplate("footer","");

	}

}
