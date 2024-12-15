package com.oneshop.entity;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "orderitem")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "orderid", nullable = false)
    @ToString.Exclude
    @JsonIgnore
    private Order order;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "productid", nullable = false)
    private Product product;

    private Integer count;

    @Column(nullable = false)
    private LocalDateTime createat;

    @Column(nullable = true)
    private LocalDateTime updateat;
}
