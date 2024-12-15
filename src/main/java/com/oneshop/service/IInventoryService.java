package com.oneshop.service;

import java.util.List;

import com.oneshop.entity.Inventory;
import com.oneshop.entity.Product;

public interface IInventoryService {

	    public Inventory getQuantityByProductId(Integer productId);
		public <S extends Inventory> S save(S entity);
		
		
	     
}
