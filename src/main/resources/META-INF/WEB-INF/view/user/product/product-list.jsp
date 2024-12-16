<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<body>
	<section id="wsus__product_page" class="wsus__vendor_details_page">
		<div class="container">
			<div class="row">
				<div class="col-xl-3 col-lg-4"></div>
				<div class="col-xl-9 col-lg-8">
					<div class="row">
						<div class="col-xl-12 d-none d-md-block mt-4 mt-lg-0">
							<div class="wsus__product_topbar">
								<div class="wsus__product_topbar_left">
									<div class="nav nav-pills" id="v-pills-tab" role="tablist"
										aria-orientation="vertical">
										<button class="nav-link active" id="v-pills-home-tab"
											data-bs-toggle="pill" data-bs-target="#v-pills-home"
											type="button" role="tab" aria-controls="v-pills-home"
											aria-selected="true">
											<i class="fas fa-th"></i>
										</button>
										<button class="nav-link" id="v-pills-profile-tab"
											data-bs-toggle="pill" data-bs-target="#v-pills-profile"
											type="button" role="tab" aria-controls="v-pills-profile"
											aria-selected="false">
											<i class="fas fa-list-ul"></i>
										</button>
									</div>
									<div class="wsus__topbar_select">
										<select class="select_2" name="state">
											<option>default shorting</option>
											<option>short by rating</option>
											<option>short by latest</option>
											<option>low to high</option>
											<option>high to low</option>
										</select>
									</div>
								</div>
								<div class="wsus__topbar_select">
									<select class="select_2" name="pageSize" id="pageSizeSelect"
										onchange="updatePageSize()">
										<option value="12" ${pageSize == 12 ? 'selected' : ''}>Show
											12</option>
										<option value="15" ${pageSize == 15 ? 'selected' : ''}>Show
											15</option>
										<option value="18" ${pageSize == 18 ? 'selected' : ''}>Show
											18</option>
										<option value="21" ${pageSize == 21 ? 'selected' : ''}>Show
											21</option>
									</select>

									<script>
										function updatePageSize() {
											const pageSize = document
													.getElementById('pageSizeSelect').value; // Lấy giá trị mới
											const url = new URL(
													window.location.href);
											url.searchParams.set('page', 1); // Đặt về trang đầu tiên
											url.searchParams.set('size',
													pageSize); // Cập nhật số lượng sản phẩm
											window.location.href = url
													.toString(); // Cập nhật URL
										}
									</script>

								</div>
							</div>
						</div>

						<div class="tab-content" id="v-pills-tabContent">

							<!-- Nội dung Tab 1 -->
							<div class="tab-pane fade show active" id="v-pills-home"
								role="tabpanel" aria-labelledby="v-pills-home-tab">
								<div class="row">
									<c:forEach var="product" items="${productPage.content}">

										<div class="col-xl-4 col-sm-6">
											<div class="wsus__product_item">
												<!-- Link dẫn đến trang chi tiết sản phẩm -->
												<a class="wsus__pro_link"
													href="/user/products/productdetail?id=${product.id}"> <!-- Hình ảnh chính của sản phẩm -->
													<img src="${product.imageUrls[0]}" alt="${product.name}"
													class="img-fluid w-100 img_1" /> <!-- Hình ảnh phụ nếu có -->
													<c:if test="${product.imageUrls.size() > 1}">
														<img src="${product.imageUrls[1]}" alt="${product.name}"
															class="img-fluid w-100 img_2" />

													</c:if>
												</a>
												<!-- Các biểu tượng hành động -->
												<ul class="wsus__single_pro_icon">
													<li><a href="#" data-bs-target="#v-pills-home"
														data-bs-toggle="pill"><i class="fal fa-shopping-bag"></i></a></li>
													<li><a href="#" data-bs-target="#v-pills-profile"
														data-bs-toggle="pill"><i class="far fa-heart"></i></a></li>
													<li><a href="#" data-bs-target="#v-pills-profile"
														data-bs-toggle="pill"><i class="far fa-random"></i></a></li>
												</ul>
												<div class="wsus__product_details">
													<!-- Hiển thị danh mục sản phẩm -->
													<a class="wsus__category" href="#">${product.category.name}</a>
													<!-- Đánh giá sản phẩm -->
													<p class="wsus__pro_rating">
														<c:forEach begin="1" end="5" varStatus="loop">
															<c:choose>
																<c:when test="${loop.index <= product.rating}">
																	<i class="fas fa-star"></i>
																</c:when>
																<c:when
																	test="${loop.index - product.rating > 0 && loop.index - product.rating < 1}">
																	<i class="fas fa-star-half-alt"></i>
																</c:when>
																<c:otherwise>
																	<i class="far fa-star"></i>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<span>(${product.reviews.size()} reviews)</span>
													</p>
													<!-- Tên sản phẩm -->
													<a class="wsus__pro_name"
														href="/user/products/productdetail?id=${product.id}">${product.name}</a>
													<!-- Giá sản phẩm -->
													<p class="wsus__price">
														${product.promotionalPrice}
														<del>
															<c:if test="${product.promotionalPrice < product.price}">${product.price}</c:if>
														</del>
													</p>
													<!-- Nút thêm vào giỏ hàng -->
													<form action="/user/cart/add/${product.id}" method="POST">
														<input type="hidden" name="_csrf" value="${_csrf.token}">
														<input type="hidden" name="quantity" value="1"> <a
															class="add_cart" href="#"
															onclick="this.closest('form').submit(); return false;">ADD
															TO CART</a>
													</form>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>

							<!-- Nội dung Tab 2 -->
							<div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
								aria-labelledby="v-pills-profile-tab">
								<div class="row">
									<c:forEach var="product" items="${productPage.content}">
										<div class="col-xl-12">
											<div
												class="wsus__product_item wsus__list_view d-flex align-items-center">
												<!-- Hình ảnh sản phẩm -->
												<a
													class="wsus__pro_link d-flex align-items-center justify-content-center me-3"
													href="/user/products/productdetail?id=${product.id}"> <img
													src="${product.imageUrls[0]}" alt="${product.name}"
													class="img-fluid img_1" style="max-width: 150px;" /> <c:if
														test="${product.imageUrls.size() > 1}">
														<img src="${product.imageUrls[1]}" alt="${product.name}"
															class="img-fluid img_2" style="max-width: 150px;" />
													</c:if>
												</a>
												<!-- Thông tin chi tiết sản phẩm -->
												<div class="wsus__product_details w-100">
													<a class="wsus__category" href="#">${product.category.name}</a>
													<a class="wsus__pro_name"
														href="/user/products/productdetail?id=${product.id}">${product.name}</a>
													<p class="wsus__pro_rating">
														<c:forEach begin="1" end="5" varStatus="loop">
															<c:choose>
																<c:when test="${loop.index <= product.rating}">
																	<i class="fas fa-star"></i>
																</c:when>
																<c:when
																	test="${loop.index - product.rating > 0 && loop.index - product.rating < 1}">
																	<i class="fas fa-star-half-alt"></i>
																</c:when>
																<c:otherwise>
																	<i class="far fa-star"></i>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<span>(${product.reviews.size()} reviews)</span>
													</p>
													<p class="wsus__price">
														${product.promotionalPrice}
														<del>
															<c:if test="${product.promotionalPrice < product.price}">${product.price}</c:if>
														</del>
													</p>
													<p class="list_description">${product.description }</p>
													<ul class="wsus__single_pro_icon d-flex mt-2">
													
														
													</ul>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-12">
			<section id="pagination">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<!-- Nút Previous -->
						<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
							<a class="page-link"
							href="?page=${currentPage - 1}&size=${pageSize}"
							aria-label="Previous"> <i class="fas fa-chevron-left"></i>
						</a>
						</li>

						<!-- Hiển thị danh sách số trang -->
						<c:forEach var="pageNum" items="${pageNumbers}">
							<li class="page-item ${pageNum == currentPage ? 'active' : ''}">
								<a class="page-link" href="?page=${pageNum}&size=${pageSize}">${pageNum}</a>
							</li>
						</c:forEach>

						<!-- Nút Next -->
						<li
							class="page-item ${currentPage == productPage.totalPages ? 'disabled' : ''}">
							<a class="page-link"
							href="?page=${currentPage + 1}&size=${pageSize}"
							aria-label="Next"> <i class="fas fa-chevron-right"></i>
						</a>
						</li>
					</ul>


				</nav>
			</section>
		</div>
	</section>
	<!--============================
       VENDORS DETAILA END
    ==============================-->

</body>
