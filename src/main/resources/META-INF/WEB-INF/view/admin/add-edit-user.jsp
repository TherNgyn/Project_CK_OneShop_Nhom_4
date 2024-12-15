<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
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
		<h2 class="section-title">THÔNG TIN NGƯỜI DÙNG</h2>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <div class="alert alert-warning" role="alert" style="${error != null && error.trim().length() > 0 ? '' : 'display: none;'}">
			${error}
		</div>

        <form action="/admin/users/save" method="post" enctype="multipart/form-data">
		    <input type="hidden" name="id" value="${user.id}">
		    
		    <div class="mb-3">
		        <label for="firstName" class="form-label">Họ</label>
		        <input type="text" class="form-control" id="firstName" name="firstName" value="${user.firstName}" >
		    </div>
		
		    <div class="mb-3">
		        <label for="lastName" class="form-label">Tên</label>
		        <input type="text" class="form-control" id="lastName" name="lastName" value="${user.lastName}" >
		    </div>
		
		    <div class="mb-3">
		        <label for="email" class="form-label">Email</label>
		        <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
		    </div>
		
		    <div class="mb-3">
		        <label for="username" class="form-label">Tên người dùng</label>
		        <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
		    </div>
		
		    <div class="mb-3">
		        <label for="phone" class="form-label">Điện thoại</label>
		        <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" required>
		    </div>
		
		    <div class="mb-3">
		        <label for="address" class="form-label">Địa chỉ</label>
		        <input type="text" class="form-control" id="address" name="address" value="${user.address}" required>
		    </div>
		
		    <div class="mb-3">
		        <label for="avatar" class="form-label">Đường dẫn ảnh (URL)</label>
    			<input type="text" class="form-control" id="avatar" name="avatar" value="${user.avatar}" placeholder="Nhập đường dẫn ảnh">
		    	<script type="text/javascript">
			    	document.getElementById('avatar').addEventListener('input', function () {
			    	    const url = this.value;
			    	    const isValidUrl = /^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$/i.test(url);
			    	    if (!isValidUrl && url != null) {
			    	        this.setCustomValidity('Vui lòng nhập đường dẫn URL hợp lệ.');
			    	    } else {
			    	        this.setCustomValidity('');
			    	    }
			    	});
		    	</script>
		    </div>
		
		    <div class="mb-3">
		        <label for="role" class="form-label">Vai trò</label>
		        <select id="role" name="role" class="form-select" required>
		            <option value="ROLE_USER" ${user.role == 'ROLE_USER' ? 'selected' : ''}>Người dùng</option>
		            <option value="ROLE_VENDOR" ${user.role == 'ROLE_VENDOR' ? 'selected' : ''}>Nhà cung cấp</option>
		            <option value="ROLE_DELIVERY" ${user.role == 'ROLE_DELIVERY' ? 'selected' : ''}>Giao hàng</option>
		        </select>
		    </div>
		
		    <div class="mb-3">
		        <label for="isActive" class="form-label">Trạng thái</label>
		        <input type="checkbox" id="isActive" name="isActive" ${user.isActive ? 'checked' : ''}>
		        <label for="isActive" class="form-check-label">Kích hoạt</label>
		    </div>
		
		    <button type="submit" class="btn btn-primary">Lưu</button>
		    <a href="/admin/users" class="btn btn-secondary">Quay lại</a>
		</form>

    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
