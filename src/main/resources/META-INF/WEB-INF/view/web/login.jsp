<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--============================
         BREADCRUMB START
    ==============================-->
<section id="wsus__breadcrumb">
	<div class="wsus_breadcrumb_overlay">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h4>login / register</h4>
					<ul>
						<li><a href="#">home</a></li>
						<li><a href="#">login / register</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</section>
<!--============================
        BREADCRUMB END
    ==============================-->


<!--============================
       LOGIN/REGISTER PAGE START
    ==============================-->
<section id="wsus__login_register">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 m-auto">
				<div class="wsus__login_reg_area">
					<ul class="nav nav-pills mb-3" id="pills-tab2" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="pills-home-tab2"
								data-bs-toggle="pill" data-bs-target="#pills-homes"
								type="button" role="tab" aria-controls="pills-homes"
								aria-selected="true">login</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="pills-profile-tab2"
								data-bs-toggle="pill" data-bs-target="#pills-profiles"
								type="button" role="tab" aria-controls="pills-profiles"
								aria-selected="true">signup</button>
						</li>
					</ul>
					<div class="tab-content" id="pills-tabContent2">
						<div class="tab-pane fade show active" id="pills-homes"
							role="tabpanel" aria-labelledby="pills-home-tab2">
							<div class="wsus__login">
								<form>
									<div class="wsus__login_input">
										<i class="fas fa-user-tie"></i> <input type="text"
											placeholder="User Name">
									</div>
									<div class="wsus__login_input">
										<i class="fas fa-key"></i> <input type="password"
											placeholder="Password">
									</div>
									<div class="wsus__login_save">
										<div class="form-check form-switch">
											<input class="form-check-input" type="checkbox"
												id="flexSwitchCheckDefault"> <label
												class="form-check-label" for="flexSwitchCheckDefault">Remember
												me</label>
										</div>
										<a class="forget_p" href="forget_password.html">forget
											password ?</a>
									</div>
									<button class="common_btn" type="submit">login</button>
									<p class="social_text">Sign in with social account</p>
									<ul class="wsus__login_link">
										<li><a href="#"><i class="fab fa-google"></i></a></li>
										<li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
										<li><a href="#"><i class="fab fa-twitter"></i></a></li>
										<li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
									</ul>
								</form>
							</div>
						</div>
						<div class="tab-pane fade" id="pills-profiles" role="tabpanel"
							aria-labelledby="pills-profile-tab2">
							<div class="wsus__login">
								<form>
									<div class="wsus__login_input">
										<i class="fas fa-user-tie"></i> <input type="text"
											placeholder="Name">
									</div>
									<div class="wsus__login_input">
										<i class="far fa-envelope"></i> <input type="text"
											placeholder="Email">
									</div>
									<div class="wsus__login_input">
										<i class="fas fa-key"></i> <input type="text"
											placeholder="Password">
									</div>
									<div class="wsus__login_input">
										<i class="fas fa-key"></i> <input type="text"
											placeholder="Confirm Password">
									</div>
									<div class="wsus__login_save">
										<div class="form-check form-switch">
											<input class="form-check-input" type="checkbox"
												id="flexSwitchCheckDefault03"> <label
												class="form-check-label" for="flexSwitchCheckDefault03">I
												consent to the privacy policy</label>
										</div>
									</div>
									<button class="common_btn" type="submit">signup</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--============================
       LOGIN/REGISTER PAGE END
    ==============================-->
<!--============================
        SCROLL BUTTON START
    ==============================-->
<div class="wsus__scroll_btn">
	<i class="fas fa-chevron-up"></i>
</div>
<!--============================
        SCROLL BUTTON  END
    ==============================-->
    
   <!--jquery library js-->
<script src="${URL}template/js/jquery-3.6.0.min.js"></script>
<!--bootstrap js-->
<script src="${URL}template/js/bootstrap.bundle.min.js"></script>
<!--font-awesome js-->
<script src="${URL}template/js/Font-Awesome.js"></script>
<!--select2 js-->
<script src="${URL}template/js/select2.min.js"></script>
<!--slick slider js-->
<script src="${URL}template/js/slick.min.js"></script>
<!--simplyCountdown js-->
<script src="${URL}template/js/simplyCountdown.js"></script>
<!--product zoomer js-->
<script src="${URL}template/js/jquery.exzoom.js"></script>
<!--nice-number js-->
<script src="${URL}template/js/jquery.nice-number.min.js"></script>
<!--counter js-->
<script src="${URL}template/js/jquery.waypoints.min.js"></script>
<script src="${URL}template/js/jquery.countup.min.js"></script>
<!--add row js-->
<script src="${URL}template/js/add_row_custon.js"></script>
<!--multiple-image-video js-->
<script src="${URL}template/js/multiple-image-video.js"></script>
<!--sticky sidebar js-->
<script src="${URL}template/js/sticky_sidebar.js"></script>
<!--price ranger js-->
<script src="${URL}template/js/ranger_jquery-ui.min.js"></script>
<script src="${URL}template/js/ranger_slider.js"></script>
<!--isotope js-->
<script src="${URL}template/js/isotope.pkgd.min.js"></script>
<!--venobox js-->
<script src="${URL}template/js/venobox.min.js"></script>
<!--classycountdown js-->
<script src="${URL}template/js/jquery.classycountdown.js"></script>

<!--main/custom js-->
<script src="${URL}template/js/main.js"></script>
