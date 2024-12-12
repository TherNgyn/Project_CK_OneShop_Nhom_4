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
                    <h4>Quên Mật Khẩu</h4>
                    <ul>
                        <li><a href="/">Trang Chủ</a></li>
                        <li><a href="#">Quên Mật Khẩu</a></li>
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
       FORGOT PASSWORD FORM 
==============================-->
<section id="forgot_password">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="wsus__login_reg_area">
                    <ul class="nav nav-pills mb-3" id="pills-tab2" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active">Quên Mật Khẩu</button>
                        </li>
                    </ul>

                    <div class="alert alert-warning" role="alert" style="${infor != null && infor.trim().length() > 0 ? '' : 'display: none;'}">
                        ${infor}
                    </div>
                    
                    <!-- Countdown Timer -->
                    <div id="countdown" style="text-align: center; font-size: 20px; margin-top: 20px;">
                        Mã OTP hết hạn sau <span id="timer">40</span> giây. 
                    </div>

                    <div class="wsus__login">
                        <form action="/otp_password" method="post" onsubmit="return validateForm()">
						    <input type="hidden" name="email" value="${sessionScope.email}">
						    <input type="hidden" name="code" value="${sessionScope.code}">
						    <div class="wsus__login_input">
						        <i class="fa fa-key"></i>
						        <input type="text" name="otp" id="otp" placeholder="Nhập mã OTP" required>
						    </div>
						    <div class="wsus__login_input">
						        <i class="fa fa-lock"></i>
						        <input type="password" name="newPassword" id="newPassword" placeholder="Nhập mật khẩu mới" required>
						    </div>
						    <div class="wsus__login_input">
						        <i class="fa fa-lock"></i>
						        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
						    </div>
						    <div class="text-center mt-3">
						        <button class="common_btn" type="submit">Đặt lại mật khẩu</button>
						    </div>
						</form>
						
						<script>
						// Hàm kiểm tra các điều kiện khi gửi form
						function validateForm() {
						    var otp = document.getElementById('otp').value;
						    var newPassword = document.getElementById('newPassword').value;
						    var confirmPassword = document.getElementById('confirmPassword').value;
						    var code = '${sessionScope.code}'; // Mã OTP từ server
						
						    // Kiểm tra OTP có đúng không
						    if (otp !== code) {
						        alert("Mã OTP không chính xác.");
						        return false; // Ngừng gửi form nếu OTP không chính xác
						    }
						
						    // Kiểm tra mật khẩu mới và mật khẩu xác nhận có khớp không
						    if (newPassword !== confirmPassword) {
						        alert("Mật khẩu xác nhận không khớp.");
						        return false; // Ngừng gửi form nếu mật khẩu không khớp
						    }
						
						    // Kiểm tra mật khẩu mới không được để trống
						    if (newPassword.trim() === "") {
						        alert("Mật khẩu mới không được để trống.");
						        return false; // Ngừng gửi form nếu mật khẩu mới trống
						    }
						
						    // Kiểm tra mật khẩu xác nhận không được để trống
						    if (confirmPassword.trim() === "") {
						        alert("Mật khẩu xác nhận không được để trống.");
						        return false; // Ngừng gửi form nếu mật khẩu xác nhận trống
						    }
						
						    // Nếu tất cả các điều kiện thỏa mãn, form sẽ được gửi
						    return true;
						}
						</script>

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

<script>
    // Kiểm tra giá trị countdownTime trong sessionStorage khi trang được load
    var countdownTime = 40;
    
    // Nếu countdownTime không có hoặc giá trị đã hết (<= 0), reset lại thành 40 giây
    if (isNaN(countdownTime) || countdownTime <= 0) {
        countdownTime = 40;
    } else {
        countdownTime = parseInt(countdownTime);  // Nếu có, lấy giá trị từ sessionStorage
    }

    var countdownElement = document.getElementById("timer");

    // Hàm đếm ngược
    var countdownInterval = setInterval(function() {
        countdownTime--;
        countdownElement.innerText = countdownTime;

        // Lưu giá trị thời gian còn lại vào sessionStorage
        sessionStorage.setItem('countdownTime', countdownTime);

        // Nếu countdownTime <= 0, dừng đếm ngược và gửi POST request
        if (countdownTime <= 0) {
            clearInterval(countdownInterval); // Dừng đếm ngược

            // Gửi POST request đến /forgot_password
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/forgot_password", true); // POST request
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); // Đặt header Content-Type cho POST
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    // Xử lý phản hồi từ server nếu cần
                    console.log("POST request đã được gửi thành công.");
                    window.location.href = "/forgot_password"; // Làm mới trang hoặc điều hướng lại trang /forgot_password
                }
            };
            xhr.send("timeout=true"); // Bạn có thể gửi thêm dữ liệu nếu cần
        }
    }, 1000);
    
    // Đánh dấu trạng thái người dùng đang ở trên trang
    sessionStorage.setItem('isUserOnPage', 'true');

    // Khi người dùng thoát trang, xóa countdownTime
    window.onbeforeunload = function () {
        var isUserNavigatingAway = sessionStorage.getItem('isUserOnPage') === 'false';

        // Nếu người dùng thực sự thoát, reset countdown
        if (isUserNavigatingAway) {
            sessionStorage.removeItem('countdownTime');
        }
    };

    // Sự kiện visibilitychange để kiểm tra người dùng có đang rời khỏi tab
    document.addEventListener("visibilitychange", function () {
        if (document.visibilityState === 'hidden') {
            sessionStorage.setItem('isUserOnPage', 'false'); // Người dùng rời khỏi trang
        } else {
            sessionStorage.setItem('isUserOnPage', 'true'); // Người dùng quay lại
        }
    });

    // Đảm bảo countdownTime là 40 khi gửi form
    document.querySelector('form').onsubmit = function() {
        // Reset countdownTime về 40 khi form được submit
        sessionStorage.setItem('countdownTime', 40);
    };

    // Lắng nghe sự kiện popstate để reset countdownTime khi người dùng nhấn nút quay lại trình duyệt
    window.addEventListener('popstate', function() {
        sessionStorage.setItem('countdownTime', 40);  // Reset countdownTime về 40 khi người dùng quay lại trang
    });
</script>




</body>
</html>
