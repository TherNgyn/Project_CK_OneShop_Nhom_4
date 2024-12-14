package com.oneshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.oneshop.entity.ProductImage;

public interface ProductImageRepository extends JpaRepository<ProductImage, Long>{
	
}
