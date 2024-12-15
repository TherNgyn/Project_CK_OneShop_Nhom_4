<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<body>
	<!--==========================
      PRODUCT MODAL VIEW START
    ===========================-->
	<section class="product_popup_modal">
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body">
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="far fa-times"></i>
						</button>
						<div class="row">
							<div
								class="col-xl-6 col-12 col-sm-10 col-md-8 col-lg-6 m-auto display">
								<div class="wsus__quick_view_img">
									<a class="venobox wsus__pro_det_video" data-autoplay="true"
										data-vbtype="video" href="https://youtu.be/7m16dFI1AF8"> <i
										class="fas fa-play"></i>
									</a>
									<div class="row modal_slider">
										<div class="col-xl-12">
											<div class="modal_slider_img">
												<img src="template/images/zoom1.jpg" alt="product"
													class="img-fluid w-100">
											</div>
										</div>
										<div class="col-xl-12">
											<div class="modal_slider_img">
												<img src="template/images/zoom2.jpg" alt="product"
													class="img-fluid w-100">
											</div>
										</div>
										<div class="col-xl-12">
											<div class="modal_slider_img">
												<img src="template/images/zoom3.jpg" alt="product"
													class="img-fluid w-100">
											</div>
										</div>
										<div class="col-xl-12">
											<div class="modal_slider_img">
												<img src="template/images/zoom4.jpg" alt="product"
													class="img-fluid w-100">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-6 col-12 col-sm-12 col-md-12 col-lg-6">
								<div class="wsus__pro_details_text">
									<ul class="wsus__button_area">
										<li><form action="/user/cart/add/${product.id}"
												method="POST">
												<input type="hidden" name="_csrf" value="${_csrf.token}">
												<input type="hidden" name="quantity" value="1"> <a
													class="add_cart" href="#"
													onclick="this.closest('form').submit(); return false;">ADD
													TO CART</a>
											</form></li>
										<li><a class="buy_now" href="#">buy now</a></li>
										<li><a href="#"><i class="fal fa-heart"></i></a></li>
										<li><a href="#"><i class="far fa-random"></i></a></li>
									</ul>
									<p class="brand_model">
										<span>model :</span> 12345670
									</p>
									<p class="brand_model">
										<span>brand :</span> The Northland
									</p>
									<div class="wsus__pro_det_share">
										<h5>share :</h5>
										<ul class="d-flex">
											<li><a class="facebook" href="#"><i
													class="fab fa-facebook-f"></i></a></li>
											<li><a class="twitter" href="#"><i
													class="fab fa-twitter"></i></a></li>
											<li><a class="whatsapp" href="#"><i
													class="fab fa-whatsapp"></i></a></li>
											<li><a class="instagram" href="#"><i
													class="fab fa-instagram"></i></a></li>
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
	<!--==========================
      PRODUCT MODAL VIEW END
    ===========================-->


	<!--============================
        BANNER PART 2 START
    ==============================-->
	<section id="wsus__banner">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">
					<div class="wsus__banner_content">
						<div class="row banner_slider">
							<div class="col-xl-12">
								<div class="wsus__single_slider"
									style="background: url(https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734146328/z6128808095562_213db3d87a124186f2f6f8ce0c31505b_ndzjkl.jpg);">
									<div class="wsus__single_slider_text">
										<h3>new arrivals</h3>
										<h1>Skincare</h1>
										<h6>start at 99.000đ</h6>
										<a class="common_btn" href="#">shop now</a>
									</div>
								</div>
							</div>
							<div class="col-xl-12">
								<div class="wsus__single_slider"
									style="background: url(https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734146328/z6128808141472_6b79ad8c11b81106d0a64ccbc9d08f7e_ykhwlu.jpg);">
									<div class="wsus__single_slider_text">
										<h3>new arrivals</h3>
										<h1>Bodycare</h1>
										<h6>start at 99.000đ</h6>
										<a class="common_btn" href="#">shop now</a>
									</div>
								</div>
							</div>
							<div class="col-xl-12">
								<div class="wsus__single_slider"
									style="background: url(https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734146328/z6128808170611_5e4a39eae4231839658e698b76bdc073_vz5ape.jpg);">
									<div class="wsus__single_slider_text">
										<h3>new arrivals</h3>
										<h1>Makeup</h1>
										<h6>start at 99.000đ</h6>
										<a class="common_btn" href="#">shop now</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--============================
        BANNER PART 2 END
    ==============================-->


	<!--============================
        FLASH SELL START
    ==============================-->
	<section id="wsus__flash_sell" class="wsus__flash_sell_2">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">
					<!-- Banner Section (if needed) -->
				</div>
			</div>
			<div class="row flash_sell_slider">
				<c:forEach var="product" items="${products}">
					<div class="col-xl-3 col-sm-6 col-lg-4">
						<div class="wsus__product_item">
							<span class="wsus__new">New</span> <a class="wsus__pro_link"
								href="/user/products/productdetail?id=${product.id}"> <c:forEach
									var="image" items="${product.images}">
									<c:if test="${image.isMain}">
										<img src="${image.imageUrl}" alt="product"
											class="img-fluid w-100 img_1" />
									</c:if>
								</c:forEach>
							</a>
							<ul class="wsus__single_pro_icon">
								<li><a href="#"><i class="far fa-heart"></i></a></li>
								<li><a href="#"><i class="far fa-random"></i></a></li>
							</ul>
							<div class="wsus__product_details">
								<a class="wsus__category"
									href="category?id=${product.category.id}"> <span>${product.category.name}</span>
								</a>
								<p class="wsus__pro_rating">
									<c:forEach begin="1" end="${product.rating}" var="i">
										<i class="fas fa-star"></i>
									</c:forEach>
									<c:if test="${product.rating % 1 != 0}">
										<i class="fas fa-star-half-alt"></i>
									</c:if>
									<span>(${fn:length(product.reviews)} review)</span>
								</p>
								<a class="wsus__pro_name"
									href="/user/products/productdetail?id=${product.id}">${product.name}</a>
								<p class="wsus__price">
									$<span>${product.price}</span>
									<c:if test="${product.promotionalPrice != null}">
										<del>$${product.promotionalPrice}</del>
									</c:if>
								</p>
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
	</section>


	<!--============================
        FLASH SELL END
    ==============================-->


	<!--============================
       MONTHLY TOP PRODUCT START
    ==============================-->
	<section id="wsus__monthly_top" class="wsus__monthly_top_2">
		<div class="container">
			<div class="row">
				<div class="col-xl-12 col-lg-12">
					<div class="wsus__monthly_top_banner">
						<div class="wsus__monthly_top_banner_img">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734146327/z6128821706439_fcfd6e9611690ff4000ba8a6c40f6ad0_olvpge.jpg"
								alt="img" class="img-fluid w-100">

						</div>

					</div>
				</div>
			</div>
			<section id="wsus__top_categories" class="wsus__top_categories">
				<div class="container">
					<div class="row">
						<div class="col-xl-12">
							<div class="wsus__section_header for_md">
								<h3>Top Categories</h3>
								<div class="monthly_top_filter">
									<button class="active" data-filter="all">All</button>
									<c:forEach var="category" items="${categories}">
										<button data-filter=".cat${category.id}">${category.name}</button>
									</c:forEach>
								</div>

							</div>
						</div>
					</div>
					<script>
					document.addEventListener("DOMContentLoaded", function () {
					    const buttons = document.querySelectorAll(".monthly_top_filter button");
					    const products = document.querySelectorAll(".grid .col-lg-3");

					    buttons.forEach((button) => {
					        button.addEventListener("click", function () {
					            // Xóa trạng thái "active" của tất cả nút
					            buttons.forEach((btn) => btn.classList.remove("active"));

					            // Gắn trạng thái "active" cho nút được chọn
					            this.classList.add("active");

					            // Lấy class category từ nút được chọn
					            const filterClass = this.getAttribute("data-filter");

					            // Ẩn hoặc hiển thị các sản phẩm theo danh mục
					            products.forEach((product) => {
					                if (filterClass === "all" || product.classList.contains(filterClass.substring(1))) {
					                    product.style.display = "block";
					                } else {
					                    product.style.display = "none";
					                }
					            });
					        });
					    });

					    // Mặc định: Hiển thị tất cả sản phẩm (nếu cần)
					    buttons[0]?.click();
					});

					</script>
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="row grid">
								<c:forEach var="category" items="${categories}">
									<c:forEach var="product" items="${category.topProducts}">
										<div
											class="col-xl-2 col-6 col-sm-6 col-md-4 col-lg-3 cat${category.id}">
											<a class="wsus__hot_deals__single"
												href="/user/products/productdetail?id=${product.id}">
												<div class="wsus__hot_deals__single_img">
													<c:forEach var="image" items="${product.images}">
														<c:if test="${image.isMain}">
															<img src="${image.imageUrl}" alt="product"
																class="img-fluid w-100" />
														</c:if>
													</c:forEach>
												</div>
												<div class="wsus__hot_deals__single_text">
													<h5>${product.name}</h5>
													<p class="wsus__rating">
														<c:forEach begin="1" end="${product.rating}" var="i">
															<i class="fas fa-star"></i>
														</c:forEach>
														<c:if test="${product.rating % 1 != 0}">
															<i class="fas fa-star-half-alt"></i>
														</c:if>
													</p>
													<p class="wsus__tk">
														$${product.price}
														<c:if test="${product.promotionalPrice != null}">
															<del>$${product.promotionalPrice}</del>
														</c:if>
													</p>
												</div>
											</a>
										</div>
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</section>

	<!--============================
       MONTHLY TOP PRODUCT END
    ==============================-->



	<!--============================
        BRAND SLIDER START
    ==============================-->
	<section id="wsus__brand_sleder" class="brand_slider_2">
		<div class="container">
			<div class="brand_border">
				<div class="row brand_slider">
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151450/z6129009593322_84a80510f36c285c50bf6fc2e1d77ffe_jxdfms.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151450/z6129009436154_990310ec16b5256a732f897282fc8007_m91prp.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151450/z6129009564789_d808e11a5be26a6176cfc3e551753b94_tjiogt.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151450/z6129009436153_bfeb396f97a7dab30bd532c64cb8e404_ulaogg.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151449/z6129009436010_5a7bd18c34b108f390e73980a026f295_xern1q.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151449/z6129009436009_96f351a91fab03de1f7227850d7f0f91_jfxj1a.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
					<div class="col-xl-2">
						<div class="wsus__brand_logo">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151449/z6129009402521_abcf6bb9736ff27853a55e58096dd805_tnvohu.jpg"
								alt="brand" class="img-fluid w-100">
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
		$(document)
				.ready(
						function() {
							$('.brand_slider')
									.slick(
											{
												slidesToShow : 5,
												slidesToScroll : 1,
												autoplay : true,
												autoplaySpeed : 2000,
												arrows : true,
												prevArrow : '<div class="prv_arr"><i class=""></i></div>',
												nextArrow : '<div class="nxt_arr"><i class=""></i></div>',
												responsive : [ {
													breakpoint : 768,
													settings : {
														slidesToShow : 3,
													}
												}, {
													breakpoint : 480,
													settings : {
														slidesToShow : 2,
													}
												} ]
											});
						});
	</script>
	<!--============================
        BRAND SLIDER END
    ==============================-->


	<!--============================
        SINGLE BANNER START
    ==============================-->
	<section id="wsus__single_banner" class="wsus__single_banner_2">
		<div class="container">
			<div class="row">
				<div class="col-xl-6 col-lg-6">
					<div class="wsus__single_banner_content">
						<div class="wsus__single_banner_img">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734151451/z6129009465372_8d89fb304a13850c7e0adefe5d616fd5_grqym8.jpg"
								alt="banner" class="img-fluid w-100">
						</div>
						<div class="wsus__single_banner_text">
							<h6>
								sell on <span>20% off</span>
							</h6>
							<h3>Makeup Products</h3>
							<a class="shop_btn" href="#">shop now</a>
						</div>
					</div>
				</div>
				<div class="col-xl-6 col-lg-6">
					<div class="wsus__single_banner_content single_banner_2">
						<div class="wsus__single_banner_img">
							<img
								src="https://res.cloudinary.com/dl0bk0sgl/image/upload/v1734147785/z6128873503763_d69634535847a555e5fe4fe3168924fa_narf5i.jpg"
								alt="banner" class="img-fluid w-100">
						</div>
						<div class="wsus__single_banner_text">
							<h6>New Collection</h6>
							<h3>Skincare Products</h3>
							<a class="shop_btn" href="#">shop now</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--============================
        SINGLE BANNER END  
    ==============================-->


	<!--============================
        HOT DEALS START
    ==============================-->
	<section id="wsus__hot_deals" class="wsus__hot_deals_2">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">
					<div class="wsus__section_header">
						<h3>Products with High Ratings</h3>
					</div>
				</div>
			</div>
			<div class="row hot_deals_slider_2">
				<c:forEach var="product" items="${topRatedProducts}">
					<div class="col-xl-4 col-lg-6">
						<div class="wsus__hot_deals_offer">
							<div class="wsus__hot_deals_img">
								<c:forEach var="image" items="${product.images}">
									<c:if test="${image.isMain}">
										<img src="${image.imageUrl}" alt="${product.name}"
											class="img-fluid w-100">
									</c:if>
								</c:forEach>
							</div>
							<div class="wsus__hot_deals_text">
								<a class="wsus__hot_title"
									href="/user/products/productdetail?id=${product.id}">
									${product.name} </a>
								<p class="wsus__rating">
									<c:forEach begin="1" end="${product.rating}" var="i">
										<i class="fas fa-star"></i>
									</c:forEach>
									<c:if test="${product.rating % 1 != 0}">
										<i class="fas fa-star-half-alt"></i>
									</c:if>
									<span>(${product.reviews.size()}
										review${product.reviews.size() > 1 ? 's' : ''})</span>
								</p>
								<p class="wsus__hot_deals_proce">
									$${product.price}
									<c:if test="${product.promotionalPrice != null}">
										<del>${product.promotionalPrice}</del>
									</c:if>
								</p>
								<p class="wsus__details">${product.description}</p>
								<ul>
									<li><form action="/user/cart/add/${product.id}"
											method="POST">
											<input type="hidden" name="_csrf" value="${_csrf.token}">
											<input type="hidden" name="quantity" value="1"> <a
												class="add_cart" href="#"
												onclick="this.closest('form').submit(); return false;">ADD
												TO CART</a>
										</form></li>
									<li><a href="#"><i class="far fa-heart"></i></a></li>
									<li><a href="#"><i class="far fa-random"></i></a></li>
								</ul>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!--============================
        HOT DEALS END  
    ==============================-->


	<!--============================
        ELECTRONIC PART START  
    ==============================-->
	<section id="wsus__electronic">
		<div class="container"></div>
	</section>
	<!--============================
        ELECTRONIC PART END  
    ==============================-->



	<!--============================
      HOME SERVICES START
    ==============================-->
	<section id="wsus__home_services" class="home_service_2">
		<div class="container">
			<div class="row">
				<div class="col-xl-3 col-sm-6 col-lg-3 pe-lg-0">
					<div
						class="wsus__home_services_single home_service_single_2 border_left">
						<i class="fal fa-truck"></i>
						<h5>Free Worldwide Shipping</h5>
						<p>Free shipping coast for all country</p>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 col-lg-3 pe-lg-0">
					<div class="wsus__home_services_single home_service_single_2">
						<i class="fal fa-headset"></i>
						<h5>24/7 Customer Support</h5>
						<p>Friendly 24/7 customer support</p>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 col-lg-3 pe-lg-0">
					<div class="wsus__home_services_single home_service_single_2">
						<i class="far fa-exchange-alt"></i>
						<h5>Money Back Guarantee</h5>
						<p>We return money within 30 days</p>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 col-lg-3">
					<div class="wsus__home_services_single home_service_single_2">
						<i class="fal fa-credit-card"></i>
						<h5>Secure Online Payment</h5>
						<p>We posess SSL / Secure Certificate</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--============================
        HOME SERVICES END
    ==============================-->


	<!--============================
        HOME BLOGS START
    ==============================-->
	<section id="wsus__blogs" class="home_blogs">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">
					<div class="wsus__section_header">
						<h3>Recent Blogs</h3>
						<a class="see_btn" href="/blogs">See More <i
							class="fas fa-caret-right"></i></a>
					</div>
				</div>
			</div>
			<div class="row home_blog_slider">
				<c:forEach var="blog" items="${latestBlogs}">
					<div class="col-xl-3">
						<div class="wsus__single_blog wsus__single_blog_2">
							<a class="wsus__blog_img" href="/blog/${blog.id}"> <img
								src="${blog.imageUrl}" alt="${blog.title}"
								class="img-fluid w-100">
							</a>
							<div class="wsus__blog_text">
								<a class="blog_top" href="#">${blog.category}</a>
								<div class="wsus__blog_text_center">
									<a href="/blog/${blog.id}">${blog.title}</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!--============================
        HOME BLOGS END
    ==============================-->
</body>