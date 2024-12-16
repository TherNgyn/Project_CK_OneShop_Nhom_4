package com.oneshop.service.Impl;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
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

import com.oneshop.repository.InventoryRepository;
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
import com.oneshop.service.IInventoryService;
import com.oneshop.service.IProductService;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.Data;

@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	ProductRepository productRepository;
	
	@Autowired
	InventoryRepository inventoryRepository;
	
	@Autowired
	ProductImageRepository productImageRepository;
	
	@Autowired
	IInventoryService inventoryService;
	
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
	        existingProduct.setPromotionalPrice(product.getPromotionalPrice());
	        existingProduct.setIsSelling(product.getIsSelling());
	        existingProduct.setBrand(product.getBrand());
	        existingProduct.setDescription(product.getDescription());
	        existingProduct.setCategory(product.getCategory());

	        // Đặt ngày cập nhật là ngày hôm nay
	        LocalDateTime now = LocalDateTime.now();
	        Date currentDate = Date.from(now.atZone(ZoneId.systemDefault()).toInstant());
	        java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());
	        existingProduct.setUpdateat(sqlDate);

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

	        // Cập nhật số lượng trong kho
	        Inventory inventory = inventoryService.getQuantityByProductId(product.getId());
	        if (inventory == null) {
	            // Nếu không có kho, tạo mới
	            inventory = new Inventory();
	            inventory.setProduct(product);
	        }
	        inventory.setQuantity(quantity);  // Đặt số lượng trong kho
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
		List<Product> topRatedProducts = productRepository.findTopRatedProducts();
	    int size = Math.min(topRatedProducts.size(), 3); // Đảm bảo không vượt quá kích thước danh sách
	    return topRatedProducts.subList(0, size);
    }
	@Override
	public List<Product> getProducts(int storeId) {
        // Lấy danh sách sản phẩm theo Store ID
        List<Product> products = productRepository.findByStoreId(storeId);

        // Gắn hình ảnh chính cho từng sản phẩm
        products.forEach(product -> {
            ProductImage mainImage = product.getMainImage(); // Lấy hình ảnh chính từ Product
            if (mainImage != null) {
                product.setImageUrls(List.of(mainImage.getImageUrl())); // Gắn URL hình ảnh chính vào Product
            } else {
                product.setImageUrls(List.of("https://www.vimaccos.vn/public/upload/phat-trien-nganh-my-pham-vimaccos.jpg")); // Nếu không có hình ảnh chính, gắn ảnh mặc định
            }
        });

        return products;
    }
	
	@Override
	public List<Product> findProducts(Integer storeId, String status, String searchTerm) {
		// Nếu tất cả các tham số đều null, trả về tất cả sản phẩm
        if (storeId == null && status == null && (searchTerm == null || searchTerm.isEmpty())) {
            return productRepository.findAll();
        }

        // Nếu storeId và status đều null, tìm theo searchTerm (name)
        if (storeId == null && status == null) {
            return productRepository.findByNameContaining(searchTerm);
        }

        // Nếu storeId và searchTerm (name) đều null, tìm theo status
        if (storeId == null && searchTerm == null) {
            return productRepository.findByStatus(status);
        }

        // Nếu status và searchTerm (name) đều null, tìm theo storeId
        if (status == null && searchTerm == null) {
            return productRepository.findByStoreId(storeId);
        }

        // Nếu chỉ có 1 tham số null thì tìm theo 2 tham số còn lại
        if (storeId == null) {
            return productRepository.findByStatusAndNameContaining(status, searchTerm);
        }
        if (status == null) {
            return productRepository.findByStoreIdAndNameContaining(storeId, searchTerm);
        }
        if (searchTerm == null) {
            return productRepository.findByStoreIdAndStatus(storeId, status);
        }

        // Nếu không có tham số nào là null, tìm theo cả 3 tham số
        return productRepository.findByStoreIdAndStatusAndNameContaining(storeId, status, searchTerm);
	}
	// Hàm trả về danh sách sản phẩm gần hết hàng
    public List<Product> getLowStockProducts(Store vendorStore, int threshold) {
        List<Product> lowStockProducts = new ArrayList<>();
        
        // Lấy tất cả sản phẩm của cửa hàng
        List<Product> products = productRepository.findProductByStore(vendorStore);

        for (Product product : products) {
            // Lấy quantity của sản phẩm từ bảng Inventory
            Inventory inventory = inventoryRepository.findByProductId(product.getId());
            if (inventory != null && inventory.getQuantity() < threshold) {
                // Thêm sản phẩm vào danh sách nếu số lượng nhỏ hơn ngưỡng
                product.setQuantity(inventory.getQuantity());
                lowStockProducts.add(product);
            }
        }

        return lowStockProducts;
    }


	@Override
	public Page<Product> findByStoreAndStatus(Store store, Boolean status, Pageable pageable) {
		
		return productRepository.findByStoreAndIsSelling(store, status, pageable);
	}
   
}
