package com.oneshop.controller.user;


import java.lang.reflect.InvocationTargetException;
import java.nio.file.Path;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Cart;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.Category;
import com.oneshop.entity.Order;
import com.oneshop.entity.Product;
import com.oneshop.entity.User;
import com.oneshop.model.ProductModel;
import com.oneshop.model.UserModel;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IUserService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/user")
public class HomeUserController {

	@Autowired
	IUserService userService;
	@Autowired
	ServletContext application;
	@Autowired
	IProductService productService;
	@Autowired
	HttpSession session;
	@Autowired
	ICartItemService cartItemService;
	@Autowired
	ICartService cartService;
	@Autowired
	ICategoryService categoryService;
	
	@GetMapping("home")
	public String home(ModelMap model, HttpServletRequest request) {

		model.addAttribute("user", getSessionUser(request));
		List<Product> listNew = productService.findTop8ByOrderByIdDesc();
		model.addAttribute("products", listNew);
		
		List<Product> listRate = productService.findTop8ByOrderByRatingDesc();
		model.addAttribute("productr", listRate);
		
		List<Product> listAll = productService.findAll();
		model.addAttribute("productAll", listAll);
		
		List<Category> listCate = categoryService.findAll();
		model.addAttribute("listcate", listCate);
		
		return "user/home";
	}

	public User getSessionUser(HttpServletRequest request) {
		return (User) request.getSession().getAttribute("loggedInUser");
	}

	@GetMapping("product")
	public String list(ModelMap model) {
		List<Product> page = productService.findAll();
		model.addAttribute("product", page);
		return "user/product/list";
	}

	@GetMapping("productdetail/{id}")
	public ModelAndView detail(ModelMap model, @PathVariable("id") Integer id) {
		Product product = productService.getById(id);
		

		List<Product> listbycate = productService.findByCategoryId(product.getCategory().getId());

		ProductModel productModel = new ProductModel();
		BeanUtils.copyProperties(product, productModel);
		
		model.addAttribute("product", productModel);
		model.addAttribute("listbycate", listbycate);
		return new ModelAndView("user/productdetail", model);
	}

	@GetMapping("profile")
	public String Profile(ModelMap model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		UserModel usermodel = new UserModel();
		BeanUtils.copyProperties(user, usermodel);
		model.addAttribute("user", usermodel);
		return "user/profile";
	}

	@PostMapping("user/profile")
	public ModelAndView resgiter(ModelMap model, @RequestParam(name = "password", required = false) String password)
			throws IllegalAccessException, InvocationTargetException {
		boolean check = false;
		model.addAttribute("message", (String) session.getAttribute("message"));
		session.removeAttribute("message");
		UserModel usermodel = new UserModel(password);
		List<User> users = userService.findAll();
		for (User user : users) {
			if (user.getPassword().equals(usermodel.getPassword()))
				check = true;
		}
		if (check == true) {
			model.addAttribute("message", "Mật khẩu đã tồn tại");
			return new ModelAndView("/user/profile", model);
		}
		return new ModelAndView("/login", model);
	}

	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, @Valid @ModelAttribute("user") UserModel user,
	                                 BindingResult result) {
	    // Lấy thông tin người dùng hiện tại từ database
	    User existingUser = userService.getById(user.getId());
	    if (existingUser == null) {
	        model.addAttribute("error", "Không tìm thấy thông tin người dùng.");
	        return new ModelAndView("redirect:/user/profile", model);
	    }

	    // Avatar: Nếu người dùng không upload avatar mới, giữ nguyên avatar cũ
	    if (!user.getAvatarFile().isEmpty()) {
	        String path = application.getRealPath("/");
	        try {
	            String avatarFileName = user.getAvatarFile().getOriginalFilename();
	            String filePath = path + "/resources/images/user/" + avatarFileName;
	            user.getAvatarFile().transferTo(Path.of(filePath));
	            existingUser.setAvatar(avatarFileName); // Cập nhật avatar
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    // Cập nhật các trường từ form (chỉ cập nhật các trường có trong form)
	    existingUser.setFirstName(user.getFirstName());
	    existingUser.setLastName(user.getLastName());
	    existingUser.setEmail(user.getEmail());
	    existingUser.setPhone(user.getPhone());
	    existingUser.setAddress(user.getAddress());

	    // Cập nhật thời gian chỉnh sửa
	    existingUser.setUpdateat(new Date(System.currentTimeMillis()));

	    // Lưu thông tin người dùng
	    try {
	        userService.save(existingUser);
	        model.addAttribute("message", "Cập nhật hồ sơ thành công!");
	    } catch (Exception e) {
	        model.addAttribute("error", "Có lỗi xảy ra trong quá trình cập nhật.");
	        return new ModelAndView("redirect:/user/profile", model);
	    }

	    return new ModelAndView("redirect:/user/profile", model);
	}





	@PostMapping("changepassword/{id}")
	public ModelAndView ProjectResgiter(ModelMap model, @PathVariable("id") Integer id,
			@RequestParam(name = "password", required = false) String password,
			@RequestParam(name = "newpassword", required = false) String newpassword,
			@RequestParam(name = "renewpassword", required = false) String renewpassword) {
		User user = userService.getById(id);
		if (!password.equals(user.getPassword())) {
			session.setAttribute("message", "Mật khẩu không chính xác");
			return new ModelAndView("redirect:/user/profile", model);
		} else {
			if (!newpassword.equals(renewpassword)) {
				session.setAttribute("message", "Mật khẩu mới không khớp");
				return new ModelAndView("redirect:/user/profile", model);

			} else {
				user.setPassword(newpassword);
				userService.save(user);
				session.setAttribute("message", "Mật khẩu đã được cập nhập");
				return new ModelAndView("redirect:/user/profile", model);

			}
		}
	}
}