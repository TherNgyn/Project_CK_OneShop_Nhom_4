package com.oneshop.controller.vendor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oneshop.entity.Inventory;
import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IInventoryService;
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
    private IInventoryService inventoryService;

    @Autowired
    HttpSession session;

   
    @GetMapping("")
    public String manageOrders(
            @RequestParam(value = "status", required = false, defaultValue = "all") String status,
            Model model) {

    	// Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("user");
		
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        
        Store store = storeService.findByOwner(loggedInUser);

        List<Order> orders = null;
        if ("all".equalsIgnoreCase(status)) {
            orders = orderService.getOrdersByStore(store.getId());
        } else if ("Processing".equalsIgnoreCase(status)) {
            orders = orderService.getOrdersByStoreAndStatus2(store, "Processing_1", "Processing_2");
        } else if ("Preparing".equalsIgnoreCase(status)) {
            orders = orderService.getOrdersByStoreAndStatus2(store, "Preparing_1", "Preparing_2");
        } else if ("In Transit".equalsIgnoreCase(status)) {
            orders = orderService.getOrdersByStoreAndStatus2(store, "In Transit_1", "In Transit_2");
        } else if ("Cancelled".equalsIgnoreCase(status)){
        	orders = orderService.getOrdersByStoreAndStatus(store, "Cancelled");
        } else if ("Completed".equalsIgnoreCase(status)) {
        	orders = orderService.getOrdersByStoreAndStatus(store, "Completed");
        }
        
        if (orders != null) {
            orders.forEach(order -> {
                List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(order.getId());

                if (orderItems != null && !orderItems.isEmpty()) { 
                    Map<Store, List<OrderItem>> storeGroupedOrderItems = orderItems.stream()
                            .filter(item -> item.getProduct() != null && item.getProduct().getStore() != null) // Lọc null
                            .collect(Collectors.groupingBy(item -> item.getProduct().getStore()));

                    storeGroupedOrderItems.forEach((storeKey, items) -> {
                        if (items != null) { 
                            items.forEach(orderItem -> {
                                Product product = orderItem.getProduct();
                                if (product != null && product.getImages() != null) {
                                    List<String> imageUrls = product.getImages().stream()
                                            .map(ProductImage::getImageUrl)
                                            .filter(Objects::nonNull)
                                            .collect(Collectors.toList());
                                    product.setImageUrls(imageUrls);
                                }
                            });
                        }
                    });
                    order.setStoreGroupedOrderItems(storeGroupedOrderItems);
                }
            });
        }
        
        model.addAttribute("orders", orders);
        model.addAttribute("store", store);

        // Trả về view
        return "vendor/order/list"; // Đường dẫn view JSP
    }
    @GetMapping("/approveOrder")
    public String approveOrder(@RequestParam("orderId") Integer orderId, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            return "redirect:/login"; 
        }
        
        Order order = orderService.getById(orderId);
        
        for (OrderItem item : order.getOrderItems()) {
            Product product = item.getProduct(); // Lấy sản phẩm 
            int orderedQuantity = item.getCount(); // Số lượng đã đặt
            
            // Truy cập kho hàng
            Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
            if (inventory != null) {
                // Kiểm tra số lượng tồn kho
                if (inventory.getQuantity() < orderedQuantity) {
                    redirectAttributes.addFlashAttribute("error", "insufficientInventory");
                    return "redirect:/vendor/manageorder"; // Báo lỗi nếu không đủ hàng
                }

                // Trừ số lượng tồn kho
                inventory.setQuantity(inventory.getQuantity() - orderedQuantity);
                inventoryService.save(inventory); // Lưu cập nhật
            } else {
                redirectAttributes.addFlashAttribute("error", "noInventory");
                return "redirect:/vendor/manageorder"; // Báo lỗi nếu không tìm thấy
            }
            product.setSold(product.getSold() + orderedQuantity);
            productService.save(product);
        }
            
        order.setStatus("Preparing_1");
        orderService.save(order);

        return "redirect:/vendor/manageorder"; 
    }

    @GetMapping("/cancelOrder")
    public String cancelOrder(@RequestParam("orderId") Integer orderId, RedirectAttributes redirectAttributes) {
        Order order = orderService.getById(orderId);

        if (order == null) {
            redirectAttributes.addFlashAttribute("error", "orderNotFound");
            return "redirect:/vendor/manageorder";
        }

        if (!order.getStatus().equals("Processing_1")) {
            redirectAttributes.addFlashAttribute("error", "invalidOrderStatus");
            return "redirect:/vendor/manageorder";
        }
        order.setStatus("Cancelled");
        orderService.save(order);

        return "redirect:/vendor/manageorder";
    }

    @GetMapping("/sendToShipping")
    public String sendToShipping(@RequestParam("orderId") Integer orderId, RedirectAttributes redirectAttributes) {
        Order order = orderService.getById(orderId);

        if (order == null) {
            redirectAttributes.addFlashAttribute("error", "orderNotFound");
            return "redirect:/vendor/manageorder";
        }

        if (!order.getStatus().equals("Preparing_1")) {
            redirectAttributes.addFlashAttribute("error", "invalidOrderStatus");
            return "redirect:/vendor/manageorder";
        }
        order.setStatus("In Transit_1");
        orderService.save(order);

        return "redirect:/vendor/manageorder";
    }
}
