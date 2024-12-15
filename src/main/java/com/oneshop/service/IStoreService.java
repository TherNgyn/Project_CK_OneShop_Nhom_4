package com.oneshop.service;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;

public interface IStoreService {
	void deleteAll();
	Store getById(Integer id);
	void delete(Store entity);
	void deleteById(Integer id);
	long count();
	boolean existsById(Integer id);
	Optional<Store> findById(Integer id);
	<S extends Store> Page<S> findAll(Example<S> example, Pageable pageable);
	List<Store> findAllById(Iterable<Integer> ids);
	List<Store> findAll(Sort sort);
	Page<Store> findAll(Pageable pageable);
	List<Store> findAll();
	<S extends Store> Optional<S> findOne(Example<S> example);
	<S extends Store> S save(S entity);
	Page<Store> findByNameContaining(String name, Pageable pageable);
	List<Store> findByNameContaining(String name);
	Integer countByCreateat(Date date);
	Store findOneByUser(User user);
	Store findByName(String name);
	Store findByOwner(User user);
	Store saveStore(Store store);
	List<Store> searchStores(String searchTerm);
}
