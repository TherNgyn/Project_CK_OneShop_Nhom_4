<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<body>
	
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-pzjw8f+ua7Kw1TIq0v8FqgsKRx2HpFQ2p4qz+JmlVAn03xmIDcK5k5V5/Yo3XtiD" crossorigin="anonymous">
    <!-- Thêm CSS tuỳ chỉnh -->
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
        }
        .btn-warning {
            background-color: #ffc107;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-warning:hover, .btn-danger:hover {
            opacity: 0.8;
        }
        .table-container {
            margin-top: 30px;
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
	<h2>DANH SÁCH NGƯỜI DÙNG</h2>
	<a href="/admin/users/add" class="btn btn-success" style="display: inline-block;">Thêm Người Dùng Mới</a>

	<div style="display: inline-block; margin-top: 20px; margin-left: 20px;">
	    <label for="roleSelect" style="font-size: 18px; color: #333; font-weight: bold; margin-right: 10px;">Chọn vai trò:</label>
	    <select id="roleSelect" name="role" onchange="window.location.href=this.value" 
	            style="padding: 12px 20px; font-size: 16px; border-radius: 8px; border: 1px solid #ddd; background-color: #fff; 
	            width: 220px; transition: background-color 0.3s, box-shadow 0.3s; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
	        <option value="/admin/users" ${selectedRole == null ? 'selected' : ''}>Tất cả</option>
	        <c:forEach var="role" items="${roles}">
	            <option value="/admin/users?role=${role}" ${role == selectedRole ? 'selected' : ''}>${role}</option>
	        </c:forEach>
	    </select>
	</div>
	
	<!-- Hiển thị thông báo lỗi nếu có -->
    <div class="alert alert-warning" role="alert" style="${error != null && error.trim().length() > 0 ? '' : 'display: none;'}">
		${error}
	</div>
	<div class="table-container">
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
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
			            <td>
			                <img src="${user.avatar}" alt="Avatar" class="img-thumbnail" style="width: 50px; height: 50px;">
			            </td>
			            <td>${user.firstName}</td>
			            <td>${user.lastName}</td>
			            <td>${user.email}</td>
			            <td>${user.username}</td>
			            <td>${user.address}</td>
			            <td>${user.phone}</td>
			            <td>${user.role}</td>
			            <td>${user.isActive ? 'Kích hoạt' : 'Không kích hoạt'}</td>
			            <td>${user.createat}</td>
			            <td>${user.updateat}</td>
			            <td>
			                <a href="/admin/users/edit/${user.id}" class="btn btn-warning btn-sm">Sửa</a>
			                <form action="/admin/users/delete" method="post" style="display:inline;">
			                    <input type="hidden" name="id" value="${user.id}">
			                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa người dùng này?')">Xóa</button>
			                </form>
			            </td>
			        </tr>
                </c:forEach>                
            </tbody>
        </table>
    </div>

    <!-- Thêm Bootstrap JS và Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zyQ5vEe3p4brv6HzR9M35e/XI86d4FfYd3vT6a7T" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.6/dist/umd/popper.min.js" integrity="sha384-Ksv2Vq/Uu/s8lXl8V2pBlZGqqfpZZR6xzLq2tT1g7bFdBqBXfoV5nHaqLhROFTMI" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0v8FqgsKRx2HpFQ2p4qz+JmlVAn03xmIDcK5k5V5/Yo3XtiD" crossorigin="anonymous"></script>

</body>
</html>