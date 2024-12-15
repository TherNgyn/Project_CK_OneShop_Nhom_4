<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${blog.title}</title>
</head>
<body>
	<!--============================
    BREADCRUMB START
==============================-->
	<section id="wsus__breadcrumb">
		<div class="wsus_breadcrumb_overlay">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<h4>${blog.title}</h4>
						<ul>
							<li><a href="/">Home</a></li>
							<li><a href="/blog">Blogs</a></li>
							<li><a href="#">${blog.title}</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--============================
    BREADCRUMB END
==============================-->

	<!--============================
    BLOG DETAILS START
==============================-->
	<section id="wsus__blog_details">
		<div class="container">
			<div class="row">
				<div class="col-xxl-9 col-xl-8 col-lg-8">
					<div class="wsus__main_blog">
						<div class="wsus__main_blog_img">
							<img src="${blog.imageUrl}" alt="${blog.title}"
								class="img-fluid w-100">
						</div>
						<p class="wsus__main_blog_header">
							<span><i class="fas fa-user-tie"></i> By Admin</span> <span><i
								class="fal fa-calendar-alt"></i> ${blog.createdAt}</span> <span><i
								class="fal fa-comment-alt-smile"></i> 0 Comments</span>
						</p>
						<div class="wsus__description_area">
							<h1>${blog.title}</h1>
							<p>${blog.content}</p>
						</div>
						<div class="wsus__share_blog">
							<p>Share:</p>
							<ul>
								<li><a class="facebook" href="#"><i
										class="fab fa-facebook-f"></i></a></li>
								<li><a class="twitter" href="#"><i
										class="fab fa-twitter"></i></a></li>
								<li><a class="linkedin" href="#"><i
										class="fab fa-linkedin-in"></i></a></li>
								<li><a class="pinterest" href="#"><i
										class="fab fa-pinterest-p"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-xxl-3 col-xl-4 col-lg-4">
					<div class="wsus__blog_sidebar">
						<h4>Recent Blogs</h4>
						<ul class="wsus__blog_list">
							<!-- Lặp qua danh sách blogs từ backend -->
							<c:forEach var="blog" items="${blogs}">
								<li><a href="/blog/${blog.id}" class="wsus__blog_link">
										<img src="${blog.imageUrl}" alt="${blog.title}"
										class="img-fluid wsus__blog_thumb"> <span>${blog.title}</span>
								</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!--============================
    BLOG DETAILS END
==============================-->
</body>
</html>
