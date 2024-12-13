<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá đơn hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="review-container">
            <h2 class="text-center mb-4">Đánh giá sản phẩm trong đơn hàng</h2>
            <form action="/user/review/save" method="post">
                <!-- Hidden Input for Order ID -->
                <input type="hidden" name="orderId" value="${order.id}" />

                <!-- Loop Through Order Items -->
                <c:forEach var="item" items="${orderItems}">
                    <div class="review-item mb-4">
                        <h4>${item.product.name}</h4>
                        <p><strong>Giá:</strong> ${item.product.price} ₫</p>
                        <p><strong>Số lượng:</strong> ${item.count}</p>

                        <div class="mb-3">
                            <label for="rating-${item.product.id}" class="form-label">Đánh giá (1-5):</label>
                            <input type="number" id="rating-${item.product.id}" name="ratings" min="1" max="5" class="form-control" required />
                        </div>

                        <div class="mb-3">
                            <label for="review-${item.product.id}" class="form-label">Nhận xét:</label>
                            <textarea id="review-${item.product.id}" name="reviews" rows="4" class="form-control" required></textarea>
                        </div>

                        <input type="hidden" name="productIds" value="${item.product.id}" />
                    </div>
                </c:forEach>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
