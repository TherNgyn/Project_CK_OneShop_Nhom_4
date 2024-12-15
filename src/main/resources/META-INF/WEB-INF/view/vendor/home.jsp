<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<h5 class="card-title">10,000,000 VND</h5>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-white bg-success mb-3">
					<div class="card-header">Đơn Hàng Mới</div>
					<div class="card-body">
						<h5 class="card-title">5 Đơn</h5>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-white bg-warning mb-3">
					<div class="card-header">Sản Phẩm Còn Hàng</div>
					<div class="card-body">
						<h5 class="card-title">120 Sản phẩm</h5>
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

		<!-- Biểu đồ thống kê -->
		<div class="row my-3">
			<div class="col-md-6">
				<h4>Doanh Thu Theo Thời Gian</h4>
				<canvas id="revenueChart"></canvas>
			</div>
			<div class="col-md-6">
				<h4>Tỷ Lệ Bán Hàng Theo Danh Mục</h4>
				<canvas id="categoryChart"></canvas>
			</div>
		</div>

		<!-- Đơn hàng mới nhất và sản phẩm gần hết hàng -->
		<div class="row my-3">
			<div class="col-md-6">
				<h4>Đơn Hàng Mới Nhất</h4>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID Đơn Hàng</th>
							<th>Tên Khách Hàng</th>
							<th>Ngày Đặt</th>
							<th>Tổng Tiền</th>
							<th>Trạng Thái</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>#101</td>
							<td>Nguyễn Thị A</td>
							<td>12/12/2024</td>
							<td>500,000 VND</td>
							<td>Chờ xử lý</td>
						</tr>
						<tr>
							<td>#102</td>
							<td>Trần Văn B</td>
							<td>12/12/2024</td>
							<td>1,200,000 VND</td>
							<td>Đã giao</td>
						</tr>
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


	<!-- Thêm thư viện Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

    // Doanh thu theo thời gian
    var ctx1 = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctx1, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Doanh Thu',
                data: [10000000, 12000000, 8000000, 15000000, 13000000, 18000000],
                borderColor: 'rgb(75, 192, 192)',
                fill: false,
            }]
        }
    });

    // Dữ liệu từ backend
    var categoryData = JSON.parse('${categoryRevenue}');
    
    // Lấy labels và dữ liệu từ danh sách categoryRevenue
    var labels = categoryData.map(item => item.name);
    var data = categoryData.map(item => item.revenuePercentage);

    // Vẽ biểu đồ
    var ctx2 = document.getElementById('categoryChart').getContext('2d');
    new Chart(ctx2, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0', '#9966ff', '#c9cbcf']
            }]
        }
    });
</script>

</body>