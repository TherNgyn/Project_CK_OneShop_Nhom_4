<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<title>Quản Lý Đơn Hàng</title>

<body>

	<nav class="navbar">
		<ul class="nav-list">
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=all"
				class="${empty param.status || param.status == 'all' ? 'active' : ''}">
					Tất cả </a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Processing"
				class="${param.status == 'Processing_1' || param.status == 'Processing_2' ? 'active' : ''}">
					Đơn hàng chưa duyệt </a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Preparing"
				class="${param.status == 'Preparing_1' || param.status == 'Preparing_2' ? 'active' : ''}">
					Đang chuẩn bị hàng </a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=In Transit"
				class="${param.status == 'In Transit_1' || param.status == 'In Transit_2' ? 'active' : ''}">
					Đã gửi cho đơn vị vận chuyển </a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Completed"
				class="${param.status == 'Completed' ? 'active' : ''}"> Đơn hàng
					đã giao </a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Cancelled"
				class="${param.status == 'Cancelled' ? 'active' : ''}"> Đơn hàng
					bị hủy </a></li>
		</ul>
	</nav>
<c:if test="${not empty error}">
    <div class="error">
        <c:choose>
            <c:when test="${error == 'insufficientInventory'}">
                Báo lỗi: Không đủ hàng trong kho.
            </c:when>
            <c:when test="${error == 'noInventory'}">
                Báo lỗi: Không tìm thấy hàng trong kho.
            </c:when>
        </c:choose>
    </div>
</c:if>

	<!-- Order List -->
<div class="order-list">
    <table class="table table-striped table-bordered">
        <thead>
            <tr>
                <th>STT</th>
                <th>Trạng thái</th>
                <th>Tổng tiền</th>
                <th>Ngày đặt</th>
                <th>Người đặt</th>
                <th>Chi tiết sản phẩm</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}" varStatus="status">
                <tr>
                    <!-- STT -->
                    <td>${status.index + 1}</td>

						<!-- Trạng thái -->
						<td><c:choose>
								<c:when test="${order.status == 'Processing_1'}">
            Chưa duyệt
        </c:when>
								<c:when test="${order.status == 'Processing_2'}">
            Chờ admin duyệt
        </c:when>
        <c:when test="${order.status == 'Cancelled'}">
            Bị hủy
        </c:when>
        <c:when test="${order.status == 'Completed'}">
            Đã giao
        </c:when>
        <c:when test="${order.status == 'Preparing_1'}">
            Chuẩn bị hàng, thanh toán khi nhận hàng
        </c:when>
        <c:when test="${order.status == 'Preparing_2'}">
           Chuẩn bị hàng, khách hàng đã thanh toán
        </c:when>
        <c:when test="${order.status == 'In Transit_1'}">
            Chờ đơn vị vận chuyển duyệt
        </c:when>
        <c:when test="${order.status == 'In Transit_2'}">
            Đang giao hàng
        </c:when>
        
								<c:otherwise>
            ${order.status}
        </c:otherwise>
							</c:choose></td>

						<!-- Tổng tiền -->
						<td>
                        <fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" />
                    </td>
                    
                    <!-- Ngày đặt -->
                    <td>
                        <fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" />
                    </td>
                    
                    <!-- Người dùng -->
                    <td>
                        ${order.user.username}
                    </td>
                    
                    <!-- Chi tiết sản phẩm -->
                    <td>
                        <c:forEach var="entry" items="${order.storeGroupedOrderItems}">
                            <c:forEach var="item" items="${entry.value}">
                                <p>
                                    <strong>${item.product.name}</strong> - 
                                    SL: ${item.count} - 
                                    Giá: 
                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" />
                                </p>
                            </c:forEach>
                        </c:forEach>
                    </td>
                    
                    <!-- Hành động -->
                    <td>
                        <!-- Nút Đánh giá -->
                      
                           
                         <!-- Nút duyệt đơn hàng --> <c:choose>
								<c:when test="${order.status == 'Processing_1'}">
									<a href="/vendor/manageorder/approveOrder?orderId=${order.id}"
										class="btn btn-danger">Duyệt</a>
									<a href="/vendor/manageorder/cancelOrder?orderId=${order.id}"
										class="btn btn-warning">Không duyệt</a>
								</c:when>
								<c:when test="${order.status == 'Preparing_1'}">
									<a
										href="/vendor/manageorder/sendToShipping?orderId=${order.id}"
										class="btn btn-primary">Gửi cho đơn vị vận chuyển</a>
								</c:when>
								<c:when test="${order.status == 'Cancelled'}">
									<p class="text-muted">Đơn hàng đã bị hủy</p>
								</c:when>
								<c:otherwise>
									<p class="text-muted">Chỉ xem</p>
								</c:otherwise>
							</c:choose>
						</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- JavaScript xử lý -->
<script>
$(document).ready(function () {
    // Xử lý nút Đánh giá
    $(document).off('click', '.btn-review').on('click', '.btn-review', function () {
        const orderId = $(this).data('order-id');
        window.location.href = `/user/review/write?orderId=${orderId}`;
    });

    
    $(document).off('click', '.btn-cancel').on('click', '.btn-cancel', function () {
        const orderId = $(this).data('order-id');
        if (confirm("Bạn có chắc chắn muốn hủy đơn hàng này?")) {
            $.ajax({
                url: '/user/delivery/cancel',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ orderId: orderId }),
                success: function () {
                    alert("Đơn hàng đã được hủy thành công!");
                    $(`button[data-order-id="${orderId}"]`).closest('tr').find('td:last-child').html('<p class="text-muted">Đơn hàng đã bị hủy</p>');
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
	
</body>
