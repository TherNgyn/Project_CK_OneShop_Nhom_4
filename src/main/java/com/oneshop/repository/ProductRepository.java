package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
	List<Product> findBynameContaining(String name);
	List<Product> findTop8ByOrderBySoldDesc();
	List<Product> findTop8ByOrderByIdDesc();
	List<Product> findTop8ByOrderByRatingDesc();
	List<Product> findProductByStore(Store store);
	List<Product> getProductByStore(Store store);
	Page<Product> findByCategoryOrderByRatingDesc(Category category, Pageable pageable);
	Page<Product> findByCategory(Category category, Pageable pageable);
	Page<Product> findBynameContaining(String name, Pageable pageable);
	Page<Product> findByStore(Store store, Pageable pageable);
	Page<Product> findByStoreAndNameContaining(Store store, String name, Pageable pageable);
	List<Product> findByStoreAndCategory(Store store, Category category);
	List<Product> findByCategory(Category category);
	List<Product> findByCategoryId(Integer id);
	Page<Product> findByCategoryAndNameContaining(Category category, String name, Pageable pageable);
	Page<Product> findByStoreAndCategory(Store store,Category category, Pageable pageable);
	List<Product> findTop5ByStoreOrderBySoldDesc(Store store);
	List<Product> findTop5ByStoreOrderByIdDesc(Store store);
	List<Product> findTop5ByStoreOrderByRatingDesc(Store store);

	// Hiển thị tất cả sản phẩm
	Page<Product> findAll(Pageable pageable);
	// Tìm kiếm theo tên và phân trang
	Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);
	
}
