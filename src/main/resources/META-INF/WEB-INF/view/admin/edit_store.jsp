<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
	
<style>
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
</style>	
	
    <div class="container mt-5">
        <h2 class="section-title">Chỉnh Sửa Cửa Hàng</h2>
        <form action="/admin/stores/edit/${store.id}" method="post">
            <div class="form-group">
                <label for="name">Tên Store</label>
                <input type="text" class="form-control" id="name" name="name" value="${store.name}" required>
            </div>
            <div class="form-group">
                <label for="bio">Mô tả</label>
                <textarea class="form-control" id="bio" name="bio" rows="4">${store.bio}</textarea>
            </div>
            <div class="form-group">
		        <label for="avatar" class="form-label">Đường dẫn ảnh (URL)</label>
    			<input type="text" class="form-control" id="avatar" name="avatar" value="${store.avatar}" placeholder="Nhập đường dẫn ảnh">
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
            <div class="form-group">
		        <label for="featuredimages" class="form-label">Hình ảnh nổi bật</label>
    			<input type="text" class="form-control" id="featuredimages" name="featuredimages" value="${store.featuredimages}" placeholder="Nhập đường dẫn ảnh">
		    	<script type="text/javascript">
			    	document.getElementById('featuredimages').addEventListener('input', function () {
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
            <div class="form-group">
                <label for="isactive">Trạng thái</label>
                <select class="form-control" id="isactive" name="isactive">
                    <option value="true" ${store.isactive ? 'selected' : ''}>Kích hoạt</option>
                    <option value="false" ${!store.isactive ? 'selected' : ''}>Không kích hoạt</option>
                </select>
            </div>
            <div class="form-group">
                <label for="rating">Đánh giá</label>
                <input type="number" class="form-control" id="rating" name="rating" value="${store.rating}" min="0"
                    max="5" step="0.1" disabled>
            </div>
            <div class="form-group">
                <label for="createat">Ngày tạo</label>
                <input type="text" class="form-control" id="createat" name="createat" value="${store.createat}" disabled>
            </div>
            <div class="form-group">
                <label for="updateat">Ngày cập nhật</label>
                <input type="text" class="form-control" id="updateat" name="updateat" value="${store.updateat}" disabled>
            </div>
            <div class="form-group">
		        <label for="ownerid">Owner ID</label>
		        <input type="text" class="form-control" id="ownerid" name="user.id" value="${store.user.id}" disabled/>
		    </div>
            <button type="submit" class="btn btn-primary">Cập nhật</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
