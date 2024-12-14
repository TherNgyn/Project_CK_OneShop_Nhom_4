<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Xác nhận Đặt hàng</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    .breadcrumb-section { padding: 50px 0; background-size: cover; background-position: center; background-color: #f8f9fa; }
    .breadcrumb__text { color: #343a40; }
    .confirmation-section { padding: 50px 0; }
    .confirmation__table { margin-bottom: 30px; }
    .primary-btn { background-color: #007bff; color: #fff; padding: 10px 20px; border: none; border-radius: 5px; text-transform: uppercase; transition: background-color 0.3s ease; }
    .primary-btn:hover { background-color: #0056b3; }
    .thead-blue { background-color: #007bff; color: white; }
</style>
</head>
<body>

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="img/breadcrumb.jpg">
    <section id="wsus__breadcrumb">
		<div class="wsus_breadcrumb_overlay">
			<div class="container">
				<div class="row">
					<div class="col-12">
					<h4>Your order</h4>
						<ul>
							<li><a href="#">Home</a></li>
							<li><a href="#">Cart</a></li>
							<li><a href="#">Order</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>
<!-- Breadcrumb Section End -->

<!-- Confirmation Section Begin -->
<section class="confirmation-section spad">
    <div class="container">
        <div class="row mb-4">
            <div class="col-lg-12">
                <p class="alert alert-success">Đơn hàng của bạn đã được xác nhận thành công. Chúng tôi sẽ gửi thông tin giao hàng sớm nhất.</p>
                <a href="<c:url value='/user/home'/>" class="primary-btn">Quay lại Trang Chủ</a>
            </div>
        </div>
    </div>
</section>
<!-- Confirmation Section End -->

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
