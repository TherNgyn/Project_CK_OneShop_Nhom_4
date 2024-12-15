<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<body>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
	<style>	
	    body {
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
		        position: relative;
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
	
		    .section-title:hover {
		        transform: scale(1.05);
		        transition: transform 0.3s ease-in-out;
    </style>
    <h2 class="section-title">Order Details</h2>

    <!-- Hiển thị lỗi nếu không tìm thấy đơn hàng -->
    <c:if test="${not empty error}">
        <p style="color: red;"><strong>${error}</strong></p>
    </c:if>

    <!-- Hiển thị thông tin đơn hàng -->
    <c:if test="${not empty order}">
        <p><strong>Order ID:</strong> ${order.id}</p>
        <p><strong>Phone:</strong> ${order.phone}</p>
        <p><strong>Total Price:</strong> ${order.price}</p>

        <h2>Products</h2>
        <!-- Lặp qua danh sách sản phẩm -->
        <c:forEach var="orderItem" items="${orderItems}">
            <div class="product">
                <!-- Hình ảnh sản phẩm -->
                <c:if test="${not empty orderItem.product.mainImage}">
                    <img src="${orderItem.product.mainImage.imageUrl}" alt="Product Image">
                </c:if>

                <!-- Thông tin sản phẩm -->
                <div class="product-info">
                    <p><strong>Product Name:</strong> ${orderItem.product.name}</p>
                    <p><strong>Quantity:</strong> ${orderItem.count}</p>
                    <p><strong>Price:</strong> ${orderItem.product.price}</p>
                </div>
            </div>
        </c:forEach>
    </c:if>
</body>
</html>
