package com.oneshop.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oneshop.entity.Address;
import com.oneshop.entity.User;
import com.oneshop.repository.AddressRepository;
import com.oneshop.service.IAddressService;

@Service
public class AddressServiceImpl implements IAddressService {
	@Autowired
    private AddressRepository addressRepository;
	
	@Override
	public Optional<Address> findById(Integer addressId) {
		 return addressRepository.findById(addressId);
	}

	@Override
    public List<Address> findByUser(User user) {
        return addressRepository.findByUser(user); 
    }
	@Override
	public Address save(Address address) {
        return addressRepository.save(address);
    }
   
}
