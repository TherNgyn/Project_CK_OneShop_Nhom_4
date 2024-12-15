<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<body>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

<style>
    /* Điều chỉnh lại tổng thể giao diện */
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
    

    /* Tiêu đề đẹp hơn */
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

    /* Bảng đẹp hơn với kiểu bảng và căn chỉnh */
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

    /* Điều chỉnh cột ngày */
    .table th.date-column, .table td.date-column {
        width: 150px;
        word-wrap: break-word;
    }

    .table th.action-column, .table td.action-column {
        width: 170px;
    }

    /* Nút bấm giữ nguyên màu cũ */
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

    /* Định dạng cho các văn bản không có dữ liệu */
    .no-data {
        text-align: center;
        color: #6c757d;
        font-style: italic;
    }
</style>

	<h2 class="section-title">DANH SÁCH CỬA HÀNG</h2>
    
    <!-- Form tìm kiếm -->
    <form action="/admin/stores" method="get" class="mb-3">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Tìm kiếm cửa hàng..." name="search" value="${searchTerm != null ? searchTerm : ''}">
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </div>
    </form>

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
                    <th class="date-column">Ngày Tạo</th>
                    <th class="date-column">Ngày Cập Nhật</th>
                    <th>Owner ID</th>
                    <th>Sản phẩm chờ duyệt</th>
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
				        <td class="date-column">${store.createat}</td>
				        <td class="date-column">${store.updateat}</td>
				        <td>${store.user.id}</td>
				        
				        <!-- Calculate waiting products count directly in the JSP -->
				        <td>
				            <c:set var="waitingProductCount" value="0" />
				            <c:forEach var="product" items="${store.products}">
				                <c:if test="${product.status == 'Waiting'}">
				                    <c:set var="waitingProductCount" value="${waitingProductCount + 1}" />
				                </c:if>
				            </c:forEach>
				            ${waitingProductCount}
				        </td>
				
				        <td class="action-column">                        
				            <a href="/admin/stores/edit/${store.id}" class="btn btn-warning btn-sm mr-2" style="display:; margin-bottom: 5px;">Sửa</a>
				            <a href="/admin/stores/products/${store.id}" class="btn btn-danger btn-sm mr-2">Xem sản phẩm</a>                            
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
