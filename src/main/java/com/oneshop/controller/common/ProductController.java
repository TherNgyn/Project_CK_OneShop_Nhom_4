package com.oneshop.controller.common;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IReviewService;

@Controller
@RequestMapping("/common/products")
public class ProductController {

    @Autowired 
    private IProductService productService;
    @Autowired 
	private IReviewService reviewService;
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private Cloudinary cloudinary;

    private String message;

    // Lấy tất cả sản phẩm với phân trang
    @RequestMapping("")
    public String allProducts(ModelMap model, Pageable pageable) {
    	int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
    	
        Page<Product> productPage = productService.findAll(PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));

        productPage.forEach(product -> {
            // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
            List<String> imageUrls = product.getImages().stream()
                                           .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                           .collect(Collectors.toList());
            product.setImageUrls(imageUrls);
        });
        addPaginationAttributes(model, pageable, productPage);

        model.addAttribute("productPage", productPage);
        return "common/product/product-list";  // Trang hiển thị danh sách sản phẩm
    }

    @GetMapping("/search")
    public String search(ModelMap model, @RequestParam(name = "searchname", required = false) String name,
                         Pageable pageable) {
    	int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
   
        Page<Product> productPage = productService.findAll(PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));
        List<Category> categories = categoryService.findAll();

        String message = null; 

        if (StringUtils.hasText(name)) {
            productPage = productService.findByNameContainingIgnoreCase(name, pageable);

            if (productPage.hasContent()) {
                message = "Tìm thấy " + productPage.getTotalElements() + " sản phẩm ";
            } else {
                message = "Không tìm thấy sản phẩm";
            }

            model.addAttribute("name", name);
        } else {
            productPage = productService.findAll(pageable);
        }
        productPage.forEach(product -> {
            // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
            List<String> imageUrls = product.getImages().stream()
                                           .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                           .collect(Collectors.toList());
            product.setImageUrls(imageUrls);
        });
        
        // Lọc danh sách các thương hiệu duy nhất
        List<String> uniqueBrands = getUniqueBrands();
       
        model.addAttribute("searchName", name);
        model.addAttribute("productPage", productPage);
        model.addAttribute("categories", categories);
        model.addAttribute("brands", uniqueBrands);
        model.addAttribute("message", message); // Truyền message xuống view
        return "common/product/product-search-result";
    }

    @RequestMapping("/filter")
    public String getProducts(@RequestParam(name = "name", required = false) String name,
                              @RequestParam(name = "categoryName", required = false) List<String> categoryName,  
                              @RequestParam(value = "brand", required = false) List<String> brand,
                              @RequestParam(value = "minPrice", required = false) Double minPrice,
                              @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                              Pageable pageable,
                              ModelMap model) {

        Page<Product> productPage;
        String message = null;

        int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
        Pageable page = PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name"));

        if (StringUtils.hasText(name)) {
            productPage = productService.findByNameContainingIgnoreCase(name, page);
            
            if (!productPage.isEmpty()) {
                if ((categoryName != null && !categoryName.isEmpty()) ||
                    (brand != null && !brand.isEmpty()) ||
                    minPrice != null || maxPrice != null) {
                    productPage = productService.findByCriteria(name,categoryName, brand, minPrice, maxPrice, page);
                    message = "Tìm thấy " + productPage.getTotalElements() + " sản phẩm";
                }
            } else {
                productPage = Page.empty(page);
                message = "Không tìm thấy sản phẩm phù hợp, vui lòng chọn loại sản phẩm khác";
            }
        } else {
            if ((categoryName != null && !categoryName.isEmpty()) ||
                (brand != null && !brand.isEmpty()) ||
                minPrice != null || maxPrice != null) {
                productPage = productService.findByCriteria(null,categoryName, brand, minPrice, maxPrice, page);
                message = "Tìm thấy " + productPage.getTotalElements() + " sản phẩm";
            } else {
                productPage = productService.findAll(page);
                message = "Không tìm thấy sản phẩm phù hợp, vui lòng chọn loại sản phẩm khác";
            }
        }

        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();

        productPage.forEach(product -> {
            // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
            List<String> imageUrls = product.getImages().stream()
                                           .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                           .collect(Collectors.toList());
            product.setImageUrls(imageUrls);
        });
        
        addPaginationAttributes(model, page, productPage);

        model.addAttribute("action", "filter");
        model.addAttribute("searchName", name);
        model.addAttribute("brand", brand);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", productPage);
        model.addAttribute("message", message);

        return "common/product/product-search-result";
    }
    @GetMapping("/productdetail")
    public String getProductDetail(
            @RequestParam("id") Integer id,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "size", required = false, defaultValue = "4") int size,
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

        List<Review> reviews = reviewService.findByProductId(product.getId());
        long totalReviews = reviewService.countByProductId(product.getId());

        Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "name"));
        Page<Product> relatedProductPage = productService.findByCategory(product.getCategory(), pageable);

        model.addAttribute("product", product);
        model.addAttribute("relatedProducts", relatedProductPage.getContent());
        model.addAttribute("reviews", reviews);
        model.addAttribute("totalReviews", totalReviews);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", relatedProductPage.getTotalPages());

        return "common/product/product-detail";
    }


    private List<String> getUniqueBrands() {
        List<Product> productList = productService.findAll();
        return productList.stream()
                .map(Product::getBrand)
                .distinct()
                .collect(Collectors.toList());
    }

    private void addPaginationAttributes(ModelMap model, Pageable pageable, Page<Product> productPage) {
        int currentPage = pageable.getPageNumber();
        int totalPages = productPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
    }

}
