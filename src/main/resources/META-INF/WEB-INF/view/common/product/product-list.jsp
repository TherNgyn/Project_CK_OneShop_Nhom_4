<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<body>
	<section id="wsus__product_page" class="wsus__vendor_details_page">
        <div class="container">
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
                                    <div class="wsus__topbar_select">
                                        <select class="select_2" name="state">
                                            <option>default shorting</option>
                                            <option>short by rating</option>
                                            <option>short by latest</option>
                                            <option>low to high </option>
                                            <option>high to low</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="wsus__topbar_select">
                                    <select class="select_2" name="state">
                                        <option>show 12</option>
                                        <option>show 15</option>
                                        <option>show 18</option>
                                        <option>show 21</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content" id="v-pills-tabContent">
                            <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                                aria-labelledby="v-pills-home-tab">
									<div class="row">
										<c:forEach var="product" items="${productPage.content}">
											<div class="col-xl-4 col-sm-6">
												<div class="wsus__product_item">
												
													<!-- Link dẫn đến trang chi tiết sản phẩm -->
													<a class="wsus__pro_link"
														href="/common/products/id=${product.id}"> <!-- Hình ảnh chính của sản phẩm -->
														<img src="${product.imageUrls[0]}" alt="${product.name}"
														class="img-fluid w-100 img_1" /> <!-- Hình ảnh phụ nếu có -->
														<c:if test="${product.imageUrls.size() > 1}">
															<img src="${product.imageUrls[1]}" alt="${product.name}"
																class="img-fluid w-100 img_2" />
														</c:if>
													</a>
													<!-- Các biểu tượng hành động -->
													<ul class="wsus__single_pro_icon">
														<li><a href="#"><i class="fal fa-shopping-bag"></i></a></li>
														<li><a href="#"><i class="far fa-heart"></i></a></li>
														<li><a href="#"><i class="far fa-random"></i></a></li>
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
															href="product_details.html?id=${product.id}">${product.name}</a>
													<!-- Giá sản phẩm -->
													<p class="wsus__price">
														<fmt:formatNumber value="${product.promotionalPrice}"
															type="number" minFractionDigits="0" maxFractionDigits="2" />
														<del>
															<c:if test="${product.promotionalPrice < product.price}">
																<fmt:formatNumber value="${product.price}" type="number"
																	minFractionDigits="0" maxFractionDigits="2" />
															</c:if>
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
                            </div>
                            <div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
                                aria-labelledby="v-pills-profile-tab">
                                <div class="row">
                                
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item wsus__list_view">
                                            <span class="wsus__new">New</span>
                                            <span class="wsus__minus">-20%</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/pro4.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/pro4_4.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item wsus__list_view">
                                            <span class="wsus__minus">-20%</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/pro9.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/pro9_9.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                            <div class="wsus__product_details">
                                                <a class="wsus__category" href="#">fashion </a>
                                                <p class="wsus__pro_rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>(5 review)</span>
                                                </p>
                                                <a class="wsus__pro_name" href="#">men's casual sholder bag</a>
                                                <p class="wsus__price">$60</p>
                                                <p class="list_description">Ultrices eros in cursus turpis massa cursus
                                                    mattis. Volutpat ac tincidunt vitae semper quis lectus. Aliquam id
                                                    diam maecenas ultricies… </p>
                                                <ul class="wsus__single_pro_icon">
                                                    <li><a class="add_cart" href="#">add to cart</a></li>
                                                    <li><a href="#"><i class="far fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="far fa-random"></i></a>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item  wsus__list_view">
                                            <span class="wsus__new">New</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/headphone_1.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/headphone_2.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                            <div class="wsus__product_details">
                                                <a class="wsus__category" href="#">electronic </a>
                                                <p class="wsus__pro_rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>(17 review)</span>
                                                </p>
                                                <a class="wsus__pro_name" href="#">bluetooth headphone</a>
                                                <p class="wsus__price">$40 <del>$50</del></p>
                                                <p class="list_description">Ultrices eros in cursus turpis massa cursus
                                                    mattis. Volutpat ac tincidunt vitae semper quis lectus. Aliquam id
                                                    diam maecenas ultricies… </p>
                                                <ul class="wsus__single_pro_icon">
                                                    <li><a class="add_cart" href="#">add to cart</a></li>
                                                    <li><a href="#"><i class="far fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="far fa-random"></i></a>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item wsus__list_view">
                                            <span class="wsus__new">New</span>
                                            <span class="wsus__minus">-20%</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/tab_1.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/tab_2.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                            <div class="wsus__product_details">
                                                <a class="wsus__category" href="#">electronic </a>
                                                <p class="wsus__pro_rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>(17 review)</span>
                                                </p>
                                                <a class="wsus__pro_name" href="#">apple 10 serise tab </a>
                                                <p class="wsus__price">$490 <del>$500</del></p>
                                                <p class="list_description">Ultrices eros in cursus turpis massa cursus
                                                    mattis. Volutpat ac tincidunt vitae semper quis lectus. Aliquam id
                                                    diam maecenas ultricies… </p>
                                                <ul class="wsus__single_pro_icon">
                                                    <li><a class="add_cart" href="#">add to cart</a></li>
                                                    <li><a href="#"><i class="far fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="far fa-random"></i></a>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item wsus__list_view">
                                            <span class="wsus__new">New</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/kids_1.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/kids_2.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                            <div class="wsus__product_details">
                                                <a class="wsus__category" href="#">fashion </a>
                                                <p class="wsus__pro_rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>(17 review)</span>
                                                </p>
                                                <a class="wsus__pro_name" href="#">kid's dress </a>
                                                <p class="wsus__price">$30 <del>$40</del></p>
                                                <p class="list_description">Ultrices eros in cursus turpis massa cursus
                                                    mattis. Volutpat ac tincidunt vitae semper quis lectus. Aliquam id
                                                    diam maecenas ultricies… </p>
                                                <ul class="wsus__single_pro_icon">
                                                    <li><a class="add_cart" href="#">add to cart</a></li>
                                                    <li><a href="#"><i class="far fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="far fa-random"></i></a>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12">
                                        <div class="wsus__product_item wsus__list_view">
                                            <span class="wsus__minus">-20%</span>
                                            <a class="wsus__pro_link" href="product_details.html">
                                                <img src="images/pro4.jpg" alt="product"
                                                    class="img-fluid w-100 img_1" />
                                                <img src="images/pro4_4.jpg" alt="product"
                                                    class="img-fluid w-100 img_2" />
                                            </a>
                                            <div class="wsus__product_details">
                                                <a class="wsus__category" href="#">fashion </a>
                                                <p class="wsus__pro_rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>(17 review)</span>
                                                </p>
                                                <a class="wsus__pro_name" href="#">men's casual fashion watch</a>
                                                <p class="wsus__price">$159 <del>$200</del></p>
                                                <p class="list_description">Ultrices eros in cursus turpis massa cursus
                                                    mattis. Volutpat ac tincidunt vitae semper quis lectus. Aliquam id
                                                    diam maecenas ultricies… </p>
                                                <ul class="wsus__single_pro_icon">
                                                    <li><a class="add_cart" href="#">add to cart</a></li>
                                                    <li><a href="#"><i class="far fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="far fa-random"></i></a>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- PHÂN TRANG -->
                <div class="col-xl-12">
                    <section id="pagination">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                                <li class="page-item"><a class="page-link page_active" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <i class="fas fa-chevron-right"></i>
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
