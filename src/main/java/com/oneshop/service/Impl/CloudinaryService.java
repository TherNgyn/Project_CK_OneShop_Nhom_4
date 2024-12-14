package com.oneshop.service.Impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.oneshop.entity.ProductImage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;
    
    public String uploadFile(MultipartFile file) throws IOException {
        Map<?, ?> uploadResult = cloudinary.uploader().upload(file.getBytes(),
                ObjectUtils.asMap("folder", "oneshop/user_avatars"));
        return uploadResult.get("url").toString(); 
    }
    public String uploadFileProduct(MultipartFile file) throws IOException {
        Map<?, ?> uploadResult = cloudinary.uploader().upload(file.getBytes(),
                ObjectUtils.asMap("folder", "oneshop/product_images"));
        return uploadResult.get("url").toString(); 
    }
    public void deleteFile(String publicId) throws IOException {
        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }
    public String updateFile(MultipartFile newFile, String oldUrl) throws IOException {
        if (oldUrl != null && !oldUrl.isEmpty()) {
            String publicId = extractPublicIdFromUrl(oldUrl);
            deleteFile(publicId);
        }
        return uploadFile(newFile);
    }
    public String extractPublicIdFromUrl(String url) {
        String folder = "oneshop/product_images";
        int startIndex = url.indexOf(folder) + folder.length();
        int endIndex = url.lastIndexOf('.');
        return url.substring(startIndex, endIndex);
    }
    public List<String> generateImageUrls(List<ProductImage> images) {
        return images.stream()
                .map(image -> {
                    String publicId = image.getImageUrl();
                    if (publicId == null || publicId.isEmpty()) {
                        throw new IllegalArgumentException("Public ID không hợp lệ: " + publicId);
                    }
                    return cloudinary.url().secure(true).publicId(publicId).generate(); // Tạo URL
                })
                .collect(Collectors.toList());
    }

}
