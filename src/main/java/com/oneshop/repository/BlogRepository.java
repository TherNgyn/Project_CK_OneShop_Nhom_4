package com.oneshop.repository;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oneshop.entity.Blog;
import org.springframework.data.domain.Page;

@Repository
public interface BlogRepository extends JpaRepository<Blog, Integer> {
	
	 List<Blog> findTop4ByOrderByCreatedAtDesc();
}

