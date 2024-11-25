<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
</head>
<body>
	<!-- <!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="../../../common/user/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>Chi tiết sản phẩm</h2>

					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End --> -->

	<!-- Product Details Section Begin -->
	<section class="product-details spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<div class="product__details__pic">
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="${product.imageUrls[0]}" alt="">
						</div>
						<div class="product__details__pic__slider owl-carousel">
							<img
								data-imgbigurl="../../../common/user/img/banner/banner-1.jpg"
								src="../../../common/user/img/banner/banner-5.jpg" alt="">
							<img
								data-imgbigurl="../../../common/user/img/banner/banner-1.jpg"
								src="../../../common/user/img/banner/banner-6.jpg" alt="">
							<img
								data-imgbigurl="../../../common/user/img/banner/banner-1.jpg"
								src="../../../common/user/img/banner/banner-7.jpg" alt="">
							<img
								data-imgbigurl="../../../common/user/img/banner/banner-1.jpg"
								src="../../../common/user/img/banner/banner-11.jpg" alt="">
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="product__details__text">
						<h3>${product.name }</h3>
						<div class="product__details__rating">
							<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star-half-o"></i> <span>(${product.rating}
								lượt)</span>
						</div>
						<div class="product__details__price">${product.price }</div>
						<p>${product.description != null ? product.description : "Không có mô tả"}</p>

						<div class="product__details__quantity">
							<div class="quantity">
								<div class="pro-qty">
									<input id="count" type="text" value="1">
								</div>
							</div>
						</div>
						<%-- <button class="primary-btn" onclick="submitForm(${product.id})">THÊM VÀO GIỎ</button> --%>

						<a onclick="submitForm(${product.id}, ${check })" href="#"
							class="primary-btn">THÊM VÀO GIỎ</a> <a href="#"
							class="heart-icon"><i class="fa-solid fa-heart"></i></a>
						<ul>
							<li><b>Tình trạng</b> <span>${product.isSelling != null && product.isSelling ? 'Còn hàng' : 'Hết hàng' }</span></li>
							<li><b>Giao hàng</b> <span>01 ngày giao hàng <samp>Free
										pickup today</samp></span></li>
							<li><b>Đã bán</b> <span>${product.sold}</span></li>
							<li><b>Bán tại</b>
								<div class="share">
									<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
										class="fa fa-twitter"></i></a> <a href="#"><i
										class="fa fa-instagram"></i></a> <a href="#"><i
										class="fa fa-pinterest"></i></a>
								</div></li>

						</ul>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="product__details__tab">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#tabs-1" role="tab" aria-selected="true">Mô
									tả</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#tabs-2" role="tab" aria-selected="false">Thông tin</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#tabs-3" role="tab" aria-selected="false">Đánh giá<span>
										(${product.rating} lượt)</span></a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-1" role="tabpanel">
								<div class="product__details__tab__desc">
									<h6>MÔ TẢ SẢN PHẨM</h6>
									<p>${product.description}</p>
								</div>
							</div>
							<div class="tab-pane" id="tabs-2" role="tabpanel">
								<div class="product__details__tab__desc">
									<h6>THÔNG TIN SẢN PHẨM</h6>
									<p>${product.description}</p>
								</div>
							</div>
							<div class="tab-pane" id="tabs-3" role="tabpanel">
								<div class="product__details__tab__desc">
									<h6>ĐÁNH GIÁ SẢN PHẨM</h6>
									<c:if test="${listreview.size() > 0}">
										<c:forEach var="review" items="${listreview}">
											<div class="contact-form spad">
												<div class="container">

													<div class="col-lg-3 col-md-6 col-sm-6"
														style="display: flex;">

														<div class="footer__about__logo">
															<img class="img-profile rounded-circle"
																style="width: 40px"
																src="/images/user/${review.user.avatar}">
														</div>
														<div class="footer__about">

															<ul>
																<li>${review.user.username}</li>
																<li>Nội dung: ${review.content}</li>
																<li>Điểm số: ${review.rating}</li>
																<li>Ngày đánh giá: ${review.createat}</li>

															</ul>

														</div>

													</div>

												</div>
											</div>
										</c:forEach>
									</c:if>
									<!-- Review Form Begin -->
									<div class="contact-form spad">
										<div class="container">
											<div class="row">
												<div class="col-lg-12">
													<div class="contact__form__title">
														<h2>Đánh giá</h2>
													</div>
												</div>
											</div>
											<form action="/user/review/${product.id }" method="post">
												<div class="" style="display: flex;">
													<div class="" style="width: 550px;">
														<div>
															<input name="content" type="text" placeholder="Nội dung"
																style="height: 150px">
														</div>
														<div>
															<input name="rating" type="number" max="5" min="0"
																placeholder="Điểm đánh giá">
														</div>
														<div class="col-lg-12 text-center">
															<button type="submit" class="site-btn">GỬI</button>
														</div>
													</div>
													<%-- <div style="width: 650px; margin-left: 170px">
														<img class="product__details__pic__item--large"
															src="${product.listimage }"
															alt="">
													</div> --%> <!-- Chỗ này xử lý hình ảnh đánh giá ở Entity Review -->
												</div>
											</form>
										</div>
									</div>
									<!-- Review Form End -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Details Section End -->

	<!-- Related Product Section Begin -->
	<section class="related-product">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title related__product__title">
						<h2>Sản phẩm liên quan</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<c:forEach var="pro" items="${listbycate.content}">
					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="product__item">
							<div class="product__item__pic set-bg"
								data-setbg="../../../common/user/img/product/${pro.listimage}">
								<ul class="product__item__pic__hover">
									<li><a href="#"><i class="fa fa-heart"></i></a></li>
									<li><a href="#"><i class="fa fa-retweet"></i></a></li>
									<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
								</ul>
							</div>
							<div class="product__item__text">
								<h6>
									<a href="/user/product/productdetail/${pro.id}">${pro.name}</a>
								</h6>
								<h5>${pro.price}</h5>
							</div>
						</div>
					</div>
				</c:forEach>

				<c:if test="${listbycate != null && listbycate.totalPages > 0}">
					<nav aria-label="Page navigation"
						style="display: flex; justify-content: center;">
						<ul class="pagination">
							<!-- First Page -->
							<li
								class="page-item ${1 == listbycate.number + 1 ? 'active' : ''}">
								<a class="page-link"
								href="/user/product/productdetail?id=${product.id}&size=${listbycate.size}&page=1">First</a>
							</li>

							<!-- Middle Pages -->
							<c:forEach items="${pageNumbers}" var="pageNumber">
								<li
									class="page-item ${pageNumber == listbycate.number + 1 ? 'active' : ''}">
									<a class="page-link"
									href="/user/product/productdetail?id=${product.id}&size=${listbycate.size}&page=${pageNumber}">${pageNumber}</a>
								</li>
							</c:forEach>

							<!-- Last Page -->
							<li
								class="page-item ${listbycate.totalPages == listbycate.number + 1 ? 'active' : ''}">
								<a class="page-link"
								href="/user/product/productdetail?id=${product.id}&size=${listbycate.size}&page=${listbycate.totalPages}">Last</a>
							</li>
						</ul>
					</nav>
				</c:if>
			</div>
		</div>
	</section>

	<script>
    async function submitForm(pro, check) {
        if (check == 0) {
            alert("BẠN VUI LÒNG ĐĂNG NHẬP ĐỂ TIẾP TỤC MUA HÀNG");
            return;
        }
        
        const ele = document.getElementById("count")?.value || 1; // Lấy giá trị số lượng, mặc định là 1 nếu không có.
        
        try {
            const response = await fetch(`http://localhost:9093/user/cart/item/add/${pro}/${ele}`);
            if (response.ok) {
                alert("Sản phẩm đã được thêm vào giỏ hàng!");
            } else {
                alert("Không thể thêm vào giỏ hàng. Vui lòng thử lại.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("Có lỗi xảy ra khi thêm vào giỏ hàng.");
        }
    }
</script>

</body>