<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Đăng Nhập</title>
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
						<h4>Đăng Nhập</h4>
						<ul>
							<li><a href="/">Trang Chủ</a></li>
							<li><a href="#">Đăng Nhập</a></li>
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
						<div class="wsus__login">
							<form action="login" method="post">
								<c:if test="${param.error != null}">
		    						<div class="alert alert-danger">Tên đăng nhập hoặc mật khẩu không đúng!</div>
								</c:if>
								<div class="wsus__login_input">
									<i class="fa fa-user"></i> <input type="text" name="username"
										placeholder="Tên đăng nhập" required>
								</div>
								<div class="wsus__login_input">
									<i class="fa fa-lock"></i> <input type="password"
										name="password" placeholder="Mật khẩu"
										autocomplete="current-password" required>
								</div>

								<div class="wsus__login_save">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="rememberMe"> <label class="form-check-label"
											for="rememberMe">Nhớ tài khoản</label>
									</div>
									<a class="forget_p" href="/forgot_password">Quên mật khẩu?</a>
								</div>
								<button class="common_btn" type="submit">Đăng Nhập</button>
							</form>

							<!-- Đường dẫn đến trang Đăng Ký -->
							<p class="text-center mt-3">
								Chưa có tài khoản? <a href="/otp_register" class="register-link">Đăng Ký ngay</a>
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
