<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
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
	    #myChartContainer {
            width: 80%;
            margin: 20px auto;
            text-align: center;
        }
        /* Cải thiện kiểu dáng của select */
    </style>
    
    <h2 class="section-title">Biểu đồ doanh thu trong tháng theo năm</h2>
	
	<div style="text-align: center; margin: 20px; font-family: 'Arial', sans-serif;">
	    <!-- Dropdown list chọn năm -->
	    <div style="display: flex; align-items: center; justify-content: center;">
	        <label for="yearSelect" style="font-size: 18px; color: #333; font-weight: bold; margin-right: 20px;">Chọn năm:</label>
	        <select id="yearSelect" name="year" onchange="window.location.href=this.value" 
	                style="padding: 12px 20px; font-size: 16px; border-radius: 8px; border: 1px solid #ddd; background-color: #fff; 
	                width: 180px; transition: background-color 0.3s, box-shadow 0.3s;">
	            <c:forEach var="year" items="${years}">
	                <option value="/admin/monthly-revenue?year=${year}" ${year.toString() == selectedYear.toString() ? 'selected' : ''}>${year}</option>
	            </c:forEach>
	        </select>
	    </div>
	</div>
	
	<!-- Hover effect via inline CSS for demonstration -->
	<style>
	    #yearSelect:hover {
	        background-color: #f1f1f1;
	        border-color: #ccc;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	    }
	
	    #yearSelect:focus {
	        border-color: #9c27b0;
	        outline: none;
	    }
	</style>

    <!-- Phần tử canvas để hiển thị biểu đồ -->
    <div id="myChartContainer">
        <canvas id="myChart"></canvas>
    </div>

	<script>

	    document.addEventListener("DOMContentLoaded", function () {
	        const labels = ${monthlyRevenueLabels};
	        const dataValues = ${monthlyRevenueValues};
	
	        const ctx = document.getElementById('myChart').getContext('2d');
	        new Chart(ctx, {
	            type: 'bar',
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
	
</body>
</html>
