# Learning
My Learning Project

Pagination in :
-------------

<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pagination extends CI_Controller {

	public function __construct(){
		parent::__construct();
		check_login();
		$this->load->library('pagination');
		// $this->load->model('pagination_model');
	}

	public function welcome()
	{
		$config = [
			'base_url'=>base_url('admin/pagination'),
			'per_page'=>2,
			'total_rows'=>$this->db->get("enquiry")->num_rows(),
		];
		$this->pagination->initialize($config);

		$data['record']=$this->db->limit($limit,$offset)->get("enquiry",$config['per_page'],$this->uri->segment(3))->result_array();
		$this->load->view('admin/header');
		$this->load->view('admin/prct/paging',$data);
	}


}

?>




pagination viw:
---------------

<div class="main-panel">
	<div class="content">
	<div class="page-inner">
		<div class="page-header">My Practice Module</div>

<div class="card">
	<div class="card-header">Pagination in codeigniter</div>
	<div class="card-body">
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Name</th>
					<th>Email</th>
				</tr>
			</thead>
			<tbody>
				<?php foreach($record as $ar){ ?>
					<tr>
						<td><?=$ar['id']?></td>
						<td><?= $ar['name']; ?></td>
						<td><?=$ar['email']?></td>
					</tr>
					<?php } ?>
			</tbody>

			<?php echo $this->pagination->create_links();  ?>
					
			
		</table>
	</div>
	</div>
</div>
</div>
</div>
</div>
