<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            background-color: #f8f9fa;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            background: linear-gradient(90deg, #007BFF, #00C6FF);
            -webkit-background-clip: text;
            color: transparent;
            text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
            margin-top: 50px;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .section-title::after {
            content: "";
            display: block;
            width: 120px;
            height: 4px;
            background: linear-gradient(90deg, #007BFF, #00C6FF);
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .table-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table th, .table td {
            padding: 12px;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #ddd;
        }

        .table th {
            background-color: #007bff;
            color: #fff;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            color: #6c757d;
            font-style: italic;
        }
    </style>

    <h2 class="section-title">Danh Sách Sản Phẩm</h2>

	<p><strong>Mã đơn hàng:</strong> ${order.id}</p>
    <p><strong>Total Price:</strong> <fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫"/></p>
        
    <div class="table-container">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá</th>
                    <th>Số Lượng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="orderItem" items="${orderItems}">
                    <tr>
                        <!-- Ảnh sản phẩm -->
                        <td>
                            <c:if test="${not empty orderItem.product.mainImage}">
                                <img src="${orderItem.product.mainImage.imageUrl}" alt="Product Image" style="width: 80px; height: auto;">
                            </c:if>
                        </td>

                        <!-- Thông tin sản phẩm -->
                        <td>${orderItem.product.name}</td>
                        <td><fmt:formatNumber value="${orderItem.product.price}" type="currency" currencySymbol="₫"/></td>
                        <td>${orderItem.count}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orderItems}">
                    <tr>
                        <td colspan="4" class="no-data">Không có sản phẩm nào trong đơn hàng</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
