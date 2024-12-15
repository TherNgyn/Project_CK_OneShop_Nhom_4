<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Giao Hàng</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Open Sans', sans-serif;
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
	
	    .section-title:hover {
	        transform: scale(1.05);
	        transition: transform 0.3s ease-in-out;
	    }
    </style>
</head>
<body>
    <h2 class="section-title">THÔNG TIN GIAO HÀNG</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <div class="alert alert-warning" role="alert" style="${error != null && error.trim().length() > 0 ? '' : 'display: none;'}">
        ${error}
    </div>

    <form action="/admin/deliveries/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${delivery.id}">
        
        <div class="mb-3">
            <label for="deliveryName" class="form-label">Tên</label>
            <input type="text" class="form-control" id="deliveryName" name="name" value="${delivery.name}" required>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Giá</label>
            <input type="number" class="form-control" id="price" name="price" value="${delivery.price}" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" id="description" name="description" rows="3">${delivery.description}</textarea>
        </div>

        <div class="mb-3">
            <label for="createdAt" class="form-label">Ngày tạo</label>
            <input type="date" class="form-control" id="createdAt" name="createdAt" value="${delivery.createat}">
        </div>

        <div class="mb-3">
            <label for="updatedAt" class="form-label">Ngày cập nhật</label>
            <input type="date" class="form-control" id="updatedAt" name="updatedAt" value="${delivery.updateat}" disabled>
        </div>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="/admin/deliveries" class="btn btn-secondary">Quay lại</a>
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
