<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<title>Manage Products</title>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content ">
    <!-- BEGIN HEADER -->
    <div class="page-header navbar navbar-fixed-top"></div>
    <!-- END HEADER -->
    <div class="clearfix"></div>
    <!-- BEGIN CONTAINER -->
    <div class="page-container">
        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <div class="page-content">
                <!-- BEGIN PAGE CONTENT-->
                <div class="row">
                    <div class="col-md-12">
                        <!-- Begin: life time stats -->
                        <div class="portlet">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-gift"></i>Sản phẩm
                                </div>
                            </div>

                            <div class="portlet-body">
                                <div class="table-container" style="">
                                    <div id="datatable_products_wrapper"
                                        class="dataTables_wrapper dataTables_extended_wrapper no-footer">
                                        
                                        <div class="row">
                                            <div class="col-md-8 col-sm-12">
                                                <div class="dataTables_paginate paging_bootstrap_extended"
                                                    id="datatable_products_paginate"></div>
                                                <div class="dataTables_length"
                                                    id="datatable_products_length"></div>
                                                <div class="dataTables_info" id="datatable_products_info"
                                                    role="status" aria-live="polite"></div>
                                            </div>
                                            <div class="col-md-4 col-sm-12">
                                                <div class="table-group-actions pull-right">
                                                    <span> </span>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="container mt-5">
                                            <h3>Cập nhật sản phẩm</h3>
                                            <form action="/vendor/manageproduct/updatesave/${product.id}" method="POST" enctype="multipart/form-data">
                                                <table class="table table-bordered">
                                                    <tbody>
                                                        <tr>
                                                            <th>ID Sản phẩm:</th>
                                                            <td><input type="text" class="form-control"
                                                                name="id" value="${product.id}" readonly></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Tên sản phẩm:</th>
                                                            <td><input type="text" class="form-control"
                                                                name="name" value="${product.name}" required></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Danh mục:</th>
                                                            <td><select class="form-control" name="category.id"
                                                                required>
                                                                    <c:forEach var="category" items="${categories}">
                                                                        <option value="${category.id}"
                                                                            ${product.category.id == category.id ? 'selected' : ''}>
                                                                            ${category.name}</option>
                                                                    </c:forEach>
                                                            </select></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Giá:</th>
                                                            <td><input type="number" class="form-control"
                                                                name="price"
                                                                value="<fmt:formatNumber value='${product.price}' type='number' pattern='###.##' />"
                                                                required></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Giá khuyến mãi:</th>
                                                            <td><input type="number" class="form-control"
                                                                name="promotionalPrice"
                                                                value="<fmt:formatNumber value='${product.promotionalPrice}' type='number' pattern='###.##' />"
                                                                required></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Số lượng:</th>
                                                            <td><input type="number" class="form-control"
                                                                name="quantity" value="${product.quantity}" required></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Thương hiệu:</th>
                                                            <td>
                                                                <select class="form-control" id="brandSelect" name="brandSelect" onchange="toggleBrandInput()">
                                                                    <option value="">Chọn thương hiệu</option>
                                                                    <c:forEach var="brand" items="${brands}">
                                                                        <option value="${brand}" ${product.brand == brand ? 'selected' : ''}>${brand}</option>
                                                                    </c:forEach>
                                                                    <option value="other">Khác</option>
                                                                </select>
                                                                <input type="text" class="form-control mt-2" id="brandInput" name="brand" value="${product.brand}" placeholder="Nhập thương hiệu mới" style="display: none;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Trạng thái:</th>
                                                            <td><select class="form-control" name="isSelling">
                                                                    <option value="true"
                                                                        ${product.isSelling ? 'selected' : ''}>Đang
                                                                        bán</option>
                                                                    <option value="false"
                                                                        ${!product.isSelling ? 'selected' : ''}>Ngừng
                                                                        bán</option>
                                                            </select></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Mô tả:</th>
                                                            <td><textarea class="form-control"
                                                                    name="description" rows="4">${product.description}</textarea></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Hình ảnh chính:</th>
                                                            <td>
                                                                <input type="file" class="form-control-file" name="image" onchange="previewMainImage(event)">
                                                                <c:forEach var="image" items="${product.images}">
                                                                    <c:if test="${image.isMain}">
                                                                        <img id="mainImagePreview" src="${image.imageUrl}" alt="${product.name}" class="img-thumbnail mt-2" width="150">
                                                                    </c:if>
                                                                </c:forEach>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Các hình ảnh khác:</th>
                                                            <td>
                                                                <input type="file" class="form-control-file" name="additionalImages" multiple onchange="previewAdditionalImages(event)">
                                                                <div id="additionalImagesPreview">
                                                                    <c:forEach var="image" items="${product.images}">
                                                                        <c:if test="${!image.isMain}">
                                                                            <div class="image-item">
                                                                                <img src="${image.imageUrl}" alt="${product.name}" class="img-thumbnail mt-2" width="150" data-image-url="${image.imageUrl}">
                                                                                <button type="button" class="delete-btn" onclick="removeImage(this, 'additional', '${image.imageUrl}')">X</button>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <input type="hidden" name="removedImages" id="removedImages" value="">
                                                
                                                <div class="text-right">
                                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                    <a href="/vendor/manageproduct" class="btn btn-secondary">Hủy</a>
                                                </div>
                                            </form>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End: life time stats -->
                    </div>
                </div>
                <!-- END PAGE CONTENT-->
            </div>
        </div>
        <!-- END CONTENT -->
    </div>

<script>
function toggleBrandInput() {
    var brandSelect = document.getElementById("brandSelect");
    var brandInput = document.getElementById("brandInput");
    if (brandSelect.value === "other") {
        brandInput.style.display = "block";
        brandInput.value = ""; // Clear the input field
    } else {
        brandInput.style.display = "none";
        brandInput.value = brandSelect.value; // Set the input field value to the selected brand
    }
}

// Initial check to display the brand input if the selected value is "other"
window.onload = function() {
    var brandSelect = document.getElementById("brandSelect");
    var brandInput = document.getElementById("brandInput");
    if (brandSelect.value === "other" || brandSelect.value === "") {
        brandInput.style.display = "block";
    } else {
        brandInput.style.display = "none";
    }
};

function previewMainImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('mainImagePreview');
        output.src = reader.result; // Set the image preview to the selected file
    };
    reader.readAsDataURL(event.target.files[0]);
}

function previewAdditionalImages(event) {
    var previewContainer = document.getElementById('additionalImagesPreview');
    previewContainer.innerHTML = ''; // Clear the previous previews

    // Loop through the selected files
    for (var i = 0; i < event.target.files.length; i++) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var img = document.createElement('img');
            img.src = e.target.result; // Set the image source to the FileReader result (the image content)
            img.classList.add('img-thumbnail', 'mt-2');
            img.width = 150;
            previewContainer.appendChild(img); // Add the new image to the preview container
        };
        reader.readAsDataURL(event.target.files[i]); // Read the file as a Data URL
    }
}

function removeImage(button, imageType, imageUrl) {
    // Kiểm tra nếu là ảnh chính thì không xóa
    if (imageType === 'main' || !imageUrl) {
        alert('Không thể xóa ảnh chính!');
        return;
    }

    // Ẩn ảnh
    const imageItem = button.closest('.image-item');
    imageItem.style.display = 'none';

    // Đánh dấu ảnh bị xóa
    let removedImages = document.getElementById('removedImages');
    const currentRemovedImages = removedImages.value ? removedImages.value.split(',') : [];
    currentRemovedImages.push(imageUrl);
    removedImages.value = currentRemovedImages.join(',');
}
</script>
</body>