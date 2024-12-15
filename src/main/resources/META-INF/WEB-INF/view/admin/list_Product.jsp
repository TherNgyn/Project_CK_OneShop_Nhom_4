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


        body/* Tiêu đề section */
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

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: 1px solid #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
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

    <h2 class="section-title">Danh Sách Sản Phẩm</h2>

        <form action="/admin/stores/listProduct" method="get" class="mb-3" id="filterForm">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm..." name="searchTerm" value="${searchTerm != null ? searchTerm : ''}">
                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
            </div>

            <div class="mb-3">
                <label for="statusSelect" class="mr-2">Chọn Trạng thái:</label>
                <select id="statusSelect" name="status" class="form-control" style="width: 200px; display: inline;" onchange="submitFilterForm()">
                    <option value="all" ${status == null || status == 'all' ? 'selected' : ''}>Tất cả</option>
                    <option value="Waiting" ${status == 'Waiting' ? 'selected' : ''}>Waiting</option>
                    <option value="Accepted" ${status == 'Accepted' ? 'selected' : ''}>Accepted</option>
                </select>

                <label for="storeSelect" class="mr-2">Chọn Store:</label>
                <select id="storeSelect" name="storeId" class="form-control" style="width: 200px; display: inline;" onchange="submitFilterForm()">
                    <option value="0" ${storeId == null || storeId == 0 ? 'selected' : ''}>Tất cả</option>
                    <c:forEach var="store" items="${stores}">
                        <option value="${store.id}" ${storeId != null && store.id == storeId ? 'selected' : ''}>${store.name}</option>
                    </c:forEach>
                </select>
            </div>
		    <script>
			    function submitFilterForm() {
			        document.getElementById('filterForm').submit();
			    }
			</script>		    
		</form>

        <div class="table-container">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Thương Hiệu</th>
                        <th>Mô Tả</th>
                        <th>Giá</th>
                        <th>Giá Khuyến Mãi</th>
                        <th>Đang Bán</th>
                        <th>Trạng Thái</th>
                        <th>Danh Mục</th>
                        <th>Đánh Giá</th>
                        <th>Ngày Tạo</th>
                        <th>Ngày Cập Nhật</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>
				                <img src="${product.imageUrls != null && !product.imageUrls.isEmpty() ? product.imageUrls[0] : '/images/default.png'}" 
							     alt="Ảnh chính" 
							     style="width: 100px; height: 100px;">
				            </td>
                            <td>${product.name}</td>
                            <td>${product.brand}</td>
                            <td>${product.description}</td>
                            <td>
							    <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
							</td>
							<td>
							    <fmt:formatNumber value="${product.promotionalPrice}" pattern="#,##0" />đ
							</td>
                            <!-- Thay thế Có/Không bằng icon -->
                            <td>
                                <c:choose>
                                    <c:when test="${product.isSelling}">
                                        <i class="fas fa-check-circle" style="color: green;"></i> <!-- Icon tích màu xanh -->
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-times-circle" style="color: red;"></i> <!-- Icon chéo màu đỏ -->
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                            	<!-- Nút tích/chéo chỉ xuất hiện khi trạng thái là Waiting -->
                                <c:if test="${product.status == 'Waiting'}">
                                    <form action="/admin/stores/accept/${product.id}" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-success"><i class="fas fa-check-circle"></i> Accept</button>
                                    </form>
                                    <form action="/admin/stores/reject/${product.id}" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-danger"><i class="fas fa-times-circle"></i> Reject</button>
                                    </form>
                                </c:if>
                            </td>
                            <td>${product.category.name}</td>
                            <td>${product.rating}</td>
                            <td>${product.createat}</td>
                            <td>${product.updateat}</td>
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
