<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
    	html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            background-color: #f8f9fa;
        }
		
		/* Thêm margin dưới cho các container để cách xa footer */
		.container {
		    margin-bottom: 100px; /* Thêm khoảng trống dưới các container */
		}


        .navbar {
            background-color: #4CAF50;
        }

        .navbar a {
            color: white !important;
        }

        .dashboard-card {
            margin-top: 20px;
        }

        .chart-container {
            width: 100%;
            height: 400px;
        }

        .product-card {
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            margin: 10px 0;
            border-radius: 8px;
            padding: 20px;
            background-color: white;
        }

        .card-title {
            color: #4CAF50;
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product-item {
            width: 30%;
            margin-bottom: 20px;
        }
		
		/* Mỗi ô có màu gradient đậm dần */
		/* Căn bản cho tất cả các thẻ .card trong .dashboard-card */
		.dashboard-card .card {
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1) !important; /* Giữ bóng đổ nhẹ */
		    border-radius: 10px !important; /* Bo góc nhẹ */
		    margin-bottom: 20px !important; /* Khoảng cách giữa các thẻ */
		}		
		.card-body {
		    font-family: 'Roboto', sans-serif !important;
		    padding: 20px !important;
		    text-align: center !important; /* Canh giữa nội dung */
		    color: #333333 !important; /* Màu chữ tối cho dễ đọc */
		}
		
		.card-title {
		    font-size: 18px !important;
		    font-weight: 600 !important;
		    margin-bottom: 10px !important; /* Khoảng cách giữa tiêu đề và nội dung */
		    color: #555555 !important; /* Màu chữ tiêu đề */
		}
		
		.card-text {
		    font-size: 16px !important;
		    font-weight: 500 !important;
		    color: #333333 !important; /* Màu chữ nội dung */
		}
		.card {
		    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease; /* Thêm hiệu ứng chuyển động */
		}
		
		.card:hover {
		    transform: translateY(-5px); /* Đẩy thẻ lên khi hover */
		    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* Thêm bóng đổ */
		}
		
		/* Gradient Background cho Navbar */
		.navbar {
		    background: linear-gradient(to right, #4CAF50, #81C784); /* Màu xanh lá nhẹ */
		}
		
		/* Màu sắc và hiệu ứng cho thẻ sản phẩm */
		.product-card {
		    background: #fff;
		    border-radius: 10px;
		    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		}
		
		.product-card:hover {
		    transform: translateY(-10px);
		    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
		}
		
		/* Thêm màu gradient cho các thẻ doanh thu */
		.bg-success {
		    background: linear-gradient(to right, #A8D5BA, #81C784);
		}
		
		.bg-primary {
		    background: linear-gradient(to right, #A2C2E8, #81A8D5);
		}
		
		.bg-warning {
		    background: linear-gradient(to right, #F7D28C, #F0C048);
		}
		
		.bg-danger {
		    background: linear-gradient(to right, #F4B6A1, #F09383);
		}
		
		/* Chỉnh sửa bố cục với CSS Grid */
		.product-list {
		    display: grid;
		    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* Sử dụng Grid để linh hoạt hơn */
		    gap: 20px;
		    justify-items: center;
		}
		.dashboard-card, #myChartContainer, .product-list {
		    margin-top: 20px;  /* Khoảng cách từ phần trên */
		    margin-bottom: 20px;  /* Khoảng cách từ phần dưới */
		}
		.product-list {
		    margin-bottom: 500px;  /* Tăng khoảng cách phía dưới */
		}
		.dashboard-card {
		    margin-top: 50px;   /* Tăng khoảng cách phía dưới */
		}
		.product-title {
		    height: 40px; /* Chiều cao cố định cho tiêu đề */
		    overflow: hidden; /* Ẩn nội dung vượt quá */
		    text-overflow: ellipsis; /* Thêm dấu "..." nếu nội dung quá dài */
		    white-space: nowrap; /* Không cho nội dung xuống dòng */
		}
		
		.product-description {
		    height: 60px; /* Chiều cao cố định cho mô tả */
		    overflow: hidden;
		    text-overflow: ellipsis;
		}				
		.product-list {
		    display: grid;
		    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Sản phẩm tự động căn chỉnh */
		    gap: 20px; /* Khoảng cách giữa các sản phẩm */
		}
		.product-title {
		    display: -webkit-box;
		    -webkit-line-clamp: 2; /* Số dòng tối đa muốn hiển thị */
		    -webkit-box-orient: vertical;
		    overflow: hidden; /* Ẩn nội dung vượt quá */
		    text-overflow: ellipsis; /* Thêm dấu "..." */
		}	
	    .section-title {
	        text-align: center;
	        font-size: 2.5rem; /* Kích thước chữ lớn */
	        font-weight: bold;
	        font-family: 'Raleway', sans-serif !important;
	        background: linear-gradient(90deg, #007BFF, #00C6FF); /* Gradient xanh dương đậm nhạt */
	        -webkit-background-clip: text; /* Chỉ áp dụng gradient cho chữ */
	        color: transparent; /* Ẩn màu mặc định */
	        text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2); /* Hiệu ứng đổ bóng nhẹ */
	        margin-bottom: 30px;
	        text-transform: uppercase; /* Chữ in hoa */
	        letter-spacing: 3px; /* Khoảng cách chữ */
	        position: relative;
	    }
	
	    /* Đường gạch ngang cách điệu */
	    .section-title::after {
	        content: "";
	        display: block;
	        width: 120px; /* Chiều dài đường gạch */
	        height: 4px; /* Độ dày đường gạch */
	        background: linear-gradient(90deg, #007BFF, #00C6FF); /* Gradient xanh dương */
	        margin: 10px auto 0; /* Căn giữa */
	        border-radius: 2px; /* Bo góc nhẹ */
	    }
	
	    /* Hiệu ứng phóng to nhẹ khi người dùng rê chuột */
	    .section-title:hover {
	        transform: scale(1.05); /* Phóng to nhẹ */
	        transition: transform 0.3s ease-in-out; /* Hiệu ứng mượt */
	    }
	        
	</style>

    <!-- Bảng điều khiển -->
    <div class="container dashboard-card">
	    <div class="row">
	        <div class="col-md-3">
	            <div class="card text-white bg-success">
	                <div class="card-body">
	                    <h5 class="card-title">Tổng sản phẩm</h5>
	                    <p class="card-text">${numProduct} sản phẩm</p>
	                </div>
	            </div>
	        </div>
	        <div class="col-md-3">
	            <div class="card text-white bg-primary">
	                <div class="card-body">
	                    <h5 class="card-title">Tổng đơn hàng</h5>
	                    <p class="card-text">${numOrder} đơn hàng</p>
	                </div>
	            </div>
	        </div>
	        <div class="col-md-3">
	            <div class="card text-white bg-warning">
	                <div class="card-body">
	                    <h5 class="card-title">Tổng khách hàng</h5>
	                    <p class="card-text">${numCustomer} khách hàng</p>
	                </div>
	            </div>
	        </div>
	        <div class="col-md-3">
	            <div class="card text-white bg-danger">
	                <div class="card-body">
	                    <h5 class="card-title">Doanh thu tháng này</h5>
	                    <p class="card-text">${thisMonthRevenue} VNĐ</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>


    <!-- Biểu đồ thống kê -->
    <!-- Thư viện Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Định dạng biểu đồ */
        #myChartContainer {
            width: 80%;
            margin: 10px auto;
            text-align: center;
        }
		        /* Tổng quan phần chứa */
		.chart-wrapper {
		    display: flex; /* Sắp xếp nội dung theo hàng ngang */
		    align-items: center; /* Căn giữa dọc */
		    gap: 20px; /* Khoảng cách giữa chữ và biểu đồ */
		    margin-top: 20px;
		    margin-bottom: 20px;
		}
		
		/* Phần chữ */
		.chart-text {
		    max-width: 300px; /* Giới hạn chiều rộng để tránh tràn */
		    color: #343a40; /* Màu chữ */
		    font-family: 'Roboto', sans-serif; /* Font chữ nhất quán */
		}
		
		.chart-text h2 {
		    font-size: 24px; /* Kích thước tiêu đề */
		    font-weight: 700; /* Độ đậm tiêu đề */
		    margin-bottom: 10px;
		}
		
		.chart-text p {
		    font-size: 16px; /* Kích thước chữ mô tả */
		    line-height: 1.6; /* Khoảng cách giữa các dòng */
		}
		
		/* Biểu đồ */
		.chart-canvas {
		    flex: 1; /* Biểu đồ chiếm phần còn lại của không gian */
		    max-width: 600px; /* Giới hạn chiều rộng */
		}
		@media (max-width: 768px) {
		    .chart-wrapper {
		        flex-direction: column; /* Chuyển từ hàng ngang sang cột */
		        text-align: center; /* Căn giữa chữ */
		    }
		    .chart-canvas {
		        max-width: 100%; /* Đảm bảo biểu đồ không tràn màn hình */
		    }
		}	
        
    </style>

    <!-- Phần tử chứa biểu đồ và chữ -->
	<div id="myChartContainer" class="chart-wrapper">
	    <div class="chart-text">
	        <h2 class="section-title">Biểu đồ doanh thu theo tháng</h2>
	        <p>Biểu đồ bên cạnh đây thể hiện doanh thu từng tháng trong năm nay, giúp nắm bắt xu hướng và đưa ra quyết định kinh doanh chính xác.</p>
	    </div>
	    <canvas id="myChart" class="chart-canvas"></canvas>
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
    
    <!-- End biểu đồ -->

	<!-- Danh sách sản phẩm mới -->
	    <div class="container product-list">
    		<h2 class="section-title">Top 4 sản phẩm mới gần đây</h2>
	        <div class="product-card">
		        <img src="${pic1}" class="card-img-top" alt="Son môi ABC">
		        <h5 class="card-title">${product1.name}</h5>
		        <p class="card-text">Giá: <fmt:formatNumber value="${product1.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</p>	        
		    </div>
	        <div class="product-card">
		        <img src="${pic2}" class="card-img-top" alt="Son môi ABC">
		        <h5 class="card-title">${product2.name}</h5>
		        <p class="card-text">Giá: <fmt:formatNumber value="${product2.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</p>
		    </div>
	        <div class="product-card">
		        <img src="${pic3}" class="card-img-top" alt="Son môi ABC">
		        <h5 class="card-title">${product3.name}</h5>
		        <p class="card-text">Giá: <fmt:formatNumber value="${product3.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</p>
		    </div>
		    <div class="product-card">
		        <img src="${pic4}" class="card-img-top" alt="Son môi ABC">
		        <h5 class="card-title">${product4.name}</h5>
		        <p class="card-text">Giá: <fmt:formatNumber value="${product4.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</p>
		    </div>
	    </div>  
	<script>
		document.addEventListener("DOMContentLoaded", () => {
			const productList = document.querySelector('.product-list');
	        
	        // Chỉ lấy các tiêu đề trong danh sách sản phẩm
	        const titles = productList.querySelectorAll('.card-title');
		    let maxHeight = 0;
	
		    // Tìm chiều cao lớn nhất
		    titles.forEach(title => {
		        if (title.offsetHeight > maxHeight) maxHeight = title.offsetHeight;
		    });
	
		    // Gán chiều cao lớn nhất cho tất cả tiêu đề
		    titles.forEach(title => {
		        title.style.height = maxHeight + 'px';
		    });
		});
	</script> 
    

    <!-- Bootstrap JS và Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
