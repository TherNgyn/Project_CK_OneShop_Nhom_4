package com.oneshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;

public interface IReviewService {
    <S extends Review> S save(S entity);
    <S extends Review> Optional<S> findOne(Example<S> example);
    List<Review> findAll();
    Page<Review> findAll(Pageable pageable);
    List<Review> findAll(Sort sort);
    List<Review> findAllById(Iterable<Integer> ids);
    <S extends Review> Page<S> findAll(Example<S> example, Pageable pageable);
    Optional<Review> findById(Integer id);
    boolean existsById(Integer id);
    long count();
    void deleteById(Integer id);
    void delete(Review entity);
    Review getById(Integer id);
    void deleteAll();
    Page<Review> findByProductStore(Store store, Pageable page);
    List<Review> findByProduct(Product product);
    List<Review> findByProductId(Integer productId);
    long countByProductId(Integer productId);
    Review findByUserAndProduct(User user, Product product);
	void saveReview(Review review);
	float calculateAverageRating(Integer id);
}
