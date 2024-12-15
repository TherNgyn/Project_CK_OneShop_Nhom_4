<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
</head>
<body>
	<!-- Product Details Section Begin -->
	<section class="product-details spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<div class="product__details__pic">
						<div class="product__details__pic__item">
							<!-- Hình ảnh chính -->
							<img class="product__details__pic__item--large main-img"
								src="${product.imageUrls[0]}" alt="Main Image">
							<!-- Hình ảnh hover -->
							<c:if test="${product.imageUrls.size() > 1}">
								<img class="hover-img" src="${product.imageUrls[1]}"
									alt="Hover Image">
							</c:if>
						</div>
						<div class="product__details__pic__list">
							<c:forEach var="img" items="${product.imageUrls}">
								<div class="product__details__pic__thumb">
									<img src="${img}" alt="Thumbnail Image"
										onclick="changeMainImage(this)">
								</div>
							</c:forEach>
						</div>
					</div>

				</div>
				<div class="col-lg-6 col-md-6">
					<div class="product__details__text">
						<h3>${product.name }</h3>
						<div class="product__details__rating">
							<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star-half-o"></i> <span>(${totalReviews}
								lượt)</span>
						</div>
						<div class="product__details__price">
							<span class="current-price">${product.promotionalPrice}</span> <span
								class="original-price">${product.price}</span>
						</div>


						<form action="/user/cart/add/${product.id}" method="post">
							<!-- Thêm CSRF token -->
							<input type="hidden" name="_csrf" value="${_csrf.token}">

							<div class="product__details__quantity">
								<div class="quantity">
									<button type="button" class="qty-btn minus"
										onclick="decrementQuantity()">-</button>
									<input id="quantity" name="quantity" type="number" value="1"
										min="1">
									<button type="button" class="qty-btn plus"
										onclick="incrementQuantity()">+</button>
								</div>
							</div>
							<button type="submit" class="primary-btn">THÊM VÀO GIỎ</button>
						</form>


						<script>
    function incrementQuantity() {
        const countInput = document.getElementById("quantity");
        let value = parseInt(countInput.value, 10);
        if (!isNaN(value)) {
            countInput.value = value + 1; // Tăng số lượng
        }
    }

    function decrementQuantity() {
        const countInput = document.getElementById("quantity");
        let value = parseInt(countInput.value, 10);
        if (!isNaN(value) && value > 1) {
            countInput.value = value - 1; // Giảm số lượng (không cho nhỏ hơn 1)
        }
    }
