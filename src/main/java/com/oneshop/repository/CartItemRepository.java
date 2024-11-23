package com.oneshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.CartItem;
@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
	List<CartItem> findByCartId(Integer id);
	List<CartItem> findByProductId(Integer id);	
}
