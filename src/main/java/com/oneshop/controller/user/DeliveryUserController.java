package com.oneshop.controller.user;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.ICartService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;

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
    private ICartService cartService;

    @ModelAttribute
    public void prepareOrders(Model model, HttpServletRequest request,
                              @RequestParam(value = "search", required = false) String search) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Store store = cartService.getStoreByUserId(user.getId());
            List<Order> orders;

            if (search == null || search.isEmpty()) {
                orders = orderService.getAllOrdersByCustomer(user.getId());
            } else {
                orders = orderService.searchOrdersByProductName(user.getId(), search);
            }

            orders.forEach(order -> {
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
            @RequestParam(value = "search", required = false) String search,
            Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Store store = cartService.getStoreByUserId(user.getId());
        List<Order> orders;

        if (search == null || search.isEmpty()) {
            if ("all".equalsIgnoreCase(status)) {
                orders = orderService.getAllOrdersByCustomerAndStore(user.getId(), store)
                                     .stream()
                                     .filter(order -> !"Waiting".equalsIgnoreCase(order.getStatus()))
                                     .collect(Collectors.toList());
            } else if ("Processing".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByCustomer(user.getId(), "Processing_1", "Processing_2");
            } else if ("Preparing".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByCustomer(user.getId(), "Preparing_1", "Preparing_2");
            } else if ("In Transit".equalsIgnoreCase(status)) {
                orders = orderService.getOrdersByCustomer(user.getId(), "In Transit_1", "In Transit_2");
            } else {
                orders = orderService.getOrdersByCustomer(user.getId(), status)
                                     .stream()
                                     .filter(order -> !"Waiting".equalsIgnoreCase(order.getStatus()))
                                     .collect(Collectors.toList());
            }
        } else {
            orders = orderService.searchOrdersByProductNameAndStatus(user.getId(), search, status)
                                 .stream()
                                 .filter(order -> !"Waiting".equalsIgnoreCase(order.getStatus()))
                                 .collect(Collectors.toList());
        }

        orders.forEach(order -> {
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
        model.addAttribute("search", search); 
        return "/user/delivery/order_manager";
    }


    @PostMapping("/cancel")
    public ResponseEntity<String> cancelOrder(@RequestBody Map<String, Integer> requestBody) {
        Integer orderId = requestBody.get("orderId");
        if (orderId == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Order ID is required.");
        }

        Optional<Order> orderOpt = orderService.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if ("Processing_1".equals(order.getStatus()) || "Processing_2".equals(order.getStatus())) {
                order.setStatus("Cancelled");
                orderService.save(order);
                return ResponseEntity.ok("Order cancelled successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Cannot cancel order with status: " + order.getStatus());
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order not found.");
    }


    
    @GetMapping("/search")
    public String searchOrders(
            @RequestParam("search") String search,
            Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Order> orders = orderService.searchOrdersByProductName(user.getId(), search)
                                         .stream()
                                         .filter(order -> !"Waiting".equalsIgnoreCase(order.getStatus()))
                                         .collect(Collectors.toList());

        enrichOrderData(orders);

        model.addAttribute("orders", orders);
        model.addAttribute("search", search);
        return "/user/delivery/order_manager";
    }
    private void enrichOrderData(List<Order> orders) {
        orders.forEach(order -> {
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
    }
   


}
