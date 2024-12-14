package com.oneshop.service;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.User;
import com.oneshop.service.Impl.UserNotFoundException;

public interface IUserService {
    void deleteAll();
    User getById(Integer id);
    void delete(User entity);
    void deleteById(Integer id);
    long count();
    boolean existsById(Integer id);
    Optional<User> findById(Integer id);
    <S extends User> Page<S> findAll(Example<S> example, Pageable pageable);
    List<User> findAllById(Iterable<Integer> ids);
    List<User> findAll(Sort sort);
    Page<User> findAll(Pageable pageable);
    List<User> findAll();
    <S extends User> Optional<S> findOne(Example<S> example);
    <S extends User> S save(S entity);
    User findByUsername(String username);
    User login(String username, String password);
    Integer countByCreateat(Date date);
    void updatePassword(User customer, String newPassword);
    User getByResetPasswordToken(String token);
    User findByEmail(String email);
    User findByPhone(String phone);
    int countCustomer();
	List<User> findUsers(String search, String role);
	void deleteUser(Integer userId);
}

