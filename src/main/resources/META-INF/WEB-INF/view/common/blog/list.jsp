<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blog List</title>
</head>
<body>
	<!-- Breadcrumb -->
	<section id="wsus__breadcrumb">
		<div class="wsus_breadcrumb_overlay">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h4>Our Latest Blogs</h4>
						<ul>
							<li><a href="user/home">Home</a></li>
							<li><a href="/blog">Blogs</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Blogs Page -->
	<section id="wsus__blogs">
		<div class="container">
			<div class="row">
				<!-- Lặp qua danh sách blogs từ model -->
				<c:forEach var="blog" items="${blogs}">
					<div class="col-xl-4 col-sm-6 col-lg-4 col-xxl-3">
						<div class="wsus__single_blog wsus__single_blog_2">
							<a class="wsus__blog_img" href="/blog/${blog.id}"> <img
								src="${blog.imageUrl}" alt="${blog.title}"
								class="img-fluid w-100">
							</a>
							<div class="wsus__blog_text">
								<div class="wsus__blog_text_center">
									<a href="/blog/${blog.id}">${blog.title}</a>
									<p class="date">${blog.createdAt}</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="pagination">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<!-- Nút Previous -->
						<c:if test="${currentPage > 0}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPage - 1}&size=6" aria-label="Previous">
									<i class="fas fa-chevron-left"></i>
							</a></li>
						</c:if>
						<!-- Vòng lặp hiển thị các trang -->
						<c:forEach var="i" begin="0" end="${totalPages - 1}">
							<li class="page-item ${i == currentPage ? 'active' : ''}"><a
								class="page-link" href="?page=${i}&size=6">${i + 1}</a></li>
						</c:forEach>
						<!-- Nút Next -->
						<c:if test="${currentPage < totalPages - 1}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPage + 1}&size=6" aria-label="Next"> <i
									class="fas fa-chevron-right"></i>
							</a></li>
						</c:if>
					</ul>
				</nav>
			</div>

		</div>
	</section>
</body>
</html>
