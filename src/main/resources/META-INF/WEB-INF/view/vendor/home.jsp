<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:url value="/" var="URL"></c:url>
    <title>Home Vendor</title>
<body>
    <!-- Sidebar -->
	<div class="sidebar">
	<div class="title">Menu</div>
	<ul>
		<li><a href="/user/home"><i class="fas fa-home"></i> Trang chủ người dùng</a></li>
		<li><a class="wsus__droap_arrow" href="/vendor/decorate/${user.store.id}"><i
								class="fal fa-tshirt"></i> Quản lý cửa hàng</a>
		</li>
		<li><a href="/vendor/manageproduct"><i class="fas fa-box"></i> Quản lý sản phẩm</a></li>
		<li><a href="/vendor/manageorder"><i class="fas fa-shopping-cart"></i> Quản lý
				đơn hàng</a></li>
		<li><a href="/vendor/managerevenue"><i class="fas fa-chart-line"></i> Quản lý
				doanh thu</a></li>
	</ul>
	</div>
	<!-- Nội dung -->
	<div class="content">
		<!-- Dashboard -->
		<div class="row my-3">
			<div class="col-md-3">
				<div class="card text-white bg-primary mb-3">
					<div class="card-header">Doanh Thu Hôm Nay</div>
					<div class="card-body">
						<h5 class="card-title">
							<fmt:formatNumber value="${todayRevenue}" type="currency"
								currencySymbol="đ" />
						</h5>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-white bg-success mb-3">
					<div class="card-header">Đơn Hàng Mới</div>
					<div class="card-body">
						<h5 class="card-title">${newOrderCount} Đơn</h5>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-white bg-danger mb-3">
					<div class="card-header">Đơn Hàng Chờ Xử Lý</div>
					<div class="card-body">
						<h5 class="card-title">${pendingOrders} Đơn</h5>
					</div>
				</div>
			</div>
		</div>

		<!-- Đơn hàng mới nhất và sản phẩm gần hết hàng -->
		<div class="row my-3">
			<div class="col-md-6">
    <h4>Đơn Hàng Mới Nhất</h4>
    <table class="table table-striped">
        <thead>
            <tr>
               
                <th>Ngày Đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng Thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${latestOrders}">
                <tr>                  
                   <td> <fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" /></td>
                    <td><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" /></td>
                    <td>${order.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
			<div class="col-md-6">
    <h4>Sản Phẩm Gần Hết Hàng</h4>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Tên Sản Phẩm</th>
                <th>Số Lượng</th>
            </tr>
        </thead>
        <tbody>
            <!-- Dùng c:forEach để lặp qua danh sách lowInventoryProducts -->
            <c:forEach var="product" items="${lowInventoryProducts}">
                <tr>
                    <td>${product.name}</td> <!-- Hiển thị tên sản phẩm -->
                    <td>${product.quantity}</td>    <!-- Hiển thị số lượng -->
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
		</div>
	</div>

</body>