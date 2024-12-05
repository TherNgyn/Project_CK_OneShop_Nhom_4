package com.oneshop.entity;

import java.sql.Date;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "review")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "productid", nullable = false)
    private Product product;

    @Column(length = 255, nullable = false)
    private String content;

    private float rating;

    @Column(nullable = false) 
    private Date createat;

    @Column(nullable = true) 
    private Date updateat;

    @Transient 
    private String formattedCreateat;

    public String getFormattedCreateat() {
        return formattedCreateat;
    }

    public void setFormattedCreateat(String formattedCreateat) {
        this.formattedCreateat = formattedCreateat;
    }
}
