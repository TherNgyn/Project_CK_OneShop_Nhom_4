package com.oneshop.repository;

import com.oneshop.entity.Address;
import com.oneshop.entity.User;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Integer> {
    Optional<Address> findById(Integer addressId);
	List<Address> findByUser(User user); 
}
