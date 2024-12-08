<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ hàng</title>
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

.shoping-cart {
	padding: 50px 0;
}

.shoping__cart__table {
	margin-bottom: 30px;
}

.shoping__cart__item img {
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
							<a href="<c:url value='/user/home'/>">Trang chủ</a> <span>Giỏ
								hàng</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shopping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<c:forEach var="entry" items="${storeGroupedCartItems}">
				<div class="row mb-4">
					<div class="col-lg-12">
						<h4 class="mb-3">${entry.key.name}</h4>
						<div class="shoping__cart__table">
							<table class="table table-hover">
								<thead class="thead-blue">
									<tr>
										<th><input type="checkbox"
											onclick="toggleStore(this, '${entry.key.id}')"></th>
										<th class="shoping__product">Sản phẩm</th>
										<th>Price</th>
										<th>Quantity</th>
										<th>Total</th>
										<th></th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="item" items="${entry.value}">
										<tr id="row-${item.id}">
											<td><input type="checkbox" class="store-${entry.key.id}"
												onclick="updateTotal()"></td>
											<td class="shoping__cart__item"><img
												src="${item.product.imageUrls[0]}"
												alt="${item.product.name}">
												<h5>${item.product.name}</h5></td>
											<td class="shoping__cart__price"><fmt:formatNumber
													value="${item.product.price}" type="currency"
													currencySymbol="₫" /></td>
											<td class="shoping__cart__quantity">
												<div class="quantity">
													<input type="number" min="1" value="${item.count}"
														onchange="updateQuantityWithPost(${item.id}, this.value)">
												</div>
											</td>
											<script>
											function updateQuantityWithPost(itemId, quantity) {
											    if (!itemId) {
											        console.error("itemId không tồn tại!");
											        return;
											    }
											    if (quantity < 1) {
											        alert("Số lượng phải lớn hơn hoặc bằng 1.");
											        return;
											    }

											    const baseUrl = window.location.origin;
											    const url = `${baseUrl}/user/cart/update`;

											    const payload = {
											        itemId: itemId,
											        count: parseInt(quantity),
											    };

											    console.log("Payload gửi đi:", payload);

											    fetch(url, {
											        method: 'POST',
											        headers: {
											            'Content-Type': 'application/json',
											        },
											        body: JSON.stringify(payload),
											    })
											        .then(response => {
											            if (!response.ok) {
											                throw new Error(`HTTP error! status: ${response.status}`);
											            }
											            return response.json();
											        })
											        .then(data => {
											            if (data.error) {
											                alert(data.error);
											            } else {
											                alert(data.message || "Cập nhật thành công!");
											                location.reload(); 
											            }
											        })
											        .catch(error => {
											            console.error("Lỗi khi cập nhật:", error);
											        });
											}
											</script>
											<td class="shoping__cart__item__close"><a
												href="<c:url value='/user/cart/delete/${item.id}'/>"><i
													class="fas fa-trash-alt"></i> Bỏ</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</c:forEach>
			<script>
			function toggleStore(checkbox, storeId) {
			    var checkboxes = document.querySelectorAll('.store-' + storeId);
			    checkboxes.forEach(function(cb) {
			        cb.checked = checkbox.checked;
			    });
			    updateTotal();
			}

			function updateTotal() {
			    let total = 0;

			    // Lấy tất cả các checkbox đã tick
			    const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');

			    checkboxes.forEach(cb => {
			        const row = cb.closest('tr'); // Lấy hàng chứa checkbox
			        if (row) {
			            const priceCell = row.querySelector('.shoping__cart__price');
			            const quantityInput = row.querySelector('.shoping__cart__quantity input');

			            if (priceCell && quantityInput) {
			                const price = parseFloat(priceCell.textContent.replace(/[^0-9.-]+/g, ""));
			                const quantity = parseInt(quantityInput.value, 10);
			                total += price * quantity; // Tính tổng tiền
			            }
			        }
			    });

			    // Cập nhật tổng tiền trên giao diện
			    const totalPriceElement = document.getElementById('totalPrice');
			    if (totalPriceElement) {
			        totalPriceElement.textContent = total.toLocaleString('vi-VN', {
			            style: 'currency',
			            currency: 'VND'
			        });
			    }

			    console.log("Tổng tiền:", total); // Log để kiểm tra
			}


			function fetchCartTotal() {
			    const baseUrl = window.location.origin;
			    fetch(`${baseUrl}/user/cart/total`, {
			        method: 'GET',
			        headers: {
			            'Content-Type': 'application/json'
			        }
			    })
			    .then(response => response.json())
			    .then(data => {
			        if (data.error) {
			            console.error("Lỗi:", data.error);
			        } else {
			            const total = data.total;
			            if (total === 0) {
			                alert("Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
			            } else {
			                const totalPriceElement = document.getElementById('totalPrice');
			                if (totalPriceElement) {
			                    totalPriceElement.textContent = total.toLocaleString('vi-VN', {
			                        style: 'currency',
			                        currency: 'VND'
			                    });
			                }

			                // Hiển thị thông báo xác nhận
			                const confirmed = confirm(`Tổng tiền của bạn là: ${total.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'})}. Bạn có muốn thanh toán không?`);
			                if (confirmed) {
			                    // Chuyển hướng đến trang thanh toán
			                    window.location.href = '/user/order';
			                }
			            }
			        }
			    })
			    .catch(error => {
			        console.error("Lỗi khi gọi API:", error);
			    });
			}

			function saveCartTotal() {
			    const baseUrl = window.location.origin;
			    const totalPriceElement = document.getElementById('totalPrice');

			    if (!totalPriceElement) {
			        console.error("Không tìm thấy phần tử #totalPrice.");
			        alert("Không tìm thấy tổng tiền. Vui lòng kiểm tra lại.");
			        return;
			    }

			    const totalPrice = parseFloat(totalPriceElement.textContent.replace(/[^0-9.-]+/g, ""));
			    if (isNaN(totalPrice) || totalPrice <= 0) {
			        alert("Tổng tiền không hợp lệ hoặc bằng 0. Vui lòng kiểm tra lại.");
			        return;
			    }

			    const payload = { total: totalPrice };

			    fetch(`${baseUrl}/user/cart/saveTotal`, {
			        method: 'POST',
			        headers: { 'Content-Type': 'application/json' },
			        body: JSON.stringify(payload)
			    })
			        .then(async (response) => {
			            const contentType = response.headers.get("content-type");
			            if (!response.ok) {
			                if (contentType && contentType.indexOf("application/json") !== -1) {
			                    const errorJson = await response.json();
			                    throw new Error(errorJson.error || "Lỗi không xác định từ server.");
			                } else {
			                    const errorText = await response.text();
			                    console.error("Server trả về lỗi dạng HTML/Text:", errorText);
			                    throw new Error("Lỗi HTTP: " + response.status);
			                }
			            }
			            return response.json();
			        })
			        .then(data => {
			            if (data.success) {
			                alert(data.success);
			                window.location.href = '${baseUrl}/user/order'; 
			            } else {
			                alert("Lỗi: " + (data.error || "Không xác định"));
			            }
			        })
			        .catch(error => {
			            console.error("Lỗi khi gọi API:", error.message);
			            alert("Đã xảy ra lỗi khi lưu tổng tiền. Chi tiết: " + error.message);
			        });
			}


			</script>
			<div class="row">
				<div class="col-lg-6">
					<div class="shoping__continue"></div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__checkout">
						<div>
							<h4>
								Tổng tiền: <span id="totalPrice">0 ₫</span>
							</h4>
						</div>
						<h5>THANH TOÁN</h5>
						<ul>
						</ul>
						<a href="javascript:void(0);" class="primary-btn" onclick="saveCartTotal()">THANH TOÁN</a>

					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
