package com.oneshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
	
	
}
