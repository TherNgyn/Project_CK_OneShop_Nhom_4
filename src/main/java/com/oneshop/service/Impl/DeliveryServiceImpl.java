package com.oneshop.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.repository.DeliveryRepository;
import com.oneshop.entity.Category;
import com.oneshop.entity.Delivery;
import com.oneshop.entity.Order;
import com.oneshop.service.IDeliveryService;

@Service
public class DeliveryServiceImpl implements IDeliveryService{
	
	@Autowired
	DeliveryRepository deliveryRepository;

	@Override
	public List<Category> findByNameContaining(String name) {
		return deliveryRepository.findByNameContaining(name);
	}

	@Override
	public Category findOneByName(String name) {
		return deliveryRepository.findOneByName(name);
	}

	@Override
	public Page<Category> findByNameContaining(String name, Pageable pageable) {
		return deliveryRepository.findByNameContaining(name, pageable);
	}

	@Override
	public <S extends Delivery> S save(S entity) {
		return deliveryRepository.save(entity);
	}

	@Override
	public <S extends Delivery> Optional<S> findOne(Example<S> example) {
		return deliveryRepository.findOne(example);
	}

	@Override
	public List<Delivery> findAll() {
		return deliveryRepository.findAll();
	}

	@Override
	public Page<Delivery> findAll(Pageable pageable) {
		return deliveryRepository.findAll(pageable);
	}

	@Override
	public List<Delivery> findAll(Sort sort) {
		return deliveryRepository.findAll(sort);
	}

	@Override
	public List<Delivery> findAllById(Iterable<Integer> ids) {
		return deliveryRepository.findAllById(ids);
	}

	@Override
	public Optional<Delivery> findById(Integer id) {
		return deliveryRepository.findById(id);
	}

	@Override
	public void deleteInBatch(Iterable<Delivery> entities) {
	    deliveryRepository.deleteAllInBatch(entities);
	}


	@Override
	public boolean existsById(Integer id) {
		return deliveryRepository.existsById(id);
	}

	@Override
	public <S extends Delivery> boolean exists(Example<S> example) {
		return deliveryRepository.exists(example);
	}

	@Override
	public long count() {
		return deliveryRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		deliveryRepository.deleteById(id);
	}

	@Override
	public Delivery getOne(Integer id) {
	    return deliveryRepository.getReferenceById(id);
	}


	@Override
	public void delete(Delivery entity) {
		deliveryRepository.delete(entity);
	}

	@Override
	public Delivery getById(Integer id) {
	    return deliveryRepository.getReferenceById(id);
	}

	@Override
	public void deleteAll() {
		deliveryRepository.deleteAll();
	}
	

}
