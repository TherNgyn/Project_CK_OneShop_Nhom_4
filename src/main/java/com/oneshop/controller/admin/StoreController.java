package com.oneshop.controller.admin;

import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.Store;
import com.oneshop.model.ProductModel;
import com.oneshop.service.IProductService;
import com.oneshop.service.Impl.StoreServiceImpl;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/stores")
public class StoreController {

    @Autowired
    private StoreServiceImpl storeService;
    @Autowired
    private IProductService productService;

    @GetMapping("")
    public String listStores(@RequestParam(value = "search", required = false) String searchTerm, Model model) {
        List<Store> stores;
        if (searchTerm != null && !searchTerm.isEmpty()) {
            stores = storeService.searchStores(searchTerm); // Gọi phương thức tìm kiếm trong service
        } else {
            stores = storeService.findAll();    
        }

        // Cập nhật đếm sản phẩm chờ duyệt
        for (Store store : stores) {
            long waitingProductCount = store.getProducts().stream()
                .filter(product -> "Waiting".equals(product.getStatus()))
                .count();
            store.setWaitingProductCount(waitingProductCount);
        }

        model.addAttribute("stores", stores);
        model.addAttribute("searchTerm", searchTerm); // Thêm tham số searchTerm vào model
        return "admin/Store_Manage";
    }

    @GetMapping("/edit/{id}")
    public String editStoreForm(@PathVariable("id") Integer id, Model model) {
        Store store = storeService.getById(id);
        model.addAttribute("store", store);
        return "admin/edit_store";
    }

    @PostMapping("/edit/{id}")
    public String updateStore(@PathVariable("id") Integer id, @ModelAttribute @Valid Store store, BindingResult result) {
        if (result.hasErrors()) {
            return "admin/store/edit"; 
        }

        Store existingStore = storeService.getById(id);
        if (existingStore == null) {
            return "redirect:/admin/stores?error=notfound";
        }

        // Cập nhật các thuộc tính
        existingStore.setName(store.getName()); 
        existingStore.setBio(store.getBio());  
        existingStore.setAvatar(store.getAvatar());
        existingStore.setFeaturedimages(store.getFeaturedimages()); 
        existingStore.setIsactive(store.getIsactive()); 
        existingStore.setUpdateat(new java.sql.Date(System.currentTimeMillis()));

        storeService.save(existingStore);

        return "redirect:/admin/stores"; 
    }
   
    @GetMapping("/products/{id}")
    public String getProductsByStore(@PathVariable("id") Integer storeId, Model model) {
        // Lấy Store dựa trên ID
        Store store = storeService.getById(storeId);
        if (store == null) {
            return "redirect:/admin/stores?error=notfound"; // Chuyển hướng nếu không tìm thấy Store
        }

        // Lấy danh sách sản phẩm của Store
        List<Product> products = productService.getProducts(storeId);
        model.addAttribute("products", products);
        model.addAttribute("store", store);

        // Trả về view hiển thị danh sách sản phẩm
        return "admin/store_product";
    }    
    
    @GetMapping("/listProduct")
    public String listProduct(@RequestParam(required = false) String status, 
                               @RequestParam(required = false) Integer storeId, 
                               @RequestParam(required = false) String searchTerm, // Thêm tham số searchTerm
                               Model model) {    
        // Kiểm tra "status" có phải "all" không
        if ("all".equals(status)) {
            status = null;
        }

        // Kiểm tra nếu storeId là 0 hoặc null thì gán lại là null
        if (storeId == null || storeId == 0) {
            storeId = null;
        } 

        // Lấy danh sách sản phẩm dựa trên storeId, status, và searchTerm
        List<Product> products = productService.findProducts(storeId, status, searchTerm); // Cập nhật phương thức findProducts
        // Thêm URL hình ảnh chính vào từng sản phẩm
        for (Product product : products) {
            ProductImage mainImage = product.getMainImage();
            if (mainImage != null) {
                product.setImageUrls(List.of(mainImage.getImageUrl())); // Sử dụng thuộc tính `imageUrls` để lưu URL hình ảnh chính
            }
        }
        // Truyền dữ liệu vào model
        model.addAttribute("products", products);
        model.addAttribute("status", status);
        model.addAttribute("storeId", storeId);
        model.addAttribute("searchTerm", searchTerm); // Truyền searchTerm vào model

        // Giả sử bạn cũng cần danh sách các store để hiển thị trong dropdown list
        List<Store> stores = storeService.findAll();
        model.addAttribute("stores", stores);

        return "admin/list_Product";  
    }

    // Xử lý yêu cầu POST khi nhấn "Accept"
    @PostMapping("/accept/{id}")
    public String acceptProduct(@PathVariable int id) {
    	Optional<Product> productOptional = productService.findById(id);
        
        if (productOptional.isPresent()) {
            Product product = productOptional.get();
            // Cập nhật trạng thái của sản phẩm
            product.setStatus("Accepted");
            // Lưu lại sản phẩm đã được cập nhật
            productService.save(product);
        }
        return "redirect:/admin/stores/listProduct";  // Reload trang danh sách sản phẩm
    }

    // Xử lý yêu cầu POST khi nhấn "Reject"
    @PostMapping("/reject/{id}")
    public String rejectProduct(@PathVariable int id) {
        productService.deleteById(id);
        return "redirect:/admin/stores/listProduct";  // Reload trang danh sách sản phẩm
    }
}
