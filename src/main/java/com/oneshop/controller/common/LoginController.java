package com.oneshop.controller.common;

import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Cart;
import com.oneshop.entity.Category;
import com.oneshop.entity.Order;
import com.oneshop.entity.Product;
import com.oneshop.entity.User;
import com.oneshop.model.UserModel;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IUserService;
import com.oneshop.service.Impl.UserNotFoundException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class LoginController {
	@Autowired
	IUserService userService;
	@Autowired
	ICartService cartService;
	@Autowired
	IOrderService orderSerivce;
	@Autowired
	HttpSession session;
	@Autowired
	ServletContext application;
	@Autowired
	IProductService productService;
	@Autowired
	IStoreService storeService;
	@Autowired
	ICategoryService categoryService;

	@RequestMapping("login")
	public String home(ModelMap model) {
		model.addAttribute("user", new UserModel());
		return "common/login";
	}

	@RequestMapping("")
	public String loadHomePage(ModelMap model) {
	    // Lấy thông tin role từ session
	    String role = (String) session.getAttribute("userRole");

	    // Gán mặc định là "GUEST" nếu chưa đăng nhập
	    if (role == null || role.trim().isEmpty()) {
	        session.setAttribute("userRole", "GUEST");
	        role = "GUEST";
	    }

	    // Thêm dữ liệu cần thiết cho trang
	    List<Product> listNew = productService.findTop8ByOrderByIdDesc();
	    model.addAttribute("products", listNew);

	    List<Product> listRate = productService.findTop8ByOrderByRatingDesc();
	    model.addAttribute("productr", listRate);

	    List<Product> listAll = productService.findAll();
	    model.addAttribute("productAll", listAll);

	    List<Category> listCate = categoryService.findAll();
	    model.addAttribute("listcate", listCate);

	    // Điều hướng theo role
	    switch (role) {
	        case "ROLE_ADMIN":
	            return "/admin/home";
	        case "ROLE_VENDOR":
	            return "/vendor/home";
	        case "ROLE_USER":
	            return "/user/home";
	        default: // GUEST
	            return "web/home";
	    }
	}

	@PostMapping("login")
	public ModelAndView login(ModelMap model, 
	                           @RequestParam(name = "username", required = false) String username,
	                           @RequestParam(name = "password", required = false) String password) {
	    session.removeAttribute("message");

	    if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
	        model.addAttribute("message", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
	        return new ModelAndView("common/login", model);
	    }

	    // Xác thực người dùng
	    User user = userService.login(username.trim(), password.trim());
	    if (user == null) {
	        model.addAttribute("message", "Tài khoản hoặc mật khẩu không chính xác.");
	        return new ModelAndView("common/login", model);
	    }

	    // Lưu thông tin người dùng và vai trò vào session
	    session.setAttribute("user", user);
	    session.setAttribute("userRole", user.getRole());

	    // Điều hướng theo vai trò
	    switch (user.getRole()) {
	        case "ROLE_ADMIN":
	            return new ModelAndView("/admin/home", model);
	        case "ROLE_VENDOR":
	            return new ModelAndView("/vendor/home", model);
	        case "ROLE_USER":
	            return new ModelAndView("/user/home", model);
	        default:
	            model.addAttribute("message", "Vai trò không hợp lệ.");
	            session.invalidate();
	            return new ModelAndView("common/login", model);
	    }
	}




	@RequestMapping("logout")
	public String logout(HttpSession session) {
	    session.invalidate(); // Xóa toàn bộ session
	    return "redirect:/login"; // Trở về trang đăng nhập
	}



	@GetMapping("/register")
	public String showregister(ModelMap model) {
		return "/common/login";
	}

	@PostMapping("register")
	public ModelAndView resgiter(ModelMap model, @RequestParam(name = "username", required = false) String username,
			@RequestParam(name = "password", required = false) String password)
			throws IllegalAccessException, InvocationTargetException {
		boolean check = false;
		UserModel usermodel = new UserModel(username, password);
		List<User> users = userService.findAll();
		for (User user : users) {
			if (user.getUsername().equals(usermodel.getUsername()))
				check = true;

		}
		if (check == true) {
			model.addAttribute("message", "Tên đăng nhập đã tồn tại");
			return new ModelAndView("common/login", model);
		} else {
			// tao user moi
			User user = new User();
			user.setUsername(username);
			user.setPassword(password);
			user.setRole("ROLE_USER");
			long millis = System.currentTimeMillis();
			Date date = new Date(millis);
			user.setCreateat(date);
			user.setUpdateat(date);

			userService.save(user);
			// tao cart va order cho user
			Cart cart = new Cart();
			Order order = new Order();
			cart.setUser(user);
			cart.setCreateat(date);
			cart.setUpdateat(date);
			cartService.save(cart);
			order.setUser(user);
			order.setCreateat(date);
			order.setUpdateat(date);
			order.setPrice((float) 0);
			orderSerivce.save(order);
			model.addAttribute("message", "Tạo tài khoản thành công!");
			return new ModelAndView("common/login", model);
		}
	}
	@GetMapping("/forgot_password")
	public String showForgotPasswordPage() {
	    return "common/forgot_password"; // Tên view tương ứng
	}

	@PostMapping("/forgot_password")
	public ModelAndView handleForgotPassword(@RequestParam("email") String email, ModelMap model) {
	    // Logic gửi email đặt lại mật khẩu
	    try {
	        userService.updateResetPasswordToken("generated-token", email);
	        model.addAttribute("message", "Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn.");
	    } catch (UserNotFoundException e) {
	        model.addAttribute("error", "Không tìm thấy email này trong hệ thống.");
	    }
	    return new ModelAndView("common/forgot_password", model);
	}
	@GetMapping("/reset_password")
	public String showResetPasswordPage(@RequestParam("token") String token, ModelMap model) {
	    model.addAttribute("token", token);
	    return "common/reset_password"; // Tên view tương ứng
	}

	@PostMapping("/reset_password")
	public ModelAndView handleResetPassword(
	    @RequestParam("token") String token,
	    @RequestParam("password") String newPassword,
	    ModelMap model) {
	    User user = userService.getByResetPasswordToken(token);
	    if (user != null) {
	        userService.updatePassword(user, newPassword);
	        model.addAttribute("message", "Mật khẩu của bạn đã được thay đổi thành công!");
	        return new ModelAndView("common/login", model);
	    } else {
	        model.addAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
	        return new ModelAndView("common/reset_password", model);
	    }
	}


}