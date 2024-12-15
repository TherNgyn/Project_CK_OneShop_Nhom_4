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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Order;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.model.CategoryModel;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.Impl.CloudinaryService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vendor")
public class HomeVendorController {

	@Autowired
    private IStoreService storeService;

	@Autowired
    private HttpSession session;
	
	 @Autowired
	 private Cloudinary cloudinary;
    @Autowired
    private ICategoryService categoryService;
    
    @Autowired IProductService productService;
    
    @Autowired
    private IOrderService orderService;

    @GetMapping("")
    public ModelAndView vendorHomeSession(ModelMap model) {
        // Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
              
        if ("ROLE_VENDOR".equals(loggedInUser.getRole())) {
            // Truy vấn để lấy store dựa trên ownerid
            Store vendorStore = storeService.findByOwner(loggedInUser);
            System.out.println("Store ID: " + vendorStore.getId());

            // Thêm thông tin cửa hàng vào model
            model.addAttribute("store", vendorStore);
        }
        
        return new ModelAndView("vendor/home", model);
    }
    
    @GetMapping("/home")
    public ModelAndView vendorHome(ModelMap model) {
        // Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
		
        if (loggedInUser == null) {
            return new ModelAndView("redirect:/login");
        }
        
        if ("ROLE_VENDOR".equals(loggedInUser.getRole())) {
            // Truy vấn để lấy store dựa trên ownerid
            Store vendorStore = storeService.findByOwner(loggedInUser);
            // Thêm thông tin cửa hàng vào model
            model.addAttribute("store", vendorStore);
        } else {
        	return new ModelAndView("redirect:/login");
        }
        
        Store vendorStore = storeService.findByOwner(loggedInUser);
        // Thêm thông tin cửa hàng vào model
        model.addAttribute("store", vendorStore);
        
        List<Product> products = productService.findProductByStore(vendorStore);
     // Lấy các sản phẩm gần hết hàng
        List<Product> lowInventoryProducts = productService.getLowStockProducts(vendorStore, 10); // Ngưỡng là 10 sản phẩm
        model.addAttribute("lowInventoryProducts", lowInventoryProducts);
        
        List<Order> latestOrders = orderService.getLatestOrders();
        model.addAttribute("latestOrders", latestOrders);
        
        Double todayRevenue = orderService.getTodayRevenue();
        if (todayRevenue == null) {
            todayRevenue = 0.0;
        }
        
        // Truyền dữ liệu vào model
        model.addAttribute("todayRevenue", todayRevenue);
        
        long pendingOrders = orderService.countPendingOrders();
        model.addAttribute("pendingOrders", pendingOrders);
        
        long newOrderCount = orderService.getNewOrderCount();
       
        model.addAttribute("newOrderCount", newOrderCount);
        
        return new ModelAndView("vendor/home", model);
    }
    @RequestMapping("/storedetail/{id}")
    public String getStore(@PathVariable("id") Integer storeId, ModelMap model, Pageable pageable) {
    	
        Store store = storeService.getById(storeId);
        int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
    	
       Page<Product> productPage = productService.findByStore(store, PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));
       
       productPage.forEach(product -> {
           // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
           List<String> imageUrls = product.getImages().stream()
                                          .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                          .collect(Collectors.toList());
           product.setImageUrls(imageUrls);
       });
          
       addPaginationAttributes(model, pageable, productPage);
       model.addAttribute("productPage", productPage);
       model.addAttribute("store", store);
       return "user/store";
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
    
    @GetMapping("/decorate/{id}")
    public String decorateShop(@PathVariable("id") Integer storeId, ModelMap model) {
    	Store store = storeService.getById(storeId);
    	model.addAttribute("store", store);
        return "vendor/decoration";
    }

    @GetMapping("/profile")
    public String shopProfile(ModelMap model, @RequestParam("storeId") Integer storeId) {
        Store store = storeService.getById(storeId);
        model.addAttribute("store", store);
        return "vendor/profile";
    }
}
