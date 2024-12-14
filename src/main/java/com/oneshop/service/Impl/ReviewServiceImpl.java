package com.oneshop.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.oneshop.repository.ReviewRepository;
import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.IReviewService;

@Service
public class ReviewServiceImpl implements IReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    public List<Review> findByProduct(Product product) {
        return reviewRepository.findByProduct(product);
    }

    @Override
    public <S extends Review> S save(S entity) {
        return reviewRepository.save(entity);
    }

    @Override
    public <S extends Review> Optional<S> findOne(Example<S> example) {
        return reviewRepository.findOne(example);
    }

    @Override
    public List<Review> findAll() {
        return reviewRepository.findAll();
    }

    @Override
    public Page<Review> findAll(Pageable pageable) {
        return reviewRepository.findAll(pageable);
    }

    @Override
    public List<Review> findAll(Sort sort) {
        return reviewRepository.findAll(sort);
    }

    @Override
    public List<Review> findAllById(Iterable<Integer> ids) {
        return reviewRepository.findAllById(ids);
    }

    @Override
    public <S extends Review> Page<S> findAll(Example<S> example, Pageable pageable) {
        return reviewRepository.findAll(example, pageable);
    }

    @Override
    public Optional<Review> findById(Integer id) {
        return reviewRepository.findById(id);
    }

    @Override
    public boolean existsById(Integer id) {
        return reviewRepository.existsById(id);
    }

    @Override
    public long count() {
        return reviewRepository.count();
    }

    @Override
    public void deleteById(Integer id) {
        reviewRepository.deleteById(id);
    }

    @Override
    public void delete(Review entity) {
        reviewRepository.delete(entity);
    }

    @Override
    public Review getById(Integer id) {
        return reviewRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteAll() {
        reviewRepository.deleteAll();
    }

    @Override
    public Page<Review> findByProductStore(Store store, Pageable page) {
        return reviewRepository.findByProductStore(store, page);
    }

	@Override
	public List<Review> findByProductId(Integer productId) {
		return reviewRepository.findByProductId(productId);
	}

	@Override
	public long countByProductId(Integer productId) {
		return reviewRepository.countByProductId(productId);
	}
	@Override
    public Review findByUserAndProduct(User user, Product product) {
        return reviewRepository.findByUserAndProduct(user, product);
    }

	@Override
	public void saveReview(Review review) {
	    reviewRepository.save(review);
	}

	@Override
	public float calculateAverageRating(Integer productId) {
	    List<Review> reviews = reviewRepository.findByProductId(productId);
	    if (reviews.isEmpty()) {
	        return 0;
	    }
	    float totalRating = 0;
	    for (Review review : reviews) {
	        totalRating += review.getRating();
	    }
	    return totalRating / reviews.size();
	}

	
	
}
