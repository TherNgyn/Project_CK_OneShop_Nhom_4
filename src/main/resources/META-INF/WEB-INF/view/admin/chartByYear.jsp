<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        #myChartContainer {
            width: 80%;
            margin: 20px auto;
            text-align: center;
        }
    </style>

    <!-- Phần tử canvas để hiển thị biểu đồ -->
    <div id="myChartContainer">
        <canvas id="myChart"></canvas>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const labels = ${yearlyRevenueLabels};  // Lấy dữ liệu nhãn năm
            const dataValues = ${yearlyRevenueValues};  // Lấy dữ liệu doanh thu theo năm

            const ctx = document.getElementById('myChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu theo năm',
                        data: dataValues,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: ''
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
    
    <div style="text-align: center; margin-bottom: 40px;">
	    <h2 style="font-size: 36px; font-weight: 600; color: #333; letter-spacing: 1px; font-family: 'Roboto', sans-serif; 
	               text-transform: uppercase; margin-bottom: 10px;">
	        Biểu đồ doanh thu theo năm
	    </h2>
	</div>
</body>
</html>
