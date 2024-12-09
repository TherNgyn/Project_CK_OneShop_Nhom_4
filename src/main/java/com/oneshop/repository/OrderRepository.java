package com.oneshop.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Order;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
@Repository
public interface OrderRepository extends JpaRepository< Order, Integer >{
	Integer countByCreateat(Date date);
	List<Order> findByStore(Store store);
	List<Order> findByUser(User user) ;
	List<Order> findByUser_Id(Integer userId);
	List<Order> findByUser_IdAndStatus(Integer userId, String status);
	List<Order> findAllByUserIdAndStore(Integer userId, Store store);
	List<Order> findAllByUserIdAndStoreAndStatus(Integer userId, Store store, String status);
	Order findTopByUserIdOrderByCreateatDesc(Integer id);
}
