package com.oneshop.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.oneshop.entity.Inventory;
import com.oneshop.entity.ProductImage;
import com.oneshop.repository.ProductImageRepository;

public class ProductImageService {
	@Autowired
	ProductImageRepository imgRepo;
	
	public <S extends ProductImage> S save(S entity) {
		return imgRepo.save(entity);
	}
}
