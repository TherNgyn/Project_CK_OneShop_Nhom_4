<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>ĐĂNG NHẬP</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
</head>
<body>
	<div class="container">
		<div class="card">
			<div class="form">
				<div class="left-side">
					<span></span> <span></span> <span></span> <span></span>
				</div>
				<div class="right-side">
					<div class="signin_form s_form ">
						
						<div class="login">
							<h2>User Login</h2>
							<span>${message}</span>
						</div>
						<form action="login" method="Post" enctype="multipart/form-data">
						
						<div class="input_text">
							<input type="text" placeholder="Username"  name="username"> <i
								class="fa fa-user"></i>
						</div>
						<div class="input_text">
							<input class="signin_pass" type="password" name="password"
								placeholder="Password"> <i class="fa fa-lock"></i> <i
								class="fa fa-eye-slash"></i>
						</div>
						<div class="login_btn">		
							<input class="login_button" type="submit" name="submit" value="LOGIN" style="padding: 13px 158px;border-radius: 24px;background-color:#8ec042"/>
						</div>
						<div class="forgot">
							<p>
								Forgot <a href="/forgot_password">Password</a> ?
							</p>
						</div>
						</form>
						<div class="create margin">
							<a href="/register" class="create_acc">Create your Account <i
								class="fa fa-long-arrow-right"></i></a>
						</div>
					</div>
					<div class="signup_form s_form d-none">
						<div class="login">
							<h2>Create Account</h2>
						</div>
						<div class="input_text">
							<input type="text" placeholder="Username"> <i
								class="fa fa-user"></i>
						</div>
						<div class="input_text">
							<input type="text" placeholder="Email"> <i
								class="fa fa-envelope"></i>
						</div>
						<div class="input_text">
							<input type="password" class="signup_pass" placeholder="Password">
							<i class="fa fa-lock"></i> <i class="fa fa-eye-slash signup_eye"></i>
						</div>
						<div class="login_btn">
							<button class="signup_button">Sign Up</button>
						</div>
						<div class="create">
							<p>
								Already have an account? <a href="#" class="login_acc">Login
									<i class="fa fa-long-arrow-right"></i>
								</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<style>
@import
	url('https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@200&display=swap')
	;

