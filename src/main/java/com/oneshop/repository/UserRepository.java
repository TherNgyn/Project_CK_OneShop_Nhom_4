package com.oneshop.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.User;


@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

	List<User> findByRoleContaining(String role);
	List<User> findByUsername(String username);
	Integer countByCreateat(Date date);
	@Query("SELECT c FROM User c WHERE c.email = ?1")
	public User findByEmail(String email);
	public User findByResetpasswordtoken(String token);
	
}
