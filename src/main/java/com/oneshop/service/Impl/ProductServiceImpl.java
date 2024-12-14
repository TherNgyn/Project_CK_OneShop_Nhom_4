package com.oneshop.service.Impl;

import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.oneshop.repository.ProductImageRepository;
import com.oneshop.repository.ProductRepository;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.Category;
import com.oneshop.entity.Inventory;
import com.oneshop.entity.Order;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.ProductSpecification;
import com.oneshop.entity.Review;
import com.oneshop.entity.Store;
import com.oneshop.service.IProductService;

import jakarta.validation.Valid;
import lombok.Data;

@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	ProductRepository productRepository;
	
	@Autowired
	ProductImageRepository productImageRepository;
	
	@Autowired
	InventoryService inventoryService;
	
	@Autowired
	private CloudinaryService cloudinaryService;

	@Override
	public List<Product> findBynameContaining(String name) {
		return productRepository.findBynameContaining(name);
	}

	@Override
	public Page<Product> findByCategoryOrderByRatingDesc(Category category, Pageable pageable) {
		// TODO Auto-generated method stub
		return productRepository.findByCategoryOrderByRatingDesc(category, pageable);
	}

	@Override
	public <S extends Product> S save(S entity) {
		return productRepository.save(entity);
	}

	@Override
	public List<Product> findAll() {
		return productRepository.findAll();
	}

	@Override
	public Optional<Product> findById(Integer id) {
		return productRepository.findById(id);
	}

	@Override
	public <S extends Product> long count(Example<S> example) {
		return productRepository.count(example);
	}

	@Override
	public <S extends Product> boolean exists(Example<S> example) {
		return productRepository.exists(example);
	}

	@Override
	public long count() {
		return productRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		productRepository.deleteById(id);
	}

	@Override
	public void delete(Product entity) {
		productRepository.delete(entity);
	}

	@Override
	public Product getOne(Integer id) {
	    return productRepository.getReferenceById(id);
	}

	@Override
	public Product getById(Integer id) {
	    return productRepository.getReferenceById(id);
	}

	@Override
	public void deleteAll() {
		productRepository.deleteAll();
	}

	@Override
	public List<Product> findTop8ByOrderBySoldDesc() {
		return productRepository.findTop8ByOrderBySoldDesc();
	}

	@Override
	public List<Product> findTop8ByOrderByIdDesc() {
		return productRepository.findTop8ByOrderByIdDesc();
	}

	@Override
	public List<Product> findTop8ByOrderByRatingDesc() {
		return productRepository.findTop8ByOrderByRatingDesc();
	}

	@Override
	public Float totalPrice(List<Product> products) {
		Float price = (float) 0;
		for (Product product : products) {
			price = (float) (price + product.getPrice() * product.getSold());
		}
		return price;
	}

	@Override
	public Page<Product> findByCategory(Category category, Pageable pageable) {
		return productRepository.findByCategory(category, pageable);
	}

	@Override
	public Page<Product> findBynameContaining(String name, Pageable pageable) {
		return productRepository.findBynameContaining(name, pageable);
	}

	@Override
	public Page<Product> findByStore(Store store, Pageable pageable) {
		return productRepository.findByStore(store, pageable);
	}

	@Override
	public Page<Product> findByStoreAndNameContaining(Store store, String name, Pageable pageable) {
		return productRepository.findByStoreAndNameContaining(store, name, pageable);
	}
	
	@Override
	public Page<Product> findByCategoryAndNameContaining(Category category, String name, Pageable pageable) {
		return productRepository.findByCategoryAndNameContaining(category, name, pageable);
	}

	@Override
	public List<Product> findByStoreAndCategory(Store store, Category category) {
		return productRepository.findByStoreAndCategory(store, category);
	}

	@Override
	public List<Product> findByCategory(Category category) {
		return productRepository.findByCategory(category);
	}

	@Override
	public List<Product> findProductByStore(Store store) {
		return productRepository.findProductByStore(store);
	}

	@Override
	public List<Product> getProductByStore(Store store) {
		return productRepository.getProductByStore(store);
	}

	@Override
	public List<Product> findByCategoryId(Integer id) {

		return productRepository.findByCategoryId(id);
	}

	@Override
	public Page<Product> findByStoreAndCategory(Store store, Category category, Pageable pageable) {
		// TODO Auto-generated method stub
		return productRepository.findByStoreAndCategory(store, category, pageable);
	}

	@Override
	public List<Product> findTop5ByStoreOrderBySoldDesc(Store store) {
		// TODO Auto-generated method stub
		return productRepository.findTop5ByStoreOrderBySoldDesc(store);
	}

	@Override
	public List<Product> findTop5ByStoreOrderByIdDesc(Store store) {
		// TODO Auto-generated method stub
		return productRepository.findTop5ByStoreOrderByIdDesc(store);
	}

	@Override
	public List<Product> findTop5ByStoreOrderByRatingDesc(Store store) {
		// TODO Auto-generated method stub
		return productRepository.findTop5ByStoreOrderByRatingDesc(store);
	}

	@Override
	public long totalproductByStore(List<Product> products,Store store) {
		long countproduct =0;
		for (Product product : products) {
			if(product.getStore().getId()==store.getId())
				countproduct++ ;
			
		}
		return countproduct;
	}
	
	// Hiển thị tất cả sản phẩm có phân trang
	@Override
	public Page<Product> findAll(Pageable pageable) {
		return productRepository.findAll(pageable);
	}
	// Tìm kiếm sản phẩm theo tên, có phân trang
	@Override
	public Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable) {
		return productRepository.findByNameContainingIgnoreCase(name, pageable);
	}

	@Override
	public Page<Product> findByCriteria(String name, List<String> categoryNames, List<String> brand, Double minPrice, Double maxPrice, Pageable pageable) {
        Specification<Product> spec = ProductSpecification.filterByCriteria(name, categoryNames, brand, minPrice, maxPrice);
        return productRepository.findAll(spec, pageable);
    }
	
	@Override
	public List<Product> findTop4ByIsSelling(){
		return productRepository.findTop4ByIsSellingTrueOrderByIdDesc();
	}

	@Override
	public Page<Product> findByStatus(Boolean status, Pageable pageable) {
		return productRepository.findByIsSelling(status, pageable);
	}
	@Override
	public String updateProductWithImages(Product product, MultipartFile mainImage, MultipartFile[] additionalImages, Integer productId) {
        try {
            
            Product existingProduct = productRepository.findById(productId).orElse(null);
            if (existingProduct == null) {
                return "Sản phẩm không tồn tại.";
            }
            
            existingProduct.setName(product.getName());
            existingProduct.setPrice(product.getPrice());
            existingProduct.setDescription(product.getDescription());
            existingProduct.setCategory(product.getCategory());
            
            ProductImage productImage = new ProductImage();
            productImage.setProduct(existingProduct);
            
            if (mainImage != null && !mainImage.isEmpty()) {
                String newImageUrl = null;
                    // Check if the product already has a main image
                    if (existingProduct.getMainImage() == null || existingProduct.getMainImage().getImageUrl() == null) {
                        // If no main image exists, upload the new image as the main image
                        newImageUrl = cloudinaryService.uploadFile(mainImage);  // Use uploadFile if it's a new image
                    } else {
                        // If a main image exists, update it using the current image URL
                        newImageUrl = cloudinaryService.updateFile(mainImage, existingProduct.getMainImage().getImageUrl());
                    }
                    
                    // Create or update the ProductImage                 
                    productImage.setImageUrl(newImageUrl);
                    productImage.setIsMain(true);
            }

            // Handle additional images upload
            if (additionalImages != null && additionalImages.length > 0) {
                List<ProductImage> productImages = Arrays.stream(additionalImages)
                    .map(file -> {
                        try {
                            String imageUrl = cloudinaryService.uploadFile(file);
                           
                            productImage.setProduct(existingProduct);
                            productImage.setImageUrl(imageUrl);
                            productImage.setIsMain(false);
                            return productImage;
                        } catch (IOException e) {
                            e.printStackTrace();
                            return null;
                        }
                    })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
                existingProduct.setImages(productImages);
            }
            
            productImageRepository.save(productImage);

            // Save the updated product
            productRepository.save(existingProduct);

            Inventory inventory = inventoryService.getQuantityByProductId(existingProduct.getId());
            if (inventory == null) {
                inventory = new Inventory();
                inventory.setProduct(existingProduct);
            }
            inventory.setQuantity(product.getQuantity());
            inventoryService.save(inventory);

            return "Sản phẩm đã được cập nhật thành công.";

        } catch (IOException e) {
            e.printStackTrace();
            return "Lỗi khi tải lên hình ảnh.";
        }
    }

	@Override
	public void updateProduct(@Valid Product product) {
		// TODO Auto-generated method stub
		
	}

}
