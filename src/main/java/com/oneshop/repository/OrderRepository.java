package com.oneshop.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Order;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
	Integer countByCreateat(Date date);

	List<Order> findByStore(Store store);

	List<Order> findByUser(User user);

	List<Order> findByUser_Id(Integer userId);

	List<Order> findByUser_IdAndStatus(Integer userId, String status);

	List<Order> findAllByUserIdAndStore(Integer userId, Store store);

	List<Order> findAllByUserIdAndStoreAndStatus(Integer userId, Store store, String status);

	Order findTopByUserIdOrderByCreateatDesc(Integer id);
  
	@Query("SELECT o FROM Order o WHERE o.user.id = :userId AND (o.status = :status1 OR o.status = :status2)")
	List<Order> findOrdersByUserAndStatuses(@Param("userId") Integer userId, @Param("status1") String status1,
			@Param("status2") String status2);

	@Query(value = "SELECT DISTINCT o.* FROM orders o " + "JOIN orderitem oi ON o.id = oi.orderid "
			+ "JOIN product p ON oi.productid = p.id "
			+ "WHERE o.userid = :userId AND p.name LIKE %:productName%", nativeQuery = true)
	List<Order> findOrdersByUserAndProductNameNative(@Param("userId") Integer userId,
			@Param("productName") String productName);

	@Query(value = "SELECT DISTINCT o.* FROM orders o " + "JOIN orderitem oi ON o.id = oi.orderid "
			+ "JOIN product p ON oi.productid = p.id "
			+ "WHERE o.userid = :userId AND p.name LIKE %:productName% AND o.status = :status", nativeQuery = true)
	List<Order> findOrdersByUserAndProductNameAndStatusNative(@Param("userId") Integer userId,
			@Param("productName") String productName, @Param("status") String status);
  
	@Query("SELECT o FROM Order o WHERE YEAR(o.createat) = :year")
    List<Order> findOrdersByYear(int year);
	@Query("SELECT COUNT(DISTINCT o.user) FROM Order o WHERE o.user.id IS NOT NULL")
	int countDistinctUsers();
}
