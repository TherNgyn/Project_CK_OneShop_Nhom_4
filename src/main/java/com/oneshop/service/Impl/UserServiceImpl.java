package com.oneshop.service.Impl;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.oneshop.entity.User;
import com.oneshop.repository.OrderRepository;
import com.oneshop.repository.StoreRepository;
import com.oneshop.repository.UserRepository;
import com.oneshop.service.IUserService;


@Service
public class UserServiceImpl implements IUserService {
	@Autowired
	UserRepository UserRepository;
	@Autowired
	OrderRepository orderRepository;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	IUserService userService;
    @Autowired
    private StoreRepository storeRepository;	

	@Override
	public <S extends User> S save(S entity) {
	    return UserRepository.save(entity);
	}


	@Override
	public <S extends User> Optional<S> findOne(Example<S> example) {
		return UserRepository.findOne(example);
	}

	@Override
	public List<User> findAll() {
		return UserRepository.findAll();
	}

	@Override
	public Page<User> findAll(Pageable pageable) {
		return UserRepository.findAll(pageable);
	}

	@Override
	public List<User> findAll(Sort sort) {
		return UserRepository.findAll(sort);
	}

	@Override
	public List<User> findAllById(Iterable<Integer> ids) {
		return UserRepository.findAllById(ids);
	}

	@Override
	public <S extends User> Page<S> findAll(Example<S> example, Pageable pageable) {
		return UserRepository.findAll(example, pageable);
	}

	@Override
	public Optional<User> findById(Integer id) {
		return UserRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return UserRepository.existsById(id);
	}

	@Override
	public long count() {
		return UserRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		UserRepository.deleteById(id);
	}

	@Override
	public void delete(User entity) {
		UserRepository.delete(entity);
	}

	@SuppressWarnings("deprecation")
	@Override
	public User getById(Integer id) {
		return UserRepository.getById(id);
	}


	@Override
	public void deleteAll() {
		UserRepository.deleteAll();
	}
	
	
	@Override
	public User findByEmail(String email) {
	    return UserRepository.findByEmail(email);
	}


	@Override
	public User getByResetPasswordToken(String token) {
		return UserRepository.findByResetpasswordtoken(token);
	}

	@Override
	public void updatePassword(User customer, String newPassword) {
		// BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		// String encodedPassword = passwordEncoder.encode(newPassword);
		customer.setPassword(newPassword);

		customer.setResetpasswordtoken(null);
		UserRepository.save(customer);
	}
	@Override
	public User findByUsername(String username) {
	    return UserRepository.findByUsername(username);
	}
	public User login(String username, String password) {
        User user = UserRepository.findByUsername(username);
        if (user == null || !passwordEncoder.matches(password, user.getPassword())) {
            return null; 
        }

        return user; 
    }


	@Override
	public Integer countByCreateat(Date date) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public User findByPhone(String phone) {
		return UserRepository.findByPhone(phone);
	}


	@Override
	public int countCustomer() {
		return orderRepository.countDistinctUsers();
	}
	
	@Override
	public List<User> findUsers(String search, String role) {
	    if (search != null && !search.isEmpty() && (role == null || role.isEmpty())) {
	        return UserRepository.findByFirstNameContainingOrLastNameContainingOrEmailContaining(search);
	    } else if (role != null && !role.isEmpty() && (search == null || search.isEmpty())) {
	        return UserRepository.findByRole(role);
	    } else if (search != null && !search.isEmpty() && role != null && !role.isEmpty()) {
	        return UserRepository.findByFirstNameContainingOrLastNameContainingOrEmailContainingAndRole(search, role);
	    } else {
	        return UserRepository.findAll();
	    }
	}
	
	public boolean canDeleteUser(Integer userId) {
        // Kiểm tra xem User có tồn tại trong Order, Store, hoặc Transaction không
        boolean isReferencedInOrder = orderRepository.existsByUserId(userId);
        boolean isReferencedInStore = storeRepository.existsByUserId(userId);

        return !(isReferencedInOrder || isReferencedInStore);
    }
	
	// Phương thức xóa User nếu có thể
    @Override
	public void deleteUser(Integer userId) {
        if (!canDeleteUser(userId)) {
            throw new IllegalStateException("Không thể xóa người dùng vì có tham chiếu từ các bảng khác.");
        }
        UserRepository.deleteById(userId);
    }
	
}