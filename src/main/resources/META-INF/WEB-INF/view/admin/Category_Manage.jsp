<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        body {
            margin: 0;
            padding: 0;
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

        .table th.action-column, .table td.action-column {
            width: 170px;
        }

        .btn {
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 4px;
            margin-right: 5px;
            transition: background-color 0.3s, opacity 0.3s;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            opacity: 0.8;
        }

        .btn-warning {
            background-color: #00aaff;
            color: white;
            border: 1px solid #00aaff;
        }

        .btn-warning:hover {
            background-color: #007bff;
            opacity: 0.8;
        }

        .btn-danger {
            background-color: #0056b3;
            color: white;
            border: 1px solid #0056b3;
        }

        .btn-danger:hover {
            background-color: #003f6d;
            opacity: 0.8;
        }

        .input-group {
            max-width: 600px;
            margin: 0 auto 20px;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>

    <div class="container">
        <h2 class="section-title">Quản Lý Danh Mục</h2>

        <!-- Search Form -->
        <form action="/admin/categories/search" method="post" class="mb-3">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm danh mục..." name="search" value="${searchTerm != null ? searchTerm : ''}">
                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
            </div>
        </form>

        <!-- Add Category Button -->
        <div class="d-flex justify-content-between mb-4">
            <a href="/admin/categories/add" class="btn btn-primary">Thêm Danh Mục</a>
        </div>

        <!-- Table displaying Categories -->
        <div class="table-container">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Hình ảnh</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categories}">
                        <tr>
                            <td>${category.id}</td>
                            <td>${category.name}</td>
                            <td><img src="${category.image}" alt="Image" style="max-width: 50px;"></td>
                            <td>${category.createat}</td>
                            <td>${category.updateat}</td>
                            <td class="action-column">
                                <a href="/admin/categories/edit/${category.id}" class="btn btn-warning btn-sm">Sửa</a>
                                <form action="/admin/categories/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${category.id}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?')">Xóa</button>
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
