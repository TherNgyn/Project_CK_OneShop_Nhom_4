package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
	List<Review> findByProduct(Product product);
	Page<Review> findByProductStore(Store store ,Pageable page);
	List<Review> findByProductId(Integer productId);
	@Query("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId")
    long countByProductId(Integer productId);
	Review findByUserAndProduct(User user, Product product);
}
