package com.oneshop.controller.common;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Cart;
import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.entity.User;
import com.oneshop.model.UserModel;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IUserService;

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
	@Autowired
	PasswordEncoder passwordEncoder;

	@RequestMapping("login")
	public String home(ModelMap model) {
		model.addAttribute("user", new UserModel());
		return "common/login";
	}

	@RequestMapping("")
	public String loadHomePage(ModelMap model) {
	    String role = (String) session.getAttribute("userRole");

	    if (role == null || role.trim().isEmpty()) {
	        role = "GUEST";
	        session.setAttribute("userRole", role);
	    }

	    System.out.println("Current userRole in session: " + role);

	    List<Product> listNew = productService.findTop8ByOrderByIdDesc();
	    model.addAttribute("products", listNew);

	    List<Product> listRate = productService.findTop8ByOrderByRatingDesc();
	    model.addAttribute("productr", listRate);

	    List<Product> listAll = productService.findAll();
	    model.addAttribute("productAll", listAll);

	    List<Category> listCate = categoryService.findAll();
	    model.addAttribute("listcate", listCate);

	    switch (role) {
	        case "ROLE_ADMIN":
	            return "/admin/home";
	        case "ROLE_VENDOR":
	            return "/vendor/home";
	        case "ROLE_USER":
	            return "/user/home";
	        default:
	            return "web/home"; // Guest page
	    }
	}

	@PostMapping("login")
	public ModelAndView login(ModelMap model, 
	                          @RequestParam(name = "username", required = false) String username,
	                          @RequestParam(name = "password", required = false) String password) {

	    if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
	        model.addAttribute("message", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
	        return new ModelAndView("common/login", model);
	    }

	    User user = userService.login(username.trim(), password.trim());
	    if (user == null) {
	        model.addAttribute("message", "Tài khoản hoặc mật khẩu không chính xác.");
	        return new ModelAndView("common/login", model);
	    }

	    // Kiểm tra session trước khi set giá trị
	    if (session != null) {
	        session.setAttribute("user", user);
	        session.setAttribute("userRole", user.getRole());
	    } else {
	        System.out.println("Session is null!");
	        model.addAttribute("message", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại.");
	        return new ModelAndView("common/login", model);
	    }

	    System.out.println("User saved in session: " + session.getAttribute("user"));
	    System.out.println("User role saved in session: " + session.getAttribute("userRole"));

	    switch (user.getRole()) {
	        case "ROLE_ADMIN":
	            return new ModelAndView("redirect:/admin/home");
	        case "ROLE_VENDOR":
	            return new ModelAndView("redirect:/vendor/home");
	        case "ROLE_USER":
	            return new ModelAndView("redirect:/user/home");
	        default:
	            model.addAttribute("message", "Vai trò không hợp lệ.");
	            session.invalidate();
	            return new ModelAndView("common/login", model);
	    }
	}


	@RequestMapping("logout")
	public String logout() {
	    session.invalidate();
	    return "redirect:/login";
	}

	@GetMapping("register")
	public String showRegisterPage(ModelMap model) {
		model.addAttribute("user", new UserModel());
		return "common/register";
	}

	@PostMapping("register")
	public ModelAndView register(ModelMap model, @RequestParam(name = "username", required = false) String username,
			@RequestParam(name = "email", required = false) String email,
			@RequestParam(name = "phone", required = false) String phone,
			@RequestParam(name = "password", required = false) String password,
			@RequestParam(name = "confirmPassword", required = false) String confirmPassword,
			@RequestParam(name = "agreePolicy", required = false) String agreePolicy) {

		if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || phone == null
				|| phone.trim().isEmpty() || password == null || password.trim().isEmpty() || confirmPassword == null
				|| confirmPassword.trim().isEmpty()) {
			model.addAttribute("message", "Vui lòng điền đầy đủ thông tin.");
			return new ModelAndView("common/register", model);
		}

		if (!password.equals(confirmPassword)) {
			model.addAttribute("message", "Mật khẩu và Nhập lại mật khẩu không khớp.");
			return new ModelAndView("common/register", model);
		}

		if (agreePolicy == null) {
			model.addAttribute("message", "Bạn cần đồng ý với Chính Sách Bảo Mật để tiếp tục.");
			return new ModelAndView("common/register", model);
		}

		if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
			model.addAttribute("message", "Email không hợp lệ.");
			return new ModelAndView("common/register", model);
		}

		if (!phone.matches("^[0-9]{10}$")) {
			model.addAttribute("message", "Số điện thoại không hợp lệ.");
			return new ModelAndView("common/register", model);
		}

		if (userService.findByUsername(username.trim()) != null) {
			model.addAttribute("message", "Tên đăng nhập đã tồn tại.");
			return new ModelAndView("common/register", model);
		}

		User user = new User();
		user.setUsername(username.trim());
		user.setEmail(email.trim());
		user.setPhone(phone.trim());
		user.setPassword(passwordEncoder.encode(password.trim()));
		user.setRole("ROLE_USER");
		Date currentDate = new Date(System.currentTimeMillis());
		user.setCreateat(currentDate);
		user.setUpdateat(currentDate);

		try {
			userService.save(user);
			Cart cart = new Cart();
			cart.setUser(user);
			cart.setCreateat(currentDate);
			cart.setUpdateat(currentDate);
			cartService.save(cart);

			model.addAttribute("message", "Tạo tài khoản thành công! Hãy đăng nhập.");
			return new ModelAndView("common/login", model);

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại.");
			return new ModelAndView("common/register", model);
		}
	}
}
