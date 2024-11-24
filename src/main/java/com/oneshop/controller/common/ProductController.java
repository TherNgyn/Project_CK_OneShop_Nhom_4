package com.oneshop.controller.common;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Product;
import com.oneshop.service.IProductService;
@Controller
@RequestMapping("/common/products")
public class ProductController{
	
	@Autowired 
	private IProductService productService;
	
	@Autowired
	private Cloudinary cloudinary;
	
	private String message;
	
	// Lấy tất cả sản phẩm với phân trang
	@RequestMapping("")
    public String allProducts(Model model, Pageable pageable) {
        Page<Product> productPage = productService.findAll(PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("name")));
        
        productPage.forEach(product -> {
            // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
            List<String> imageUrls = product.getImages().stream()
                                           .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                           .collect(Collectors.toList());
            product.setImageUrls(imageUrls); // Giả sử bạn đã thêm thuộc tính `imageUrls` trong Product
        });

        model.addAttribute("productPage", productPage);
        return "common/product/product-list";  // Trang hiển thị danh sách sản phẩm
    }

    @GetMapping("/search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page, @RequestParam("size") Optional<Integer> size) {
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<Product> resultPage;
        String message = null; 

        if (StringUtils.hasText(name)) {
            resultPage = productService.findByNameContainingIgnoreCase(name, pageable);

            if (resultPage.hasContent()) {
                message = "Tìm thấy " + resultPage.getTotalElements() + " sản phẩm ";
            } else {
                message = "Không tìm thấy sản phẩm";
            }

            model.addAttribute("name", name);
        } else {
            resultPage = productService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            if (totalPages > count) {
                if (end == totalPages)
                    start = end - count;
                else if (start == 1)
                    end = start + count;
            }
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        resultPage.forEach(product -> {
            // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
            List<String> imageUrls = product.getImages().stream()
                                           .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                           .collect(Collectors.toList());
            product.setImageUrls(imageUrls);
        });

        model.addAttribute("productPage", resultPage);
        model.addAttribute("message", message); // Truyền message xuống view

        return "common/product/product-search-result";
    }
}
