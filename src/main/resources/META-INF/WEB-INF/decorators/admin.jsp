<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/" var="URL"></c:url>
<!--<![endif]-->

<!-- Head BEGIN -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densityDpi=device-dpi" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    
<title><sitemesh:write property="title"/></title>
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
	<%-- <link rel="stylesheet" href="${URL}template/css/rtl.css">  --%>
</head>
<!-- Head END -->

    <!-- BEGIN HEADER -->
    <%@ include file = "/commons/admin/header.jsp" %>
    <!-- END HEADER -->
    
    <div class="main"> 
        <div class="container">
             <sitemesh:write property="body"/>
        </div>
    </div>
    
    <!-- BEGIN FOOTER -->
    <%@ include file = "/commons/admin/footer.jsp" %>
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