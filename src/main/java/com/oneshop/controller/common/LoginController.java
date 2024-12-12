package com.oneshop.controller.common;

import java.sql.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	    //System.out.println("Current userRole in session: " + role);

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
	        System.out.println("userRole"+ user.getRole());
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
	
	@GetMapping("otp_register")
	public String otp_register(ModelMap model) {
		return "common/otp_register";
	}
	
	@PostMapping("otp_register")
	public ModelAndView otp_register(RedirectAttributes redirectAttributes, 
	                             @RequestParam(name = "email", required = false) String email, HttpSession session) {
	    if (email == null || email.trim().isEmpty()) {
	        redirectAttributes.addFlashAttribute("infor", "Email không được trống");
	        return new ModelAndView("redirect:/otp_register");
	    }
	    User user = userService.findByEmail(email);
        if (user != null) {
            redirectAttributes.addFlashAttribute("infor", "Email đã tồn tại");
            return new ModelAndView("redirect:/otp_register");
        }
        session.setAttribute("email", email);
    	SendMail sm = new SendMail();
    	String code = getRandom();
    	Boolean success = sm.sendEmail(email, code);
    	session.setAttribute("code", code);
    	if (success == true) {	        		
    		return new ModelAndView("redirect:/enterOtp");
    	}
    	else {
    		redirectAttributes.addFlashAttribute("infor", "Gửi mã thất bại");
            return new ModelAndView("redirect:/otp_register");
    	}
	}
	
	@GetMapping("enterOtp")
	public String enterOtp(ModelMap model) {
		session.setAttribute("code", session.getAttribute("code"));
		return "common/enterOtp";
	}
	
	@PostMapping("enterOtp")
	public ModelAndView enterOtp(RedirectAttributes redirectAttributes, @RequestParam(name = "otp", required = true) String otp) {
		if (!otp.equals(session.getAttribute("code").toString())) {
			redirectAttributes.addFlashAttribute("infor", "Otp không đúng.");
			return new ModelAndView("redirect:/enterOtp");
		}
		session.setAttribute("otp", otp);
		return new ModelAndView("redirect:/register");
	}
	

	@GetMapping("register")
	public String showRegisterPage(ModelMap model) {
		String otp = (String) session.getAttribute("otp");
		if (!otp.equals(session.getAttribute("code"))) {
			return "redirect:/enterOtp";
		}
		model.addAttribute("user", new UserModel());
		return "common/register";
	}

	@PostMapping("register")
	public ModelAndView register(RedirectAttributes redirectAttributes, @RequestParam(name = "username", required = false) String username,
			@RequestParam(name = "phone", required = false) String phone,
			@RequestParam(name = "password", required = false) String password,
			@RequestParam(name = "confirmPassword", required = false) String confirmPassword,
			@RequestParam(name = "agreePolicy", required = false) String agreePolicy, HttpSession session) {

		if (!password.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("message", "Mật khẩu và Nhập lại mật khẩu không khớp.");
			//model.addAttribute("message", "Mật khẩu và Nhập lại mật khẩu không khớp.");
			return new ModelAndView("redirect:/register");
		}

		if (agreePolicy == null) {
			redirectAttributes.addFlashAttribute("message", "Bạn cần đồng ý với Chính Sách Bảo Mật để tiếp tục.");
			//model.addAttribute("message", "Bạn cần đồng ý với Chính Sách Bảo Mật để tiếp tục.");
			return new ModelAndView("redirect:/register");
		}
		
		if (userService.findByPhone(phone.trim()) != null) {
			redirectAttributes.addFlashAttribute("message", "Số điện thoại đã tồn tại.");
			//model.addAttribute("message", "Số điện thoại không hợp lệ.");
			return new ModelAndView("redirect:/register");
		}

		if (!phone.matches("^[0-9]{10}$")) {
			redirectAttributes.addFlashAttribute("message", "Số điện thoại không hợp lệ.");
			//model.addAttribute("message", "Số điện thoại không hợp lệ.");
			return new ModelAndView("redirect:/register");
		}

		if (userService.findByUsername(username.trim()) != null) {
			redirectAttributes.addFlashAttribute("message", "Tên đăng nhập đã tồn tại.");
			return new ModelAndView("redirect:/register");
		}

		User user = new User();
		user.setUsername(username.trim());
		user.setEmail(session.getAttribute("email").toString());
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
			redirectAttributes.addFlashAttribute("message", "Tạo tài khoản thành công! Hãy đăng nhập.");
			return new ModelAndView("redirect:/login");

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại.");
			//model.addAttribute("message", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại.");
			return new ModelAndView("redirect:/register");
		}
	}
	

	@GetMapping("/reset_password")
	public String showResetPasswordPage(@RequestParam("token") String token, ModelMap model) {
	    model.addAttribute("token", token);
	    return "common/reset_password";
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
	@GetMapping("/forgot_password")
	public String ForgetPassword(Model model) {
	    return "common/forgot_password";
	}
	
	@PostMapping("/forgot_password")
	public ModelAndView register(RedirectAttributes redirectAttributes, 
	                             @RequestParam(name = "email", required = false) String email, HttpSession session) {
	    if (email == null || email.trim().isEmpty()) {
	        redirectAttributes.addFlashAttribute("infor", "Email không được trống");
	        return new ModelAndView("redirect:/forgot_password");
	    } else {
	        User user = userService.findByEmail(email);
	        if (user == null) {
	            redirectAttributes.addFlashAttribute("infor", "Email không tồn tại");
	            return new ModelAndView("redirect:/forgot_password");
	        } else {
	        	session.setAttribute("email", email);
	        	SendMail sm = new SendMail();
	        	String code = getRandom();
	        	Boolean success = sm.sendEmail(email, code);
	        	session.setAttribute("code", code);
	        	if (success == true) {	        		
	        		return new ModelAndView("common/otp_password");
	        	}
	        	else {
	        		redirectAttributes.addFlashAttribute("infor", "Gửi mã thất bại");
		            return new ModelAndView("redirect:/forgot_password");
	        	}
	            
	        }
	    }	
	}
	
	@PostMapping("/otp_password")
	public ModelAndView resetPassword(Model model,
	                                  @RequestParam(name = "newPassword") String newPassword,
	                                  @RequestParam(name = "confirmPassword") String confirmPassword,
	                                  @RequestParam(name = "email") String email,
	                                  @RequestParam(name = "otp") String otp,
	                                  @RequestParam(name = "code") String code) {
	    ModelAndView modelAndView = new ModelAndView("common/otp_password");

	    if (email == null || email.trim().isEmpty()) {
	        model.addAttribute("infor", "Email không tìm thấy.");
	        return modelAndView;
	    }

	    if (!newPassword.equals(confirmPassword)) {
	        model.addAttribute("infor", "Mật khẩu không khớp.");
	        return modelAndView;
	    }

	    if (!otp.equals(code)) {
	        model.addAttribute("infor", "Mã OTP không chính xác.");
	        return modelAndView;
	    }

	    User user = userService.findByEmail(email);
	    userService.updatePassword(user, passwordEncoder.encode(newPassword.trim()));

	    // Chuyển hướng tới trang đăng nhập nếu thành công
	    return new ModelAndView("redirect:/login")
	            .addObject("message", "Mật khẩu đã được đặt lại thành công.");
	}



	String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number); // Định dạng mã gồm 6 chữ số
    }

}