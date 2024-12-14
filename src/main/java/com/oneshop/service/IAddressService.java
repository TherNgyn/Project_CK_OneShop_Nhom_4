package com.oneshop.service;

import java.util.List;
import java.util.Optional;

import com.oneshop.entity.Address;
import com.oneshop.entity.User;

public interface IAddressService {
	Optional<Address> findById(Integer addressId);
	List<Address> findByUser(User user);
	Address save(Address address);
}
