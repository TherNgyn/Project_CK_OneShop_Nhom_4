package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "store")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true) // Chỉ bao gồm trường cần thiết trong hashCode/equals
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include // Bao gồm ID trong hashCode/equals
    private Integer id;

    @Column(length = 255)
    private String name;

    @Column(length = 255)
    private String bio;

    @OneToOne
    @JoinColumn(name = "ownerid", nullable = false)
    @ToString.Exclude // Ngăn vòng lặp trong toString
    @EqualsAndHashCode.Exclude // Loại bỏ khỏi hashCode/equals
    private User user;

    private Boolean isactive;
    private String avatar;
    private String featuredimages;
    private float rating;
    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude // Ngăn vòng lặp trong toString
    @EqualsAndHashCode.Exclude // Loại bỏ khỏi hashCode/equals
    private List<Cart> carts;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Product> products;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Order> orders;

    private long waitingProductCount;

    // Add the getter and setter methods for the waitingProductCount field
    public long getWaitingProductCount() {
        return waitingProductCount;
    }

    public void setWaitingProductCount(long waitingProductCount) {
        this.waitingProductCount = waitingProductCount;
    }
    
    
    
}
