<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<body>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

   <style>
    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
    }
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        padding: 0;
        margin: 0;
    }
	.table {
	    table-layout: auto; /* Automatically adjusts the column width */
	    width: 100%; /* Make the table width fill the container */
	}
	
	.table th, .table td {
	    text-align: center;
	    vertical-align: middle;
	    padding: 15px;
	    white-space: nowrap; /* Prevents text from wrapping */
	}
	
	.table th {
	    word-wrap: break-word; /* Ensures header text wraps if it's too long */
	}  
	/* Cho phép xuống hàng trong các cột */	
	body.wrap-text {
	    word-wrap: break-word;
	    word-break: break-word;
	    white-space: normal; /* Cho phép nội dung tự xuống dòng */
	}
	
	/* Giữ nội dung trên một dòng */
	.nowrap-text {
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis; /* Hiển thị dấu "..." nếu nội dung quá dài */
	}
	
	/* Chỉnh độ rộng của các trường để tránh quá dài */
	input, textarea, select {
	    max-width: 100%; /* Không cho phép vượt quá chiều ngang của form */
	}  
    table {
        margin-top: 20px;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
    }
    .table th, .table td {
        padding: 15px;
    }
    .table-hover tbody tr:hover {
        background-color: #f1f1f1;
    }
    .btn {
        font-size: 14px;
        padding: 6px 12px;
        border-radius: 4px; /* Rounded corners for the buttons */
        transition: background-color 0.3s, opacity 0.3s; /* Smooth hover effect */
    }
    .btn-primary {
        background-color: #007bff; /* Blue color */
        color: white;
        border: 1px solid #007bff;
    }
    .btn-primary:hover {
        background-color: #0056b3; /* Darker blue on hover */
        opacity: 0.8;
    }
    .btn-secondary {
        background-color: #ffffff; /* White color */
        color: #007bff; /* Blue text */
        border: 1px solid #007bff;
    }
    .btn-secondary:hover {
        background-color: #f1f1f1; /* Light gray on hover */
        color: #0056b3; /* Darker blue on hover */
        opacity: 0.8;
    }
    .btn-warning {
        background-color: #00aaff; /* Lighter blue color */
        color: white;
        border: 1px solid #00aaff;
    }
    .btn-warning:hover {
        background-color: #007bff; /* Darker blue on hover */
        opacity: 0.8;
    }
    .btn-danger {
        background-color: #0056b3; /* Blue color */
        color: white;
        border: 1px solid #0056b3;
    }
    .btn-danger:hover {
        background-color: #003f6d; /* Darker blue on hover */
        opacity: 0.8;
    }
    .table-container {
        margin-top: 30px;
    }
    .btn-success {
	    background-color: #007bff; /* Blue color */
	    color: white;
	    border: 1px solid #007bff;
	    border-radius: 4px;
	    padding: 6px 12px;
	    font-size: 14px;
	    transition: background-color 0.3s, opacity 0.3s;
	}
	
	.btn-success:hover {
	    background-color: #0056b3; /* Darker blue on hover */
	    opacity: 0.8;
	}
    

    h2 {
        margin-top: 20px;
        text-align: center;
        margin-bottom: 20px;
        color: #343a40;
    }
    .no-data {
        text-align: center;
        color: #6c757d;
        font-style: italic;
    }
</style>

<div class="container">
    <div style="text-align: center; margin-bottom: 40px;">
        <h2 style="font-size: 36px; font-weight: 600; color: #333; letter-spacing: 1px; font-family: 'Roboto', sans-serif; 
                   text-transform: uppercase; margin-bottom: 10px;">
            DANH SÁCH CÁC CỬA HÀNG
        </h2>
    </div>
    <a href="/admin/stores/add" class="btn btn-primary mb-3">Thêm Store Mới</a>

    <div class="table-container">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Avatar</th>
                    <th>Mô Tả</th>
                    <th>Hình ảnh nổi bật</th>
                    <th>Trạng Thái</th>
                    <th>Đánh Giá</th>
                    <th>Ngày Tạo</th>
                    <th>Ngày Cập Nhật</th>
                    <th>Owner ID</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="store" items="${stores}">
                    <tr>
                        <td>${store.id}</td>
                        <td>${store.name}</td>
                        <td><img src="${store.avatar}" alt="Avatar" style="width: 50px; height: 50px;"></td>
                        <td>${store.bio}</td>
                        <td><img src="${store.featuredimages}" alt="Featured Image" style="width: 50px; height: 50px;"></td>
                        <td>${store.isactive ? 'Kích hoạt' : 'Không kích hoạt'}</td>
                        <td>${store.rating}</td>
                        <td>${store.createat}</td>
                        <td>${store.updateat}</td>
                        <td>${store.user.id}</td>
                        <td>
                            <a href="/admin/stores/edit/${store.id}" class="btn btn-warning btn-sm">Sửa</a>
                            <form action="/admin/stores/delete/${store.id}" method="post" style="display:inline;">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa store này?')">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
    