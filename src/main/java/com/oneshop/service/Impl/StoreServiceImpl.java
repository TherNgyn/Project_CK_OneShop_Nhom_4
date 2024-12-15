package com.oneshop.service.Impl;

import java.sql.Date;
import java.util.List;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.repository.StoreRepository;
import com.oneshop.service.IStoreService;
@Service
public class StoreServiceImpl implements IStoreService {
	@Autowired
	StoreRepository StoreRepository;
	@Override
	public <S extends Store> S save(S entity) {
		return StoreRepository.save(entity);
	}

	@Override
	public <S extends Store> Optional<S> findOne(Example<S> example) {
		return StoreRepository.findOne(example);
	}

	@Override
	public List<Store> findAll() {
		return StoreRepository.findAll();
	}

	@Override
	public Page<Store> findAll(Pageable pageable) {
		return StoreRepository.findAll(pageable);
	}

	@Override
	public List<Store> findAll(Sort sort) {
		return StoreRepository.findAll(sort);
	}

	@Override
	public List<Store> findAllById(Iterable<Integer> ids) {
		return StoreRepository.findAllById(ids);
	}

	@Override
	public <S extends Store> Page<S> findAll(Example<S> example, Pageable pageable) {
		return StoreRepository.findAll(example, pageable);
	}

	@Override
	public Optional<Store> findById(Integer id) {
		return StoreRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return StoreRepository.existsById(id);
	}

	@Override
	public long count() {
		return StoreRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		StoreRepository.deleteById(id);
	}

	@Override
	public void delete(Store entity) {
		StoreRepository.delete(entity);
	}

	@Override
	public Store getById(Integer id) {
	    return StoreRepository.getReferenceById(id);
	}


	@Override
	public void deleteAll() {
		StoreRepository.deleteAll();
	}
	
	@Override
	public Page<Store> findByNameContaining(String name, Pageable pageable) {
		return StoreRepository.findByNameContaining(name, pageable);
	}
	
	@Override
	public List<Store> findByNameContaining(String name) {
		return StoreRepository.findByNameContaining(name);
	}
	
	@Override
	public Store findByOwner(User user) {
		return StoreRepository.findByUserId(user.getId());
	}
	@Override
	public Integer countByCreateat(Date date) {
		return StoreRepository.countByCreateat(date);
	}
	
	@Override
	public Store findOneByUser(User user) {
		return StoreRepository.findOneByUser(user);
	}
	@Override
	public Store findByName(String name) {
		return StoreRepository.findByName(name);
	}
	@Override
    public Store saveStore(Store store) {
        return StoreRepository.save(store);
    }
	
	@Override
	public List<Store> searchStores(String searchTerm) {
	    // Tìm kiếm các cửa hàng theo tên hoặc mô tả
	    return StoreRepository.findByNameContainingIgnoreCaseOrBioContainingIgnoreCase(searchTerm, searchTerm);
	}
}
