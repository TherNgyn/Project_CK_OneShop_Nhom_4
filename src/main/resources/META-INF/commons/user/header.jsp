<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header>
	<div class="container">
		<div class="row">
			<div class="col-2 col-md-1 d-lg-none">
				<div class="wsus__mobile_menu_area">
					<span class="wsus__mobile_menu_icon"><i class="fal fa-bars"></i></span>
				</div>
			</div>
			<div class="col-xl-2 col-7 col-md-8 col-lg-2">
				<div class="wsus_logo_area">
					<a class="wsus__header_logo" href="/user/home"> <img
						src="/template/images/logo_2.png" alt="logo"
						class="img-fluid w-100">
					</a>
				</div>

			</div>
			<div class="col-xl-5 col-md-6 col-lg-4 d-none d-lg-block">
				<div class="wsus__search">
					<form action="/user/products/search" method="get">
						<input type="text" placeholder="Search..." name="searchname">
						<button type="submit">
							<i class="far fa-search"></i>
						</button>
					</form>
				</div>
			</div>
			<div class="col-xl-5 col-3 col-md-3 col-lg-6">
				<div class="wsus__call_icon_area">
					<div class="wsus__call_area">
						<div class="wsus__call">
							<i class="fas fa-user-headset"></i>
						</div>
						<div class="wsus__call_text">
							<p>oneshop@gmail.com</p>
							<p>0942782355</p>
						</div>




					</div>
					<ul class="wsus__icon_area">
						<li><a href="compare.jsp"><i class="fal fa-random"></i></a></li>
						<li><a class="wsus__cart_icon" href="/user/cart"> <i
								class="fal fa-shopping-bag"></i> <span>0</span>
						</a></li>
					</ul>

					<script>
					function updateCartCount() {
					    fetch("/user/cart/count", { method: "GET" })
					        .then(response => {
					            if (!response.ok) {
					                throw new Error("Network response was not ok");
					            }
					            return response.text();
					        })
					        .then(count => {
					            const cartCountElement = document.querySelector('.wsus__cart_icon span');
					            if (cartCountElement) {
					                cartCountElement.textContent = count; // Hiển thị số lượng CartItem
					            }
					        })
					        .catch(error => console.error('Error fetching cart count:', error));
					}

					// Gọi hàm khi tải trang
					document.addEventListener('DOMContentLoaded', () => {
					    updateCartCount();
					});

					// Tự động cập nhật số lượng CartItem mỗi 30 giây
					setInterval(updateCartCount, 30000);



</script>

				</div>
			</div>
		</div>
	</div>
	<%-- <div class="wsus__mini_cart">
		<h4>
			shopping cart <span class="wsus_close_mini_cart"><i
				class="far fa-times"></i></span>
		</h4>
		<ul>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/tab_2.jpg"
						alt="product" class="img-fluid w-100"></a> <a
						class="wsis__del_icon" href="#"><i class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">apple 9.5" 7 serise tab
						with full view display</a>
					<p>
						$140
						<del>$150</del>
					</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/pro4.jpg"
						alt="product" class="img-fluid w-100"></a> <a
						class="wsis__del_icon" href="#"><i class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">men's fashion casual watch</a>
					<p>$130</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/pro2.jpg"
						alt="product" class="img-fluid w-100"></a> <a
						class="wsis__del_icon" href="#"><i class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">men's casual shoes</a>
					<p>
						$140
						<del>$150</del>
					</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/pro9.jpg"
						alt="product" class="img-fluid w-100"></a> <a
						class="wsis__del_icon" href="#"><i class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">men's fashion casual
						sholder bag</a>
					<p>$140</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/tab_2.jpg"
						alt="product" class="img-fluid w-100"></a> <a
						class="wsis__del_icon" href="#"><i class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">apple 9.5" 7 serise tab
						with full view display</a>
					<p>
						$140
						<del>$150</del>
					</p>
				</div>
			</li>
		</ul>
		<h5>
			sub total <span>$3540</span>
		</h5>
		<div class="wsus__minicart_btn_area">
			<a class="common_btn" href="cart_view.jsp">view cart</a> <a
				class="common_btn" href="check_out.jsp">checkout</a>
		</div>
	</div> --%>
</header>
<!--============================
        MAIN MENU START
    ==============================-->
<nav class="wsus__main_menu d-none d-lg-block">
	<div class="container">
		<div class="row">
			<div class="col-xl-12">
				<div class="relative_contect d-flex">

					<ul class="wsus__menu_item">
						<li><a class="active" href="/user/home">home</a></li>
						<%-- <li><a href="product_grid_view.html">brands <i
								class="fas fa-caret-down"></i></a>
							<div class="wsus__mega_menu">
								<div class="row">
									<div class="col-xl-3 col-lg-3">
										<div class="wsus__mega_menu_colum">
											<h4>Brands</h4>
											<ul class="wsis__mega_menu_item">
												<c:forEach var="brand" items="${brands}">
													<li><a
														href="/common/products/filterbrand?brand=${brand}">${brand}</a></li>
												</c:forEach>
											</ul>
										</div>
									</div>


								</div>
							</div></li> --%>
						<li><a href="/user/products">product</a></li>
						<li><a href="/blog">blog</a></li>
						<li><a href="/vendor/home">Vendor Chanel</a></li>
						<li><a href="/user/delivery">Track Order</a></li>
					</ul>
					<ul class="wsus__menu_item wsus__menu_item_right">
						<li><a href="/contract">Contact</a></li>
						<li><a href="/user/profile">Profile</a></li>
						<c:choose>
							<c:when
								test="${not empty sessionScope.userRole && sessionScope.userRole != 'GUEST'}">
								<li><a href="/logout">Logout</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/login">Login</a></li>
							</c:otherwise>
						</c:choose>

					</ul>
				</div>
			</div>
		</div>
	</div>
</nav>
<!--============================
        MAIN MENU END
    ==============================-->


<!--============================
        MOBILE MENU START
    ==============================-->
<section id="wsus__mobile_menu">
	<span class="wsus__mobile_menu_close"><i class="fal fa-times"></i></span>
	<ul class="wsus__mobile_menu_header_icon d-inline-flex">

		<li><a href="wishlist.html"><i class="far fa-heart"></i> <span>2</span></a></li>

		<li><a href="compare.html"><i class="far fa-random"></i> </i><span>3</span></a></li>
	</ul>
	<form>
		<input type="text" placeholder="Search">
		<button type="submit">
			<i class="far fa-search"></i>
		</button>
	</form>

	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="pills-home-tab"
				data-bs-toggle="pill" data-bs-target="#pills-home" role="tab"
				aria-controls="pills-home" aria-selected="true">Categories</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
				data-bs-target="#pills-profile" role="tab"
				aria-controls="pills-profile" aria-selected="false">main
				menu</button>
		</li>
	</ul>
	
</section>
<!--============================
        MOBILE MENU END
    ==============================-->