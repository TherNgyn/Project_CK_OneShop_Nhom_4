package com.oneshop.controller.vendor;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IOrderItemService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vendor/manageorder")
public class OrderVendorController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IStoreService storeService;

    @Autowired
    private IOrderItemService orderItemService;

    @Autowired
    private IProductService productService;

    @Autowired
    HttpSession session;

    

    @GetMapping("")
    public String manageOrders(
            @RequestParam(value = "status", required = false, defaultValue = "all") String status,
            @RequestParam(value = "search", required = false) String search,
            Model model) {

        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Store store = storeService.findByOwner(loggedInUser);
        List<Order> orders;

       
            if ("all".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByStore(store.getId());
            } if ("Processing".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByStoreAndStatus2(store, "Processing_1", "Processing_2");
            } else if ("Preparing".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByStoreAndStatus2(store, "Preparing_1", "Preparing_2");
            } else if ("In Transit".equalsIgnoreCase(status)) {
                
                orders = orderService.getOrdersByStoreAndStatus2(store, "In Transit_1", "In Transit_2");
            } else {               
                orders = orderService.getOrdersByStoreAndStatus(store, status);
            }
            
        orders.forEach(order -> {
            List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(order.getId());

            Map<Store, List<OrderItem>> storeGroupedOrderItems = orderItems.stream()
                    .collect(Collectors.groupingBy(item -> item.getProduct().getStore()));

            storeGroupedOrderItems.forEach((storeKey, items) -> {
                items.forEach(orderItem -> {
                    Product product = orderItem.getProduct();
                    product.setImageUrls(product.getImages().stream()
                            .map(image -> image.getImageUrl())
                            .collect(Collectors.toList()));
                });
            });

            order.setStoreGroupedOrderItems(storeGroupedOrderItems);
        });

        model.addAttribute("orders", orders);
        model.addAttribute("store", store);

        return "vendor/order/list"; 
    }

    @GetMapping("/approveOrder")
    public String approveOrder(@RequestParam("orderId") Integer orderId) {
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            return "redirect:/login"; // Redirect if not logged in
        }

        Order order = orderService.getById(orderId);
        
            order.setStatus("Preparing_1");
            orderService.save(order);

        return "redirect:/vendor/manageorder"; 
    }

    @GetMapping("/cancelOrder")
    public String cancelOrder(@RequestParam("orderId") Integer orderId) {
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            return "redirect:/login"; // Redirect if not logged in
        }

        Order order = orderService.getById(orderId);
        order.setStatus("Cancelled");
        orderService.save(order);

        return "redirect:/vendor/manageorder"; // Redirect to order management after cancellation
    }
}
