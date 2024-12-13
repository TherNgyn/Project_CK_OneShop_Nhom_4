<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<body>
    <section id="wsus__product_page" class="wsus__vendor_details_page">
        <div class="container">
            <div class="row justify-content-center">
				<div class="col-xl-9 col-lg-8">
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
								<form action="/common/products" method="get" id="filter-form">
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
						<!-- Grid View -->
						<div class="tab-pane fade show active" id="v-pills-home"
							role="tabpanel" aria-labelledby="v-pills-home-tab">
							<div class="row" id="grid-view">
								<c:forEach var="product" items="${productPage.content}">
									<div class="col-xl-4 col-sm-6 mb-4">
										<div class="wsus__product_item">
											<a class="wsus__pro_link"
												href="/common/products/productdetail?id=${product.id}"> <img
												src="${product.imageUrls[0]}" alt="${product.name}"
												class="img-fluid w-100 img_1" /> <c:if
													test="${product.imageUrls.size() > 1}">
													<img src="${product.imageUrls[1]}" alt="${product.name}"
														class="img-fluid w-100 img_2" />
												</c:if>
											</a>
											<ul class="wsus__single_pro_icon">
												<li><a href="#"><i class="fal fa-shopping-bag"></i></a></li>
												<li><a href="#"><i class="far fa-heart"></i></a></li>
												<li><a href="#"><i class="far fa-random"></i></a></li>
											</ul>
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
												<a class="add_cart" href="/common/products/productdetail?id=${product.id}">add to cart</a>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>

						<!-- List View -->
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
													href="/common/products/productdetail?id=${product.id}"></a>
													<fmt:formatNumber value="${product.promotionalPrice}"
														type="number" minFractionDigits="0" maxFractionDigits="2" />
													<del>
														<c:if test="${product.promotionalPrice < product.price}">
															<fmt:formatNumber value="${product.price}" type="number"
																minFractionDigits="0" maxFractionDigits="2" />
														</c:if>
													</del>
												
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

					<!-- Pagination -->
					<div class="col-xl-12 text-center">
						<section id="pagination">
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center">
									<!-- Previous page link -->
									<c:if test="${productPage.number > 0}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/common/products?size=${productPage.size}&page=${productPage.number}'/>"
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
											href="<c:url value='/common/products?size=${productPage.size}&page=${pageNumber}'/>">
												${pageNumber} </a>
										</li>
									</c:forEach>

									<!-- Next page link -->
									<c:if test="${productPage.number < productPage.totalPages - 1}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/common/products?size=${productPage.size}&page=${productPage.number+2}'/>"
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
			</div>
        </div>
    </section>
</body>
