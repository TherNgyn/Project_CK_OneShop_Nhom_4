package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Category;
import com.oneshop.entity.Delivery;
import com.oneshop.entity.Order;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {
	List<Category> findByNameContaining(String name);
	Category findOneByName(String name);
	Page<Category> findByNameContaining(String name, Pageable pageable);
	List<Delivery> findByIsDeletedFalse();
	Delivery findByName(String name);
	// Tìm tất cả các bản ghi có tên chứa từ khóa (không phân biệt chữ hoa/thường) và isDeleted = false hoặc null
    List<Delivery> findByNameContainingIgnoreCaseAndIsDeletedFalseOrIsDeletedIsNull(String name);
    List<Delivery> findByIsDeletedFalseOrIsDeletedIsNull();	
}
