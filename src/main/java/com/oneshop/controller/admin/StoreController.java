package com.oneshop.controller.admin;

import com.oneshop.entity.Store;
import com.oneshop.service.Impl.StoreServiceImpl;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/admin/stores")
public class StoreController {

    @Autowired
    private StoreServiceImpl storeService;

    @GetMapping("")
    public String listStores(Model model) {
        List<Store> stores = storeService.findAll();
        model.addAttribute("stores", stores);
        return "admin/Store_Manage";
    }

    @GetMapping("/add")
    public String addStoreForm(Model model) {
        model.addAttribute("store", new Store());
        return "admin/add_store";
    }

    @PostMapping("/add")
    public String addStore(@ModelAttribute Store store) {
        storeService.saveStore(store);
        return "redirect:/admin/stores";
    }

    @GetMapping("/edit/{id}")
    public String editStoreForm(@PathVariable("id") Integer id, Model model) {
        Store store = storeService.getById(id);
        model.addAttribute("store", store);
        return "admin/edit_store";
    }

    @PostMapping("/edit/{id}")
    public String updateStore(@PathVariable("id") Integer id, @ModelAttribute @Valid Store store, BindingResult result) {
        if (result.hasErrors()) {
            return "admin/store/edit"; // Nếu có lỗi validation, quay lại form chỉnh sửa
        }

        // Kiểm tra nếu updateat là rỗng và không cần cập nhật
        if (store.getUpdateat() == null || store.getUpdateat().toString().isEmpty()) {
            store.setUpdateat(new java.sql.Date(System.currentTimeMillis())); // Gán ngày hiện tại nếu rỗng
        }

        store.setId(id); // Đảm bảo ID không bị thay đổi
        storeService.save(store); // Cập nhật Store trong cơ sở dữ liệu
        return "redirect:/admin/stores"; // Sau khi cập nhật, chuyển hướng về danh sách Store
    }


    @PostMapping("/delete/{id}")
    public String deleteStore(@PathVariable("id") Integer id) {
        storeService.deleteById(id);
        return "redirect:/admin/stores";
    }
}
