package com.oneshop.controller.user;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.util.Collections;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.entity.Store;
import com.oneshop.model.ProductModel;
import com.oneshop.service.IProductService;
import com.oneshop.service.IReviewService;
import com.oneshop.service.IStoreService;
@Controller
@RequestMapping("/user/products")
public class ProductUserController{
	
	@Autowired 
	private IProductService productService;
	@Autowired 
	private IReviewService reviewService;
	@Autowired 
	private IStoreService storeService;
	@Autowired
	private Cloudinary cloudinary;

	private String message;
	@RequestMapping("")
	public String allProducts(Model model, 
	                          @RequestParam("page") Optional<Integer> page, 
	                          @RequestParam("size") Optional<Integer> size) {
	    int currentPage = page.orElse(1);
	    int pageSize = size.orElse(12);
	    if (currentPage < 1) currentPage = 1;
	    if (pageSize <= 0) pageSize = 12;

	    Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
	    Page<Product> productPage = productService.findAll(pageable);

	    productPage.forEach(product -> {
	        List<String> imageUrls = product.getImages().stream()
	                                       .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
	                                       .collect(Collectors.toList());
	        product.setImageUrls(imageUrls);
	    });
	    int totalPages = productPage.getTotalPages();
	    if (totalPages > 0) {
	        List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
	        model.addAttribute("pageNumbers", pageNumbers);
	    }

	    model.addAttribute("productPage", productPage);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("pageSize", pageSize);
	    return "user/product/product-list";
	}


	@GetMapping("/search")
	public String search(ModelMap model, 
	                     @RequestParam(name = "name", required = false) String name,
	                     @RequestParam("page") Optional<Integer> page, 
	                     @RequestParam("size") Optional<Integer> size) {
	    int currentPage = page.orElse(1);
	    if (currentPage < 1) {
	        currentPage = 1; // Đảm bảo giá trị hợp lệ
	    }

	    int pageSize = size.orElse(12);
	    if (pageSize <= 0) {
	        pageSize = 12; // Đảm bảo giá trị hợp lệ
	    }

	    Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
	    Page<Product> resultPage;

	    if (StringUtils.hasText(name)) {
	        resultPage = productService.findByNameContainingIgnoreCase(name, pageable);
	        model.addAttribute("name", name);
	    } else {
	        resultPage = productService.findAll(pageable);
	    }

	    int totalPages = resultPage.getTotalPages();
	    if (totalPages > 0) {
	        List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
	        model.addAttribute("pageNumbers", pageNumbers);
	    }

	    resultPage.forEach(product -> {
	        List<String> imageUrls = product.getImages().stream()
	                                       .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
	                                       .collect(Collectors.toList());
	        product.setImageUrls(imageUrls);
	    });

	    model.addAttribute("productPage", resultPage);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("pageSize", pageSize);
	    return "user/product/product-search-result";
	}

	@GetMapping("/productdetail")
	public String getProductDetail(
			@RequestParam("id") Integer id,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "size", required = false, defaultValue = "4") int size,
			@RequestParam(value = "quantity", required = false, defaultValue = "1") int quantity,
			Model model) {

		if (id == null) {
			throw new IllegalArgumentException("Product ID is required.");
		}

		Product product = productService.getById(id);
		if (product == null) {
			throw new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + id);
		}

		List<String> imageUrls = product.getImages().stream()
				.map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
				.collect(Collectors.toList());
		product.setImageUrls(imageUrls);

		Pageable pageable = PageRequest.of(page - 1, size, Sort.by("name"));
		Page<Product> relatedProductPage = productService.findByCategory(product.getCategory(), pageable);

		int totalPages = relatedProductPage.getTotalPages();
		List<Integer> pageNumbers = totalPages > 0
				? IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList())
				: Collections.emptyList();

		// Đưa dữ liệu vào model
		model.addAttribute("product", product);
		model.addAttribute("relatedProducts", relatedProductPage.getContent());
		model.addAttribute("quantity", quantity);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", size);
		model.addAttribute("pageNumbers", pageNumbers);

		return "user/product/productdetail";
	}







}
