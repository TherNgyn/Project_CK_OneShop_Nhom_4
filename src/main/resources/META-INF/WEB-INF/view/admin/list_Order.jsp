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
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            background-color: #f8f9fa;
        }


        .section-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            background: linear-gradient(90deg, #007BFF, #00C6FF);
            -webkit-background-clip: text;
            color: transparent;
            margin-bottom: 30px;
            margin-top: 50px;
            text-transform: uppercase;
            letter-spacing: 3px;
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

        .input-group {
            max-width: 600px;
            margin: 0 auto 20px;
        }

        .btn {
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 4px;
            margin-right: 5px;
            transition: background-color 0.3s, opacity 0.3s;
        }
        h2 .btn {
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
    </style>

    <h2 class="section-title">Danh Sách Đơn Hàng</h2>

    <form action="/admin/orders" method="get" class="mb-3" id="filterForm">
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Tìm kiếm..." name="searchTerm" value="${searchTerm != null ? searchTerm : ''}">
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </div>

        <div class="mb-3">
            <label for="statusSelect" class="mr-2">Trạng thái:</label>
            <select id="statusSelect" name="status" class="form-control" style="width: 250px; display: inline;" onchange="submitFilterForm()">
                <option value="all" ${status == null || status == 'all' ? 'selected' : ''}>Tất cả</option>
                <option value="Processing_1" ${status == 'Processing_1' ? 'selected' : ''}>Chưa thanh toán</option>
                <option value="Processing_2" ${status == 'Processing_2' ? 'selected' : ''}>Chưa duyệt thanh toán</option>
                <option value="Preparing_1" ${status == 'Preparing_1' ? 'selected' : ''}>Đang chuẩn bị hàng</option>
                <option value="Preparing_2" ${status == 'Preparing_2' ? 'selected' : ''}>Đã thanh toán và đang chuẩn bị hàng</option>
                <option value="In Transit_1" ${status == 'In Transit_1' ? 'selected' : ''}>Đang vận chuyển (Chưa thanh toán)</option>
                <option value="In Transit_2" ${status == 'In Transit_2' ? 'selected' : ''}>Đang vận chuyển (Đã thanh toán)</option>
                <option value="Completed" ${status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
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
                    <th>Tên Khách Hàng</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Trạng Thái</th>
                    <th>Ngày Tạo</th>
                    <th>Tổng Tiền</th>
                    <th> Thao Tác </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.user.firstName} ${order.user.lastName }</td>
                        <td>${order.phone}</td>
                        <td>${order.address.addressLine1} ${order.address.addressLine2} ${order.address.city}</td>
                        <td>
						    <!-- Nút tích/chéo chỉ xuất hiện khi trạng thái là Processing_2 -->
						    <c:if test="${order.status == 'Processing_2'}">
						        <div class="d-flex justify-content-start">
						            <form action="/admin/orders/accept/${order.id}" method="post" style="display:inline;">
						                <button type="submit" class="btn btn-success mr-2">
						                    <i class="fas fa-check-circle"></i>
						                </button>
						            </form>
						            <form action="/admin/orders/reject/${order.id}" method="post" style="display:inline;">
						                <button type="submit" class="btn btn-danger">
						                    <i class="fas fa-times-circle"></i> 
						                </button>
						            </form>
						        </div>
						    </c:if>
						    <c:if test="${order.status != 'Processing_2'}">
						        ${order.status}
						    </c:if>
						</td>
                        <td>${order.createat}</td>
                        <td>
							 <fmt:formatNumber value="${order.price}" pattern="#,##0" />đ
						</td>
						<td class="action-column">                        
				            <a href="/admin/orders/${order.id}" class="btn btn-warning btn-sm mr-2" style="display:; margin-bottom: 5px;">Xem sản phẩm</a>   
				        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="5" class="text-center text-muted">Không có dữ liệu</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
