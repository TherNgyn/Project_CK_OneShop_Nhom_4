package com.oneshop.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.oneshop.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
	List<Cart> findByUserId(Integer Id);
	@Query("SELECT COUNT(ci) FROM CartItem ci WHERE ci.cart.user.id = :userId")
    int countCartItemsByUserId(@Param("userId") Integer userId);

	
}
