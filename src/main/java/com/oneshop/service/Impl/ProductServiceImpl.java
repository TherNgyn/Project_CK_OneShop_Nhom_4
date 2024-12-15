package com.oneshop.service.Impl;

import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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

import jakarta.transaction.Transactional;
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
	public String updateProductWithImages(Product product, Integer quantity, MultipartFile mainImage, MultipartFile[] additionalImages, Integer productId, String removedImages) {
	    try {
	        // Lấy sản phẩm hiện có
	        Product existingProduct = productRepository.findById(productId).orElse(null);
	        if (existingProduct == null) {
	            return "Sản phẩm không tồn tại.";
	        }

	        // Cập nhật thông tin sản phẩm cơ bản
	        existingProduct.setName(product.getName());
	        existingProduct.setPrice(product.getPrice());
	        existingProduct.setIsSelling(product.getIsSelling());
	        existingProduct.setBrand(product.getBrand());
	        existingProduct.setDescription(product.getDescription());
	        existingProduct.setCategory(product.getCategory());

	        // Xử lý hình ảnh chính (mainImage)
	        if (mainImage != null && !mainImage.isEmpty()) {
	            String newImageUrl;
	            ProductImage mainProductImage = existingProduct.getMainImage();

	            // Nếu có ảnh chính cũ, xóa ảnh chính cũ
	            if (mainProductImage != null) {
	                existingProduct.getImages().remove(mainProductImage);
	            }

	            // Tạo mới hoặc cập nhật ảnh chính
	            newImageUrl = cloudinaryService.uploadFile(mainImage);

	            // Tạo mới ảnh chính và gán cho sản phẩm
	            ProductImage newMainImage = new ProductImage();
	            newMainImage.setProduct(existingProduct);
	            newMainImage.setImageUrl(newImageUrl);
	            newMainImage.setIsMain(true);

	            existingProduct.getImages().add(newMainImage);
	        }

	        // Xử lý xóa các hình ảnh đã bị xóa
	        if (removedImages != null && !removedImages.isEmpty()) {
	            String[] removedImageUrls = removedImages.split(",");
	            for (String imageUrl : removedImageUrls) {
	                // Xóa ảnh phụ khỏi danh sách sản phẩm (chỉ xóa ảnh không phải ảnh chính)
	                existingProduct.getImages().removeIf(image -> 
	                    !image.getIsMain() && image.getImageUrl().equals(imageUrl)
	                );
	            }
	        }

	        // Xử lý các ảnh phụ (additional images)
	        if (additionalImages != null && additionalImages.length > 0) {
	            for (MultipartFile file : additionalImages) {
	                if (!file.isEmpty()) {
	                    try {
	                        String imageUrl = cloudinaryService.uploadFile(file);

	                        ProductImage newImage = new ProductImage();
	                        newImage.setProduct(existingProduct);
	                        newImage.setImageUrl(imageUrl);
	                        newImage.setIsMain(false);  // Đánh dấu ảnh này là ảnh phụ

	                        existingProduct.getImages().add(newImage);
	                    } catch (IOException e) {
	                        e.printStackTrace();
	                        return "Lỗi khi tải lên hình ảnh.";
	                    }
	                }
	            }
	        }
	        Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
		    if (inventory == null) {
		        // If no inventory exists, create a new inventory entry
		        inventory = new Inventory();
		        inventory.setProduct(product);
		    }
		    inventory.setQuantity(quantity);  // Set the quantity in inventory
		    inventoryService.save(inventory);
	        // Lưu sản phẩm sau khi cập nhật
	        productRepository.save(existingProduct);
	        return "Sản phẩm đã được cập nhật thành công.";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Đã xảy ra lỗi khi cập nhật sản phẩm.";
	    }
	}

	@Override
	public void updateProduct(@Valid Product product) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Product> findTop4ByOrderBySoldDesc() {
		return productRepository.findTop4ByOrderBySoldDesc();
	}

	@Override
	public String updateProductWithImages(Product product, MultipartFile mainImage, MultipartFile[] additionalImages,
			Integer productId, String removedImages) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Product> findTop4ByOrderByIdDesc() {
		// TODO Auto-generated method stub
		return productRepository.findTop4ByOrderBySoldDesc();
	}

	@Override
	public List<String> getAllBrands() {
	    return productRepository.findDistinctBrands();
	}

	@Override
    public Page<Product> findByBrand(String brand, Pageable pageable) {
        return productRepository.findByBrand(brand, pageable);
    }

	public List<Product> findTopProductsByCategory(Integer categoryId) {
	    return productRepository.findTopProductsByCategoryId(categoryId, PageRequest.of(0, 6)); // Lấy 6 sản phẩm đầu
	}
	@Override
	public List<Product> getTopRatedProducts() {
        return productRepository.findTopRatedProducts().subList(0, 3); // Lấy top 3
    }
}
