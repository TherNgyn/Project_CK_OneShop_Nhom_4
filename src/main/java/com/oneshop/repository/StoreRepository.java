package com.oneshop.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;


@Repository
public interface StoreRepository extends JpaRepository<Store, Integer> {
	// Tìm Kiếm theo nội dung tên from Store where Storename
	List<Store> findByNameContaining(String name);
	Store findOneByName(String name);
	// Tìm kiếm và Phân trang
	// Ham phan trang
	Page<Store> findByNameContaining(String name, Pageable pageable);
	// Viết thêm
	Integer countByCreateat(Date date);
	Store findOneByUser(User user);
	Store findByUserId(Integer userId);
	Store findByName(String name);
	boolean existsByUserId(Integer userId);
	public List<Store> findByNameContainingIgnoreCaseOrBioContainingIgnoreCase(String name, String bio);

}
