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
	
}
