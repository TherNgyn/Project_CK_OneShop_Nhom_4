package com.oneshop.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.oneshop.repository.ProductRepository;
import com.oneshop.entity.Category;
import com.oneshop.entity.Order;
import com.oneshop.entity.Product;
import com.oneshop.entity.ProductImage;
import com.oneshop.entity.ProductSpecification;
import com.oneshop.entity.Store;
import com.oneshop.service.IProductService;

@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	ProductRepository productRepository;

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
	public List<Product> findTop4ByOrderBySoldDesc() {
		return productRepository.findTop4ByOrderBySoldDesc();
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
	public List<String> getAllBrands() {
	    return productRepository.findDistinctBrands();
	}

	@Override
    public Page<Product> findByBrand(String brand, Pageable pageable) {
        return productRepository.findByBrand(brand, pageable);
    }

	@Override
	public List<Product> findTop8ByOrderBySoldDesc() {
		// TODO Auto-generated method stub
		return productRepository.findTop8ByOrderByIdDesc();
	}

	@Override
	public List<Product> findTop4ByOrderByIdDesc() {
		// TODO Auto-generated method stub
		return productRepository.findTop4ByOrderBySoldDesc();
	}
	public List<Product> findTopProductsByCategory(Integer categoryId) {
	    return productRepository.findTopProductsByCategoryId(categoryId, PageRequest.of(0, 6)); // Lấy 6 sản phẩm đầu
	}
	@Override
	public List<Product> getTopRatedProducts() {
        return productRepository.findTopRatedProducts().subList(0, 3); // Lấy top 3
    }
	
	@Override
	public List<Product> findTop4ByIsSelling(){
		return productRepository.findTop4ByIsSellingTrueOrderByIdDesc();
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


}
