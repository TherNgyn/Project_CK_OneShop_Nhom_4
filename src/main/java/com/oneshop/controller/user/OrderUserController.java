package com.oneshop.controller.user;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oneshop.entity.Address;
import com.oneshop.entity.Delivery;
import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.User;
import com.oneshop.service.IAddressService;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.IDeliveryService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/order")
public class OrderUserController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ICartService cartService;

    @Autowired
    private ICartItemService cartItemService;

    @Autowired
    private IOrderItemService orderItemService;

    @Autowired
    private IDeliveryService deliveryService;

    @Autowired
    private IAddressService addressService;

    @RequestMapping("")
    public String order(ModelMap model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        Order latestOrder = orderService.findLatestOrder(user); 
        if (latestOrder == null) {
            return "redirect:/user/products"; 
        }
        
        List<Address> userAddresses = addressService.findByUser(user);
        List<Delivery> deliveries = deliveryService.findAll();

        if (userAddresses.isEmpty()) {
            model.addAttribute("error", "Bạn chưa có địa chỉ giao hàng. Vui lòng thêm địa chỉ.");
        }

        if (deliveries.isEmpty()) {
            model.addAttribute("error", "Không có đơn vị giao hàng nào. Vui lòng liên hệ quản trị.");
        }

        List<OrderItem> listItem = orderItemService.findByOrderId(latestOrder.getId());
        if (listItem == null || listItem.isEmpty()) {
            listItem = new ArrayList<>();
        }
        double totalPrice = listItem.stream()
                .mapToDouble(item -> item.getCount() * item.getProduct().getPrice())
                .sum();

        model.addAttribute("listcart", listItem);
        model.addAttribute("price", totalPrice);
        model.addAttribute("addresses", userAddresses);
        model.addAttribute("deliveries", deliveries);
        return "user/order/order";
    }
    @RequestMapping(value = "/checkout", method = RequestMethod.POST)
    public String checkout(@RequestParam(value = "addressId", required = false) Integer addressId,
                           @RequestParam(value = "deliveryId", required = false) Integer deliveryId,
                           @RequestParam(value = "newAddressLine1", required = false) String newAddressLine1,
                           @RequestParam(value = "newAddressLine2", required = false) String newAddressLine2,
                           @RequestParam(value = "newCity", required = false) String newCity,
                           @RequestParam(value = "isPrimary", required = false) Boolean isPrimary,
                           HttpServletRequest request, ModelMap model) {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Address selectedAddress = null;

        if (addressId != null) {
            selectedAddress = addressService.findById(addressId).orElse(null);
        }

        if (newAddressLine1 != null && !newAddressLine1.trim().isEmpty() && 
        	    newCity != null && !newCity.trim().isEmpty()) {
        	    System.out.println("Received new address: " + newAddressLine1 + ", " + newCity);
        	    Address newAddress = new Address();
        	    newAddress.setUser(user);
        	    newAddress.setAddressLine1(newAddressLine1.trim());
        	    newAddress.setAddressLine2(newAddressLine2 != null ? newAddressLine2.trim() : "");
        	    newAddress.setCity(newCity.trim());
        	    newAddress.setIsPrimary(isPrimary != null && isPrimary);
        	    addressService.save(newAddress); // Save new address
        	    selectedAddress = newAddress;
        	}


        if (selectedAddress == null) {
            model.addAttribute("error", "Vui lòng chọn hoặc nhập địa chỉ giao hàng!");
            return "user/order/order";
        }

        Delivery selectedDelivery = deliveryService.findById(deliveryId).orElse(null);
        if (selectedDelivery == null) {
            model.addAttribute("error", "Vui lòng chọn đơn vị giao hàng!");
            return "user/order/order";
        }

        Order latestOrder = orderService.findLatestOrder(user);
        if (latestOrder == null) {
            return "redirect:/user/products";
        }

        List<OrderItem> listItem = orderItemService.findByOrderId(latestOrder.getId());
        double totalPrice = listItem.stream()
                .mapToDouble(item -> item.getCount() * item.getProduct().getPrice())
                .sum();

        float finalTotal = (float) (totalPrice + selectedDelivery.getPrice());

        latestOrder.setStatus("Processing");
        latestOrder.setAddress(selectedAddress);
        latestOrder.setDelivery(selectedDelivery);
        latestOrder.setPrice(finalTotal); // Lưu tổng tiền vào cột price của order
        orderService.save(latestOrder);

        model.addAttribute("listcart", listItem);
        model.addAttribute("price", finalTotal);

        return "redirect:/user/order/payment";
    }
    
    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public String payment(ModelMap model, HttpServletRequest request) {
    	User user = (User) request.getSession().getAttribute("user");
    	Order order = orderService.findLatestOrder(user); 
    	String paymentCode = "https://img.vietqr.io/image/VCB-1025984614-compact.png?amount=" + order.getPrice() + "&addInfo=<" + "Thanh toán đơn hàng " + order.getId() + ">&accountName=PHAMQUYNHTHU";
    	model.addAttribute("paymentCode", paymentCode);
        return "user/order/payment";  
    }
    
    @RequestMapping(value = "/payment", method = RequestMethod.POST)
    public String payment(@RequestParam(value = "paymentMethod", required = false) String paymentMethod, HttpServletRequest request) {
    	User user = (User) request.getSession().getAttribute("user");
		Order order = orderService.findLatestOrder(user);
    	if ("cod".equals(paymentMethod)) {    
    		order.setStatus("Processing_1");
    		orderService.update(order);
    		cartItemService.deleteCartItem(order.getId(), user.getId());
    		return "redirect:/user/order/confirmation";
    	}else if ("online".equals(paymentMethod)) {
    		order.setStatus("Processing_2");
    		orderService.update(order);
    		cartItemService.deleteCartItem(order.getId(), user.getId());
    		return "redirect:/user/order/confirmation";
    	} else {
    		return "redirect:/user/order/payment";
    	}
    	
    }
    
    
    @RequestMapping(value = "/confirmation", method = RequestMethod.GET)
    public String confirmationPage() {
        return "user/order/confirmation";  
    }
}
