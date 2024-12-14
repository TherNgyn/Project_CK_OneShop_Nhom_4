package com.oneshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;


public interface IProductService {
	void deleteAll();
	Product getById(Integer id);
	void delete(Product entity);
	Product getOne(Integer id);
	void deleteById(Integer id);
	Page<Product> findByCategoryOrderByRatingDesc(Category category, Pageable pageable);
	
	<S extends Product> boolean exists(Example<S> example);
	<S extends Product> long count(Example<S> example);
	Optional<Product> findById(Integer id);
	List<Product> findAll();
	<S extends Product> S save(S entity);
	List<Product> findProductByStore(Store store);
	List<Product> getProductByStore(Store store);
	List<Product> findBynameContaining(String name);
	List<Product> findTop8ByOrderBySoldDesc();
	List<Product> findTop4ByOrderByIdDesc();
	List<Product> findTop8ByOrderByRatingDesc();
	Float totalPrice(List<Product> products);
	Page<Product> findByCategory(Category category, Pageable pageable);
	Page<Product> findBynameContaining(String name, Pageable pageable);
	Page<Product> findByStore(Store store, Pageable pageable);
	Page<Product> findByStoreAndNameContaining(Store store, String name, Pageable pageable);
	Page<Product> findByCategoryAndNameContaining(Category category, String name, Pageable pageable);
	List<Product> findByStoreAndCategory(Store store, Category category);
	List<Product> findByCategory(Category category);
	List<Product> findByCategoryId(Integer id);
	Page<Product> findByStoreAndCategory(Store store,Category category, Pageable pageable);
	List<Product> findTop5ByStoreOrderBySoldDesc(Store store);
	List<Product> findTop5ByStoreOrderByIdDesc(Store store);
	List<Product> findTop5ByStoreOrderByRatingDesc(Store store);
	long totalproductByStore(List<Product> products, Store store);
	// Hiển thị tất cả sản phẩm
	Page<Product> findAll(Pageable pageable);
	// Tìm kiếm theo tên và phân trang
	Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);
	long count();
	// Lọc sản phẩm
	Page<Product> findByCriteria(String name, List<String> categoryName, List<String> brand, Double maxPrice, Double minPrice, Pageable page);
	List<String> getAllBrands();
	Page<Product> findByBrand(String brand, Pageable pageable);
	List<Product> findTop8ByOrderByIdDesc();
	List<Product> findTop4ByOrderBySoldDesc();
	List<Product> findTopProductsByCategory(Integer categoryId);
	List<Product> getTopRatedProducts();
	
	

}
