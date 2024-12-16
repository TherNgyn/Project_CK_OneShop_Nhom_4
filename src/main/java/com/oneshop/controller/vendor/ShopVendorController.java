package com.oneshop.controller.vendor;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.Impl.CloudinaryService;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/vendor")
public class ShopVendorController {

    @Autowired
    private IStoreService storeService;

    @Autowired
    private CloudinaryService cloudinaryService;
    
    @Autowired IProductService productService;

    @PostMapping("/savedecoration")
    public String saveShop(@RequestParam("storeId") Integer storeId,
                           @RequestParam("storeName") String storeName,
                           @RequestParam("storeAvatar") MultipartFile avatar,
                           @RequestParam("storeDescription") String storeDescription,
                           @RequestParam("storeStatus") String storeStatus,
                           @RequestParam("storeImage") MultipartFile storeImage,
                           RedirectAttributes redirectAttributes) {

        Store store = storeService.getById(storeId);
        if (store == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy thông tin cửa hàng.");
            return "redirect:/user/storedetail/" + storeId;
        }
        
        store.setName(storeName);
        store.setBio(storeDescription);
        store.setIsactive("active".equalsIgnoreCase(storeStatus));

        if (storeImage != null && !storeImage.isEmpty()) {
            try {
                String imageUrl = cloudinaryService.uploadFile(storeImage);
                store.setFeaturedimages(imageUrl);
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Không thể upload ảnh: " + e.getMessage());
                return "redirect:/user/storedetail/" + storeId;
            }
        }

        if (avatar != null && !avatar.isEmpty()) {
            try {
                String avatarUrl = cloudinaryService.uploadFile(avatar);
                store.setAvatar(avatarUrl);
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Không thể upload ảnh đại diện: " + e.getMessage());
                return "redirect:/user/storedetail/" + storeId;
            }
        }

        storeService.save(store);
        redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin thành công!");

        return "redirect:/user/storedetail/" + storeId;
    }
}
