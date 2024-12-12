<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng Ký</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${URL}template/css/style.css">
</head>
<body>
	<section id="wsus__breadcrumb">
		<div class="wsus_breadcrumb_overlay">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h4>Đăng Ký</h4>
						<ul>
							<li><a href="/">Trang Chủ</a></li>
							<li><a href="#">Đăng Ký</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="wsus__login_register">
		<div class="container">
			<div class="row">
				<div class="col-xl-5 m-auto">
					<div class="wsus__login_reg_area">
						<div class="alert alert-warning" role="alert" style="${message != null && message.trim().length() > 0 ? '' : 'display: none;'}">
			                        ${message}
			             </div>
						<div class="wsus__login">							
							<form action="/register" method="post">
								<input type="hidden" name="email" value="${sessionScope.email}">
								<div class="wsus__login_input">
									<i class="fa fa-user"></i> <input type="text" name="username"
										placeholder="Tên đăng nhập" required autocomplete="username">
								</div>
								<div class="wsus__login_input">
									<i class="fa fa-phone"></i> <input type="text" name="phone"
										placeholder="Số điện thoại (10 chữ số)" required
										autocomplete="tel">
								</div>
								<div class="wsus__login_input">
									<i class="fa fa-lock"></i> <input type="password"
										name="password" placeholder="Mật khẩu" required
										autocomplete="new-password">
								</div>
								<div class="wsus__login_input">
									<i class="fa fa-lock"></i> <input type="password"
										name="confirmPassword" placeholder="Nhập lại mật khẩu"
										required autocomplete="new-password">
								</div>


								<div class="wsus__login_save">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="agreePolicy" name="agreePolicy" required> <label
											class="form-check-label" for="agreePolicy">Tôi đồng ý
											với chính sách bảo mật</label>
									</div>
								</div>
								<button class="common_btn" type="submit">Đăng Ký</button>
							</form>

							<!-- Thêm liên kết quay lại login -->
							<p class="text-center mt-3">
								Đã có tài khoản? <a href="/login" class="login-link">Đăng
									Nhập ngay</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<script src="${URL}template/js/jquery-3.6.0.min.js"></script>
	<script src="${URL}template/js/bootstrap.bundle.min.js"></script>
	<script src="${URL}template/js/main.js"></script>
</body>
</html>
