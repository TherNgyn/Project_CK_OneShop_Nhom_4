package com.oneshop.entity;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // Liên kết với người dùng
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userid", nullable = false)
    @JsonIgnore
    @ToString.Exclude
    private User user;

    // Liên kết với cửa hàng
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "storeid", nullable = true)
    @ToString.Exclude
    private Store store;

    // Liên kết với giao hàng
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "deliveryid", nullable = true)
    @ToString.Exclude
    private Delivery delivery;

    // Liên kết với địa chỉ
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id", nullable = true)
    @ToString.Exclude
    private Address address;

    @Column(nullable = false)
    private String phone;

    @Column(length = 255)
    private String status;

    private Float price;

    private LocalDateTime createat;
    private LocalDateTime updateat;

    @Column(nullable = false)
    private Boolean received = false; // Trạng thái nhận hàng, mặc định là `false`

    @Column(nullable = false)
    private Boolean reviewed = false; // Trạng thái đã đánh giá, mặc định là `false`

    // Tránh vòng lặp khi trả về danh sách đơn hàng
    @ToString.Exclude
    @JsonIgnore
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> orderItems;

    // Không lưu trữ trong cơ sở dữ liệu
    @Transient
    @JsonIgnore
    private Map<Store, List<OrderItem>> storeGroupedOrderItems;

    public Map<Store, List<OrderItem>> getStoreGroupedOrderItems() {
        return storeGroupedOrderItems;
    }

    public void setStoreGroupedOrderItems(Map<Store, List<OrderItem>> storeGroupedOrderItems) {
        this.storeGroupedOrderItems = storeGroupedOrderItems;
    }

    // Chuyển `createat` thành `Date` để tương thích
    @Transient
    public Date getCreateAtAsDate() {
        return createat == null ? null : Date.from(createat.atZone(ZoneId.systemDefault()).toInstant());
    }

    // Định dạng ngày tháng
    @Transient
    public String getFormattedCreateAt() {
        if (createat == null) {
            return null;
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return createat.format(formatter);
    }
}
