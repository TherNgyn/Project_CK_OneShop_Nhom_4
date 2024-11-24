package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "delivery")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(nullable = false)
    private Double price;

    @Column(length = 255)
    private String description;

    private Boolean isDeleted;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "delivery", cascade = CascadeType.ALL)
    private List<Order> orders;
}
