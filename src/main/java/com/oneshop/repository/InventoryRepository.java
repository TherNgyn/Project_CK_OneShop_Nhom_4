package com.oneshop.repository;

import com.oneshop.entity.Inventory;
import com.oneshop.entity.Product;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, Long> {

    Inventory findByProductId(Integer productId);
    
}
