package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;

import jakarta.validation.Valid;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {
	List<Product> findBynameContaining(String name);
	List<Product> findTop4ByOrderBySoldDesc();
	List<Product> findTop8ByOrderByIdDesc();
	List<Product> findTop8ByOrderByRatingDesc();
	List<Product> findProductByStore(Store store);
	List<Product> getProductByStore(Store store);
	Page<Product> findByCategoryOrderByRatingDesc(Category category, Pageable pageable);
	Page<Product> findByCategory(Category category, Pageable pageable);
	Page<Product> findBynameContaining(String name, Pageable pageable);

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
	 @Query("SELECT DISTINCT p.brand FROM Product p WHERE p.brand IS NOT NULL")
	    List<String> findDistinctBrands();
	Page<Product> findByBrand(String brand, Pageable pageable);
	List<Product> findTopProductsByCategoryId(Integer categoryId, PageRequest of);
	@Query("SELECT p FROM Product p WHERE p.category.id = :categoryId ORDER BY p.rating DESC")
	List<Product> findTopProductsByCategoryId(@Param("categoryId") Integer categoryId, Pageable pageable);
	@Query("SELECT p FROM Product p " +
		       "JOIN p.reviews r " +
		       "GROUP BY p " +
		       "ORDER BY AVG(r.rating) DESC")
		List<Product> findTopRatedProducts();
	@Query("SELECT p FROM Product p WHERE p.isSelling = true ORDER BY p.id DESC")
    List<Product> findTop4ByIsSellingTrueOrderByIdDesc();
	List<Product> findByStoreId(Integer storeId);
	List<Product> findByStoreIdAndStatus(int storeId, String status);
	List<Product> findByStatus(String status);
	List<Product> findByStoreIdAndStatusAndNameContaining(Integer storeId, String status, String searchTerm);
	List<Product> findByStatusAndNameContaining(String status, String searchTerm);
	List<Product> findByStoreIdAndNameContaining(Integer storeId, String searchTerm);
	List<Product> findByNameContaining(String searchTerm);
	Page<Product> findByIsSelling(Boolean isSelling, Pageable pageable);
	List<Product> findTop8ByOrderBySoldDesc();
	Page<Product> findByStore(Store store, Pageable pageable);
	Page<Product> findByStoreAndIsSelling(Store store, Boolean isSelling, Pageable pageable);
	
	
}
