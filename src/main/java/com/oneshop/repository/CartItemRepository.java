package com.oneshop.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.CartItem;

import jakarta.transaction.Transactional;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
	List<CartItem> findByCartId(Integer id);
	List<CartItem> findByProductId(Integer id);
	@Query("SELECT ci FROM CartItem ci WHERE ci.cart.user.id = :userId")
    List<CartItem> findByUserId(@Param("userId") Integer userId);
	@Modifying
	@Transactional
	@Query("DELETE FROM CartItem ci WHERE ci.id IN :cartItemIds")
	void deleteAllByIds(@Param("cartItemIds") List<Integer> cartItemIds);
	@Modifying
	@Transactional
	@Query("DELETE FROM CartItem ci WHERE ci IN :cartItems")
	void deleteAllByCartItems(@Param("cartItems") List<CartItem> cartItems);
	@Query("SELECT ci FROM CartItem ci WHERE ci.cart.user.id = :userId AND ci.product.id IN :productIds")
    List<CartItem> findByUserIdAndProductIds(@Param("userId") int userId, @Param("productIds") List<Integer> productIds);
}
