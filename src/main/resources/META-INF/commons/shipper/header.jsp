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
					<form action="/common/products/search" method="get">
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
</header>
<!--============================
        MAIN MENU START
    ==============================-->
<nav class="wsus__main_menu d-none d-lg-block">
	<div class="container">
		<div class="row">
			<div class="col-xl-12">
				<div class="relative_contect d-flex">
					<div class="wsus_menu_category_bar">
						<i class="far fa-bars"></i>
					</div>
					<ul class="wsus__menu_item">
						<li><a class="active" href="/shipper/home">home</a></li>				
						<li><a href="/common/products">product</a></li>
						<li><a href="/blog">blog</a></li>
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
