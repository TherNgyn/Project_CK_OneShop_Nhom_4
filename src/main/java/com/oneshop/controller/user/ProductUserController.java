package com.oneshop.controller.user;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.model.ProductModel;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
@Controller
@RequestMapping("/user/products")
public class ProductUserController{
	
	@Autowired 
	private IProductService productService;
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
	public String getProductDetail(@RequestParam("id") Integer id, Model model) {
	    // Lấy sản phẩm từ service
	    Product product = productService.getById(id);
	    Store store = storeService.getById(product.getId());
	    // Khởi tạo danh sách URL hình ảnh từ danh sách `images`
	    List<String> imageUrls = product.getImages().stream()
	            .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
	            .collect(Collectors.toList());
	    product.setImageUrls(imageUrls);

	    // Đưa dữ liệu vào model để hiển thị trong view
	    model.addAttribute("product", product);
	    model.addAttribute("store", store);
	    // Thêm số lượng mặc định
	    model.addAttribute("quantity", 1);

	    return "user/product/productdetail";
	}






}
