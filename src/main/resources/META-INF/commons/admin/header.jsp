<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<header>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
	<style>
		/* Đảm bảo menu không bị nới rộng */
		.wsus__menu_item {
		    display: flex;
		    flex-wrap: wrap; /* Cho phép các phần tử trong menu bao quanh nhau */
		    justify-content: space-evenly; /* Đảm bảo các phần tử có khoảng cách đều */
		    align-items: center;
		    width: 100%;
		}
		
		.wsus__menu_item li {
		    margin-right: 20px;
		    white-space: nowrap; /* Không cho chữ xuống dòng */
		}
		
		/* Cải thiện không gian giữa các phần tử */
		.wsus__menu_item li:last-child {
		    margin-right: 0;
		}
		
		/* Đảm bảo các nút có chiều rộng đủ lớn để chứa nội dung */
		.wsus__menu_item a {
		    padding: 5px 5px; /* Thêm padding để tạo không gian xung quanh chữ */
		}
		/* Đảm bảo chiều rộng của menu dropdown đủ lớn */
		.wsus__menu_item .wsus__menu_droapdown {
		    width: 250px; /* Cập nhật chiều rộng phù hợp với nội dung */
		    max-width: 100%;
		    min-width: 220px;
		}
		
		/* Đảm bảo menu không bị tràn */
		.wsus__menu_item .wsus__menu_droapdown li {
		    white-space: nowrap; /* Ngăn chặn việc cắt dòng trong menu */
		}
		
		/* Cải thiện chiều rộng của các menu chính */
		.wsus__menu_item .nav-link {
		    display: block;
		    white-space: nowrap; /* Ngăn chặn việc cắt dòng trong các mục chính */
		    overflow: hidden;
		    text-overflow: ellipsis;
		}	

	</style>


	<div class="container">
		<div class="row">
			<div class="col-2 col-md-1 d-lg-none">
				<div class="wsus__mobile_menu_area">
					<span class="wsus__mobile_menu_icon"><i class="fal fa-bars"></i></span>
				</div>
			</div>
			<div class="col-xl-2 col-7 col-md-8 col-lg-2">
				<div class="wsus_logo_area">
					<a class="wsus__header_logo" href="/admin/home"> <img
						src="/template/images/logo_2.png" alt="logo" class="img-fluid w-100">
					</a>
				</div>
			</div>
			<div class="col-xl-5 col-3 col-md-3 col-lg-6">
				<div class="wsus__call_icon_area">
					<div class="wsus__call_area">
						<div class="wsus__call">
							<i class="fas fa-user-headset"></i>
						</div>
						<div class="wsus__call_text">
							<p>thuquynhliti@gmail.com</p>
							<p>+84 0585281758</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</header>
<!--============================
        MAIN MENU START
    ==============================-->
    <nav class="wsus__main_menu d-none d-lg-block">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="relative_contect d-flex">
                        <div class="wsus_menu_category_bar">
                            <i class="far fa-bars"></i>
                        </div>

                        <ul class="wsus__menu_item">
						    <li class="nav-item">
						        <a class="nav-link" href="/admin/home">Home</a>
						    </li>    
						    <li class="wsus__relative_li">Cửa hàng và sản phẩm <i class="fas fa-caret-down"></i>
						        <ul class="wsus__menu_droapdown">
									<li><a class="nav-link" href="/admin/stores">Cửa hàng</a></li>
									<li><a class="nav-link" href="/admin/stores/listProduct">Sản phẩm</a></li>
								</ul>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link" href="/admin/orders">Đơn hàng</a>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link" href="/admin/users">Người dùng</a>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link" href="/admin/deliveries">Vận chuyển</a>
						    </li>
						    <li class="wsus__relative_li">Thống kê <i class="fas fa-caret-down"></i>
								<ul class="wsus__menu_droapdown">
									<li><a class="nav-link" href="/admin/monthly-revenue">Doanh thu theo tháng</a></li>
									<li><a class="nav-link" href="/admin/yearly-revenue">Doanh thu theo năm</a></li>
								</ul>
							</li>
						    <c:choose>
						        <c:when test="${not empty sessionScope.userRole && sessionScope.userRole != 'GUEST'}">
						            <li class="nav-item"><a class="nav-link" href="/logout">Đăng xuất</a></li>
						        </c:when>
						        <c:otherwise>
						            <li class="nav-item"><a class="nav-link" href="/login">Đăng nhập</a></li>
						        </c:otherwise>
						    </c:choose>
						</ul>

                    </div>
                </div>
            </div>
        </div>
    </nav>
    <!--============================
        MAIN MENU END
    ==============================-->