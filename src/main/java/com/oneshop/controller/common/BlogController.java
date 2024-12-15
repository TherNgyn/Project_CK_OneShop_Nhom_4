package com.oneshop.controller.common;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.data.domain.Pageable;

import com.oneshop.entity.Blog;
import com.oneshop.service.IBlogService;
import com.oneshop.service.ICartService;

@Controller
@RestController
@RequestMapping("/blog")
public class BlogController {
	@Autowired
	 private IBlogService blogService;
	
	@GetMapping("")
	public ModelAndView listBlogs(
	        @RequestParam(value = "page", defaultValue = "0") int page,
	        @RequestParam(value = "size", defaultValue = "6") int size,
	        ModelMap model) {
	    Page<Blog> blogPage = blogService.getBlogsPaginated(PageRequest.of(page, size));
	    model.addAttribute("blogs", blogPage.getContent());
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", blogPage.getTotalPages());
	    return new ModelAndView("common/blog/list", model);
	}



	@GetMapping("/{id}")
	public ModelAndView viewBlog(@PathVariable Integer id, ModelMap model) {
	    Blog blog = blogService.getBlogById(id);
	    model.addAttribute("blog", blog);

	    List<Blog> blogs = blogService.getAllBlogs().stream()
	                                  .filter(b -> !b.getId().equals(id)) 
	                                  .limit(5) 
	                                  .collect(Collectors.toList());
	    model.addAttribute("blogs", blogs);
	    return new ModelAndView("common/blog/detail", model);
	}



}