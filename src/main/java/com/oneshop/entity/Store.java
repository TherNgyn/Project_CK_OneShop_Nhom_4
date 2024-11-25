package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "store")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(length = 255)
    private String bio;

    @OneToOne
    @JoinColumn(name = "ownerid", nullable = false)
    @ToString.Exclude // Ngăn vòng lặp với User
    private User user;

    private Boolean isactive;
    private String avatar;
    private String featuredimages;
    private float rating;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Cart
    private List<Cart> carts;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Product
    private List<Product> products;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Transaction
    private List<Transaction> transactions;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Order
    private List<Order> orders;
}

