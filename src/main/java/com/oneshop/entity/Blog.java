package com.oneshop.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "blog")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Blog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String title; // Tiêu đề bài viết

    @Column(length = 500)
    private String description; // Mô tả ngắn bài viết

    @Column(nullable = false, length = 5000)
    private String content; // Nội dung bài viết

    @Column(nullable = true)
    private String imageUrl; // URL hình ảnh đại diện bài viết

    @Column(nullable = false)
    private String category; // Danh mục (ví dụ: Fashion, Lifestyle...)

    @Column(nullable = false)
    private LocalDateTime createdAt; // Thời gian tạo bài viết

    @Column(nullable = true)
    private LocalDateTime updatedAt; // Thời gian cập nhật bài viết

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}

