<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipper Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background for subtle contrast */
            font-family: Arial, sans-serif;
            font-size: 14px; /* Smaller font size */
        }
        h2 {
            color: #0056b3; /* Darker blue for the heading */
            margin-bottom: 20px;
        }
        .table th, .table td {
            font-size: 14px; /* Consistent small font size for table content */
            vertical-align: middle;
        }
        .btn {
            font-size: 12px; /* Smaller font size for buttons */
            padding: 5px 10px;
            color: white;
        }
        .btn-primary {
            background-color: #007bff; /* Blue color for buttons */
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Đơn Hàng Đang Vận Chuyển</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>ID Đơn Hàng</th>
                    <th>Tên Khách Hàng</th>
                    <th>Ngày Đặt</th>
                    <th>Tổng Tiền</th>
                    <th>Đơn Vị Vận Chuyển</th>
                    <th>Phí Ship</th>
                    <th>Trạng Thái</th>
                    <th>Địa Chỉ</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${ordersInTransit}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td>${order.id}</td>
                        <td>${order.user.username}</td>
                        <td><fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" /></td>
                        <td><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="đ" /></td>
                        <td>${order.delivery.name}</td>
                        <td><fmt:formatNumber value="${order.delivery.price}" type="currency" currencySymbol="đ" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'In Transit_1'}">
                                    Thanh toán tiền mặt
                                </c:when>
                                <c:otherwise>
                                    Đã thanh toán
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${order.address.addressLine1}, ${order.address.addressLine2}, ${order.address.city}</td>
                        <td>
                            <form action="/shipper/updateOrderStatus"
								method="post">
								<input type="hidden" name="orderId" value="${order.id}" />
								<c:choose>
									
									<c:when test="${order.status == 'Completed'}">
										<button type="button" class="btn btn-success btn-sm" disabled>
											Đã Giao Thành Công</button>
									</c:when>
									<c:when test="${order.status == 'Cancelled'}">
										<button type="button" class="btn btn-danger btn-sm" disabled>
											Giao Thất Bại</button>
									</c:when>
									<c:otherwise>
										
										<button type="submit" name="status" value="Completed"
											class="btn btn-primary btn-sm">Giao Thành Công</button>
										<button type="submit" name="status" value="Cancelled"
											class="btn btn-primary btn-sm">Giao Thất Bại</button>
									</c:otherwise>
								</c:choose>
							</form>

						</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
