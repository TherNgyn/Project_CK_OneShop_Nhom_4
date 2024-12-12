package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import com.fasterxml.jackson.annotation.JsonIgnore;

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

    // Ngăn vòng lặp khi gọi toString() hoặc chuyển đổi JSON
    @OneToMany(mappedBy = "delivery", cascade = CascadeType.ALL)
    @JsonIgnore
    @ToString.Exclude
    private List<Order> orders;
}
