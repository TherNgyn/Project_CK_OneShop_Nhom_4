package com.oneshop.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oneshop.entity.Inventory;
import com.oneshop.repository.InventoryRepository;
import com.oneshop.service.IInventoryService;
@Service
public class InventoryService implements IInventoryService{

	@Autowired
	private InventoryRepository inventoryRepository;
	
	@Override
	public Inventory getQuantityByProductId(Integer productId) {
		return inventoryRepository.findByProductId(productId);
    }

	@Override
	public <S extends Inventory> S save(S entity) {
		return inventoryRepository.save(entity);
	}
}
