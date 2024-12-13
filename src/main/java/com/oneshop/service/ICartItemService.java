package com.oneshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.CartItem;
import com.oneshop.entity.User;

public interface ICartItemService {

	void deleteAll();
	CartItem getById(Integer id);
	void delete(CartItem entity);
	void deleteById(Integer id);
	long count();
	boolean existsById(Integer id);
	Optional<CartItem> findById(Integer id);
	<S extends CartItem> Page<S> findAll(Example<S> example, Pageable pageable);
	List<CartItem> findAllById(Iterable<Integer> ids);
	List<CartItem> findAll(Sort sort);
	Page<CartItem> findAll(Pageable pageable);
	List<CartItem> findAll();
	<S extends CartItem> Optional<S> findOne(Example<S> example);
	<S extends CartItem> S save(S entity);
	List<CartItem> findByCartId(Integer id);
	List<CartItem> findByUserId(Integer userId);
	void deleteAll(List<CartItem> cartItems);
	void deleteAllByIds(List<Integer> cartItemIds);
	public void deleteCartItem(int orderId, int userId);
	
}
