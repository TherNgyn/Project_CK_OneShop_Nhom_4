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
    <title>One Shop || e-Commerce HTML Template</title>
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
	<!-- <link rel="stylesheet" href="${URL}template/css/rtl.css"> -->
</head>
<!-- Head END -->

    <!-- BEGIN HEADER -->
    <%@ include file = "/commons/web/header.jsp" %>
    <!-- END HEADER -->
    
    <div class="main"> 
        <div class="container">
             <sitemesh:write property="body"/>
        </div>
    </div>
    
    <!-- BEGIN FOOTER -->
    <%@ include file = "/commons/web/footer.jsp" %>
    <!-- END FOOTER -->
    
   
