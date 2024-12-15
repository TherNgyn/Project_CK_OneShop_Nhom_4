package com.oneshop.controller.vendor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oneshop.entity.Order;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.model.RevenueData;
import com.oneshop.service.IInventoryService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vendor/managerevenue")
public class RevenueVendorController {
	@Autowired
    private IOrderService orderService;

    @Autowired
    private IStoreService storeService;

    @Autowired
    private IOrderItemService orderItemService;

    @Autowired
    private IProductService productService;
    
    @Autowired
    private IInventoryService inventoryService;

    @Autowired
    HttpSession session;
    
    @GetMapping("")
    public String viewRevenue(
            ModelMap model) {

    	// Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
		
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Store store = storeService.findByOwner(loggedInUser);
        List<Order> orders = orderService.getOrdersByStoreAndStatus(store, "Completed");
   
        
        Double revenue = orderService.viewSumRevenue();
        
        model.addAttribute("revenue", revenue);
        model.addAttribute("store", store); 
        model.addAttribute("orders", orders);
        
        return "vendor/revenue";
    }

}
