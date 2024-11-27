package com.oneshop.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.model.UserModel;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	HttpSession session;
	
	@GetMapping("/")
	public String index() {
		return "web/home";
	}
	@RequestMapping("contract")
	public String home(ModelMap model) {
	    return "common/contract";
	}
	
//	@RequestMapping("home")
//	public String homePage(ModelMap model) {
//	    // Lấy vai trò của người dùng từ session
//	    String userRole = (String) session.getAttribute("userRole");
//	    if (userRole == null) {
//	        model.addAttribute("message", "Bạn cần đăng nhập để truy cập trang này.");
//	        return "common/login";
//	    }
//
//	    switch (userRole) {
//	        case "ROLE_ADMIN":
//	            return "admin/home"; 
//	        case "ROLE_VENDOR":
//	            return "vendor/home"; 
//	        case "ROLE_USER":
//	            return "user/home"; 
//	        default:
//	            model.addAttribute("message", "Vai trò của bạn không hợp lệ.");
//	            return "common/login"; 
//	    }
//	}



}