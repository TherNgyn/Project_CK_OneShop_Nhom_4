<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt hàng</title>
<!-- Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Custom CSS -->
<style>
.breadcrumb-section {
	padding: 50px 0;
	background-size: cover;
	background-position: center;
	background-color: #f8f9fa;
}

.breadcrumb__text {
	color: #343a40;
}

.order-section {
	padding: 50px 0;
}

.order__table {
	margin-bottom: 30px;
}

.order__item img {
	width: 80px;
	height: 80px;
}

.primary-btn {
	background-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	text-transform: uppercase;
	transition: background-color 0.3s ease;
}

.primary-btn:hover {
	background-color: #0056b3;
}

.site-btn {
	background-color: #28a745;
	color: #fff;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	text-transform: uppercase;
	transition: background-color 0.3s ease;
}

.site-btn:hover {
	background-color: #218838;
}

.breadcrumb__option a {
	color: #007bff;
	text-decoration: none;
}

.breadcrumb__option a:hover {
	color: #0056b3;
}

.thead-blue {
	background-color: #007bff;
	color: white;
}
</style>
<script>
	function toggleNewAddress() {
		var existingAddressDiv = document.getElementById('existing-address');
		var newAddressDiv = document.getElementById('new-address');

		// Toggle visibility of existing address and new address forms
		if (document.getElementById('new-address-radio').checked) {
			existingAddressDiv.style.display = 'none';
			newAddressDiv.style.display = 'block';
		} else {
			existingAddressDiv.style.display = 'block';
			newAddressDiv.style.display = 'none';
		}
	}
</script>
</head>
<body>
	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<div class="breadcrumb__option">
							<a href="<c:url value='/user/home'/>">Trang chủ</a> <span>Đặt
								hàng</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Order Section Begin -->
	<section class="order-section spad">
		<div class="container">
			<div class="row mb-4">
				<div class="col-lg-12">
					<form action="<c:url value='/user/order/checkout'/>" method="POST">
						<h4>Đơn hàng của bạn</h4>
						<div class="order__table">
							<table class="table table-hover">
								<thead class="thead-blue">
									<tr>
										<th class="order__product">Sản phẩm</th>
										<th>Giá</th>
										<th>Số lượng</th>
										<th>Tổng</th>
										<th>Thời gian</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${listcart}">
										<tr>
											<td class="order__item"><img
												src="${item.product.imageUrls[0]}"
												alt="${item.product.name}">
												<h5>${item.product.name}</h5></td>
											<td class="order__price"><fmt:formatNumber
													value="${item.product.price}" type="currency"
													currencySymbol="₫" /></td>
											<td class="order__quantity">${item.count}</td>
											<td class="order__total"><fmt:formatNumber
													value="${item.count * item.product.price}" type="currency"
													currencySymbol="₫" /></td>
											<td class="order__time">${item.order.formattedCreateAt}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- Chọn địa chỉ giao hàng -->
						<h4>Chọn địa chỉ giao hàng</h4>
						<div class="form-group">
							<input type="radio" name="addressType"
								id="existing-address-radio" checked onclick="toggleNewAddress()">
							Chọn địa chỉ có sẵn <input type="radio" name="addressType"
								id="new-address-radio" onclick="toggleNewAddress()">
							Nhập địa chỉ mới

							<!-- Chọn địa chỉ có sẵn -->
							<div id="existing-address" class="mt-3">
								<select name="addressId" class="form-control" required>
									<c:forEach var="address" items="${addresses}">
										<option value="${address.id}">${address.addressLine1},
											${address.addressLine2}, ${address.city}</option>
									</c:forEach>
								</select>

								<c:if test="${empty addresses}">
									<div class="alert alert-danger">Bạn chưa có địa chỉ giao
										hàng. Vui lòng thêm địa chỉ.</div>
								</c:if>
							</div>

							<!-- Nhập địa chỉ mới -->
							<h4>Chọn địa chỉ mới</h4>
							<div id="new-address" class="mt-3" style="display: none;">
								<div class="form-group">
									<label for="newAddressLine1">Địa chỉ (Số nhà, tên
										đường):</label> <input type="text" name="newAddressLine1"
										id="newAddressLine1" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="newAddressLine2">Địa chỉ (Phường, Quận):</label> <input
										type="text" name="newAddressLine2" id="newAddressLine2"
										class="form-control">
								</div>
								<div class="form-group">
									<label for="newCity">Thành phố:</label> <input type="text"
										name="newCity" id="newCity" class="form-control" required>
								</div>
								<div class="form-group">
									<input type="checkbox" name="isPrimary" id="isPrimary"
										class="form-check-input"> <label for="isPrimary">Đánh
										dấu là địa chỉ chính</label>
								</div>
							</div>
						</div>

						<!-- Chọn đơn vị giao hàng -->
						<h4>Chọn đơn vị giao hàng</h4>
						<div class="form-group">
							<select name="deliveryId" class="form-control"
								id="deliverySelect" onchange="updateTotalPrice()">
								<c:forEach var="delivery" items="${deliveries}">
									<option value="${delivery.id}" data-price="${delivery.price}">
										${delivery.name} - ${delivery.description}
										(${delivery.price}₫)</option>
								</c:forEach>
							</select>
							<c:if test="${empty deliveries}">
								<div class="alert alert-danger">Không có đơn vị giao hàng
									nào. Vui lòng liên hệ quản trị.</div>
							</c:if>
						</div>

						<!-- Hiển thị tổng tiền -->
						<div class="text-right">
							<h5>
								Tổng tiền: <span id="total-price">${price}₫</span>
							</h5>
						</div>

						<script>
function updateTotalPrice() {
    let basePrice = parseFloat(${price});
    const deliverySelect = document.getElementById("deliverySelect");
    const selectedOption = deliverySelect.options[deliverySelect.selectedIndex];
    const deliveryPrice = parseFloat(selectedOption.getAttribute("data-price")) || 0;
    const totalPrice = basePrice + deliveryPrice;
    document.getElementById("total-price").innerText = totalPrice.toLocaleString('vi-VN') + "₫";
}
</script>


						<!-- Gửi form -->
						<div class="order__btns">
							<button type="submit" class="primary-btn">ĐẶT HÀNG</button>
							<a href="<c:url value='/user/products'/>" class="primary-btn">TIẾP
								TỤC MUA SẮM</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Order Section End -->
	<script>
	function toggleNewAddress() {
	    const existingAddressDiv = document.getElementById('existing-address');
	    const newAddressDiv = document.getElementById('new-address');
	    const isNewAddress = document.getElementById('new-address-radio').checked;

	    existingAddressDiv.style.display = isNewAddress ? 'none' : 'block';
	    newAddressDiv.style.display = isNewAddress ? 'block' : 'none';
	}

	</script>
	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
