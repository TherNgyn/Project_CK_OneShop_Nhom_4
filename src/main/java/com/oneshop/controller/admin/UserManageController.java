package com.oneshop.controller.admin;

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

import com.oneshop.entity.User;
import com.oneshop.service.Impl.UserServiceImpl;

@Controller
@RequestMapping("/admin/users")
public class UserManageController {

    @Autowired
    private UserServiceImpl userService;

    @GetMapping("")
    public String listUsers(Model model, 
                            @RequestParam(value = "search", required = false) String search,
                            @RequestParam(value = "role", required = false) String role) {
        
        // Call service to find users based on both search and role
        List<User> users = userService.findUsers(search, role);
        
        // Predefined roles for the select box
        List<String> roles = List.of("ROLE_USER", "ROLE_VENDOR", "ROLE_ADMIN", "ROLE_DELIVERY");
        
        // Add attributes to the model
        model.addAttribute("users", users);
        model.addAttribute("roles", roles);
        model.addAttribute("selectedRole", role);  // Selected role to highlight in the dropdown
        model.addAttribute("searchTerm", search);  // Retain search term to show in the search input
        
        return "admin/User_Manage";
    }

    
    @PostMapping("search")
    public String listUsersBySearch(Model model, 
                            @RequestParam(value = "search", required = false) String search,
                            @RequestParam(value = "role", required = false) String role) {

        // Call service to find users based on both search and role
        List<User> users = userService.findUsers(search, role);
        
        // Predefined roles for the select box
        List<String> roles = List.of("ROLE_USER", "ROLE_VENDOR", "ROLE_ADMIN", "ROLE_DELIVERY");
        
        // Add attributes to the model
        model.addAttribute("users", users);
        model.addAttribute("roles", roles);
        model.addAttribute("selectedRole", role);
        model.addAttribute("searchTerm", search);  // For retaining the search value in the UI
        
        return "admin/User_Manage";
    }


    @GetMapping("/add")
    public String addUserForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/add-edit-user";
    }

    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable Integer id, Model model) {
        User user = userService.getById(id);
        model.addAttribute("user", user);
        return "admin/add-edit-user";
    }

    @PostMapping("/save")
    public String saveUser(@ModelAttribute User user, Model model) {
        // Kiểm tra trùng số điện thoại (bỏ qua chính người dùng đang sửa)
        User existingUserByPhone = userService.findByPhone(user.getPhone());
        if (existingUserByPhone != null && !existingUserByPhone.getId().equals(user.getId())) {
            model.addAttribute("error", "Số điện thoại đã tồn tại!");
            return "admin/add-edit-user"; // Quay lại trang thêm/sửa người dùng với thông báo lỗi
        }

        // Kiểm tra trùng email (bỏ qua chính người dùng đang sửa)
        User existingUserByEmail = userService.findByEmail(user.getEmail());
        if (existingUserByEmail != null && !existingUserByEmail.getId().equals(user.getId())) {
            model.addAttribute("error", "Email đã tồn tại!");
            return "admin/add-edit-user"; // Quay lại trang thêm/sửa người dùng với thông báo lỗi
        }
        
     // Kiểm tra trùng username (bỏ qua chính người dùng đang sửa)
        User existingUserByUsername = userService.findByUsername(user.getUsername());
        if (existingUserByUsername != null && !existingUserByUsername.getId().equals(user.getId())) {
            model.addAttribute("error", "Tên người dùng đã tồn tại!");
            return "admin/add-edit-user"; // Quay lại trang thêm/sửa người dùng với thông báo lỗi
        }

        // Nếu không trùng, thực hiện lưu thông tin người dùng
        userService.save(user);
        return "redirect:/admin/users"; // Chuyển hướng về trang danh sách người dùng
    }

    @PostMapping("/delete")
    public String deleteUser(@RequestParam Integer id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("success", "Xóa người dùng thành công!");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/users";
    }

}