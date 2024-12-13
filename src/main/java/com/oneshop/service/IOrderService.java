package com.oneshop.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;

public interface IOrderService {
	void deleteAll();

	Order getById(Integer id);

	void delete(Order entity);

	void deleteById(Integer id);

	long count();

	boolean existsById(Integer id);

	Optional<Order> findById(Integer id);

	<S extends Order> Page<S> findAll(Example<S> example, Pageable pageable);

	List<Order> findAllById(Iterable<Integer> ids);

	List<Order> findAll(Sort sort);

	Page<Order> findAll(Pageable pageable);

	List<Order> findAll();

	<S extends Order> Optional<S> findOne(Example<S> example);

	<S extends Order> S save(S entity);

	Float totalPrice(List<Order> orders);

	Float getPrice12Month(List<Order> oders, Integer limit);

	Integer countByCreateat(Date date);

	Float getPrice12MonthOfStore(List<Order> oders, Integer id, Integer limit);

	List<Order> findByStore(Store store);

	long countOrder(List<Order> orders, Store store);

	List<Order> findByUser(User user);

	List<Order> getAllOrdersByCustomer(Integer customerId);

	List<Order> getOrdersByCustomer(Integer customerId, String status);

	List<OrderItem> getOrderItemsByOrderId(Integer id);

	List<Order> getAllOrdersByCustomerAndStore(Integer userId, Store store);

	List<Order> getOrdersByCustomerAndStore(Integer userId, Store store, String status);

	Float totalPriceToDay(List<Order> orders, LocalDate date);

	Float totalPrice(List<Order> orders, Store store);

	Order findLatestOrder(User user);

	List<Order> getOrdersByCustomer(Integer userId, String status1, String status2);

	List<Order> searchOrdersByProductName(Integer userId, String productName);

	List<Order> searchOrdersByProductNameAndStatus(Integer userId, String productName, String status);
}
