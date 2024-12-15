package com.oneshop.repository;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Order;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.model.RevenueData;

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
	
	@Query("SELECT DISTINCT YEAR(o.updateat) FROM Order o ORDER BY YEAR(o.updateat) DESC")
	List<Integer> findDistinctYearsFromUpdateAt();
	
	boolean existsByUserId(Integer userId);

	long countByStatus(String status);
	
	@Query("SELECT DISTINCT o FROM Order o JOIN o.orderItems oi JOIN oi.product p WHERE p.store.id = :storeId")
    List<Order> findAllByStoreId(@Param("storeId") Integer storeId);
	
	List<Order> findDistinctByOrderItems_Product_StoreAndStatus(Store store, String status);

	@Query("SELECT o FROM Order o " +
	           "JOIN FETCH o.orderItems oi " +
	           "JOIN FETCH oi.product p " +
	           "WHERE p.store.id = :storeId AND " +
	           "(o.status = :status1 OR o.status = :status2)")
	    List<Order> getOrdersByStoreAndStatuses(
	            @Param("storeId") Integer storeId,
	            @Param("status1") String status1,
	            @Param("status2") String status2);
	@Query("SELECT o FROM Order o ORDER BY o.createat DESC")
    List<Order> findLatestOrders();
	@Query("SELECT COUNT(o) FROM Order o WHERE o.status IN ('Processing_1', 'Processing_2')")
    long countNewOrders();
	@Query("SELECT SUM(o.price) FROM Order o WHERE o.status = 'Completed'")
    Double findTotalRevenue();
	@Query("SELECT SUM(o.price) FROM Order o WHERE o.status = 'Completed' AND o.createat >= :startOfDay AND o.createat < :endOfDay")
    Double findTodayRevenue(LocalDateTime startOfDay, LocalDateTime endOfDay);
	@Query("SELECT o FROM Order o WHERE o.status IN ('In Transit_1', 'In Transit_2')")
    List<Order> findOrdersInTransit();

	List<Order> findByStatusIgnoreCase(String status);
    List<Order> findByStatusIgnoreCaseAndPhoneContainingIgnoreCase(String status, String phone);

	List<Order> findByStatusIgnoreCaseAndPhoneContainingIgnoreCaseOrUserFirstNameContainingIgnoreCaseOrUserLastNameContainingIgnoreCase(
			String status, String searchTerm, String searchTerm2, String searchTerm3);

	List<Order> findByPhoneContainingIgnoreCaseOrUserFirstNameContainingIgnoreCaseOrUserLastNameContainingIgnoreCase(
			String searchTerm, String searchTerm2, String searchTerm3);

}

