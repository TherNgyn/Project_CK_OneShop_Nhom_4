<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Thư viện Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Định dạng biểu đồ */
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
        // Chuyển đổi dữ liệu từ model thành JSON cho JavaScript
        const labels = ${monthlyRevenueLabels};
        const dataValues = ${monthlyRevenueValues};

        // Khởi tạo biểu đồ
        const ctx = document.getElementById('myChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar', // Kiểu biểu đồ: cột (bar), đường (line), tròn (pie)...
            data: {
                labels: labels,
                datasets: [{
                    label: 'Doanh thu theo tháng',
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
                responsive: true, // Tự động điều chỉnh theo kích thước màn hình
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Biểu đồ Doanh thu theo Tháng Trong Năm'
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

</body>
</html>
