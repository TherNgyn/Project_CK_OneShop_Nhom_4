<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

		/* Tiêu đề section */
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
	    }

	    /* Cải thiện thiết kế bảng sản phẩm */
	    .product-table {
	        width: 100%;
	        max-width: 1200px; /* Đặt giới hạn chiều rộng */
	        margin: 0 auto;
	        border-collapse: collapse;
	        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	        background-color: white;
	    }
	    
	    .product-table th, .product-table td {
	        padding: 15px;
	        text-align: center;
	        border: 1px solid #ddd;
	        font-size: 1rem;
	    }

	    .product-table th {
	        background-color: #007BFF;
	        color: white;
	        font-weight: bold;
	        text-transform: uppercase;
	    }

	    .product-table td {
	        background-color: #f9f9f9;
	    }

	    .product-table tr:hover {
	        background-color: #f1f1f1; /* Thêm hiệu ứng hover cho dòng */
	    }

	    /* Thêm hiệu ứng cho hình ảnh */
	    .product-table img {
	        max-width: 100%;
	        height: auto;
	        border-radius: 5px;
	    }

	    /* Nút quay lại */
	    .back-button {
	        display: inline-block;
	        margin-top: 20px;
	        padding: 10px 20px;
	        background-color: #007BFF;
	        color: white;
	        text-decoration: none;
	        border-radius: 5px;
	        font-weight: bold;
	    }

	    .back-button:hover {
	        background-color: #0056b3;
	    }
    </style>

    <h2 class="section-title">DANH SÁCH SẢN PHẨM CỦA ${store.name}</h2>
	
	<p><strong>ID Store:</strong> ${store.id}</p>
    <p><strong>Mô tả:</strong> ${store.bio}</p>

    <!-- Hiển thị danh sách sản phẩm -->
    <table class="product-table">
    <thead>
        <tr>
            <th>Tên sản phẩm</th>
            <th>Hình ảnh</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Giá khuyến mãi</th>
            <th>Đã bán</th>
            <th>Trạng thái</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty product.mainImage}">
                            <img src="${product.mainImage.imageUrl}" alt="Main Image" width="100" height="100"/>
                        </c:when>
                        <c:otherwise>
                            <p>Không có hình ảnh</p>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${product.description}</td>
                <td>
					 <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
				</td>
                <td>
					  <fmt:formatNumber value="${product.promotionalPrice}" pattern="#,##0" />đ
				</td>
                <td>${product.sold}</td>
                <td>${product.status}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    <!-- Nút quay lại -->
    <a href="/admin/stores" class="back-button">Quay lại danh sách Store</a>
</body>
</html>
