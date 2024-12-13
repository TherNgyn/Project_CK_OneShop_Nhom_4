package com.oneshop.controller.admin;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oneshop.entity.Product;
import com.oneshop.model.MonthlyRevenue;
import com.oneshop.service.IOrderService;
import com.oneshop.service.Impl.OrderServiceImpl;
import com.oneshop.service.Impl.ProductServiceImpl;
import com.oneshop.service.Impl.UserServiceImpl;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
    private OrderServiceImpl orderService; 
	@Autowired
    private ProductServiceImpl productService; 
	@Autowired
    private UserServiceImpl userService; 
	
    @GetMapping("/home")
    public String adminHome(Model model) {
    	int currentYear = LocalDate.now().getYear();
    	int currentMonth = LocalDate.now().getMonthValue();
    	List<MonthlyRevenue> monthlyRevenues = orderService.calculateMonthlyRevenue(currentYear);

        // Chuyển đổi thành dữ liệu JSP có thể sử dụng
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();

        for (MonthlyRevenue revenue : monthlyRevenues) {
            labels.add("Tháng " + revenue.getMonth());
            values.add(revenue.getRevenue());
        }

        double thisMonthRevenue = values.get(currentMonth - 1);  // Giá trị doanh thu thập được từ dữ liệu
        String formattedRevenue = formatRevenue(thisMonthRevenue);  // Định dạng doanh thu
        model.addAttribute("thisMonthRevenue", formattedRevenue);
        model.addAttribute("numOrder", orderService.count());
        model.addAttribute("numProduct", productService.count());
        model.addAttribute("numCustomer", userService.countCustomer());
        try {
			model.addAttribute("monthlyRevenueLabels", new ObjectMapper().writeValueAsString(labels));
			model.addAttribute("monthlyRevenueValues", new ObjectMapper().writeValueAsString(values));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    
        
        //DS sản phẩm gần đây
        List<Product> listProduct = productService.findTop4ByIsSelling();
        model.addAttribute("product1", listProduct.get(0));
        model.addAttribute("product2", listProduct.get(1));
        model.addAttribute("product3", listProduct.get(2));
        model.addAttribute("product4", listProduct.get(3));
        model.addAttribute("pic1", listProduct.get(0).getMainImage().getImageUrl());
        model.addAttribute("pic2", listProduct.get(1).getMainImage().getImageUrl());
        model.addAttribute("pic3", listProduct.get(2).getMainImage().getImageUrl());
        model.addAttribute("pic4", listProduct.get(3).getMainImage().getImageUrl());
        
        return "admin/home"; 
    }
    
    @GetMapping("/monthly-revenue")
    public String showMonthlyRevenue(Model model) {
        // Lấy doanh thu theo tháng từ service
        List<MonthlyRevenue> monthlyRevenues = orderService.calculateMonthlyRevenue(2024);

        // Chuyển đổi thành dữ liệu JSP có thể sử dụng
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();

        for (MonthlyRevenue revenue : monthlyRevenues) {
            labels.add("Tháng " + revenue.getMonth());
            values.add(revenue.getRevenue());
        }

        // Thêm dữ liệu vào model để sử dụng trong JSP
        try {
			model.addAttribute("monthlyRevenueLabels", new ObjectMapper().writeValueAsString(labels));
			model.addAttribute("monthlyRevenueValues", new ObjectMapper().writeValueAsString(values));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}     
        
        
        return "admin/chart"; // Trả về tên JSP
    }
    
    public String formatRevenue(double revenue) {
        DecimalFormat formatter = new DecimalFormat("#,###");  // Định dạng không có phần thập phân và dấu phẩy
        return formatter.format(revenue);
    }

}