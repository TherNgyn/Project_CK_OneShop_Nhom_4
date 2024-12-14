package com.oneshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.oneshop.entity.Blog;

public interface IBlogService {
	List<Blog> getAllBlogs();
	Blog getBlogById(Integer id);
	Page<Blog> getBlogsPaginated(Pageable pageable);
	List<Blog> getTop4LatestBlogs();
}
