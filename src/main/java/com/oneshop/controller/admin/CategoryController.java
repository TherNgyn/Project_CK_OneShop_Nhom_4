package com.oneshop.controller.admin;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oneshop.entity.Category;
import com.oneshop.service.Impl.CategoryServiceImpl;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryServiceImpl categoryService;

    // Get list of categories, with optional search filter by name
    @GetMapping("")
    public String listCategories(Model model, 
                                @RequestParam(value = "search", required = false) String search) {
        
        // Call service to find categories based on search name
        List<Category> categories = categoryService.findCategories(search);
        
        // Add attributes to the model for displaying in the view
        model.addAttribute("categories", categories);
        model.addAttribute("searchTerm", search); // Retain search term to show in the search input
        
        return "admin/Category_Manage";
    }

    // POST method for searching categories by name
    @PostMapping("/search")
    public String searchCategories(Model model, 
                                   @RequestParam(value = "search", required = false) String search) {
        
        List<Category> categories = categoryService.findCategories(search);
        
        model.addAttribute("categories", categories);
        model.addAttribute("searchTerm", search);
        
        return "admin/Category_Manage";
    }

    // Show form for adding a new category
    @GetMapping("/add")
    public String addCategoryForm(Model model) {
        model.addAttribute("category", new Category());
        return "admin/add-edit-category";
    }

    // Show form for editing an existing category
    @GetMapping("/edit/{id}")
    public String editCategoryForm(@PathVariable Integer id, Model model) {
        Category category = categoryService.getById(id);
        model.addAttribute("category", category);
        return "admin/add-edit-category";
    }

    // Save or update a category
    @PostMapping("/save")
    public String saveCategory(@ModelAttribute Category category, Model model) {
        
        // Kiểm tra nếu tên danh mục đã tồn tại
        Category existingCategoryByName = categoryService.findOneByName(category.getName());
        if (existingCategoryByName != null && !existingCategoryByName.getId().equals(category.getId())) {
            model.addAttribute("error", "Tên danh mục đã tồn tại!");
            return "admin/add-edit-category"; // Hiển thị lỗi trên form
        }
        
        // Kiểm tra nếu giá trị các trường cần thiết là null hoặc không hợp lệ
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            model.addAttribute("error", "Tên danh mục không được để trống!");
            return "admin/add-edit-category";
        }
        
     // Thiết lập thời gian hiện tại cho updateat
        category.setUpdateat(new Date(System.currentTimeMillis()));

        // Nếu là danh mục mới (id == null), thiết lập createat
        if (category.getId() == null) {
        	category.setCreateat(new Date(System.currentTimeMillis()));
        }
        
        // Lưu danh mục (cập nhật hoặc tạo mới)
        categoryService.save(category);
        return "redirect:/admin/categories"; // Điều hướng về trang danh sách danh mục
    }

    // Delete a category (soft delete)
    @PostMapping("/delete")
    public String deleteCategory(@RequestParam Integer id, RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.getById(id);
            category.setIsDeleted(true);
            categoryService.save(category);
            redirectAttributes.addFlashAttribute("success", "Xóa danh mục thành công!");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/categories"; // Redirect to list page
    }
}
