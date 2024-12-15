package com.oneshop.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // Thêm khóa chính cho class Inventory

    @ManyToOne 
    private Product product;

    private int quantity;
    
}
