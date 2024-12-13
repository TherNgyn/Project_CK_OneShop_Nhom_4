package com.oneshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {
	List<OrderItem> findByOrder(Order Order);
	List<OrderItem> findByOrder_Id(Integer orderId);
	List<OrderItem> findAllByOrderId(int orderId);
	@Query("SELECT oi FROM OrderItem oi WHERE oi.order.id = :orderId")
	List<OrderItem> findByOrderId(@Param("orderId") int orderId);
	
}
