<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/" var="URL"></c:url>
<!--<![endif]-->

<!-- Head BEGIN -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	<title><sitemesh:write property="title"/></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="icon" type="image/png" href="${URL}template/images/favicon.png">
	<link rel="stylesheet" href="${URL}template/css/all.min.css">
	<link rel="stylesheet" href="${URL}template/css/bootstrap.min.css">
	<link rel="stylesheet" href="${URL}template/css/select2.min.css">
	<link rel="stylesheet" href="${URL}template/css/slick.css">
	<link rel="stylesheet" href="${URL}template/css/jquery.nice-number.min.css">
	<link rel="stylesheet" href="${URL}template/css/jquery.calendar.css">
	<link rel="stylesheet" href="${URL}template/css/add_row_custon.css">
	<link rel="stylesheet" href="${URL}template/css/mobile_menu.css">
	<link rel="stylesheet" href="${URL}template/css/jquery.exzoom.css">
	<link rel="stylesheet" href="${URL}template/css/multiple-image-video.css">
	<link rel="stylesheet" href="${URL}template/css/ranger_style.css">
	<link rel="stylesheet" href="${URL}template/css/jquery.classycountdown.css">
	<link rel="stylesheet" href="${URL}template/css/venobox.min.css">
	<link rel="stylesheet" href="${URL}template/css/style.css">
	<link rel="stylesheet" href="${URL}template/css/responsive.css">
	<link rel="stylesheet" href="${URL}template/css/product_detail.css">
	<link rel="stylesheet" href="${URL}template/css/order_manager.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	

</head>
<!-- Head END -->
<%
    if (session.getAttribute("userRole") == null) {
        session.setAttribute("userRole", "GUEST");
    }
%>
<!-- BEGIN HEADER -->

    <c:choose>
        <c:when test="${sessionScope.userRole == 'ROLE_USER'}">
            <%@ include file = "/commons/user/header.jsp" %>
        </c:when>
        <c:when test="${sessionScope.userRole == 'ROLE_VENDOR'}">
            <%@ include file = "/commons/vendor/header.jsp" %>
        </c:when>
        <c:when test="${sessionScope.userRole == 'ROLE_ADMIN'}">
            <%@ include file = "/commons/admin/header.jsp" %>
        </c:when>
        <c:when test="${sessionScope.userRole == 'ROLE_SHIPPER'}">
            <%@ include file = "/commons/shipper/header.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file = "/commons/web/header.jsp" %>
        </c:otherwise>
    </c:choose>

<!-- END HEADER -->

    <!-- END HEADER -->
    
    <div class="main"> 
        <div class="container">
             <sitemesh:write property="body"/>
        </div>
    </div>
    
    <!-- BEGIN FOOTER -->
    <%@ include file = "/commons/web/footer.jsp" %>
    <!-- END FOOTER -->
    
 <!--jquery library js-->
    <script src="${URL}template/js/jquery-3.6.0.min.js"></script>
    <!--bootstrap js-->
    <script src="${URL}template/js/bootstrap.bundle.min.js"></script>
    <!--font-awesome js-->
    <script src="${URL}template/js/Font-Awesome.js"></script>
    <!--select2 js-->
    <script src="${URL}template/js/select2.min.js"></script>
    <!--slick slider js-->
    <script src="${URL}template/js/slick.min.js"></script>
    <!--simplyCountdown js-->
    <script src="${URL}template/js/simplyCountdown.js"></script>
    <!--product zoomer js-->
    <script src="${URL}template/js/jquery.exzoom.js"></script>
    <!--nice-number js-->
    <script src="${URL}template/js/jquery.nice-number.min.js"></script>
    <!--counter js-->
    <script src="${URL}template/js/jquery.waypoints.min.js"></script>
    <script src="${URL}template/js/jquery.countup.min.js"></script>
    <!--add row js-->
    <script src="${URL}template/js/add_row_custon.js"></script>
    <!--multiple-image-video js-->
    <script src="${URL}template/js/multiple-image-video.js"></script>
    <!--sticky sidebar js-->
    <script src="${URL}template/js/sticky_sidebar.js"></script>
    <!--price ranger js-->
    <script src="${URL}template/js/ranger_jquery-ui.min.js"></script>
    <script src="${URL}template/js/ranger_slider.js"></script>
    <!--isotope js-->
    <script src="${URL}template/js/isotope.pkgd.min.js"></script>
    <!--venobox js-->
    <script src="${URL}template/js/venobox.min.js"></script>
    <!--classycountdown js-->
    <script src="${URL}template/js/jquery.classycountdown.js"></script>

    <!--main/custom js-->
    <script src="${URL}template/js/main.js"></script>