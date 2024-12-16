<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/" var="URL"></c:url>

<body>
  <!--============================
        BREADCRUMB START
    ==============================-->
    <section id="wsus__breadcrumb">
        <div class="wsus_breadcrumb_overlay">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h4>vendor details</h4>
                        <ul>
                            <li><a href="#">vendor</a></li>
                            <li><a href="/user/storedetail/${store.id}">vendor details</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--============================
        BREADCRUMB END
    ==============================-->
    <!--============================
      VENDORS DETAILA START
    ==============================-->
    <section id="wsus__product_page" class="wsus__vendor_details_page">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="wsus__pro_page_bammer vendor_det_banner">
                        <img src="${store.featuredimages }" alt="banner" class="img-fluid w-100">
                        <div class="wsus__pro_page_bammer_text wsus__vendor_det_banner_text">
                            <div class="wsus__vendor_text_center">
                                <h4>${store.name }</h4>
								<p class="wsus__vendor_rating">
									<c:forEach var="i" begin="1" end="${store.rating}" step="1">
										<i class="fas fa-star"></i>
									</c:forEach>
									<c:if test="${store.rating % 1 != 0}">
										<i class="fas fa-star-half-alt"></i>
									</c:if>
									
								</p>
								<a href="callto:+962555544411"><i class="far fa-phone-alt"></i> ${store.user.phone}</a>
                                <a href="mailto:example@gmail.com"><i class="far fa-envelope"></i> ${store.user.email}</a>
                                
                                <p class="wsus__vendor_location"><i class="fal fa-map-marker-alt"></i> ${store.bio} </p>
                                <p class="wsus__open_store"><i class="fab fa-shopify"></i> ${store.isactive ? 'Hoạt động':'Đóng cửa' }</p>
                                <ul class="d-flex">
                                    <li><a class="facebook" href="#"><i class="fab fa-facebook-f"></i></a></li>
                                    <li><a class="twitter" href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a class="whatsapp" href="#"><i class="fab fa-whatsapp"></i></a></li>
                                    <li><a class="instagram" href="#"><i class="fab fa-instagram"></i></a></li>
                                </ul>
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
                                        <button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill"
                                            data-bs-target="#v-pills-home" type="button" role="tab"
                                            aria-controls="v-pills-home" aria-selected="true">
                                            <i class="fas fa-th"></i>
                                        </button>
                                        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill"
                                            data-bs-target="#v-pills-profile" type="button" role="tab"
                                            aria-controls="v-pills-profile" aria-selected="false">
                                            <i class="fas fa-list-ul"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="wsus__topbar_select">
								<form action="/user/storedetail/${store.id }" method="get" id="filter-form">
									<div class="wsus__topbar_select">
										<select class="select_2" name="size"
											onchange="this.form.submit()">
											<option value="5" ${productPage.size == 5 ? 'selected' : ''}>show
												5</option>
											<option value="10"
												${productPage.size == 10 ? 'selected' : ''}>show 10</option>
											<option value="15"
												${productPage.size == 15 ? 'selected' : ''}>show 15</option>
											<option value="20"
												${productPage.size == 20 ? 'selected' : ''}>show 20</option>
										</select>
									</div>
								</form>
							</div>
                            </div>
                        </div>
                        <div class="tab-content" id="v-pills-tabContent">
                            <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                                aria-labelledby="v-pills-home-tab">
                                <div class="row">
									<c:forEach var="product" items="${store.products}">
										<div class="col-xl-4 col-sm-6">
											<div class="wsus__product_item">
												<!-- Link dẫn đến trang chi tiết sản phẩm -->
												<a class="wsus__pro_link" href="/user/products/productdetail?id=${product.id}"> <!-- Hình ảnh chính của sản phẩm -->
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
									<c:forEach var="product" items="${store.products}">
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
                <div class="col-xl-12 text-center">
						<section id="pagination">
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center">
									<!-- Previous page link -->
									<c:if test="${productPage.number > 0}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/user/storedetail/${store.id}?size=${productPage.size}&page=${productPage.number}'/>"
											aria-label="Previous"> <i class="fas fa-chevron-left"></i>
										</a></li>
									</c:if>
									<c:if test="${productPage.number == 0}">
										<li class="page-item disabled"><a class="page-link"
											href="javascript:void(0)" aria-label="Previous"> <i
												class="fas fa-chevron-left"></i>
										</a></li>
									</c:if>
									<!-- Page numbers -->
									<c:forEach items="${pageNumbers}" var="pageNumber">
										<li
											class="page-item ${pageNumber == productPage.number + 1 ? 'active' : ''}">
											<a class="page-link"
											href="<c:url value='/user/storedetail/${store.id }?size=${productPage.size}&page=${pageNumber}'/>">
												${pageNumber} </a>
										</li>
									</c:forEach>

									<!-- Next page link -->
									<c:if test="${productPage.number < productPage.totalPages - 1}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/user/storedetail/${store.id }?size=${productPage.size}&page=${productPage.number+2}'/>"
											aria-label="Next"> <i class="fas fa-chevron-right"></i>
										</a></li>
									</c:if>
									<c:if
										test="${productPage.number == productPage.totalPages - 1}">
										<li class="page-item disabled"><a class="page-link"
											href="javascript:void(0)" aria-label="Next"> <i
												class="fas fa-chevron-right"></i>
										</a></li>
									</c:if>
								</ul>
							</nav>
						</section>
					</div>
            </div>
    </section>
    <!--============================
       VENDORS DETAILA END
    ==============================-->

    <!--============================
        SCROLL BUTTON START
    ==============================-->
    <div class="wsus__scroll_btn">
        <i class="fas fa-chevron-up"></i>
    </div>
</body>