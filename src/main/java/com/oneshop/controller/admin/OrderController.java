package com.oneshop.controller.admin;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Store;
import com.oneshop.service.Impl.OrderServiceImpl;
import com.oneshop.service.Impl.StoreServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrderServiceImpl orderService;

    @Autowired
    private StoreServiceImpl storeService;

    @GetMapping("")
    public String listOrders(@RequestParam(required = false) String status,
                             @RequestParam(required = false) String searchTerm,
                             Model model) {

        // Xử lý giá trị "all" cho status
        if ("all".equals(status)) {
            status = null;
        }

        // Lấy danh sách đơn hàng dựa trên status và searchTerm
        List<Order> orders = orderService.findOrders(status, searchTerm);
        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("searchTerm", searchTerm);

        // Lấy danh sách các store (nếu cần dùng cho mục đích khác)
        List<Store> stores = storeService.findAll();
        model.addAttribute("stores", stores);

        return "admin/list_Order";
    }

    @GetMapping("/{orderId}")
    public String getOrderDetails(@PathVariable("orderId") Integer orderId, Model model) {
        // Lấy thông tin đơn hàng theo ID
        Order order = orderService.getById(orderId);
        if (order == null) {
            model.addAttribute("error", "Order not found!");
            return "admin/orders";
        }

        // Lấy danh sách sản phẩm trong đơn hàng
        List<OrderItem> orderItems = order.getOrderItems();

        // Gắn dữ liệu vào model để truyền sang giao diện
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);

        return "admin/order_product"; 
    }
    
}
