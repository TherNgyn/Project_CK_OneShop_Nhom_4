<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<div class="container">
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <h2 class="mt-4">Thêm Store Mới</h2>
    <form action="/admin/stores/add" method="post">
        <div class="form-group">
            <label for="name">Tên Store</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="bio">Mô tả</label>
            <textarea class="form-control" id="bio" name="bio"></textarea>
        </div>
        <div class="form-group">
            <label for="avatar">Avatar</label>
            <input type="text" class="form-control" id="avatar" name="avatar">
        </div>
        <div class="form-group">
            <label for="featuredImages">Hình ảnh nổi bật</label>
            <input type="text" class="form-control" id="featuredImages" name="featuredImages">
        </div>
        <div class="form-group">
            <label for="isActive">Trạng thái</label>
            <select class="form-control" id="isActive" name="isActive">
                <option value="true">Kích hoạt</option>
                <option value="false">Không kích hoạt</option>
            </select>
        </div>
        <div class="form-group">
            <label for="rating">Đánh giá</label>
            <input type="number" class="form-control" id="rating" name="rating" min="0" max="5">
        </div>
        <div class="form-group">
            <label for="ownerId">Owner ID</label>
            <input type="number" class="form-control" id="ownerId" name="ownerId">
        </div>
        <button type="submit" class="btn btn-primary">Thêm Store</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
