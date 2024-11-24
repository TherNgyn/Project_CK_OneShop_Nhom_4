package com.oneshop.entity;

import java.sql.Date;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cartitem")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "cartid", nullable = false)
    private Cart cart;

    @ManyToOne
    @JoinColumn(name = "productid", nullable = false)
    private Product product;

    private Integer count;
    private Date createat;
    private Date updateat;
}