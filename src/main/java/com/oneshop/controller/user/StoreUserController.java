package com.oneshop.controller.user;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;

@Controller
@RequestMapping("/user/storedetail")
public class StoreUserController {

    @Autowired
    private IStoreService storeService;
    
    @Autowired
    private IProductService productService;

    @Autowired
    private Cloudinary cloudinary;

    @RequestMapping("/{id}")
    public String getStore(@PathVariable("id") Integer storeId, ModelMap model, Pageable pageable) {
    	
        Store store = storeService.getById(storeId);
        int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
    	
       Page<Product> productPage = productService.findByStore(store, PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name")));
       
       productPage.forEach(product -> {
           // Lặp qua tất cả các hình ảnh của sản phẩm và tạo URL cho chúng
           List<String> imageUrls = product.getImages().stream()
                                          .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                                          .collect(Collectors.toList());
           product.setImageUrls(imageUrls);
       });
          
       addPaginationAttributes(model, pageable, productPage);

       model.addAttribute("productPage", productPage);
       model.addAttribute("store", store);
       return "user/store";
    }
    private void addPaginationAttributes(ModelMap model, Pageable pageable, Page<Product> productPage) {
        int currentPage = pageable.getPageNumber();
        int totalPages = productPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
    }
}

