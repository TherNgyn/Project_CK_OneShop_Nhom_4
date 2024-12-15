<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f8f9fa;
	margin: 0;
	padding: 0;
}

/* Title styling */
.section-title h2 {
	text-align: center;
	color: #333;
	margin-bottom: 30px;
	font-size: 24px;
	font-weight: bold;
}

/* Main container styling */
.main {
	max-width: 1200px;
	margin: auto;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

/* Card styling */
.card {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border: 1px solid #ddd;
	margin-bottom: 20px;
	padding: 20px;
}

.card-body {
	padding: 15px;
}

/* Profile image styling */
/* Avatar image styling */
.profile-card img {
	max-width: 150px !important;
	max-height: 150px !important;
	object-fit: cover !important;
	width: auto;
	height: auto;
	object-fit: cover;
	border-radius: 50%;
	border: 2px solid #ddd; /* Viền ảnh */
	display: block; /* Đảm bảo ảnh là block để căn giữa */
	margin: auto; /* Căn giữa ảnh */
}

.profile-card {
	max-width: 200px;
	margin: auto;
	text-align: center;
}

/* Responsive adjustments for smaller screens */
@media ( max-width : 768px) {
	.profile-card img {
		width: 100px; /* Thu nhỏ trên màn hình nhỏ */
		height: 100px;
	}
	.main {
		margin: 10px;
		padding: 15px;
	}
}

/* Tabs styling */
.nav-tabs .nav-link {
	border: 1px solid #ddd;
	margin: 0 5px;
	color: #555;
	font-weight: bold;
	border-radius: 5px;
	padding: 10px 15px;
	text-align: center;
}

.nav-tabs .nav-link.active {
	background-color: #007bff;
	color: white;
	border-color: #007bff;
}

.tab-content {
	margin-top: 20px;
}

/* Label and input fields styling */
.label {
	font-weight: bold;
	color: #555;
	margin-bottom: 5px;
}

input[type="text"], input[type="email"], input[type="password"], input[type="file"]
	{
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-bottom: 10px;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus,
	input[type="file"]:focus {
	border-color: #007bff;
	outline: none;
}

/* Button styling */
.btn-primary {
	background-color: #007bff;
	border: none;
	color: white;
	font-size: 16px;
	font-weight: bold;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

.btn-primary:hover {
	background-color: #0056b3;
}
/* Responsive styling */
@media ( max-width : 768px) {
	.main {
		margin: 10px;
		padding: 15px;
	}
	.profile-card img {
		width: 100px;
		height: 100px;
	}
	.nav-tabs .nav-link {
		font-size: 14px;
		padding: 8px;
	}
	.btn-primary {
		font-size: 14px;
		padding: 8px 15px;
	}
}
</style>
</head>
<body>
<body>

	<div class="section-title from-blog__title" style="margin-top: 50px">
		<!-- Breadcrumb Section Begin -->
	<section id="wsus__breadcrumb">
		<div class="wsus_breadcrumb_overlay">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<ul>
							<li><a href="user/home">Home</a></li>
							<li><a href="user/profile">Profile</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->
	</div>
	<main id="main" class="main"
		style="margin: 30px 160px; margin-top: 50px">

		<p>${message}</p>
		<section class="section profile">
			<div class="row">
				<div class="col-xl-4">

					<div class="card">
						<div
							class="card-body profile-card pt-4 d-flex flex-column align-items-center">

							<img src="${user.avatar}" alt="Profile" class="rounded-circle"
								style="width: 150px; height: 150px; object-fit: cover;">

							<h3>${user.username}</h3>
							<h5>USER</h5>
							<div class="social-links mt-2">
								<a href="#" class="twitter"><i class="bi bi-twitter"></i></a> <a
									href="#" class="facebook"><i class="bi bi-facebook"></i></a> <a
									href="#" class="instagram"><i class="bi bi-instagram"></i></a>
								<a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
							</div>
						</div>
					</div>

				</div>

				<div class="col-xl-8">

					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">

								<li class="nav-item">
									<button class="nav-link active" data-bs-toggle="tab"
										data-bs-target="#profile-overview">Overview</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-edit">Edit Profile</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-change-password">Change
										Password</button>
								</li>

							</ul>
							<div class="tab-content pt-2">

								<div class="tab-pane fade show active profile-overview"
									id="profile-overview">

									<h5 class="card-title">Profile Details</h5>


									<div class="row">
										<div class="col-lg-3 col-md-4 label ">First Name</div>
										<div class="col-lg-9 col-md-8">${user.firstName}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Last Name</div>
										<div class="col-lg-9 col-md-8">${user.lastName}</div>
									</div>


									<div class="row">
										<div class="col-lg-3 col-md-4 label">Address</div>
										<div class="col-lg-9 col-md-8">${user.address}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Phone</div>
										<div class="col-lg-9 col-md-8">${user.phone}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Email</div>
										<div class="col-lg-9 col-md-8">${user.email}</div>
									</div>

								</div>

								<div class="tab-pane fade profile-edit pt-3" id="profile-edit">
									<form action="<c:url value='/user/saveOrUpdate' />"
										method="POST" enctype="multipart/form-data">
										<div class="card-body mx-auto">
											<div class="mb-3">
												<input type="text" class="form-control" name="id"
													value="${user.id}" readonly="readonly" hidden="true">
											</div>
											<div class="mb-3">
												<label for="firstName" class="form-label">Họ</label> <input
													type="text" class="form-control" id="firstName"
													name="firstName" value="${user.firstName}">
											</div>
											<div class="mb-3">
												<label for="lastName" class="form-label">Tên</label> <input
													type="text" class="form-control" id="lastName"
													name="lastName" value="${user.lastName}">
											</div>
											<div class="mb-3">
												<label for="email" class="form-label">Email</label> <input
													type="email" class="form-control" id="email" name="email"
													value="${user.email}">
											</div>
											<div class="mb-3">
												<label for="phone" class="form-label">Số điện thoại</label>
												<input type="text" class="form-control" id="phone"
													name="phone" value="${user.phone}">
											</div>
											<div class="mb-3">
												<label for="address" class="form-label">Địa chỉ</label> <input
													type="text" class="form-control" id="address"
													name="address" value="${user.address}">
											</div>
											<div class="mb-3">
												<label for="avatarFile" class="form-label">Avatar</label> <input
													type="file" class="form-control" id="avatarFile"
													name="avatarFile">
											</div>
											<button type="submit" class="btn btn-primary">Submit</button>
										</div>
									</form>
								</div>


								<div class="tab-pane fade pt-3" id="profile-change-password">
									<!-- Change Password Form -->

									<form action="/user/changepassword/${user.id}" method="post"
										enctype="mutipart/form-data">

										<div class="row mb-3">
											<label for="currentPassword"
												class="col-md-4 col-lg-3 col-form-label">Current
												Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="password" class="form-control"
													id="currentPassword" value="${user.password}">
											</div>
										</div>

										<div class="row mb-3">
											<label for="newPassword"
												class="col-md-4 col-lg-3 col-form-label">New
												Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="newpassword" type="password"
													class="form-control" id="newPassword">
											</div>
										</div>

										<div class="row mb-3">
											<label for="renewPassword"
												class="col-md-4 col-lg-3 col-form-label">Re-enter
												New Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="renewpassword" type="password"
													class="form-control" id="renewpassword">
											</div>
										</div>

										<div class="text-center">
											<button type="submit" class="btn btn-primary">Change
												Password</button>
										</div>
									</form>
									<!-- End Change Password Form -->

								</div>

							</div>
							<!-- End Bordered Tabs -->

						</div>
					</div>

				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->

</body>
</body>
</html>
