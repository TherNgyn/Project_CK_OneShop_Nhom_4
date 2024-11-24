package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Category;
import com.oneshop.entity.Delivery;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {
	// Tìm Kiếm theo nội dung tên from category where Categoryname
	List<Category> findByNameContaining(String name);
	//
	Category findOneByName(String name);
	// Tìm kiếm và Phân trang
	// Ham phan trang
	Page<Category> findByNameContaining(String name, Pageable pageable);

}
