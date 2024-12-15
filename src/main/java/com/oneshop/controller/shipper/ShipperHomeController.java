package com.oneshop.controller.shipper;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oneshop.entity.Address;
import com.oneshop.entity.Order;
import com.oneshop.service.IAddressService;
import com.oneshop.service.IBlogService;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IUserService;
import com.oneshop.service.Impl.CloudinaryService;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/shipper/")
public class ShipperHomeController {
	
	@Autowired
	ServletContext application;
	@Autowired
	IProductService productService;
	@Autowired
	HttpSession session;
	@Autowired
	ICartItemService cartItemService;
	@Autowired
	ICartService cartService;
	@Autowired
	ICategoryService categoryService;
	@Autowired
	IOrderService orderService;
	@Autowired
	IAddressService addSer;
	@GetMapping("home")
    public String viewOrdersInTransit(ModelMap model) {
		
        List<Order> ordersInTransit = orderService.getOrdersInTransit();
        List<Optional<Address>> addresses = ordersInTransit.stream()
        	    .map(order -> addSer.findById(order.getId())) // Tìm Address theo ID của từng Order
        	    .collect(Collectors.toList());
        model.addAttribute("ordersInTransit", ordersInTransit);
        model.addAttribute("address", addresses);
        return "shipper/home";
    }

	@PreAuthorize("hasAuthority('ROLE_SHIPPER')")
    @PostMapping("updateOrderStatus")
    public String updateOrderStatus(@RequestParam("orderId") Integer orderId, @RequestParam("status") String status) {
        orderService.updateOrderStatus(orderId, status);
        return "redirect:/shipper/home";
    }
	
}


	
	