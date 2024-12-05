<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giỏ Hàng</title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
/* ... existing styles ... */

/* Thêm styles mới */
.cart-item-image {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 8px;
}

.quantity-input {
	width: 80px;
	text-align: center;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 5px;
}

.remove-item-btn {
	color: #dc3545;
	border: 1px solid #dc3545;
	padding: 5px 15px;
	border-radius: 4px;
	transition: all 0.3s;
}

.remove-item-btn:hover {
	background-color: #dc3545;
	color: white;
	text-decoration: none;
}

.checkout-section {
	background-color: #f8f9fa;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(95, 93, 93, 0.1);
}

.discount-section {
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section py-4">
		<div class="container">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb mb-0">
					<li class="breadcrumb-item"><a
						href="<c:url value='/user/home'/>">Trang chủ</a></li>
					<li class="breadcrumb-item active" aria-current="page">Giỏ
						hàng</li>
				</ol>
			</nav>
		</div>
	</section>

	<!-- Shopping Cart Section -->
	<section class="shoping-cart py-5">
		<div class="container">
			<!-- Bảng giỏ hàng -->
			<div class="table-responsive mb-4">
				<table class="table align-middle">
					<thead class="table-dark">
						<tr>
							<!-- Cột chọn tất cả -->
							<th scope="col"><input type="checkbox" id="selectAll"
								onclick="toggleAll(this)"></th>
							<th scope="col">Sản phẩm</th>
							<th scope="col">Giá</th>
							<th scope="col">Số lượng</th>
							<th scope="col">Tổng</th>
							<th scope="col"></th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="list" items="${listcart}" varStatus="status">
							<tr>
								<!-- Cột checkbox cho từng sản phẩm -->
								<td><input type="checkbox" class="select-item"
									name="selectedItems" value="${list.id}"></td>
								<!-- Cột sản phẩm -->
								<td class="shoping__cart__item">
									<div class="d-flex align-items-center">
										<!-- Hình ảnh sản phẩm -->
										<img
											src="${not empty product.imageUrls[0] ? product.imageUrls[0] : '/default-image.jpg'}"
											width="100" height="100" alt="${list.product.name}"
											class="rounded me-3" style="object-fit: cover;">
										<!-- Tên sản phẩm -->
										<h5 class="mb-0">${list.product.name}</h5>
									</div>
								</td>
								<!-- Cột giá -->
								<td class="shoping__cart__price"><fmt:formatNumber
										value="${list.product.price}" type="currency"
										currencySymbol="₫" /></td>
								<!-- Cột số lượng -->
								<td class="shoping__cart__quantity">
									<div class="quantity">
										<div class="pro-qty">
											<input id="${status.index}" type="number"
												class="quantity-input" value="${list.count}" min="1"
												onchange="submitForm(${list.id}, ${status.index})">
										</div>
									</div>
								</td>
								<!-- Cột tổng -->
								<td class="shoping__cart__total"><fmt:formatNumber
										value="${list.count * list.product.price}" type="currency"
										currencySymbol="₫" /></td>
								<!-- Cột xóa sản phẩm -->
								<td class="shoping__cart__item__close"><a
									href="<c:url value='/user/cart/item/delete/${list.id}'/>">Bỏ</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


			</div>

			<!-- Phần thanh toán và mã giảm giá -->
			<div class="row g-4">
				<div class="col-md-6">
					<div class="discount-section">
						<h5 class="mb-3">Mã giảm giá</h5>
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Nhập mã giảm giá">
							<button class="btn btn-success" type="button">Áp dụng</button>
						</div>
					</div>
				</div>

				<div class="col-md-6">
					<div class="checkout-section">
						<h5 class="mb-3">Tổng thanh toán</h5>
						<div class="d-flex justify-content-between mb-2">
							<span>Tổng tiền hàng:</span> <strong><fmt:formatNumber
									value="${price}" type="currency" currencySymbol="₫" /></strong>
						</div>
						<div class="d-flex justify-content-between mb-3">
							<span>Tổng thanh toán:</span> <strong class="text-danger">
								<fmt:formatNumber value="${price}" type="currency"
									currencySymbol="₫" />
							</strong>
						</div>
						<div class="d-grid gap-2">
							<a href="<c:url value='/user/order'/>" class="btn btn-primary">
								Thanh toán ngay </a> <a href="<c:url value='/user/products'/>"
								class="btn btn-outline-primary"> Tiếp tục mua sắm </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    function submitForm(id, index) {
        const quantity = document.getElementById(index).value;
        if (quantity < 1) {
            alert('Số lượng phải lớn hơn 0');
            return;
        }

        fetch(`user/cart/item/update/${id}/${quantity}`)
            .then(response => response.json())
            .then(data => {
                console.log(data);
                location.reload();
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi cập nhật số lượng');
            });
    }
    function toggleAll(selectAllCheckbox) {
        const checkboxes = document.querySelectorAll('.select-item');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }

    function getSelectedItems() {
        const selectedItems = [];
        const checkboxes = document.querySelectorAll('.select-item:checked');
        checkboxes.forEach(checkbox => {
            selectedItems.push(checkbox.value);
        });
        console.log('Selected Items:', selectedItems);
        return selectedItems;
    }

    // Gọi hàm này khi nhấn nút "Thanh toán ngay"
    function checkoutSelectedItems() {
        const selectedItems = getSelectedItems();
        if (selectedItems.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.');
            return;
        }

        alert('Đang xử lý thanh toán cho các sản phẩm: ' + selectedItems.join(', '));
    }

</script>
</body>
</html>