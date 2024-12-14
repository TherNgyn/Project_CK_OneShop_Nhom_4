<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Đơn Hàng</title>
<link rel="stylesheet" href="<c:url value='/css/styles.css' />">
</head>
<body>
	<div class="container">

		<!-- Search bar -->
		<div class="search-bar">
			<form
				action="${pageContext.request.contextPath}/user/delivery/search"
				method="get">
				<input type="text" name="search"
					placeholder="Nhập từ khóa tìm kiếm..." value="${param.search}"
					class="search-input" />
				<button type="submit" class="search-button">Tìm kiếm</button>
			</form>
		</div>


		<!-- Tabs for different order statuses -->
		<div class="tabs">
			<a href="${pageContext.request.contextPath}/user/delivery?status=all"
				class="<c:choose><c:when test='${empty param.status or param.status == "all"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Tất
				cả</a> <a
				href="${pageContext.request.contextPath}/user/delivery?status=Processing"
				class="<c:choose><c:when test='${param.status == "Processing_1" || param.status == "Processing_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đang
				xử lý</a> <a
				href="${pageContext.request.contextPath}/user/delivery?status=Preparing"
				class="<c:choose><c:when test='${param.status == "Preparing_1" || param.status == "Preparing_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đang
				chuẩn bị hàng</a> <a
				href="${pageContext.request.contextPath}/user/delivery?status=In Transit"
				class="<c:choose><c:when test='${param.status == "In Transit_1" || param.status == "In Transit_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đang
				vận chuyển</a> <a
				href="${pageContext.request.contextPath}/user/delivery?status=Completed"
				class="<c:choose><c:when test='${param.status == "Completed"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Hoàn
				thành</a> <a
				href="${pageContext.request.contextPath}/user/delivery?status=Cancelled"
				class="<c:choose><c:when test='${param.status == "Cancelled"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đã
				hủy</a>
		</div>

		<!-- Order List -->
		<div class="order-list">
			<c:forEach var="order" items="${orders}">
				<div class="order-card">
					<div class="order-header">
						<p>Trạng thái: ${order.status}</p>
						<p>
							Tổng tiền:
							<fmt:formatNumber value="${order.price}" type="currency"
								currencySymbol="₫" />
						</p>
						<p>
							Ngày đặt:
							<fmt:formatDate value="${order.createAtAsDate}"
								pattern="dd/MM/yyyy" />
						</p>
					</div>

					<!-- Thông tin cửa hàng và sản phẩm -->
					<div class="orders">
						<c:forEach var="entry" items="${order.storeGroupedOrderItems}">
							<h4>Cửa hàng: ${entry.key.name}</h4>
							<c:forEach var="item" items="${entry.value}">
								<div class="order-item">
									<div class="col product-image">
										<c:choose>
											<c:when test="${not empty item.product.imageUrls}">
												<img src="${item.product.imageUrls[0]}"
													alt="Image of ${item.product.name}" />
											</c:when>
											<c:otherwise>
												<img src="/images/default_product.png" alt="Default Image" />
											</c:otherwise>
										</c:choose>
									</div>
									<div class="col product-details">
										<p>
											<strong>Tên sản phẩm:</strong> ${item.product.name}
										</p>
										<p>
											<strong>Giá:</strong>
											<fmt:formatNumber value="${item.product.price}"
												type="currency" currencySymbol="₫" />
										</p>
										<p>
											<strong>Số lượng:</strong> ${item.count}
										</p>
									</div>
								</div>
							</c:forEach>
						</c:forEach>
					</div>

					<!-- Nút xử lý theo trạng thái hủy-->
					<div class="order-actions">
						<c:choose>
							<c:when test="${order.status == 'Completed' && !order.reviewed}">
								<c:if test="${not empty order.received}">
									<button class="btn btn-primary btn-review"
										data-order-id="${order.id}">Đánh giá đơn hàng</button>
								</c:if>
							</c:when>
							<c:when test="${order.reviewed}">
								<p class="text-success">Đã đánh giá</p>
							</c:when>
						</c:choose>
					</div>
					<script>
document.addEventListener('DOMContentLoaded', () => {
    // Xử lý nút "Đánh giá đơn hàng"
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', event => {
            const orderId = button.getAttribute('data-order-id');
            // Chuyển hướng sang trang đánh giá đơn hàng
            window.location.href = `/user/review/write?orderId=${orderId}`;
        });
    });
});
</script>


					<script>
document.addEventListener('DOMContentLoaded', () => {
    // Xử lý nút "Đã nhận được hàng"
    document.querySelectorAll('.btn-received').forEach(button => {
        button.addEventListener('click', event => {
            const orderId = button.getAttribute('data-order-id');
            if (confirm("Bạn có chắc chắn đã nhận được hàng?")) {
                // Trực tiếp thay đổi trạng thái trong giao diện
                button.textContent = "Đã nhận hàng";
                button.disabled = true;

                // Hiển thị nút Đánh giá
                const reviewButton = document.createElement('button');
                reviewButton.className = "btn btn-primary btn-review";
                reviewButton.textContent = "Đánh giá";
                reviewButton.setAttribute('data-order-id', orderId);
                reviewButton.addEventListener('click', () => {
                    window.location.href = `/user/review/write?orderId=${orderId}`;
                });

                // Thêm nút Đánh giá vào DOM
                const actionContainer = button.parentElement;
                actionContainer.appendChild(reviewButton);
            }
        });
    });

    // Xử lý nút "Đánh giá"
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', event => {
            const orderId = button.getAttribute('data-order-id');
            window.location.href = `/user/review/write?orderId= ${order.id}`;
        });
    });
});
</script>
<!-- Nút Hủy đơn hàng -->
<c:choose>
    <c:when test="${order.status == 'Processing_1' || order.status == 'Processing_2'}">
        <button class="btn btn-danger btn-cancel" data-order-id="${order.id}">Hủy đơn hàng</button>
    </c:when>
    <c:otherwise>
        <p class="text-muted">Đơn hàng không thể hủy</p>
    </c:otherwise>
</c:choose>



<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    // Đảm bảo sự kiện không bị gắn lặp lại
    $(document).off('click', '.btn-cancel').on('click', '.btn-cancel', function () {
        const orderId = $(this).data('order-id'); // Lấy ID đơn hàng từ thuộc tính data-order-id
        if (confirm("Bạn có chắc chắn muốn hủy đơn hàng này?")) {
            // Gửi yêu cầu hủy đơn hàng qua AJAX
            $.ajax({
                url: '/user/delivery/cancel',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ orderId: orderId }),
                success: function (response) {
                    alert("Đơn hàng đã được hủy thành công!");
                    $(`button[data-order-id="${orderId}"]`).replaceWith('<p class="text-muted">Đơn hàng đã bị hủy</p>');
                },
                error: function (xhr) {
                    console.error("Lỗi khi hủy đơn hàng:", xhr.responseText);
                    alert("Đã xảy ra lỗi: " + (xhr.responseText || 'Không có thông tin chi tiết.'));
                }
            });
        }
    });
});

</script>


				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
