package com.oneshop.controller.admin;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oneshop.entity.Delivery;
import com.oneshop.service.Impl.DeliveryServiceImpl;

@Controller
@RequestMapping("/admin/deliveries")
public class DeliveryController {

    @Autowired
    private DeliveryServiceImpl deliveryService;

    // Get list of deliveries, with optional search filter by name
    @GetMapping("")
    public String listDeliveries(Model model, 
                                @RequestParam(value = "search", required = false) String search) {
        
        // Call service to find deliveries based on search name
        List<Delivery> deliveries = deliveryService.findDeliveries(search);
        
        // Add attributes to the model for displaying in the view
        model.addAttribute("deliveries", deliveries);
        model.addAttribute("searchTerm", search);  // Retain search term to show in the search input
        
        return "admin/Delivery_Manage";
    }

    // POST method for searching deliveries by name
    @PostMapping("/search")
    public String searchDeliveries(Model model, 
                                   @RequestParam(value = "search", required = false) String search) {
        
        List<Delivery> deliveries = deliveryService.findDeliveries(search);
        
        model.addAttribute("deliveries", deliveries);
        model.addAttribute("searchTerm", search);
        
        return "admin/Delivery_Manage";
    }

    // Show form for adding a new delivery
    @GetMapping("/add")
    public String addDeliveryForm(Model model) {
        model.addAttribute("delivery", new Delivery());
        return "admin/add-edit-delivery";
    }

    // Show form for editing an existing delivery
    @GetMapping("/edit/{id}")
    public String editDeliveryForm(@PathVariable Integer id, Model model) {
        Delivery delivery = deliveryService.getById(id);
        model.addAttribute("delivery", delivery);
        return "admin/add-edit-delivery";
    }

    // Save or update a delivery
    @PostMapping("/save")
    public String saveDelivery(@ModelAttribute Delivery delivery, Model model) {
        
        // Kiểm tra nếu tên giao hàng đã tồn tại
        Delivery existingDeliveryByName = deliveryService.getByName(delivery.getName()); // Sử dụng phương thức getByName để kiểm tra tên
        if (existingDeliveryByName != null && !existingDeliveryByName.getId().equals(delivery.getId())) {
            model.addAttribute("error", "Tên phương thức giao hàng đã tồn tại!");
            return "admin/add-edit-delivery"; // Hiển thị lỗi trên form
        }
        
        // Kiểm tra nếu giá trị price, description hoặc createdAt null hoặc không hợp lệ
        if (delivery.getPrice() == null || delivery.getPrice() <= 0) {
            model.addAttribute("error", "Giá giao hàng không hợp lệ!");
            return "admin/add-edit-delivery";
        }
        
        // Thiết lập thời gian hiện tại cho updateat
        delivery.setUpdateat(new Date(System.currentTimeMillis()));

        // Nếu là danh mục mới (id == null), thiết lập createat
        if (delivery.getId() == null) {
            delivery.setCreateat(new Date(System.currentTimeMillis()));
        }
        // Lưu giao hàng (cập nhật hoặc tạo mới)
        deliveryService.save(delivery);
        return "redirect:/admin/deliveries"; // Điều hướng về trang danh sách giao hàng
    }

    // Delete a delivery
    @PostMapping("/delete")
    public String deleteDelivery(@RequestParam Integer id, RedirectAttributes redirectAttributes) {
        try {
        	Delivery delivery = deliveryService.getById(id);
        	delivery.setIsDeleted(true);
            deliveryService.save(delivery);
            redirectAttributes.addFlashAttribute("success", "Xóa phương thức giao hàng thành công!");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/deliveries"; // Redirect to list page
    }
}
