<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng</title>
    <!-- Include Bootstrap, Font Awesome, and Custom CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .thead-blue { background-color: #007bff; color: white; }
        .primary-btn { background-color: #007bff; color: white; border: none; padding: 10px 20px; }
        .primary-btn:hover { background-color: #0056b3; }
        .order-header, .order-item { margin-bottom: 15px; }
        .order-actions button { margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Quản Lý Đơn Hàng</h2>

        <!-- Tabs for Filtering by Status -->
        <div class="tabs">
			<a href="${pageContext.request.contextPath}/vendor/manageorder?status=all"
				class="<c:choose><c:when test='${empty param.status or param.status == "all"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Tất
				cả</a> <a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Processing"
				class="<c:choose><c:when test='${param.status == "Processing_1" || param.status == "Processing_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đơn hàng chưa duyêt</a> <a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Preparing"
				class="<c:choose><c:when test='${param.status == "Preparing_1" || param.status == "Preparing_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đang
				chuẩn bị hàng</a> <a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=In Transit"
				class="<c:choose><c:when test='${param.status == "In Transit_1" || param.status == "In Transit_2"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Chờ đơn vị vận chuyển</a> <a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Completed"
				class="<c:choose><c:when test='${param.status == "Completed"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đơn hàng đã giao</a> <a
				href="${pageContext.request.contextPath}/vendor/manageorder?status=Cancelled"
				class="<c:choose><c:when test='${param.status == "Cancelled"}'>tab active</c:when><c:otherwise>tab</c:otherwise></c:choose>">Đơn hàng đã bị Hủy</a>
		</div>

        <!-- Order List -->
        <div>
            <c:if test="${empty orders}">
                <div class="alert alert-warning">Không có đơn hàng nào.</div>
            </c:if>

            <table class="table table-striped">
    <thead>
        <tr>
            <th>Trạng Thái</th>
            <th>Tổng Tiền</th>
            <th>Ngày Đặt</th>
            <th>Người Dùng</th>
            <th>Thông Tin Cửa Hàng/Sản Phẩm</th>
            <th>Hành Động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 'Processing_1'}">Chưa duyệt</c:when>
                        <c:when test="${order.status == 'Processing_2'}">Đang chờ admin duyệt</c:when>
                        <c:when test="${order.status == 'Preparing_1'}">Đã duyệt</c:when>
                        <c:when test="${order.status == 'Preparing_2'}">Admin đã duyệt</c:when>
                        <c:when test="${order.status == 'In Transit_1'}">Đang Vận Chuyển</c:when>
                        <c:when test="${order.status == 'In Transit_2'}">Đang Vận Chuyển</c:when>
                        <c:when test="${order.status == 'Completed'}">Đơn hàng đã giao</c:when>
                        <c:when test="${order.status == 'Cancelled'}">Đơn hàng đã bị Hủy</c:when>
                        <c:otherwise>${order.status}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" />
                </td>
                <td>
                    <fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" />
                </td>
                <td>
                    ${order.user.username}
                </td>
                <td>
                    <c:forEach var="entry" items="${order.storeGroupedOrderItems}">
                        <h5>Cửa Hàng: ${entry.key.name}</h5>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Giá</th>
                                    <th>Số Lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${entry.value}">
                                    <tr>
                                        <td>${item.product.name}</td>
                                        <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" /></td>
                                        <td>${item.count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:forEach>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 'Completed' && !order.reviewed}">
                            <button class="btn btn-primary btn-review" data-order-id="${order.id}">Đánh Giá</button>
                        </c:when>
                        <c:when test="${order.reviewed}">
                            <span class="text-success">Đã đánh giá</span>
                        </c:when>
                    </c:choose>
                    <c:if test="${order.status == 'Processing'}">
                        <button class="btn btn-danger btn-cancel" data-order-id="${order.id}">Đồng Ý Yêu Cầu Hủy</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</body>