</script>


						<ul>
							<li><b>Tình trạng</b> <span>${product.isSelling != null && product.isSelling ? 'Còn hàng' : 'Hết hàng' }</span></li>
							<li><b>Đã bán</b> <span>${product.sold}</span></li>

						</ul>
						<!-- !-- Social sharing -->
						<div class="social-icons">
							<h3>Share with:</h3>
							<div>
								<ul>
									<!-- Social sharing -->
									<li><a class="facebook" href="javascript:void(0);"
										onclick="shareOnFacebook()"> <i class="fab fa-facebook-f"></i>
									</a></li>

								</ul>
							</div>

						</div>
					</div>
				</div>
				<div class="shop-info">
					<div class="row align-items-center">
						<!-- Logo và tên shop -->
						<div class="col-lg-2 col-md-3 col-sm-4 text-center">
							<img src="${product.store.avatar}" alt="Shop Logo" class="shop-logo">
						</div>
						<div class="col-lg-10 col-md-9 col-sm-8">
							<!-- Thông tin shop -->
							<div class="shop-details">
								<h4>${product.store.name}</h4>
								<div>
									<a href="/user/chat/${product.store.id}" class="btn btn-danger">Chat
										Ngay</a> <a href="/user/storedetail/${product.store.id}"
										class="btn btn-outline-secondary">Xem Shop</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row shop-stats">
						<!-- Đánh Giá -->
						<div class="col-lg-3 col-md-4 col-sm-6">
							<p>
								<b>Đánh Giá:</b> <span>${store.rating != null ? store.rating : 'Chưa có đánh giá'}</span>
							</p>
						</div>
						<!-- Tình trạng hoạt động -->
						<div class="col-lg-3 col-md-4 col-sm-6">
							<p>
								<b>Trạng thái:</b> <span>${store.isactive ? 'Hoạt động' : 'Ngừng hoạt động'}</span>
							</p>
						</div>
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
										(${totalReviews} lượt)</span></a></li>
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
									<div class="reviews">
										<!-- Kiểm tra nếu có đánh giá -->
										<c:choose>
											<c:when test="${!empty reviews}">
												<ul>
													<c:forEach var="review" items="${reviews}">
														<li>
															<p>
																<!-- Hiển thị tên người dùng -->
																<strong>${review.user.username}</strong>: <br>
																<!-- Hiển thị nội dung đánh giá -->
																<span>${review.content}</span> <br>
																<!-- Hiển thị đánh giá (rating) -->
																<span>Rating:</span>
																<c:forEach begin="1" end="${review.rating}">
																	<i class="fa fa-star"></i>
																</c:forEach>
																<c:forEach begin="${review.rating + 1}" end="5">
																	<i class="fa fa-star-o"></i>
																</c:forEach>
																<br>
																<!-- Hiển thị ngày tạo (định dạng ngay tại đây) -->
																<small class="text-muted"> <fmt:formatDate
																		value="${review.createat}" pattern="dd-MM-yyyy HH:mm" />
																</small>
															</p>
														</li>
													</c:forEach>
												</ul>
											</c:when>
											<c:otherwise>
												<!-- Hiển thị khi không có đánh giá -->
												<p>Chưa có đánh giá nào cho sản phẩm này.</p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Details Section End -->

	<section class="related-product">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title related__product__title">
					</div>
				</div>
			</div>
			<div class="container mt-5">
				<h2 class="text-center mb-4">Sản phẩm liên quan</h2>
				<div id="productCarousel" class="carousel slide"
					data-bs-ride="carousel">
					<!-- Carousel Inner -->
					<div class="carousel-inner">
						<c:forEach var="chunk" items="${relatedProducts}"
							varStatus="status">
							<div class="carousel-item ${status.first ? 'active' : ''}">
								<div class="row">
									<c:forEach var="pro" items="${relatedProducts}">
										<div class="col-lg-3 col-md-4 col-sm-6">
											<div class="product__item card">
												<div class="product__item__pic card-img-top"
													style="background-image: url('${pro.imageUrls[0] != null ? pro.imageUrls[0] : 'default-image.jpg'}');">
													<ul class="product__item__pic__hover">
														<li><a href="#"><i class="fa fa-heart"></i></a></li>
														<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
													</ul>
												</div>
												<div class="product__item__text card-body">
													<h6 class="card-title">
														<a href="/user/product/productdetail?id=${pro.id}">${pro.name}</a>
													</h6>
													<h5 class="bold-text"
														style="color: black; font-weight: bold; font-size: 20px;">
														${pro.promotionalPrice}</h5>
													<h5>
														<s>${pro.price}</s>
													</h5>
												</div>
											</div>
										</div>
									</c:forEach>

								</div>
							</div>
						</c:forEach>
					</div>

					<!-- Controls -->
					<button class="carousel-control-prev" type="button"
						data-bs-target="#productCarousel" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#productCarousel" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			</div>
			</section>




			<!-- Related Product Section End -->

			<script>
	function changeMainImage(thumbnail) {
		const mainImage = document.querySelector('.product__details__pic__item--large');
		mainImage.src = thumbnail.src;
	}
	function loadRelatedProducts(productId, page, size) {
		const url = `/user/product/productdetail?id=${productId}&page=${page}&size=${size}`;

		fetch(url, { method: 'GET' })
				.then(response => response.text())
				.then(html => {
					const parser = new DOMParser();
					const doc = parser.parseFromString(html, 'text/html');
					const relatedProductSection = doc.querySelector('.related-product');
					document.querySelector('.related-product').innerHTML = relatedProductSection.innerHTML;
				})
				.catch(error => console.error('Error loading related products:', error));
	}

	</script>
	
	<!-- Load the Facebook SDK for JavaScript -->
<div id="fb-root"></div>
<script async defer crossorigin="anonymous"
  src="https://connect.facebook.net/en_US/sdk.js"></script>
<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '492624269865314', // Thay đổi appId của bạn nếu cần
            xfbml      : true,
            version    : 'v21.0'
        });
        FB.AppEvents.logPageView();
    };
    (function(d, s, id){
         var js, fjs = d.getElementsByTagName(s)[0];
         if (d.getElementById(id)) return;
         js = d.createElement(s); js.id = id;
         js.src = "https://connect.facebook.net/en_US/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>

			<script>
    function shareOnFacebook() {
        FB.ui({
            method: 'share',
            href: 'https://a066-103-129-191-39.ngrok-free.app/products/productdetail?id=<c:out value="${product.id}" />', // Chỉnh sửa cú pháp JSP
        }, function(response) {
            if (response && !response.error_message) {
                alert('Sharing succeeded.');
            } else {
                alert('Error while sharing.');
            }
        });
    }
</script>
</body>