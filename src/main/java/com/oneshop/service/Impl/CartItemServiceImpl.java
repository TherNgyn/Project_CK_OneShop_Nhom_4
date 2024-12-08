package com.oneshop.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.entity.CartItem;
import com.oneshop.entity.User;
import com.oneshop.repository.CartItemRepository;
import com.oneshop.service.ICartItemService;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class CartItemServiceImpl implements ICartItemService {
	@Autowired
	CartItemRepository CartItemRepository;

	@Override
	public <S extends CartItem> S save(S entity) {
		return CartItemRepository.save(entity);
	}

	@Override
	public <S extends CartItem> Optional<S> findOne(Example<S> example) {
		return CartItemRepository.findOne(example);
	}

	@Override
	public List<CartItem> findAll() {
		return CartItemRepository.findAll();
	}

	@Override
	public Page<CartItem> findAll(Pageable pageable) {
		return CartItemRepository.findAll(pageable);
	}

	@Override
	public List<CartItem> findAll(Sort sort) {
		return CartItemRepository.findAll(sort);
	}

	@Override
	public List<CartItem> findAllById(Iterable<Integer> ids) {
		return CartItemRepository.findAllById(ids);
	}

	@Override
	public <S extends CartItem> Page<S> findAll(Example<S> example, Pageable pageable) {
		return CartItemRepository.findAll(example, pageable);
	}

	@Override
	public Optional<CartItem> findById(Integer id) {
		return CartItemRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return CartItemRepository.existsById(id);
	}

	@Override
	public long count() {
		return CartItemRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		CartItemRepository.deleteById(id);
	}

	@Override
	public void delete(CartItem entity) {
		CartItemRepository.delete(entity);
	}

	@Override
	public CartItem getById(Integer id) {
	    try {
	        return CartItemRepository.getReferenceById(id);
	    } catch (EntityNotFoundException e) {
	        throw new RuntimeException("CartItem not found for ID: " + id, e);
	    }
	}


	@Override
	public void deleteAll() {
		CartItemRepository.deleteAll();
	}
	
	@Override
	public List<CartItem> findByCartId(Integer id) {
		return CartItemRepository.findByCartId(id);
	}
	@Override
    public List<CartItem> findByUserId(Integer userId) {
        return CartItemRepository.findByUserId(userId);
    }
	
	@Override
	@Transactional
	public void deleteAll(List<CartItem> cartItems) {
	    CartItemRepository.deleteAllByCartItems(cartItems);
	}

	@Override
	@Transactional
	public void deleteAllByIds(List<Integer> cartItemIds) {
	    CartItemRepository.deleteAllByIds(cartItemIds);
	}



}
