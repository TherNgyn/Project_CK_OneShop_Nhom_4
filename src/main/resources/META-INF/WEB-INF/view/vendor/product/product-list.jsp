<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>Manage Products</title>

<body class="page-header-fixed page-quick-sidebar-over-content">
    <!-- BEGIN HEADER -->
    <div class="page-header navbar navbar-fixed-top">
    </div>
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
                                <div class="actions">
                                    <div class="btn-group">
                                        <a class="btn default yellow-stripe dropdown-toggle" href="#" data-toggle="dropdown">
                                            <i class="fa fa-share"></i> Công cụ <i class="fa fa-angle-down"></i>
                                        </a>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a href="#">Xuất Excel</a></li>
                                            <li><a href="#">Xuất CSV</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
							
                            <div class="portlet-body">
                                <div class="table-container">
                                    <div id="datatable_products_wrapper" class="dataTables_wrapper dataTables_extended_wrapper no-footer">
										<c:if test="${not empty message}">
											<div id="prefix_480614921548"
												class="Metronic-alerts alert alert-success fade in">
												<button type="button" class="close" data-dismiss="alert"
													aria-hidden="true"></button>
												<i class="fa-lg fa fa-check-circle"></i> ${message}
											</div>
										</c:if>
										<a href="/vendor/manageproduct/add" class="btn yellow">
                                                                        <i class="fa fa-tag"></i> Thêm sản phẩm
                                                                    </a>
                                        <form action="/vendor/manageproduct/paginated" method="GET">
                                            <div class="row">
                                                <div class="col-md-8 col-sm-12">
                                                    <div class="dataTables_paginate paging_bootstrap_extended" id="datatable_products_paginate">
                                                        <div class="pagination-panel">
                                                            Page
                                                            <!-- Nút "Trước" -->
                                                            <a href="<c:url value='/vendor/manageproduct/paginated?page=${productPage.number}&size=${productPage.size}&status=${param.status}'/>"
                                                                class="btn btn-sm default prev ${productPage.number == 0 ? 'disabled' : ''}" id="prev-page" title="Prev">
                                                                <i class="fa fa-angle-left"></i>
                                                            </a>

                                                            <!-- Input hiện tại cho trang -->
                                                            <input type="text" class="pagination-panel-input form-control input-mini input-inline input-sm" id="current-page" name="page"
                                                                maxlength="5" style="text-align: center; margin: 0 5px;" value="${productPage.number + 1}" />

                                                            <!-- Nút "Tiếp theo" -->
                                                            <a href="<c:url value='/vendor/manageproduct/paginated?page=${productPage.number + 2}&size=${productPage.size}&status=${param.status}'/>"
                                                                class="btn btn-sm default next ${productPage.number == productPage.totalPages - 1 ? 'disabled' : ''}" id="next-page" title="Next">
                                                                <i class="fa fa-angle-right"></i>
                                                            </a> of <span id="total-pages">${productPage.totalPages}</span>
                                                        </div>
                                                    </div>
                                                    <div class="dataTables_length" id="datatable_products_length">
                                                        <label>View 
                                                            <select name="size" id="records-per-page" class="form-control input-xsmall input-sm input-inline">
                                                                <option value="5">5</option>
                                                                <option value="10">10</option>
                                                                <option value="15">15</option>
                                                                <option value="20">20</option>
                                                                <option value="50">50</option>
                                                            </select> records
                                                        </label>
                                                    </div>
                                                </div>

                                                <div class="col-md-4 col-sm-12">
                                                    <div class="table-group-actions pull-right">
                                                        <select name="status" class="table-group-action-input form-control input-inline input-small input-sm">
                                                            <option value="">Chọn...</option>
                                                            <option value="1">Đang bán</option>
                                                            <option value="0">Ngừng bán</option>
                                                        </select>
                                                        <button type="submit" class="btn btn-sm yellow table-group-action-submit">
                                                            <i class="fa fa-check"></i> Chọn
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>

                                        <div class="table-scrollable">
                                            <table class="table table-striped table-bordered table-hover dataTable no-footer" id="datatable_products" aria-describedby="datatable_products_info" role="grid">
                                                <thead>
                                                    <tr role="row" class="heading">
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">STT</th>
                                                        <th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Tên Sản phẩm</th>
                                                        <th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Danh mục</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Giá</th>
                                                        <th width="5%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Số lượng</th>
                                                        <th width="15%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Thương hiệu</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Trạng thái</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Mô tả</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Hình ảnh chính</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Các hình ảnh khác</th>
                                                        <th width="10%" class="sorting" tabindex="0" aria-controls="datatable_products" rowspan="1" colspan="1">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" items="${productPage.content}" varStatus="status">
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${product.name}</td>
                                                            <td>${product.category.name}</td>
                                                            <td><fmt:formatNumber value="${product.price}" type="number" pattern="#.##" /></td>
                                                            <td>${product.quantity}</td>
                                                            <td>${product.brand}</td>
                                                            <td>
                                                                <c:if test="${product.isSelling}">Đang bán</c:if>
                                                                <c:if test="${!product.isSelling}">Ngừng bán</c:if>
                                                            </td>
                                                            <td>${product.description}</td>
															<td><c:forEach var="image" items="${product.images}">
																	<c:if test="${image.isMain}">
																		<img src="${image.imageUrl}" alt="${product.name}"
																			class="img-fluid w-100 img_1" />
																	</c:if>
																</c:forEach></td>
															<td><c:forEach var="image" items="${product.images}">
																	<c:if test="${!image.isMain}">
																		<img src="${image.imageUrl}" alt="${product.name}"
																			class="img-fluid w-100 img_2" />
																	</c:if>
																</c:forEach></td>
															<td>
																<div class="margin-bottom-5">
																	<a href="/vendor/manageproduct/update/${product.id}"
																		class="btn btn-sm yellow filter-submit margin-bottom">
																		<i class="fa fa-search"></i> Cập nhật
																	</a> <a href="/vendor/manageproduct/delete/${product.id}">
																		<button class="btn btn-sm red filter-cancel">
																			<i class="fa fa-times"></i> Xóa
																		</button>
																	</a>
																</div>
															</td>
														</tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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
