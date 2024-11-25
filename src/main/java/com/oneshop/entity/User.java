package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String firstName;

    @Column(length = 255)
    private String lastName;

    @Column(length = 255, unique = true, nullable = false) 
    private String email;

    @Column(length = 10, nullable = false)
    private String phone;

    private String username;
    private String password;

    @Column(length = 255)
    private String address;

    private String avatar;
    private String role;
    private Boolean isActive;
    private String resetpasswordtoken;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Order
    private List<Order> orders;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Store
    private Store store;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Cart
    private List<Cart> carts;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Review
    private List<Review> reviews;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp với Transaction
    private List<Transaction> transactions;
}

