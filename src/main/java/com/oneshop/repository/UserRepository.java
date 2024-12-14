package com.oneshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.User;


@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    User findByEmail(String email);
    User findByResetpasswordtoken(String token);
    User findByPhone(String phone);
    @Query("SELECT u FROM User u WHERE u.firstName LIKE %:search% OR u.lastName LIKE %:search% OR u.email LIKE %:search%")
    List<User> findByFirstNameContainingOrLastNameContainingOrEmailContaining(@Param("search") String search);
    @Query("SELECT u FROM User u WHERE u.role = :role")
    List<User> findByRole(@Param("role") String role);
    @Query("SELECT u FROM User u WHERE (u.firstName LIKE %:search% OR u.lastName LIKE %:search% OR u.email LIKE %:search%) AND u.role = :role")
    List<User> findByFirstNameContainingOrLastNameContainingOrEmailContainingAndRole(@Param("search") String search, @Param("role") String role);
}

