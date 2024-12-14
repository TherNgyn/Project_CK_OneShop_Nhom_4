<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>Manage Products</title>

<body class="page-header-fixed page-quick-sidebar-over-content ">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">

</div>
<!-- END HEADER -->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">			
			<!-- BEGIN PAGE CONTENT-->
			<div class="row">
				<div class="col-md-12">
					<!-- Begin: life time stats -->
					<div class="portlet">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-gift"></i>Sản phẩm
							</div>
							<div class="actions">
								<div class="btn-group">
									<a class="btn default yellow-stripe dropdown-toggle" href="#" data-toggle="dropdown">
									<i class="fa fa-share"></i> Công cụ <i class="fa fa-angle-down"></i>
									</a>
									<ul class="dropdown-menu pull-right">
										<li>
											<a href="#">
											Xuất Excel </a>
										</li>
										<li>
											<a href="#">
											Xuất CSV </a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						
						<div class="portlet-body">
							<div class="table-container" style="">
								
								<div id="datatable_products_wrapper" class="dataTables_wrapper dataTables_extended_wrapper no-footer"><div id="prefix_480614921548" class="Metronic-alerts alert alert-danger fade in"><button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button><i class="fa-lg fa fa-warning"></i>  Please select an action</div><div class="row"><div class="col-md-8 col-sm-12"><div class="dataTables_paginate paging_bootstrap_extended" id="datatable_products_paginate"><div class="pagination-panel"> Page <a href="#" class="btn btn-sm default prev disabled" title="Prev"><i class="fa fa-angle-left"></i></a><input type="text" class="pagination-panel-input form-control input-mini input-inline input-sm" maxlenght="5" style="text-align:center; margin: 0 5px;"><a href="#" class="btn btn-sm default next disabled" title="Next"><i class="fa fa-angle-right"></i></a> of <span class="pagination-panel-total"></span></div></div><div class="dataTables_length" id="datatable_products_length"><label><span class="seperator">|</span>View <select name="datatable_products_length" aria-controls="datatable_products" class="form-control input-xsmall input-sm input-inline"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="150">150</option></select> records</label></div><div class="dataTables_info" id="datatable_products_info" role="status" aria-live="polite"></div></div><div class="col-md-4 col-sm-12"><div class="table-group-actions pull-right">
									<span>
									</span>
									<select class="table-group-action-input form-control input-inline input-small input-sm">
										<option value="">Chọn...</option>
										<option value="publish">Publish</option>
										<option value="unpublished">Un-publish</option>
										<option value="delete">Delete</option>
									</select>
									<button class="btn btn-sm yellow table-group-action-submit"><i class="fa fa-check"></i> Chọn</button>
								</div></div></div><div class="table-scrollable"><table class="table table-striped table-bordered table-hover dataTable no-footer" id="datatable_products" aria-describedby="datatable_products_info" role="grid">
								<thead>
								<tr role="row" class="heading"><th width="1%" class="sorting_disabled" rowspan="1" colspan="1">
										<div class="checker"><span><input type="checkbox" class="group-checkable"></span></div>
									</th><th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 ID
									</th><th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Tên&nbsp;Sản phẩm
									</th><th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Danh mục
									</th><th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Giá
									</th><th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Số lượng
									</th><th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Thương hiệu
									</th><th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Trạng thái
									</th><th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">
										 Hành động
									</th></tr>
								<tr role="row" class="filter"><td rowspan="1" colspan="1">
									</td><td rowspan="1" colspan="1">
										<input type="text" class="form-control form-filter input-sm" name="product_id">
									</td><td rowspan="1" colspan="1">
										<input type="text" class="form-control form-filter input-sm" name="product_name">
									</td><td rowspan="1" colspan="1">
										<select name="product_category" class="form-control form-filter input-sm">
											<option value="">Select...</option>
											<option value="1">Mens</option>
											<option value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Footwear</option>
											<option value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Clothing</option>
											<option value="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessories</option>
											<option value="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fashion Outlet</option>
											<option value="6">Football Shirts</option>
											<option value="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Premier League</option>
											<option value="8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Football League</option>
											<option value="9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Serie A</option>
											<option value="10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bundesliga</option>
											<option value="11">Brands</option>
											<option value="12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Adidas</option>
											<option value="13">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nike</option>
											<option value="14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Airwalk</option>
											<option value="15">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;USA Pro</option>
											<option value="16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kangol</option>
										</select>
									</td><td rowspan="1" colspan="1">
										<div class="margin-bottom-5">
											<input type="text" class="form-control form-filter input-sm" name="product_price_from" placeholder="From">
										</div>
										<input type="text" class="form-control form-filter input-sm" name="product_price_to" placeholder="To">
									</td><td rowspan="1" colspan="1">
										<div class="margin-bottom-5">
											<input type="text" class="form-control form-filter input-sm" name="product_quantity_from" placeholder="From">
										</div>
										<input type="text" class="form-control form-filter input-sm" name="product_quantity_to" placeholder="To">
									</td><td rowspan="1" colspan="1">
										<select name="product_status" class="form-control form-filter input-sm">
											<option value="">Select...</option>
											<option value="published">Published</option>
											<option value="notpublished">Not Published</option>
											<option value="deleted">Deleted</option>
										</select>
									</td><td rowspan="1" colspan="1">
										<select name="product_status" class="form-control form-filter input-sm">
											<option value="">Select...</option>
											<option value="published">Published</option>
											<option value="notpublished">Not Published</option>
											<option value="deleted">Deleted</option>
										</select>
									</td><td rowspan="1" colspan="1">
										<div class="margin-bottom-5">
											<button class="btn btn-sm yellow filter-submit margin-bottom"><i class="fa fa-search"></i> Cập nhật</button>
										</div>
										<button class="btn btn-sm red filter-cancel"><i class="fa fa-times"></i> Xóa</button>
									</td></tr>
								</thead>
								<tbody>
								</tbody>
								</table></div>
								</div>
							</div>
						</div>
					</div>
					<!-- End: life time stats -->
				</div>
			</div>
			<!-- END PAGE CONTENT-->
		</div>
	</div>
	<!-- END CONTENT -->
</div>

</body>