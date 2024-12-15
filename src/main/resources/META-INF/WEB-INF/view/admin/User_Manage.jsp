<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        h2 {
            font-size: 36px;
            font-weight: 700;
            color: #343a40;
            letter-spacing: 1px;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 20px;
            font-family: 'Roboto', sans-serif;
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

        .table th.date-column, .table td.date-column {
            width: 150px;
            word-wrap: break-word;
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

        .btn-secondary {
            background-color: #ffffff;
            color: #007bff;
            border: 1px solid #007bff;
        }

        .btn-secondary:hover {
            background-color: #f1f1f1;
            color: #0056b3;
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

        .btn-success {
            background-color: #28a745;
            color: white;
            border: 1px solid #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
            opacity: 0.8;
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            color: #6c757d;
            font-style: italic;
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

    <div>
        <h2 class="section-title">DANH SÁCH NGƯỜI DÙNG</h2>
        <form action="/admin/users/search" method="post" class="mb-3">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm người dùng..." name="search" value="${searchTerm != null ? searchTerm : ''}">
                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
            </div>
        </form>

        <div class="d-flex justify-content-between mb-4">
            <a href="/admin/users/add" class="btn btn-primary">Thêm Người Dùng Mới</a>
            <div>
                <label for="roleSelect" class="mr-2">Chọn vai trò:</label>
                <select id="roleSelect" name="role" onchange="window.location.href=this.value" class="form-control" style="width: 200px; display: inline;">
                    <option value="/admin/users?role=&search=${searchTerm != null ? searchTerm : ''}" ${selectedRole == null ? 'selected' : ''}>Tất cả</option>
                    <c:forEach var="role" items="${roles}">
                        <option value="/admin/users?role=${role}&search=${searchTerm != null ? searchTerm : ''}" ${role == selectedRole ? 'selected' : ''}>${role}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="alert alert-warning" role="alert" style="${error != null && error.trim().length() > 0 ? '' : 'display: none;'}">
            ${error}
        </div>

        <div class="table-container">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Avatar</th>
                        <th>Họ</th>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Tên người dùng</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td><img src="${user.avatar}" alt="Avatar" class="img-thumbnail" style="width: 50px; height: 50px;"></td>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.email}</td>
                            <td>${user.username}</td>
                            <td>${user.address}</td>
                            <td>${user.phone}</td>
                            <td>${user.role}</td>
                            <td>${user.isActive ? 'Kích hoạt' : 'Không kích hoạt'}</td>
                            <td class="date-column">${user.createat}</td>
                            <td class="date-column">${user.updateat}</td>
                            <td class="action-column">
                                <a href="/admin/users/edit/${user.id}" class="btn btn-warning btn-sm" style="display:; margin-bottom: 5px;">Sửa</a>
                                <form action="/admin/users/delete" method="post">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa người dùng này?')">Xóa</button>
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
