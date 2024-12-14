package com.oneshop.controller.vendor;

import java.util.List;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Category;
import com.oneshop.entity.Inventory;
import com.oneshop.entity.Product;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IInventoryService;
import com.oneshop.service.IProductService;

import jakarta.validation.Valid;
@Controller
@RequestMapping("/vendor/manageproduct")
public class ProductVendorController {
	@Autowired
	IProductService productService;
	
	@Autowired
	private ICategoryService categoryService;
	
	@Autowired
	IInventoryService inventoryService;
	
	@Autowired
    private Cloudinary cloudinary;
	
	@GetMapping("")
	public String allProduct(ModelMap model, Pageable pageable) {
		int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
		
		Page<Product> productPage = productService
				.findAll(PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));

		productPage.forEach(product -> {
		    // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
		    List<String> imageUrls = product.getImages().stream()
		            .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
		            .collect(Collectors.toList());
		    product.setImageUrls(imageUrls);

		    // Lấy số lượng từ Inventory cho từng sản phẩm
		    Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
		    if (inventory != null) {
		        product.setQuantity(inventory.getQuantity());  // Gán số lượng vào product
		    } else {
		        product.setQuantity(0);  // Nếu không có Inventory, gán số lượng = 0
		    }
		});

		addPaginationAttributes(model, pageable, productPage);
		model.addAttribute("productPage", productPage);
		return "vendor/product/product-list"; // Trang hiển thị danh sách sản phẩm
	}
	@GetMapping("/paginated")
	public String manageProducts(Pageable pageable,
	                             @RequestParam(value = "status", required = false) Boolean status,
	                             ModelMap model) {
		int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;

		pageable = PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name"));
	    
		 Page<Product> productPage;

		    // Kiểm tra nếu status trống thì lấy tất cả sản phẩm
		    if (status == null) {
		        // Nếu status trống, lấy tất cả sản phẩm
		        productPage = productService.findAll(pageable);
		    } else {
		        // Nếu có status, lọc theo status
		        productPage = productService.findByStatus(status, pageable);
		    }

		    productPage.forEach(product -> {
			    // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
			    List<String> imageUrls = product.getImages().stream()
			            .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
			            .collect(Collectors.toList());
			    product.setImageUrls(imageUrls);

			    // Lấy số lượng từ Inventory cho từng sản phẩm
			    Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
			    if (inventory != null) {
			        product.setQuantity(inventory.getQuantity());  // Gán số lượng vào product
			    } else {
			        product.setQuantity(0);  // Nếu không có Inventory, gán số lượng = 0
			    }
			});
	    // Thêm dữ liệu vào model để gửi sang view
	    model.addAttribute("productPage", productPage);
	    model.addAttribute("status", status);
	    
	    return "vendor/product/product-list"; // Trả về trang danh sách sản phẩm
	}
	
	@GetMapping("/update/{id}")
	public String redirectUpdate(@PathVariable("id") Integer id, ModelMap model) {
		List<Category> category = categoryService.findAll();
		Product product = productService.getById(id);
		model.addAttribute("product", product);
		model.addAttribute("categories", category);
		return "vendor/product/product-update";  
	}
	@PostMapping("/save")
		public String saveProduct(@Valid @ModelAttribute("product") Product product, BindingResult result, Model model) {
			if (result.hasErrors()) {
				model.addAttribute("message", "Có lỗi khi lưu sản phẩm, vui lòng kiểm tra lại.");
				return "/vendor/product/product-add";
			}
			productService.save(product);
			model.addAttribute("message", "Sản phẩm đã được thêm thành công.");
			return "redirect:/vendor/productmanage";  
		}
		
		// Dùng BindingR để lưu lỗi và kiểm tra tính hợp lệ của Product
	@PostMapping("/updatesave/{id}")
		public String updateProduct(@PathVariable("id") Integer id, @Valid @ModelAttribute("product") Product product,
				BindingResult result, ModelMap model) {
			if (result.hasErrors()) {
				model.addAttribute("message", "Lỗi cập nhật, vui lòng kiểm tra lại.");
				return "/vendor/product/product-update";
			}
			product.setId(id); 
			productService.updateProduct(product);
			model.addAttribute("message", "Sản phẩm đã được cập nhật thành công.");
			return "redirect:/vendor/productmanage"; 
		}
		
	    @GetMapping("/delete/{id}")
	    public String deleteProduct(@PathVariable("id") Integer id, ModelMap model) {
	        productService.deleteById(id); 
	        model.addAttribute("message", "Sản phẩm đã được xóa thành công.");
	        return "redirect:/vendor/productmanage";  
	    }

	private void addPaginationAttributes(ModelMap model, Pageable pageable, Page<Product> productPage) {
		int currentPage = pageable.getPageNumber();
		int totalPages = productPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
	}
}
	
