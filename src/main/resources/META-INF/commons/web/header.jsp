<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<a class="wsus__header_logo" href="/"> <img
						src="/template/images/logo_2.png" alt="logo" class="img-fluid w-100">
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
							<p>Oneshop@gmail.com</p>
							<p>0942782355</p>
						</div>
					</div>
					<ul class="wsus__icon_area">
						<li><a href="compare.jsp"><i class="fal fa-random"></i></a></li>
						<li><a class="wsus__cart_icon" href="/user/cart"> <i
								class="fal fa-shopping-bag"></i> <span>0</span>
						</a></li>
					</ul>

					
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
					<a href="#"><img src="${URL}template/images/tab_2.jpg" alt="product"
						class="img-fluid w-100"></a> <a class="wsis__del_icon" href="#"><i
						class="fas fa-minus-circle"></i></a>
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
					<a href="#"><img src="${URL}template/images/pro4.jpg" alt="product"
						class="img-fluid w-100"></a> <a class="wsis__del_icon" href="#"><i
						class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">men's fashion casual watch</a>
					<p>$130</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/pro2.jpg" alt="product"
						class="img-fluid w-100"></a> <a class="wsis__del_icon" href="#"><i
						class="fas fa-minus-circle"></i></a>
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
					<a href="#"><img src="${URL}template/images/pro9.jpg" alt="product"
						class="img-fluid w-100"></a> <a class="wsis__del_icon" href="#"><i
						class="fas fa-minus-circle"></i></a>
				</div>
				<div class="wsus__cart_text">
					<a class="wsus__cart_title" href="#">men's fashion casual
						sholder bag</a>
					<p>$140</p>
				</div>
			</li>
			<li>
				<div class="wsus__cart_img">
					<a href="#"><img src="${URL}template/images/tab_2.jpg" alt="product"
						class="img-fluid w-100"></a> <a class="wsis__del_icon" href="#"><i
						class="fas fa-minus-circle"></i></a>
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
                            <li><a class="active" href="/">home</a></li>
                            <li><a href="/common/products">product</a></li>
                            <li><a href="/blog">blog</a></li>
                        </ul>
                        <ul class="wsus__menu_item wsus__menu_item_right">
                            <li><a href="/contract">contact</a></li>
                            <li><a href="/login">Login</a></li>
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
            <button type="submit"><i class="far fa-search"></i></button>
        </form>

        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home"
                    role="tab" aria-controls="pills-home" aria-selected="true">Categories</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile"
                    role="tab" aria-controls="pills-profile" aria-selected="false">main menu</button>
            </li>
        </ul>
        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <div class="wsus__mobile_menu_main_menu">
                    <div class="accordion accordion-flush" id="accordionFlushExample">
                        <ul class="wsus_mobile_menu_category">
                            <li><a href="#"><i class="fas fa-star"></i> hot promotions</a></li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThreew" aria-expanded="false"
                                    aria-controls="flush-collapseThreew"><i class="fal fa-tshirt"></i> fashion</a>
                                <div id="flush-collapseThreew" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">men's</a></li>
                                            <li><a href="#">wemen's</a></li>
                                            <li><a href="#">kid's</a></li>
                                            <li><a href="#">others</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThreer" aria-expanded="false"
                                    aria-controls="flush-collapseThreer"><i class="fas fa-tv"></i> electronics</a>
                                <div id="flush-collapseThreer" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">Consumer Electronic</a></li>
                                            <li><a href="#">Accessories & Parts</a></li>
                                            <li><a href="#">other brands</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThreerrp" aria-expanded="false"
                                    aria-controls="flush-collapseThreerrp"><i class="fas fa-chair-office"></i>
                                    furnicture</a>
                                <div id="flush-collapseThreerrp" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">home</a></li>
                                            <li><a href="#">office</a></li>
                                            <li><a href="#">restaurent</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThreerrw" aria-expanded="false"
                                    aria-controls="flush-collapseThreerrw"><i class="fal fa-mobile"></i> Smart
                                    Phones</a>
                                <div id="flush-collapseThreerrw" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">apple</a></li>
                                            <li><a href="#">xiaomi</a></li>
                                            <li><a href="#">oppo</a></li>
                                            <li><a href="#">samsung</a></li>
                                            <li><a href="#">vivo</a></li>
                                            <li><a href="#">others</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="#"><i class="fas fa-home-lg-alt"></i> Home & Garden</a></li>
                            <li><a href="#"><i class="far fa-camera"></i> Accessories</a></li>
                            <li><a href="#"><i class="fas fa-heartbeat"></i> healthy & Beauty</a></li>
                            <li><a href="#"><i class="fal fa-gift-card"></i> Gift Ideas</a></li>
                            <li><a href="#"><i class="fal fa-gamepad-alt"></i> Toy & Games</a></li>
                            <li><a href="#"><i class="fal fa-gem"></i> View All Categories</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                <div class="wsus__mobile_menu_main_menu">
                    <div class="accordion accordion-flush" id="accordionFlushExample2">
                        <ul>
                            <li><a href="home">home</a></li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThree" aria-expanded="false"
                                    aria-controls="flush-collapseThree">shop</a>
                                <div id="flush-collapseThree" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample2">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="#">men's</a></li>
                                            <li><a href="#">wemen's</a></li>
                                            <li><a href="#">kid's</a></li>
                                            <li><a href="#">others</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="vendor.html">vendor</a></li>
                            <li><a href="blog.html">blog</a></li>
                            <li><a href="daily_deals.html">campain</a></li>
                            <li><a href="#" class="accordion-button collapsed" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThree101" aria-expanded="false"
                                    aria-controls="flush-collapseThree101">pages</a>
                                <div id="flush-collapseThree101" class="accordion-collapse collapse"
                                    data-bs-parent="#accordionFlushExample2">
                                    <div class="accordion-body">
                                        <ul>
                                            <li><a href="404.html">404</a></li>
                                            <li><a href="faqs.html">faq</a></li>
                                            <li><a href="invoice.html">invoice</a></li>
                                            <li><a href="about_us.html">about</a></li>
                                            <li><a href="team.html">team</a></li>
                                            <li><a href="product_grid_view.html">product grid view</a></li>
                                            <li><a href="product_grid_view.html">product list view</a></li>
                                            <li><a href="team_details.html">team details</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="track_order.html">track order</a></li>
                            <li><a href="daily_deals.html">daily deals</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--============================
        MOBILE MENU END
    ==============================-->