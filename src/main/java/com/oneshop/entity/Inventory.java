package com.oneshop.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Inventory {

    @Id
    private Long id;  // Thêm khóa chính cho class Inventory

    @ManyToOne  // Mối quan hệ Many-to-One với Product
    private Product product;

    private int quantity;

}
