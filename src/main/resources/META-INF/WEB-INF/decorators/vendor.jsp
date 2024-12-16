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
	<link rel="stylesheet" href="${URL}template/css/stylevendor.css">
	<link rel="stylesheet" href="${URL}template/css/responsive.css">
	<link rel="stylesheet" href="${URL}template/css/product_detail.css">
	<link rel="stylesheet" href="${URL}template/css/order_manager.css">
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
<link href="/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>

<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>

<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>

<link href="/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css"/>
<link href="/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>

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
    <!-- END CONTAINER -->

<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<script>
        jQuery(document).ready(function() {    
           Metronic.init(); // init metronic core components
Layout.init(); // init current layout
QuickSidebar.init(); // init quick sidebar
Demo.init(); // init demo features
           EcommerceProducts.init();
        });
    </script>
<!-- END JAVASCRIPTS --> 