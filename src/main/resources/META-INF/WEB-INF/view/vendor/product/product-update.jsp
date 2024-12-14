<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<title>Manage Products</title>

<body class="page-header-fixed page-quick-sidebar-over-content ">
	<!-- BEGIN HEADER -->
	<div class="page-header navbar navbar-fixed-top"></div>
	<!-- END HEADER -->
	<div class="clearfix"></div>
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
							</div>

							<div class="portlet-body">
								<div class="table-container" style="">
									<div id="datatable_products_wrapper"
										class="dataTables_wrapper dataTables_extended_wrapper no-footer">
										<div id="prefix_480614921548"
											class="Metronic-alerts alert alert-danger fade in">
											<button type="button" class="close" data-dismiss="alert"
												aria-hidden="true"></button>
											<i class="fa-lg fa fa-warning"></i> ${message }
										</div>
										<div class="row">
											<div class="col-md-8 col-sm-12">
												<div class="dataTables_paginate paging_bootstrap_extended"
													id="datatable_products_paginate"></div>
												<div class="dataTables_length"
													id="datatable_products_length"></div>
												<div class="dataTables_info" id="datatable_products_info"
													role="status" aria-live="polite"></div>
											</div>
											<div class="col-md-4 col-sm-12">
												<div class="table-group-actions pull-right">
													<span> </span>

												</div>
											</div>
										</div>
										<div class="container mt-5">
											<h3>Cập nhật sản phẩm</h3>
											<form action="/vendor/manageproduct/update" method="post"
												enctype="multipart/form-data">
												<table class="table table-bordered">
													<tbody>
														<tr>
															<th>ID Sản phẩm:</th>
															<td><input type="text" class="form-control"
																name="id" value="${product.id}" readonly></td>
														</tr>
														<tr>
															<th>Tên sản phẩm:</th>
															<td><input type="text" class="form-control"
																name="name" value="${product.name}" required></td>
														</tr>
														<tr>
															<th>Danh mục:</th>
															<td><select class="form-control" name="category.id"
																required>
																	<c:forEach var="category" items="${categories}">
																		<option value="${category.id}"
																			${product.category.id == category.id ? 'selected' : ''}>
																			${category.name}</option>
																	</c:forEach>
															</select></td>
														</tr>
														<tr>
															<th>Giá:</th>
															<td><input type="number" class="form-control"
																name="price" value="${product.price}" required></td>
														</tr>
														<tr>
															<th>Số lượng:</th>
															<td><input type="number" class="form-control"
																name="quantity" value="${product.quantity}" required></td>
														</tr>
														<tr>
															<th>Thương hiệu:</th>
															<td><input type="text" class="form-control"
																name="brand" value="${product.brand}" required></td>
														</tr>
														<tr>
															<th>Trạng thái:</th>
															<td><select class="form-control" name="isSelling">
																	<option value="true"
																		${product.isSelling ? 'selected' : ''}>Đang
																		bán</option>
																	<option value="false"
																		${!product.isSelling ? 'selected' : ''}>Ngừng
																		bán</option>
															</select></td>
														</tr>
														<tr>
															<th>Mô tả:</th>
															<td><textarea class="form-control"
																	name="description" rows="4">${product.description}</textarea></td>
														</tr>
														<tr>
															<th>Hình ảnh chính:</th>
															<td><input type="file" class="form-control-file"
																name="image"> <img src="${product.imageUrls[0]}"
																alt="${product.name}" class="img-thumbnail mt-2"
																width="150"></td>
														</tr>
														<tr>
															<th>Các hình ảnh khác:</th>
															<td><input type="file" class="form-control-file"
																name="additionalImages" multiple> <c:forEach
																	var="image" items="${product.imageUrls}" begin="1">
																	<img src="${image}" alt="${product.name}"
																		class="img-thumbnail mt-2" width="150">
																</c:forEach></td>
														</tr>
													</tbody>
												</table>
												<div class="text-right">
													<button type="submit" class="btn btn-primary">Lưu
														thay đổi</button>
													<a href="/vendor/manageproduct" class="btn btn-secondary">Hủy</a>
												</div>
											</form>
										</div>


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