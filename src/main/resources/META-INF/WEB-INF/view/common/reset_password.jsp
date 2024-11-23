<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Lại Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${URL}template/css/style.css">
</head>
<body>
<section id="reset_password">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="wsus__login_reg_area">
                    <ul class="nav nav-pills mb-3" id="pills-tab2" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active">Đặt Lại Mật Khẩu</button>
                        </li>
                    </ul>
                    <div class="wsus__login">
                        <form action="/reset_password" method="post">
                            <input type="hidden" name="token" value="${token}" />
                            <!-- Nhập mật khẩu mới -->
                            <div class="wsus__login_input">
                                <i class="fa fa-lock"></i>
                                <input type="password" name="password" id="password" placeholder="Nhập mật khẩu mới" required>
                            </div>
                            <!-- Xác nhận mật khẩu -->
                            <div class="wsus__login_input">
                                <i class="fa fa-lock"></i>
                                <input type="password" id="confirmPassword" placeholder="Xác nhận mật khẩu mới" required oninput="checkPasswordMatch(this);">
                            </div>
                            <!-- Nút đổi mật khẩu -->
                            <div class="text-center mt-3">
                                <button class="common_btn" type="submit">Đổi Mật Khẩu</button>
                            </div>
                        </form>
                        <!-- Link quay lại đăng nhập -->
                        <div class="text-center mt-3">
                            <a href="/login" class="text-decoration-none text-primary">Quay lại Đăng Nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="${URL}template/js/jquery-3.6.0.min.js"></script>
<script src="${URL}template/js/bootstrap.bundle.min.js"></script>
<script src="${URL}template/js/main.js"></script>
<script type="text/javascript">
    // Hàm kiểm tra khớp mật khẩu
    function checkPasswordMatch(fieldConfirmPassword) {
        const password = document.getElementById("password").value;
        if (fieldConfirmPassword.value !== password) {
            fieldConfirmPassword.setCustomValidity("Mật khẩu không khớp!");
        } else {
            fieldConfirmPassword.setCustomValidity("");
        }
    }
</script>
</body>
</html>
