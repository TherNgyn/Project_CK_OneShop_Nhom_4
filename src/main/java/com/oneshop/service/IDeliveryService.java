package com.oneshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.Category;
import com.oneshop.entity.Delivery;

public interface IDeliveryService {
	void deleteAll();
	Delivery getById(Integer id);
	void delete(Delivery entity);
	Delivery getOne(Integer id);
	void deleteById(Integer id);
	long count();
	<S extends Delivery> boolean exists(Example<S> example);
	boolean existsById(Integer id);
	void deleteInBatch(Iterable<Delivery> entities);
	Optional<Delivery> findById(Integer id);
	List<Delivery> findAllById(Iterable<Integer> ids);
	List<Delivery> findAll(Sort sort);
	Page<Delivery> findAll(Pageable pageable);
	List<Delivery> findAll();
	<S extends Delivery> Optional<S> findOne(Example<S> example);
	<S extends Delivery> S save(S entity);
	Page<Category> findByNameContaining(String name, Pageable pageable);
	Category findOneByName(String name);
	List<Category> findByNameContaining(String name);
	List<Delivery> findDeliveries(String search);
	Delivery getByName(String name);
}
