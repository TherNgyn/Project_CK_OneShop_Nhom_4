package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "storeid", nullable = false)
    private Store store;

    @ManyToOne
    @JoinColumn(name = "deliveryid", nullable = false)
    private Delivery delivery;

    @Column(length = 255)
    private String address;

    @Column(nullable = false)
    private String phone;

    @Column(length = 255)
    private String status;

    private Float price;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;
}
