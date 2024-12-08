<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        .order-section {
            padding: 50px 0;
        }
        .order__table {
            margin-bottom: 30px;
        }
        .order__item img {
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
                        <a href="<c:url value='/user/home'/>">Trang chủ</a> <span>Đặt hàng</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Order Section Begin -->
<section class="order-section spad">
    <div class="container">
        <div class="row mb-4">
            <div class="col-lg-12">
                <h4 class="mb-3">Đơn hàng của bạn</h4>
                <div class="order__table">
                    <table class="table table-hover">
                        <thead class="thead-blue">
                        <tr>
                            <th class="order__product">Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${listcart}">
                            <tr>
                                <td class="order__item"><img
                                        src="${item.product.imageUrls[0]}"
                                        alt="${item.product.name}">
                                    <h5>${item.product.name}</h5></td>
                                <td class="order__price"><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/></td>
                                <td class="order__quantity">${item.count}</td>
                                <td class="order__total"><fmt:formatNumber value="${item.count * item.product.price}" type="currency" currencySymbol="₫"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="text-right">
                    <h5>Tổng tiền: <fmt:formatNumber value="${price}" type="currency" currencySymbol="₫"/></h5>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="order__btns">
                    <a href="<c:url value='/user/products'/>" class="primary-btn">TIẾP TỤC MUA SẮM</a>
                    <a href="<c:url value='/user/order/checkout'/>" class="primary-btn">THANH TOÁN</a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Order Section End -->

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
