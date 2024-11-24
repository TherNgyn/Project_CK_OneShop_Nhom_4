package com.oneshop.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oneshop.model.UserModel;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index() {
		return "web/home";
	}
	@RequestMapping("contract")
	public String home(ModelMap model) {
	    return "common/contract";
	}

}