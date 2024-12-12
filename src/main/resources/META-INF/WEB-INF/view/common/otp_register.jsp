<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${URL}template/css/style.css">
</head>
<body>
<!--============================
         BREADCRUMB START
==============================-->
<section id="wsus__breadcrumb">
    <div class="wsus_breadcrumb_overlay">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h4>Đăng ký</h4>
                    <ul>
                        <li><a href="/">Trang Chủ</a></li>
                        <li><a href="#">Đăng ký</a></li>
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
        FORM ĐĂNG KÝ
==============================-->
<section id="forgot_password">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="wsus__login_reg_area">
                    <ul class="nav nav-pills mb-3" id="pills-tab2" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active">Đăng ký</button>
                        </li>
                    </ul>
					<div class="alert alert-warning" role="alert" style="${infor != null && infor.trim().length() > 0 ? '' : 'display: none;'}">
					    ${infor}
					</div>
                    <div class="wsus__login">
                        <form action="/otp_register" method="post">
                        		<div class="wsus__login_input">
									<i class="fa fa-envelope"></i> <input type="email" name="email"
										placeholder="Email (ví dụ: abc@gmail.com)" required
										autocomplete="email">
								</div>
                            <div class="text-center mt-3">
                                <button class="common_btn" type="submit">Gửi Yêu Cầu</button>
                            </div>
                        </form>
                        <div class="text-center mt-3">
                            <a href="/login" class="text-decoration-none text-primary">Quay lại Đăng Nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<style>
    #forgot_password .container {
        margin-top: 40px; 
    }
</style>

<script src="${URL}template/js/jquery-3.6.0.min.js"></script>
<script src="${URL}template/js/bootstrap.bundle.min.js"></script>
<script src="${URL}template/js/main.js"></script>
</body>
</html>
