package com.oneshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "product_images")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String imageUrl;

    // Đánh dấu hình ảnh chính
    @Column(nullable = false)
    private Boolean isMain = false;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    @ToString.Exclude // Ngăn tham chiếu lặp trong Lombok
    @EqualsAndHashCode.Exclude
    private Product product;
}