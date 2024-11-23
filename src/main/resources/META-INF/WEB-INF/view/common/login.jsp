<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập / Đăng Ký</title>
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
                    <h4>Đăng Nhập / Đăng Ký</h4>
                    <ul>
                        <li><a href="/">Trang Chủ</a></li>
                        <li><a href="#">Đăng Nhập / Đăng Ký</a></li>
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
                            <button class="nav-link active" id="login-tab" data-bs-toggle="pill" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="true">Đăng Nhập</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="register-tab" data-bs-toggle="pill" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="false">Đăng Ký</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent2">
                        <!-- Login Form -->
                        <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                            <div class="wsus__login">
                                <form action="/login" method="post">
                                    <div class="wsus__login_input">
                                        <i class="fa fa-user"></i>
                                        <input type="text" name="username" placeholder="Tên đăng nhập" required>
                                    </div>
                                    <div class="wsus__login_input">
                                        <i class="fa fa-lock"></i>
                                        <input type="password" name="password" placeholder="Mật khẩu" required>
                                    </div>
                                    <div class="wsus__login_save">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="rememberMe">
                                            <label class="form-check-label" for="rememberMe">Nhớ tài khoản</label>
                                        </div>
                                        <a class="forget_p" href="/forgot_password">Quên mật khẩu?</a>
                                    </div>
                                    <button class="common_btn" type="submit">Đăng Nhập</button>
                                </form>
                            </div>
                        </div>

                        <!-- Register Form -->
                        <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                            <div class="wsus__login">
                                <form action="/register" method="post">
                                    <div class="wsus__login_input">
                                        <i class="fa fa-user"></i>
                                        <input type="text" name="username" placeholder="Tên đăng nhập" required>
                                    </div>
                                    <div class="wsus__login_input">
                                        <i class="fa fa-envelope"></i>
                                        <input type="email" name="email" placeholder="Email" required>
                                    </div>
                                    <div class="wsus__login_input">
                                        <i class="fa fa-lock"></i>
                                        <input type="password" name="password" placeholder="Mật khẩu" required>
                                    </div>
                                    <div class="wsus__login_input">
                                        <i class="fa fa-lock"></i>
                                        <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                                    </div>
                                    <div class="wsus__login_save">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="agreePolicy" required>
                                            <label class="form-check-label" for="agreePolicy">Tôi đồng ý với chính sách bảo mật</label>
                                        </div>
                                    </div>
                                    <button class="common_btn" type="submit">Đăng Ký</button>
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
       SCROLL BUTTON START
==============================-->
<div class="wsus__scroll_btn">
    <i class="fa fa-chevron-up"></i>
</div>

<!--============================
       SCRIPT START
==============================-->
<script src="${URL}template/js/jquery-3.6.0.min.js"></script>
<script src="${URL}template/js/bootstrap.bundle.min.js"></script>
<script src="${URL}template/js/main.js"></script>
</body>
</html>
