package com.oneshop.controller.common;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Blog;
import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.model.UserModel;
import com.oneshop.service.IBlogService;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IUserService;
import com.oneshop.service.Impl.CloudinaryService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	HttpSession session;
	@Autowired
	IUserService userService;
	@Autowired
	ServletContext application;
	@Autowired
	IProductService productService;
	@Autowired
	ICartItemService cartItemService;
	@Autowired
	ICartService cartService;
	@Autowired
	ICategoryService categoryService;
	@Autowired
	IBlogService blogService;
	@Autowired
	private CloudinaryService cloudinaryService;
	@GetMapping("/")
	public String index(ModelMap model, HttpServletRequest request) {
		List<Product> listNew = productService.findTop4ByOrderByIdDesc();
	    model.addAttribute("products", listNew);
	    List<Category> categories = categoryService.findAll();
	    categories.forEach(category -> {
	        List<Product> topProducts = productService.findTopProductsByCategory(category.getId());
	        category.setTopProducts(topProducts);
	    });
	    model.addAttribute("categories", categories);
	    List<Product> listRate = productService.findTop8ByOrderByRatingDesc();
	    model.addAttribute("productr", listRate);
	    List<Product> listAll = productService.findAll();
	    model.addAttribute("productAll", listAll);
	    List<Category> listCate = categoryService.findAll();
	    model.addAttribute("listcate", listCate);
	    List<Product> topRatedProducts = productService.getTopRatedProducts();
	    model.addAttribute("topRatedProducts", topRatedProducts);
	    List<Blog> latestBlogs = blogService.getTop4LatestBlogs();
	    model.addAttribute("latestBlogs", latestBlogs);
		return "web/home";
	}
	@RequestMapping("contract")
	public String home(ModelMap model) {
	    return "common/contract";
	}
	



}