<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
								class="fa fa-star-half-o"></i> <span>(${product.rating}
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
							<img src="${store.avatar}" alt="Shop Logo" class="shop-logo">
						</div>
						<div class="col-lg-10 col-md-9 col-sm-8">
							<!-- Thông tin shop -->
							<div class="shop-details">
								<h4>${store.name}</h4>
								<div>
									<a href="/user/chat/${store.id}" class="btn btn-danger">Chat
										Ngay</a> <a href="/user/store/${store.id}"
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
									<div class="reviews">
										<!-- Hiển thị danh sách đánh giá -->
										<ul>
											<c:forEach var="review" items="${reviews}">
												<li>
													<p>
														<!-- Hiển thị tên người dùng -->
														<strong>${review.user.username}</strong>:
														<!-- Hiển thị nội dung đánh giá -->
														<span>${review.content}</span> <br />
														<!-- Hiển thị đánh giá (rating) -->
														<span>Rating:</span> <span>${review.rating}</span> <br />
														<!-- Hiển thị ngày tạo -->
														<small>${review.formattedCreateat}</small>
													</p>
												</li>
											</c:forEach>
										</ul>
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
						<h2>Sản phẩm liên quan</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<!-- Hiển thị danh sách sản phẩm liên quan -->
				<c:forEach var="pro" items="${relatedProducts}">
					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="product__item">
							<div class="product__item__pic"
								style="background-image: url('${pro.imageUrls[0] != null ? pro.imageUrls[0] : 'default-image.jpg'}');">
								<ul class="product__item__pic__hover">
									<li><a href="#"><i class="fa fa-heart"></i></a></li>
									<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
								</ul>
							</div>
							<div class="product__item__text">
								<h6>
									<a href="/user/product/productdetail?id=${pro.id}">${pro.name}</a>
								</h6>
								<h5>${pro.price}</h5>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- Phân trang -->
			<div class="row">
				<div class="col-lg-12">
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<!-- Nút Previous -->
							<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
								<a class="page-link" href="javascript:void(0);"
								onclick="loadRelatedProducts(${product.id}, ${currentPage - 1}, ${pageSize});">
									Previous </a>
							</li>

							<!-- Số trang -->
							<c:forEach var="pageNumber" items="${pageNumbers}">
								<li
									class="page-item ${pageNumber == currentPage ? 'active' : ''}">
									<a class="page-link" href="javascript:void(0);"
									onclick="loadRelatedProducts(${product.id}, ${pageNumber}, ${pageSize});">
										${pageNumber} </a>
								</li>
							</c:forEach>

							<!-- Nút Next -->
							<li
								class="page-item ${currentPage == pageNumbers[pageNumbers.size() - 1] ? 'disabled' : ''}">
								<a class="page-link" href="javascript:void(0);"
								onclick="loadRelatedProducts(${product.id}, ${currentPage + 1}, ${pageSize});">
									Next </a>
							</li>
						</ul>
					</nav>

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
            href: 'https://a066-103-129-191-39.ngrok-free.app/common/products/productdetail?id=<c:out value="${product.id}" />', // Chỉnh sửa cú pháp JSP
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