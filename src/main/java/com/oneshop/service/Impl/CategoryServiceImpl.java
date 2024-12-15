package com.oneshop.service.Impl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.repository.CategoryRepository;
import com.oneshop.entity.Category;
import com.oneshop.entity.Product;
import com.oneshop.model.CategoryModel;
import com.oneshop.service.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService {

	@Autowired
	CategoryRepository categoryRepository;

	@Override
	public List<Category> findByNameContaining(String name) {
		return categoryRepository.findByNameContaining(name);
	}

	@Override
	public Category findOneByName(String name) {
		return categoryRepository.findOneByName(name);
	}

	@Override
	public Page<Category> findByNameContaining(String name, Pageable pageable) {
		return categoryRepository.findByNameContaining(name, pageable);
	}
	
	
	public <S extends Category> S save(S entity) {
		return categoryRepository.save(entity);
	}

	@Override
	public <S extends Category> Optional<S> findOne(Example<S> example) {
		return categoryRepository.findOne(example);
	}

	@Override
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	public Page<Category> findAll(Pageable pageable) {
		return categoryRepository.findAll(pageable);
	}

	@Override
	public List<Category> findAll(Sort sort) {
		return categoryRepository.findAll(sort);
	}

	@Override
	public List<Category> findAllById(Iterable<Integer> ids) {
		return categoryRepository.findAllById(ids);
	}

	@Override
	public Optional<Category> findById(Integer id) {
		return categoryRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return categoryRepository.existsById(id);
	}

	@Override
	public <S extends Category> long count(Example<S> example) {
		return categoryRepository.count(example);
	}

	@Override
	public <S extends Category> boolean exists(Example<S> example) {
		return categoryRepository.exists(example);
	}

	@Override
	public void deleteAllByIdInBatch(Iterable<Integer> ids) {
		categoryRepository.deleteAllByIdInBatch(ids);
	}

	@Override
	public long count() {
		return categoryRepository.count();
	}

	@Override
	public void deleteAllInBatch() {
		categoryRepository.deleteAllInBatch();
	}

	@Override
	public void deleteById(Integer id) {
		categoryRepository.deleteById(id);
	}

	@Override
	public Category getReferenceById(Integer id) {
	    return categoryRepository.getReferenceById(id);
	}



	@Override
	public void delete(Category entity) {
		categoryRepository.delete(entity);
	}

	@Override
	public void deleteAllById(Iterable<? extends Integer> ids) {
		categoryRepository.deleteAllById(ids);
	}

	@Override
	public void deleteAll() {
		categoryRepository.deleteAll();
	}

	@Override
	public Category getById(Integer id) {
		return categoryRepository.getById(id);
	}

	@Override
	public Category getOne(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Category> findCategories(String name) {
        if (name == null || name.trim().isEmpty()) {
            // Tìm tất cả các category không bị xóa
            return categoryRepository.findByIsDeletedFalseOrIsDeletedIsNull();
        } else {
            // Tìm theo tên và không bị xóa
            List<Category> categories = categoryRepository.findByNameContainingIgnoreCaseAndIsDeletedFalseOrIsDeletedIsNull(name);
            if (categories == null || categories.isEmpty()) {
                return new ArrayList<>();
            }
            return categories;
        }
    }
}
