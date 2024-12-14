package com.oneshop.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.oneshop.entity.Blog;
import com.oneshop.repository.BlogRepository;
import com.oneshop.service.IBlogService;
import com.oneshop.service.ICartItemService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
public class BlogServiceImpl implements IBlogService {
	@Autowired
    private BlogRepository blogRepository;

    @Override
    public List<Blog> getAllBlogs() {
        return blogRepository.findAll(); 
    }

    @Override
    public Blog getBlogById(Integer id) {
        return blogRepository.findById(id).orElse(null); 
    }
    @Override
    public Page<Blog> getBlogsPaginated(Pageable pageable) {
        return blogRepository.findAll(pageable);
    }
    @Override
    public List<Blog> getTop4LatestBlogs() {
        return blogRepository.findTop4ByOrderByCreatedAtDesc();
    }

}

