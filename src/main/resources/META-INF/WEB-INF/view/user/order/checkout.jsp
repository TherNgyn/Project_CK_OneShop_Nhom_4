<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <h1>Quản Lý Đơn Hàng</h1>

        <!-- Tabs for different order statuses -->
        <div class="tabs">
            <a href="${pageContext.request.contextPath}/user/delivery?status=all" class="tab <c:if test='${empty param.status or param.status == "all"}'>active</c:if>">Tất cả</a>
            <a href="${pageContext.request.contextPath}/user/delivery?status=Pending" class="tab <c:if test='${param.status == "Pending"}'>active</c:if>">Chờ xử lý</a>
            <a href="${pageContext.request.contextPath}/user/delivery?status=In Transit" class="tab <c:if test='${param.status == "In Transit"}'>active</c:if>">Đang giao</a>
            <a href="${pageContext.request.contextPath}/user/delivery?status=Completed" class="tab <c:if test='${param.status == "Completed"}'>active</c:if>">Hoàn thành</a>
            <a href="${pageContext.request.contextPath}/user/delivery?status=Cancelled" class="tab <c:if test='${param.status == "Cancelled"}'>active</c:if>">Đã hủy</a>
        </div>

        <!-- Order List -->
        <div class="order-list">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-header">
                        <p>Trạng thái: ${order.status}</p>
                        <p>
                            Tổng tiền: 
                            <fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" />
                        </p>
                        <p>
                            Ngày đặt:
                            <fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" />
                        </p>
                    </div>

                    <!-- Store and Product Details -->
                    <div class="orders">
                        <c:forEach var="entry" items="${order.storeGroupedOrderItems}">
                            <h4>Cửa hàng: ${entry.key.name}</h4>
                            <c:forEach var="item" items="${entry.value}">
                                <div class="order-item">
                                    <div class="col product-image">
                                        <c:choose>
                                            <c:when test="${not empty item.product.imageUrls}">
                                                <img src="${item.product.imageUrls[0]}" alt="Image of ${item.product.name}" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/images/default_product.png" alt="Default Image" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col product-details">
                                        <p><strong>Tên sản phẩm:</strong> ${item.product.name}</p>
                                        <p><strong>Giá:</strong>
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" />
                                        </p>
                                        <p><strong>Số lượng:</strong> ${item.count}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
