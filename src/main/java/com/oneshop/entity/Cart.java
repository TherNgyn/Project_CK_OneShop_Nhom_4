package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "cart")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "storeid", nullable = true)
    private Store store;

    private Date createat;
    private Date updateat;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL)
    @ToString.Exclude // Loại trừ `cartItems` khỏi `toString`
    private List<CartItem> cartItems;

    @PrePersist
    public void prePersist() {
        if (store == null) {
            store = null; // Hoặc sử dụng store mặc định nếu cần
        }
    }
}

