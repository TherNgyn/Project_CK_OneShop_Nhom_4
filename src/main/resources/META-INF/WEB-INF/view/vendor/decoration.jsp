<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*" %>
<title>Cập nhật cửa hàng</title>
<form action="/vendor/savedecoration" method="post" enctype="multipart/form-data">
    <input type="hidden" name="storeId" value="${store.id}" />
    <input type="hidden" name="loggedInUser" value="${loggedInUser}" />
    
    <!-- Shop Name -->
    <div class="form-group">
        <label for="storeName">Tên cửa hàng</label>
        <input type="text" class="form-control" id="storeName" name="storeName" value="${store.name}" required>
    </div>

    <!-- Shop Description -->
    <div class="form-group">
        <label for="storeDescription">Mô tả</label>
        <textarea class="form-control" id="storeDescription" name="storeDescription" rows="4">${store.bio}</textarea>
    </div>

    <!-- Featured Image -->
    <div class="form-group">
        <label for="storeImage">Ảnh nổi bật</label>
        <input type="file" class="form-control" id="storeImage" name="storeImage">
        <img src="${store.featuredimages}" alt="Current Image" class="img-fluid mt-3" style="max-width: 150px;">
    </div>

    <!-- Avatar Image -->
    <div class="form-group">
        <label for="storeAvatar">Avatar</label>
        <input type="file" class="form-control" id="storeAvatar" name="storeAvatar" onchange="previewAvatarImage(event)">
        <img id="avatarImagePreview" src="${store.avatar}" alt="Current Avatar" class="img-fluid mt-3" style="max-width: 150px;">
    </div>

    <!-- Store Open Status -->
    <div class="form-group">
        <label for="storeStatus">Trạng thái cửa hàng</label>
        <select class="form-control" id="storeStatus" name="storeStatus">
            <option value="active" ${store.isactive ? 'selected' : ''}>Mở cửa</option>
            <option value="inactive" ${!store.isactive ? 'selected' : ''}>Đóng cửa</option>
        </select>
    </div>

    <button type="submit" class="common_btn">Lưu thay đổi</button>
</form>

<script>
function previewAvatarImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('avatarImagePreview');
        output.src = reader.result; // Set the image preview to the selected file
    };
    reader.readAsDataURL(event.target.files[0]);
}
</script>