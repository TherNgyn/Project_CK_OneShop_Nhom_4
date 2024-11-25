<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<body>
	<section id="wsus__product_page" class="wsus__vendor_details_page">
		<div class="container">
			<div class="row">

				<div class="col-xl-3 col-lg-4">
					<div class="wsus__sidebar_filter">
						<p>filter</p>
						<span class="wsus__filter_icon"> <i class="far fa-minus"
							id="minus"></i> <i class="far fa-plus" id="plus"></i>
						</span>
					</div>
					<div class="wsus__product_sidebar" id="sticky_sidebar">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">All
										Categories</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<ul>
											<li><a href="#">Accessories</a></li>
											<li><a href="#">Babies</a></li>
											<li><a href="#">Babies</a></li>
											<li><a href="#">Beauty</a></li>
											<li><a href="#">Decoration</a></li>
											<li><a href="#">Electronics</a></li>
											<li><a href="#">Fashion</a></li>
											<li><a href="#">Food</a></li>
											<li><a href="#">Furniture</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										Price</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse show"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="price_ranger">
											<input type="hidden" id="slider_range" class="flat-slider" />
											<button type="submit" class="common_btn">filter</button>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree2">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree2"
										aria-expanded="false" aria-controls="collapseThree">
										size</button>
								</h2>
								<div id="collapseThree2"
									class="accordion-collapse collapse show"
									aria-labelledby="headingThree2"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckDefault"> <label
												class="form-check-label" for="flexCheckDefault">
												small </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked"> <label
												class="form-check-label" for="flexCheckChecked">
												medium </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked2"> <label
												class="form-check-label" for="flexCheckChecked2">
												large </label>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree3">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree3"
										aria-expanded="false" aria-controls="collapseThree">
										brand</button>
								</h2>
								<div id="collapseThree3"
									class="accordion-collapse collapse show"
									aria-labelledby="headingThree3"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckDefault11"> <label
												class="form-check-label" for="flexCheckDefault11">
												gentle park </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked22"> <label
												class="form-check-label" for="flexCheckChecked22">
												colors </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked222"> <label
												class="form-check-label" for="flexCheckChecked222">
												yellow </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked33"> <label
												class="form-check-label" for="flexCheckChecked33">
												enice man </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckChecked333"> <label
												class="form-check-label" for="flexCheckChecked333">
												plus point </label>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="true" aria-controls="collapseThree">
										color</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse show"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckDefaultc1"> <label
												class="form-check-label" for="flexCheckDefaultc1">
												black </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckCheckedc2"> <label
												class="form-check-label" for="flexCheckCheckedc2">
												white </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckCheckedc3"> <label
												class="form-check-label" for="flexCheckCheckedc3">
												green </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckCheckedc4"> <label
												class="form-check-label" for="flexCheckCheckedc4">
												pink </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value=""
												id="flexCheckCheckedc5"> <label
												class="form-check-label" for="flexCheckCheckedc5">
												red </label>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
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
												<a class="wsus__pro_link" href="/user/product/productdetail?id=${product.id}"> <!-- Hình ảnh chính của sản phẩm -->
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
														href="/user/product/productdetail?id=${product.id}">${product.name}</a>
													<!-- Giá sản phẩm -->
													<p class="wsus__price">
														$${product.promotionalPrice}
														<del>
															<c:if test="${product.promotionalPrice < product.price}">$${product.price}</c:if>
														</del>
													</p>
													<!-- Nút thêm vào giỏ hàng -->
													<a class="add_cart" href="#">add to cart</a>
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
													href="/user/product/productdetail?id=${product.id}"> <img
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
														href="/user/product/productdetail?id=${product.id}">${product.name}</a>
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
														$${product.promotionalPrice}
														<del>
															<c:if test="${product.promotionalPrice < product.price}">$${product.price}</c:if>
														</del>
													</p>
													<p class="list_description">Ultrices eros in cursus
														turpis massa cursus mattis...</p>
													<ul class="wsus__single_pro_icon d-flex mt-2">
														<li class="me-2"><a class="add_cart" href="#">Add
																to cart</a></li>
														<li class="me-2"><a href="#"><i
																class="far fa-heart"></i></a></li>
														<li><a href="#"><i class="far fa-random"></i></a></li>
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

		</div>
		</div>
	</section>
	<!--============================
       VENDORS DETAILA END
    ==============================-->

</body>