* {
	padding: 0;
	margin: 0;
	box-sizing: border-box
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background-image: linear-gradient(to right top, #78895f, #8ec042)
}

.container .card {
	height: 420px;
	width: 800px;
	background-color: #fff;
	position: relative;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
	font-family: 'Roboto Slab', serif
}

.container .card .form {
	width: 100%;
	height: 100%;
	display: flex
}

.container .card .left-side {
	width: 50%;
	background-color: #fff;
	height: 100%;
	position: relative;
	overflow: hidden
}

.left-side span:nth-child(1) {
	position: absolute;
	transform: rotate(45deg);
	top: 70px;
	left: -100px;
	display: flex;
	height: 180px;
	width: 400px;
	border-top-right-radius: 150px;
	border-bottom-right-radius: 150px;
	border: 15px solid #7FC1D2;
	background-image: linear-gradient(to right, #D43CC6, #682E36)
}

.left-side span:nth-child(2) {
	position: absolute;
	transform: rotate(45deg);
	top: -20px;
	left: 130px;
	display: flex;
	height: 100px;
	width: 200px;
	border-top-right-radius: 150px;
	border-bottom-right-radius: 150px;
	background-image: linear-gradient(to right, #D43CC6, #682E36)
}

.left-side span:nth-child(3) {
	position: absolute;
	transform: rotate(45deg);
	top: 280px;
	left: -70px;
	display: flex;
	height: 100px;
	width: 200px;
	border-top-right-radius: 150px;
	border-bottom-right-radius: 150px;
	background-image: linear-gradient(to right, #D43CC6, #682E36)
}

.left-side span:nth-child(4) {
	position: absolute;
	transform: rotate(-135deg);
	top: 370px;
	left: 170px;
	display: flex;
	height: 100px;
	width: 200px;
	border-top-right-radius: 150px;
	border-bottom-right-radius: 150px;
	background-image: linear-gradient(to right, #FD2A6F, #FD2A46)
}

.container .card .right-side {
	width: 50%;
	background-color: #fff;
	height: 100%;
	padding: 20px
}

.d-none {
	display: none !important
}

.login {
	display: flex;
	justify-content: center;
	text-align: center;
	width: 100%;
	margin-top: 20px
}

.input_text {
	margin-top: 20px;
	width: 100%;
	position: relative
}

input[type="text"] {
	height: 45px;
	width: 100%;
	border: none;
	background-color: #E7DCE6;
	outline: 0;
	padding: 5px 10px;
	padding-left: 25px;
	border-radius: 10px
}

input[type="password"] {
	height: 45px;
	width: 100%;
	border: none;
	background-color: #E7DCE6;
	outline: 0;
	padding: 5px 10px;
	padding-left: 25px;
	padding-right: 28px;
	border-radius: 10px
}

.fa-lock {
	position: absolute;
	top: 15px;
	left: 10px;
	cursor: pointer;
	color: #70747C
}

.fa-user {
	position: absolute;
	top: 14px;
	left: 9px;
	cursor: pointer;
	color: #70747C
}

.fa-envelope {
	position: absolute;
	top: 15px;
	left: 7px;
	cursor: pointer;
	color: #70747C;
	font-size: 14px
}

.fa-eye-slash {
	position: absolute;
	top: 15px;
	right: 9px;
	cursor: pointer;
	color: #70747C
}

.fa-eye {
	position: absolute;
	top: 15px;
	right: 9px;
	cursor: pointer;
	color: #70747C
}

.login_btn {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center
}

.login_btn button {
	height: 45px;
	outline: 0;
	border: none;
	width: 100%;
	color: #fff;
	border-radius: 30px;
	background-color: #B33346;
	font-size: 13px;
	cursor: pointer;
	transition: all 0.5s
}

.login_btn button:hover {
	background-color: #631B26
}

.forgot {
	text-align: center;
	margin-top: 20px;
	font-size: 13px;
	color: #B8B0B1;
	font-weight: 600;
	letter-spacing: 1px
}

.forgot p a {
	text-decoration: none
}

.create {
	margin-top: 40px;
	text-align: center;
	text-decoration: none;
	font-size: 13px;
	font-weight: 700
}

.margin {
	margin-top: 67px !important
}

.create a {
	text-decoration: none;
	color: blue
}

.signin_warn {
	border: 1px solid red !important
}

.signup_warn {
	border: 1px solid red !important
}

.signin_eye_wrn {
	border: 1px solid blue !important
}

.signup_eye_wrn {
	border: 1px solid blue !important
}

@media ( max-width :750px) {
	.container .card {
		max-width: 350px
	}
	.container .card .right-side {
		width: 100%
	}
	.container .card .left-side {
		display: none
	}
}
</style>
	<script type="text/javascript">var create_acc=document.querySelector(".create_acc");
var login_acc=document.querySelector(".login_acc");
var s_form=document.querySelectorAll(".s_form");
var login_button=document.querySelector(".login_button");
var signin_form_input=document.querySelectorAll(".signin_form input");

var signin_eye_click = document.querySelector(".fa-eye-slash");
var signin_type = document.querySelector(".signin_pass");
var set_signin_eye = document.querySelector(".fa-eye-slash");

var signup_eye_click = document.querySelector(".signup_eye");
var signup_type = document.querySelector(".signup_pass");
var set_signup_eye = document.querySelector(".signup_eye");

var signup_form_input=document.querySelectorAll(".signup_form input");
var signup_button=document.querySelector(".signup_button");


let formnumber=0;

create_acc.addEventListener('click',function(){
   formnumber++;
   create();
});

login_acc.addEventListener('click',function(){
   formnumber--;
   create();
});



function create(){
    s_form.forEach((form_num)=>{
       form_num.classList.add('d-none');
   });
   s_form[formnumber].classList.remove('d-none'); 
};


login_button.onclick=function(){
    signin_form_input.forEach((e)=>{
        if(e.value.length<1){
            e.classList.add('signin_warn');
        }
          
    });
};

signin_form_input.forEach((e)=>{
    e.addEventListener('keyup',function(){
       if(e.value.length<1){
           e.classList.add('signin_warn');
          
       } 
      
       else{
           e.classList.remove('signin_warn');
       }
    });
});



signup_button.onclick=function(){
    signup_form_input.forEach((signup_e)=>{
        if(signup_e.value.length<1){
            signup_e.classList.add('signup_warn');
        }
    });
};

signup_form_input.forEach((signup_e)=>{
    signup_e.addEventListener('keyup',function(){
       if(signup_e.value.length<1){
           signup_e.classList.add('signup_warn');
          
       } 
        else{
               signup_e.classList.remove('signup_warn');
           }
    });
});


signin_eye_click.addEventListener('click',function(){
   if(signin_type.type=="password"){
       signin_type.type="text";
       set_signin_eye.classList.remove('fa-eye-slash');
       set_signin_eye.classList.add('fa-eye');
       signin_type.classList.add('signin_eye_wrn');
   } 
   else{
       signin_type.type="password";
       set_signin_eye.classList.add('fa-eye-slash');
       set_signin_eye.classList.remove('fa-eye');
       signin_type.classList.remove('signin_eye_wrn');
   }
});

signup_eye_click.addEventListener('click',function(){ 
   if(signup_type.type=="password"){
       signup_type.type="text";
       set_signin_eye.classList.remove('fa-eye-slash');
       set_signup_eye.classList.add('fa-eye');
       signup_type.classList.add('signup_eye_wrn');
   }
   else{
       signup_type.type="password";
       set_signin_eye.classList.add('fa-eye-slash');
       set_signup_eye.classList.remove('fa-eye');
       signup_type.classList.remove('signup_eye_wrn');
       
   }
});</script>
</body>
</html>