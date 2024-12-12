package com.oneshop.controller.user;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.ICartService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/delivery")
public class DeliveryUserController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderItemService orderItemService;
    
    @Autowired
    private ICartItemService cartItemService;

    @Autowired
    private ICartService cartService;

    @ModelAttribute
    public void prepareOrders(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Store store = cartService.getStoreByUserId(user.getId());
            List<Order> orders = orderService.getAllOrdersByCustomerAndStore(user.getId(), store);

            orders.forEach(order -> {
                if (order.getCreateat() != null) {
                    order.setCreateat(order.getCreateAtAsDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime());
                }

                List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(order.getId());

                Map<Store, List<OrderItem>> storeGroupedOrderItems = orderItems.stream()
                        .collect(Collectors.groupingBy(item -> item.getProduct().getStore()));

                storeGroupedOrderItems.forEach((storeKey, items) -> {
                    items.forEach(orderItem -> {
                        Product product = orderItem.getProduct();
                        List<String> imageUrls = product.getImages().stream()
                                .map(ProductImage::getImageUrl)
                                .collect(Collectors.toList());
                        product.setImageUrls(imageUrls);
                    });
                });
                order.setStoreGroupedOrderItems(storeGroupedOrderItems);
            });

            model.addAttribute("orders", orders);
            model.addAttribute("store", store);
        }
    }

    @GetMapping("")
    public String getOrderManager(
            @RequestParam(value = "status", required = false, defaultValue = "all") String status,
            Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login"; 
        }
        
        Store store = cartService.getStoreByUserId(user.getId()); 
        List<Order> orders;
        if ("all".equalsIgnoreCase(status)) {
            orders = orderService.getAllOrdersByCustomerAndStore(user.getId(), store);
        } else {
            orders = orderService.getOrdersByCustomerAndStore(user.getId(), store, status);
        }

        orders.forEach(order -> {
            if (order.getCreateat() != null) {
                order.setCreateat(order.getCreateAtAsDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime());
            }
            List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(order.getId());

            Map<Store, List<OrderItem>> storeGroupedOrderItems = orderItems.stream()
                    .collect(Collectors.groupingBy(item -> item.getProduct().getStore()));

            storeGroupedOrderItems.forEach((storeKey, items) -> {
                items.forEach(orderItem -> {
                    Product product = orderItem.getProduct();
                    List<String> imageUrls = product.getImages().stream()
                            .map(ProductImage::getImageUrl)
                            .collect(Collectors.toList());
                    product.setImageUrls(imageUrls);
                });
            });
            order.setStoreGroupedOrderItems(storeGroupedOrderItems);
        });

        model.addAttribute("orders", orders);
        model.addAttribute("store", store);
        return "/user/delivery/order_manager";  
    }
}
