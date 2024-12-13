<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*" %>

<form action="/vendor/savedecoration" method="post" enctype="multipart/form-data">
    <input type="hidden" name="storeId" value="${store.id}" />
    <input type="hidden" name="loggedInUser" value="${loggedInUser}" />
    <!-- Shop Name -->
    <div class="form-group">
        <label for="storeName">Shop Name</label>
        <input type="text" class="form-control" id="storeName" name="storeName" value="${store.name}" required>
    </div>

    <!-- Shop Description -->
    <div class="form-group">
        <label for="storeDescription">Shop Description</label>
        <textarea class="form-control" id="storeDescription" name="storeDescription" rows="4">${store.bio}</textarea>
    </div>

    <!-- Featured Image -->
    <div class="form-group">
        <label for="storeImage">Featured Image</label>
        <input type="file" class="form-control" id="storeImage" name="storeImage">
        <img src="${store.featuredimages}" alt="Current Image" class="img-fluid mt-3" style="max-width: 150px;">
    </div>

    <%-- <!-- Social Media Links -->
    <div class="form-group">
        <label for="facebook">Facebook</label>
        <input type="url" class="form-control" id="facebook" name="facebook" value="${store.facebook}" />
    </div>

    <div class="form-group">
        <label for="twitter">Twitter</label>
        <input type="url" class="form-control" id="twitter" name="twitter" value="${store.twitter}" />
    </div>

    <div class="form-group">
        <label for="instagram">Instagram</label>
        <input type="url" class="form-control" id="instagram" name="instagram" value="${store.instagram}" />
    </div>
 --%>
    <!-- Store Open Status -->
    <div class="form-group">
        <label for="storeStatus">Store Status</label>
        <select class="form-control" id="storeStatus" name="storeStatus">
            <option value="active" ${store.isactive ? 'selected' : ''}>Active</option>
            <option value="inactive" ${!store.isactive ? 'selected' : ''}>Inactive</option>
        </select>
    </div>

    <button type="submit" class="common_btn">Save Changes</button>
</form>
