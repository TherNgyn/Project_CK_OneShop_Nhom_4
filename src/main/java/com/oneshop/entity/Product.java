package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "product")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(nullable=true)
    private String brand;
    
    @Column(length = 255)
    private String description;

    // Giá gốc
    private Double price;

    // Giá khuyến mãi
    private Double promotionalPrice;

    private Integer sold;

    // Có đang bán hay không
    private Boolean isSelling;

    // Không cần lưu trữ vào cơ sở dữ liệu
    @Transient
    private List<String> imageUrls; // URL to be generated

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude // Ngăn tham chiếu lặp trong Lombok
    private List<ProductImage> images;

    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    @ToString.Exclude // Ngăn tham chiếu ngược
    private Category category;

    @ManyToOne
    @JoinColumn(name = "storeid", nullable = false)
    @ToString.Exclude
    private Store store;

    private float rating;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn tham chiếu lặp trong Lombok
    private List<Review> reviews;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn tham chiếu lặp trong Lombok
    private List<CartItem> cartItems;

}
