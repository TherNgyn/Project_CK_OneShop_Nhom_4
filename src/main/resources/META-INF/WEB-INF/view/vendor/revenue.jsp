<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý doanh thu</title>
</head>
<body>
	<div class="col-md-6">
    <h4>Doanh Thu</h4>
    <div class="card text-white bg-info mb-3">
        <div class="card-header">Tổng Doanh Thu</div>
        <div class="card-body">
            <h5 class="card-title"><fmt:formatNumber value="${revenue}" type="currency" currencySymbol="₫" /></h5>
        </div>
    </div>
    
    <div class="col-md-12">
        <h4>Chi Tiết Doanh Thu</h4>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID Đơn Hàng</th>
                    <th>Tên Khách Hàng</th>
                    <th>Ngày Đặt</th>
                    <th>Tổng Tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                       <td>${order.id}</td> 
                       <td>${order.user.username}</td>
                       <td> <fmt:formatDate value="${order.createAtAsDate}" pattern="dd/MM/yyyy" /></td>
                    <td><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" /></td>
                    
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- Biểu đồ thống kê -->
    <%-- <div class="row my-3">
        <div class="col-md-6">
            <h4>Doanh Thu Theo Thời Gian</h4>
            <canvas id="revenueChart"></canvas>
        </div>
    </div>

</div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueData = {
                labels: [
                    <c:forEach var="data" items="${revenueData}">
                        '${data.date}',
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Doanh Thu',
                    data: [
                        <c:forEach var="data" items="${revenueData}">
                            ${data.totalAmount},
                        </c:forEach>
                    ],
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            };

            var revenueChart = new Chart(ctx, {
                type: 'line',
                data: revenueData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script> --%>
</body>