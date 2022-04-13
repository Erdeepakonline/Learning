<?php

class export extends controller {
	function __construct(){

		parent::__construct();

		$this->chkAdmin();

	}


	public function index(){
		///$this->excel(array(1));
		tamplate("head","",true);
		tamplate("header","",true);
		tamplate("left-nav","",true);
		tamplate("top-bar","",true);
		tamplate("export/view",$data,true);
		tamplate("footer",'',true);

	}


	public function excel($url){

		$type = $url[0];
		$str_dt = $url[1];
		$end_dt = $url[2];

		if($type == 1):

			$tbl = "tbl_buyer";
			$file_name= "tattoogizmo_buyer_report_".date('Y');

		elseif($type == 2):

			$tbl = "tbl_distributor";
			$file_name= "tattoogizmo_distributor_report_".date('Y');

		elseif($type == 3):

			$tbl = "tbl_order";
			$file_name= "tattoogizmo_order_report_".date('Y');

		endif;

		$sql = "SELECT * FROM $tbl WHERE created >= '$str_dt 00:00:00' AND created <= '$end_dt 00:00:00'";
		$qry = $this->db->query($sql);

		$data = $qry->fetchAll(PDO::FETCH_ASSOC);

		// The function header by sending raw excel
		header("Content-type: application/vnd-ms-excel");

		// Defines the name of the export file "codelution-export.xls"
		header("Content-Disposition: attachment; filename=".$file_name.'.xls');

		if($type == 1):

				foreach($data as $key =>$val):

					$city = $this->fetch("tbl_city","id='$val[city]'");
					$state = $this->fetch("tbl_state","id='$val[state]'");
					$country = $this->fetch("tbl_country","id='$val[country]'");

					$val['city'] = $city['city'];
					$val['state'] = $state['state'];
					$val['country'] = $country['country_name'];

					$res[] = $val;

				endforeach;

		echo '<table border="1">
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Email</th>
						<th>Mobile</th>
						<th>Address Line 1</th>
						<th>Address Line 2</th>
						<th>City</th>
						<th>State</th>
						<th>Country</th>
						<th>Status</th>
						<th>Join Date</th>
					</tr>';
					 foreach ($res as $th => $td)  {
						extract($td);

					echo "<tr>
								<td>$fname</td>
								<td>$lname</td>
								<td>$email</td>
								<td>$mobile</td>
								<td>$address_line1</td>
								<td>$address_line2</td>
								<td>$city</td>
								<td>$state</td>
								<td>$country</td>
								<td>$status</td>
								<td>$created</td>
								</tr>";
					}

					echo '</table>';

				endif;


				if($type == 2	):

						foreach($data as $key =>$val):

							$city = $this->fetch("tbl_city","id='$val[city]'");
							$state = $this->fetch("tbl_state","id='$val[state]'");
							$country = $this->fetch("tbl_country","id='$val[country]'");

							$val['city'] = $city['city'];
							$val['state'] = $state['state'];
							$val['country'] = $country['country_name'];

							$res[] = $val;

						endforeach;

				echo '<table border="1">
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Mobile</th>
								<th>Address</th>
								<th>City</th>
								<th>State</th>
								<th>Country</th>
								<th>Postal Code</th>
								<th>Company Name</th>
								<th>Company Address</th>
								<th>Company Phone No.</th>
								<th>Status</th>
								<th>Join Date</th>
							</tr>';
							 foreach ($res as $th => $td)  {
								extract($td);

							echo "<tr>
										<td>$name</td>
										<td>$email</td>
										<td>$mobile</td>
										<td>$address</td>
										<td>$city</td>
										<td>$state</td>
										<td>$country</td>
										<td>$post_code</td>
										<td>$company_name</td>
										<td>$com_address</td>
										<td>$com_mobile</td>
										<td>$status</td>
										<td>$created</td>
										</tr>";
							}

							echo '</table>';

						endif;




						if($type == 3	):

								foreach($data as $key =>$val):

									$city = $this->fetch("tbl_city","id='$val[city]'");
									$state = $this->fetch("tbl_state","id='$val[state]'");
									$country = $this->fetch("tbl_country","id='$val[country]'");

									$val['city'] = $city['city'];
									$val['state'] = $state['state'];
									$val['country'] = $country['country_name'];

									$res[] = $val;

								endforeach;

						echo '<table border="1">
									<tr>
										<th>Order ID</th>
										<th>User Email</th>
										<th>User Type</th>
										<th>Address</th>
										<th>City</th>
										<th>State</th>
										<th>Country</th>
										<th>Postal Code</th>
										<th>Company Name</th>
										<th>Company Address</th>
										<th>Company Phone No.</th>
										<th>Status</th>
										<th>Join Date</th>
									</tr>';
									 foreach ($res as $th => $td)  {
										extract($td);

									echo "<tr>
												<td>$name</td>
												<td>$email</td>
												<td>$mobile</td>
												<td>$address</td>
												<td>$city</td>
												<td>$state</td>
												<td>$country</td>
												<td>$post_code</td>
												<td>$company_name</td>
												<td>$com_address</td>
												<td>$com_mobile</td>
												<td>$status</td>
												<td>$created</td>
												</tr>";
									}

									echo '</table>';

								endif;

	}

}
