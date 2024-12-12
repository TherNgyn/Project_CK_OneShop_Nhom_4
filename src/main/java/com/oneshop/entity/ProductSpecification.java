package com.oneshop.entity;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

public class ProductSpecification {

	public static Specification<Product> hasName(String name) {
        return (root, query, criteriaBuilder) -> 
            name != null && !name.trim().isEmpty() ? 
                criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.toLowerCase() + "%") : null;
    }
	
    public static Specification<Product> hasCategory(List<String> categories) {
        return (root, query, criteriaBuilder) -> 
            categories != null && !categories.isEmpty() ? 
            root.get("category").get("name").in(categories) : null;
    } // Lọc theo nhiều danh mục

    public static Specification<Product> hasBrand(List<String> brands) {
        return (root, query, criteriaBuilder) -> 
            brands != null && !brands.isEmpty() ? 
                root.get("brand").in(brands) : null;  // Lọc theo nhiều thương hiệu
    }

    public static Specification<Product> isPriceBetween(Double minPrice, Double maxPrice) {
        return (root, query, criteriaBuilder) -> {
            if (minPrice != null && maxPrice != null) {
                return criteriaBuilder.between(root.get("price"), minPrice, maxPrice);
            } else if (minPrice != null) {
                return criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice);
            } else if (maxPrice != null) {
                return criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice);
            }
            return null;
        };
    }  
    public static Specification<Product> filterByCriteria(String name, List<String> categories, List<String> brand, Double minPrice, Double maxPrice) {
        return Specification.where(hasName(name)) // Thêm lọc theo tên sản phẩm
                            .and(hasCategory(categories)) // Lọc theo danh mục
                            .and(hasBrand(brand)) // Lọc theo thương hiệu
                            .and(isPriceBetween(minPrice, maxPrice)); // Lọc theo giá
    }
    
}
