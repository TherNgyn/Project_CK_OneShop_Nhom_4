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
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oneshop.entity.Product;
import com.oneshop.model.MonthlyRevenue;
import com.oneshop.model.YearlyRevenue;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.Impl.OrderServiceImpl;
import com.oneshop.service.Impl.UserServiceImpl;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
    private OrderServiceImpl orderService; 
	@Autowired
    private IProductService productService; 
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
    public String showMonthlyRevenue(@RequestParam(value = "year", required = false) Integer year, Model model) {
    	// Lấy danh sách năm từ OrderService
        List<Integer> years = orderService.getDistinctYearsFromOrders();
        
        // Nếu không có năm được chọn, mặc định lấy năm đầu tiên trong danh sách
        if (year == null && !years.isEmpty()) {
            year = years.get(0);
        }
        // Lấy dữ liệu doanh thu theo năm
        List<MonthlyRevenue> monthlyRevenues = orderService.calculateMonthlyRevenue(year);

        // Chuẩn bị dữ liệu cho biểu đồ
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();
        for (MonthlyRevenue revenue : monthlyRevenues) {
            labels.add("Tháng " + revenue.getMonth());
            values.add(revenue.getRevenue());
        }

        // Truyền dữ liệu vào model
        model.addAttribute("years", years);
        model.addAttribute("selectedYear", Integer.valueOf(year));
        try {
			model.addAttribute("monthlyRevenueLabels", new ObjectMapper().writeValueAsString(labels));
			model.addAttribute("monthlyRevenueValues", new ObjectMapper().writeValueAsString(values));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
        return "admin/chart";
    }

    @GetMapping("/yearly-revenue")
    public String showYearlyRevenue(Model model) {
        // Lấy dữ liệu doanh thu theo năm từ service
        List<YearlyRevenue> yearlyRevenues = orderService.calculateYearlyRevenue();

        // Chuẩn bị dữ liệu cho biểu đồ
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();
        for (YearlyRevenue revenue : yearlyRevenues) {
            labels.add("Năm " + revenue.getYear());
            values.add(revenue.getRevenue());
        }

        // Truyền dữ liệu vào model
        try {
            model.addAttribute("yearlyRevenueLabels", new ObjectMapper().writeValueAsString(labels));
            model.addAttribute("yearlyRevenueValues", new ObjectMapper().writeValueAsString(values));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return "admin/chartByYear";
    }

    
    public String formatRevenue(double revenue) {
        DecimalFormat formatter = new DecimalFormat("#,###");  // Định dạng không có phần thập phân và dấu phẩy
        return formatter.format(revenue);
    }

}