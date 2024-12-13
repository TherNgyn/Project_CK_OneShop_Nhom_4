<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<form action="${pageContext.request.contextPath}/user/order/payment" method="POST" style="background: #fff; width: 100%; max-width: 500px; padding: 30px; margin: 40px auto; border-radius: 16px; 
             box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease, box-shadow 0.3s ease;">
    <!-- Tiêu đề -->
    <h3 style="text-align: center; font-size: 1.3rem; color: #000; margin-bottom: 20px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
        Chọn Phương Thức Thanh Toán
    </h3>

    <!-- Ship COD (Mặc định chọn) -->
    <div style="display: flex; align-items: center; margin-bottom: 20px;">
        <input type="radio" id="codPayment" name="paymentMethod" value="cod" 
               checked onchange="document.getElementById('qrContainer').style.display='none'" 
               required style="margin-right: 10px; accent-color: #333;">
        <label for="codPayment" style="font-size: 1rem; color: #555; cursor: pointer;">Thanh toán khi nhận hàng (Ship COD)</label>
    </div>

    <!-- Thanh toán ngay -->
    <div style="display: flex; align-items: center; margin-bottom: 20px;">
        <input type="radio" id="onlinePayment" name="paymentMethod" value="online" 
               onchange="document.getElementById('qrContainer').style.display='block'" 
               required style="margin-right: 10px; accent-color: #333;">
        <label for="onlinePayment" style="font-size: 1rem; color: #555; cursor: pointer;">Thanh toán ngay bằng mã</label>
    </div>

    <!-- QR Code Container -->
    <div id="qrContainer" style="display: none; text-align: center; margin-bottom: 20px;">
        <img id="qrImage" src="${paymentCode}" alt="QR Code" style="max-width: 100%; height: auto; border-radius: 12px; border: 1px solid #ccc;">
    </div>
    
    <button type="submit" 
            style="display: block; width: 100%; padding: 12px 20px; font-size: 1rem; font-weight: bold; color: #fff; 
                   background: #333; border: none; border-radius: 8px; text-align: center; cursor: pointer; 
                   transition: background 0.3s ease, transform 0.2s ease;"
            onmouseover="this.style.background='#000'; this.style.transform='scale(1.05)';"
            onmouseout="this.style.background='#333'; this.style.transform='scale(1)';"
            onmousedown="this.style.background='#555';">
        Xác nhận
    </button>
</form>