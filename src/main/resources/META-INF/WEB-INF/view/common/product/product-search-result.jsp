<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<body>
	<section id="wsus__product_page" class="wsus__vendor_details_page">
        <div class="container">
            <div class="row">
                <div class="col-xl-3 col-lg-4">
					<div class="wsus__sidebar_filter">
						<p>LỌC SẢN PHẨM</p>
						<span class="wsus__filter_icon"> <i class="far fa-minus"
							id="minus"></i> <i class="far fa-plus" id="plus"></i>
						</span>
					</div>
					<div class="wsus__product_sidebar" id="sticky_sidebar">
						<form action="/common/products/filter" method="get">
							<div class="accordion" id="accordionExample">
								<!-- Danh mục sản phẩm -->
								<div class="accordion-item">
									<h2 class="accordion-header" id="headingOne">
										<button class="accordion-button" type="button"
											data-bs-toggle="collapse" data-bs-target="#collapseOne"
											aria-expanded="true" aria-controls="collapseOne">
											Danh mục sản phẩm</button>
									</h2>
									<div id="collapseOne" class="accordion-collapse collapse show"
										aria-labelledby="headingOne">
										<div class="accordion-body">
											<div class="form-check">
												<c:forEach var="category" items="${categories}">
													<ul>
														<li><input class="form-check-input" type="checkbox"
															name="categoryName" value="${category.name}" /> <label
															for="category_${category.id}">${category.name}</label></li>
													</ul>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>

								<!-- Thương hiệu -->
								<div class="accordion-item">
									<h2 class="accordion-header" id="headingThree3">
										<button class="accordion-button" type="button"
											data-bs-toggle="collapse" data-bs-target="#collapseThree3"
											aria-expanded="false" aria-controls="collapseThree">
											Thương hiệu</button>
									</h2>
									<div id="collapseThree3"
										class="accordion-collapse collapse show"
										aria-labelledby="headingThree3">
										<div class="accordion-body">
											<div class="form-check">
												<c:forEach var="brand" items="${brands}">
													<ul>
														<li><input class="form-check-input" type="checkbox"
															name="brand" value="${brand}" id="flexCheckDefault11">
															<label class="form-check-label" for="flexCheckDefault11">
																${brand} </label></li>
													</ul>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
								<!-- Giá -->
								<div class="accordion-item">
									<h2 class="accordion-header" id="headingTwo">
										<button class="accordion-button" type="button"
											data-bs-toggle="collapse" data-bs-target="#collapseTwo"
											aria-expanded="false" aria-controls="collapseTwo">
											Giá</button>
									</h2>
									<div id="collapseTwo" class="accordion-collapse collapse show"
										aria-labelledby="headingTwo">
										<div class="accordion-body">
											<div class="price-input-container">
												<!-- Nhập giá trực tiếp -->
												<div class="price-input">
													<div>
														<label class="form-check-label" for="flexCheckDefault11">Giá
															từ:</label> <input type="number" name="minPrice"
															placeholder="Nhập giá tối thiểu" min="0" step="1000"
															value="minPrice">
													</div>
													<div>
														<label class="form-check-label" for="flexCheckDefault11">Đến:</label>
														<input type="number" name="maxPrice"
															placeholder="Nhập giá tối đa" min="0" step="1000"
															value="maxPrice">
													</div>
												</div>

												<!-- Nút lọc -->
												<div class="filter-button-container">
													<button type="submit" class="common_btn">Lọc</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" value="${searchName}" name="name">
						</form>
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
									<%-- <div class="wsus__topbar_select">
                <!-- Sorting Dropdown -->
                <select class="select_2" name="sorting" onchange="window.location.href=this.value">
                    <option value="<c:url value='/common/products/filter'>
                        <c:param name='name' value='${searchname}' />
                        <c:param name='size' value='${productPage.size}' />
                        <c:param name='page' value='${productPage.number}' />
                        <c:param name='sort' value='rating' />
                        </c:url>">short by rating</option>
                    <option value="<c:url value='/common/products/filter'>
                        <c:param name='name' value='${searchname}' />
                        <c:param name='size' value='${productPage.size}' />
                        <c:param name='page' value='${productPage.number}' />
                        <c:param name='sort' value='low-to-high' />
                        </c:url>">low to high</option>
                    <option value="<c:url value='/common/products/filter'>
                        <c:param name='name' value='${searchname}' />
                        <c:param name='size' value='${productPage.size}' />
                        <c:param name='page' value='${productPage.number}' />
                        <c:param name='sort' value='high-to-low' />
                        </c:url>">high to low</option>
                </select>
            
        </div> --%>

									<div class="wsus__topbar_select">
										<!-- Display Count Dropdown -->
										<form action="/common/products/filter" method="get"
											id="filter-form">
											<div class="wsus__topbar_select">
												<!-- Display Count Dropdown -->
												<select class="select_2" name="size"
													onchange="this.form.submit()">
													<option value="5"
														${productPage.size == 5 ? 'selected' : ''}>show 5</option>
													<option value="10"
														${productPage.size == 10 ? 'selected' : ''}>show
														10</option>
													<option value="15"
														${productPage.size == 15 ? 'selected' : ''}>show
														15</option>
													<option value="20"
														${productPage.size == 20 ? 'selected' : ''}>show
														20</option>
												</select>
											</div>
											
											<input type="hidden" name="name" value="${searchName}" /> <input
												type="hidden" name="page" value="${productPage.number}" />

											<c:forEach var="category" items="${categoryName}">
												<input type="hidden" name="categoryName" value="${category}" />
											</c:forEach>

											<c:forEach var="brandItem" items="${brand}">
												<input type="hidden" name="brand" value="${brandItem}" />
											</c:forEach>

											<input type="hidden" name="minPrice" value="${minPrice}" />
											<input type="hidden" name="maxPrice" value="${maxPrice}" />
										</form>
									</div>
								</div>
							</div>
							<!-- <SẢN PHẨM> -->
							<div class="tab-content" id="v-pills-tabContent">
							<div class="tab-pane fade show active" id="v-pills-home"
								role="tabpanel" aria-labelledby="v-pills-home-tab">
								<c:if test="${not empty message}">
									<div class="alert alert-info" role="alert">
										<span>${message}</span>
									</div>
								</c:if>
								<div class="row">
									<c:forEach var="product" items="${productPage.content}">
										<div class="col-xl-4 col-sm-6">
											<div class="wsus__product_item">

												<!-- Link dẫn đến trang chi tiết sản phẩm -->
												<a class="wsus__pro_link"
													href="/common/products/productdetail?id=${product.id}"> <!-- Hình ảnh chính của sản phẩm -->
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
														href="/common/products/productdetail?id=${product.id}">${product.name}</a>
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
						<!-- CHIỀU NGANG -->
						<div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
							aria-labelledby="v-pills-profile-tab">
							<div class="row" id="list-view">
								<c:forEach var="product" items="${productPage.content}">
									<div class="col-xl-12 mb-4">
										<div class="wsus__product_item wsus__list_view">
											<a class="wsus__pro_link"
												href="/common/products/productdetail?id=${product.id}"> <img
												src="${product.imageUrls[0]}" alt="${product.name}"
												class="img-fluid w-100 img_1" /> <c:if
													test="${product.imageUrls.size() > 1}">
													<img src="${product.imageUrls[1]}" alt="${product.name}"
														class="img-fluid w-100 img_2" />
												</c:if>
											</a>
											<div class="wsus__product_details">
												<a class="wsus__category" href="/common/products/productdetail?id=${product.id}">${product.category.name}</a>
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
												<a class="wsus__pro_name"
													href="/common/products/productdetail?id=${product.id}">${product.name}</a>
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
												<p class="list_description">${product.description}</p>
												<ul class="wsus__single_pro_icon">
													<li><a class="add_cart" href="#">add to cart</a></li>
													<li><a href="#"><i class="far fa-heart"></i></a></li>
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
               <!-- BEGIN PAGINATOR -->
