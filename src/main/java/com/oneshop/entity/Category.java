package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "category")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(length = 255)
    private String image;

    private Date createat;
    private Date updateat;
    private Boolean isDeleted;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp khi dùng Lombok
    private List<Product> products;
    
    @Transient
    private List<Product> topProducts;
}
