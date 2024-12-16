package com.oneshop.controller.vendor;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
import com.cloudinary.utils.ObjectUtils;
import com.oneshop.entity.Category;
import com.oneshop.entity.Inventory;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IInventoryService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IUserService;
import com.oneshop.service.Impl.CloudinaryService;

import jakarta.servlet.http.HttpSession;
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
	private IStoreService storeService;

	@Autowired
	HttpSession session;
	
	@Autowired
	private CloudinaryService cloudinaryService;

	@GetMapping("")
	public String allProduct(ModelMap model, Pageable pageable) {
		
		// Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
		
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Store store = storeService.findByOwner(loggedInUser);
        
		int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;

		Page<Product> productPage = productService.findByStore(store, PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));
		
		productPage.forEach(product -> {
			List<String> imageUrls = cloudinaryService.generateImageUrls(product.getImages());
			product.setImageUrls(imageUrls);

			Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
			if (inventory != null) {
				product.setQuantity(inventory.getQuantity());
			} else {
				product.setQuantity(0);
			}
		});

		addPaginationAttributes(model, pageable, productPage);
		model.addAttribute("productPage", productPage);
		return "vendor/product/product-list"; // Trang hiển thị danh sách sản phẩm
	}

	@GetMapping("/paginated")
	public String manageProducts(Pageable pageable, @RequestParam(value = "status", required = false) Boolean status,
			ModelMap model) {
		
		// Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
		
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Store store = storeService.findByOwner(loggedInUser);
        
		
		int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;

		pageable = PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name"));

		Page<Product> productPage;
		if (status == null) {
			productPage = productService.findByStore(store, pageable);
		} else {
			productPage = productService.findByStoreAndStatus(store, status, pageable);
		}

		productPage.forEach(product -> {
			List<String> imageUrls = cloudinaryService.generateImageUrls(product.getImages());
			product.setImageUrls(imageUrls);

			Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
			if (inventory != null) {
				product.setQuantity(inventory.getQuantity());
			} else {
				product.setQuantity(0);
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
		
		List<String> imageUrls = cloudinaryService.generateImageUrls(product.getImages());
		product.setImageUrls(imageUrls);
		
		List<String> brands = getUniqueBrands();
		
		Inventory inventory = inventoryService.getQuantityByProductId(id);
		if (inventory != null) {
			product.setQuantity(inventory.getQuantity());
		} else {
			product.setQuantity(0);
		}
		
		model.addAttribute("product", product);
		model.addAttribute("brands", brands);
		model.addAttribute("categories", category);
		return "vendor/product/product-update";
	}
	
	@GetMapping("/add")
	public String redirectAdd(ModelMap model) {
		List<Category> category = categoryService.findAll();
		List<String> uniqueBrands = getUniqueBrands();
		model.addAttribute("brands",uniqueBrands);
		model.addAttribute("categories", category);
		return "vendor/product/product-add";
	}

	@PostMapping("/save")
	public String saveProduct(@Valid @ModelAttribute("product") Product product, BindingResult result, 
	                          @RequestParam("quantity") int quantity,
	                          @RequestParam("image") MultipartFile mainImage, 
	                          @RequestParam("additionalImages") MultipartFile[] additionalImages, 
	                          @RequestParam("promotionalPrice") Double promotionalPrice,
	                          RedirectAttributes redirectAttributes) {
	    if (result.hasErrors()) {
	        redirectAttributes.addFlashAttribute("message", "Có lỗi khi lưu sản phẩm, vui lòng kiểm tra lại.");
	        return "redirect:/vendor/manageproduct/add";  
	    }
	    
	    User loggedInUser = (User) session.getAttribute("user");
	    if (loggedInUser == null) {
	        return "redirect:/login";
	    }
	    if ("ROLE_VENDOR".equals(loggedInUser.getRole())) {
	        Store vendorStore = storeService.findByOwner(loggedInUser);
	        product.setStore(vendorStore);
	    } else {
	        redirectAttributes.addFlashAttribute("message", "Bạn cần đăng nhập.");
	        return "redirect:/login";  
	    }
	    
	    // Đặt trạng thái sản phẩm là "waiting"
	    product.setStatus("Waiting");

	 // Lấy ngày giờ hiện tại
	    LocalDateTime now = LocalDateTime.now();

	    // Chuyển LocalDateTime thành java.util.Date
	    Date currentDate = Date.from(now.atZone(ZoneId.systemDefault()).toInstant());

	    // Chuyển java.util.Date thành java.sql.Date
	    java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());

	    // Đặt ngày tạo và ngày cập nhật
	    product.setCreateat(sqlDate);
	    product.setUpdateat(sqlDate);

	    // Đặt giá khuyến mãi
	    product.setPromotionalPrice(promotionalPrice);
	    
	    // Lưu sản phẩm trước
	    productService.save(product);

	    if (product.getImages() == null) {
	        product.setImages(new ArrayList<>());
	    }
	    
	    if (mainImage != null && !mainImage.isEmpty()) {
	        String mainImageUrl = null;
	        try {
	            mainImageUrl = cloudinaryService.uploadFile(mainImage);
	        } catch (IOException e) {
	            e.printStackTrace();
	            return "redirect:/vendor/manageproduct/add";  
	        }

	        ProductImage mainProductImage = new ProductImage();
	        mainProductImage.setImageUrl(mainImageUrl);  
	        mainProductImage.setIsMain(true);  
	        mainProductImage.setProduct(product);  // Set the product reference
	        product.getImages().add(mainProductImage);
	    }
	    
	    // Xử lý ảnh phụ (additionalImages)
	    if (additionalImages != null && additionalImages.length > 0) {
	        List<ProductImage> productImages = Arrays.stream(additionalImages)
	            .map(file -> {
	                String imageUrl = null;
	                try {
	                    imageUrl = cloudinaryService.uploadFile(file);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	                ProductImage productImage = new ProductImage();
	                productImage.setProduct(product);  // Set the product reference
	                productImage.setImageUrl(imageUrl);
	                return productImage;
	            })
	            .collect(Collectors.toList());

	        // Thêm ảnh phụ vào sản phẩm
	        product.getImages().addAll(productImages);  
	    }

	    // Lưu lại sản phẩm với các ảnh đã thêm
	    productService.save(product);
	    
	    Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
	    if (inventory == null) {
	        inventory = new Inventory();
	        inventory.setProduct(product);
	    }
	    inventory.setProduct(product);
	    inventory.setQuantity(quantity);  
	    inventoryService.save(inventory);
	    
	    // Thêm thông báo thành công vào flash attributes
	    redirectAttributes.addFlashAttribute("message", "Sản phẩm đã được thêm thành công và đang chờ duyệt.");
	    
	    // Redirect về trang quản lý sản phẩm
	    return "redirect:/vendor/manageproduct";
	}


	@PostMapping("/updatesave/{id}")
	public String updateProduct(@PathVariable("id") Integer id, 
	                             @Valid @ModelAttribute("product") Product product,
	                             @RequestParam(value = "quantity", required = false) Integer quantity, 
	                             BindingResult result, 
	                             @RequestParam(value = "image", required = false) MultipartFile mainImage, 
	                             @RequestParam(value = "additionalImages", required = false) MultipartFile[] additionalImages, 
	                             @RequestParam(value = "removedImages", required = false) String removedImages,
	                             RedirectAttributes redirectAttributes) {

	    if (result.hasErrors()) {
	        redirectAttributes.addFlashAttribute("message", "Lỗi cập nhật, vui lòng kiểm tra lại.");
	        return "redirect:/vendor/product/product-update";  
	    }
	    
	    String message = productService.updateProductWithImages(product, quantity, mainImage, additionalImages, id, removedImages);

	    redirectAttributes.addFlashAttribute("message", message);

	    if (message.equals("Sản phẩm đã được cập nhật thành công.")) {
	        return "redirect:/vendor/manageproduct";  
	    } else {
	        return "redirect:/vendor/manageproduct/update/{id}";  
	    }
	}


	@GetMapping("/delete/{id}")
	public String deleteProduct(@PathVariable("id") Integer id, ModelMap model) {
		productService.deleteById(id);
		model.addAttribute("message", "Sản phẩm đã được xóa thành công.");
		return "redirect:/vendor/manageproduct";
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
	private List<String> getUniqueBrands() {
        List<Product> productList = productService.findAll();
        return productList.stream()
                .map(Product::getBrand)
                .distinct()
                .collect(Collectors.toList());
    }
}