<div class="col-xl-12 text-center">
    <section id="pagination">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">

                <!-- Previous page link -->
                <c:choose>
                    <c:when test="${action == 'filter'}">
                        <c:if test="${productPage.number > 0}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/common/products/filter'/>?name=${searchName}&categoryName=<c:forEach items="${categoryName}" var="cat">${cat},</c:forEach>&brand=<c:forEach items="${brand}" var="br">${br},</c:forEach>&minPrice=${minPrice}&maxPrice=${maxPrice}&size=${productPage.size}&page=${productPage.number}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${productPage.number == 0}">
                            <li class="page-item disabled">
                                <a class="page-link" href="javascript:void(0)">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${productPage.number > 0}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/common/products/search'/>?name=${searchName}&size=${productPage.size}&page=${productPage.number}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${productPage.number == 0}">
                            <li class="page-item disabled">
                                <a class="page-link" href="javascript:void(0)">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                <!-- Page numbers -->
                <c:forEach items="${pageNumbers}" var="pageNumber">
                    <li class="page-item ${pageNumber == productPage.number + 1 ? 'active' : ''}">
                        <c:choose>
                            <c:when test="${action == 'filter'}">
                                <a class="page-link" href="<c:url value='/common/products/filter'/>?name=${searchName}&categoryName=<c:forEach items="${categoryName}" var="cat">${cat},</c:forEach>&brand=<c:forEach items="${brand}" var="br">${br},</c:forEach>&minPrice=${minPrice}&maxPrice=${maxPrice}&size=${productPage.size}&page=${pageNumber}">
                                    ${pageNumber}
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="page-link" href="<c:url value='/common/products/search'/>?name=${searchName}&size=${productPage.size}&page=${pageNumber}">
                                    ${pageNumber}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>

                <!-- Next page link -->
                <c:choose>
                    <c:when test="${action == 'filter'}">
                        <c:if test="${productPage.number < productPage.totalPages - 1}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/common/products/filter'/>?name=${searchName}&categoryName=<c:forEach items="${categoryName}" var="cat">${cat},</c:forEach>&brand=<c:forEach items="${brand}" var="br">${br},</c:forEach>&minPrice=${minPrice}&maxPrice=${maxPrice}&size=${productPage.size}&page=${productPage.number + 2}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${productPage.number == productPage.totalPages - 1}">
                            <li class="page-item disabled">
                                <a class="page-link" href="javascript:void(0)">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${productPage.number < productPage.totalPages - 1}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/common/products/search'/>?name=${searchName}&size=${productPage.size}&page=${productPage.number + 2}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${productPage.number == productPage.totalPages - 1}">
                            <li class="page-item disabled">
                                <a class="page-link" href="javascript:void(0)">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </c:otherwise>
                </c:choose>

            </ul>
        </nav>
    </section>
</div>


<!-- END PAGINATOR -->

            </div>
    </section>
    <!--============================
       VENDORS DETAILA END
    ==============================-->
</body>
