package com.oneshop.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "addresses")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;  // Liên kết với User

    @Column(length = 255)
    private String addressLine1;  // Địa chỉ dòng 1 (số nhà, tên đường)
    
    @Column(length = 255)
    private String addressLine2;  // Địa chỉ dòng 2 (phường, quận)

    @Column(length = 100)
    private String city;  // Thành phố

    private Boolean isPrimary;  // Địa chỉ chính (nếu có nhiều địa chỉ)

    private Date createat;
    private Date updateat;
    
    @OneToMany(mappedBy = "address", cascade = CascadeType.ALL)
    private List<Order> orders;

	@Override
	public String toString() {
		return "Address [addressLine1=" + addressLine1 + ", addressLine2=" + addressLine2 + ", city=" + city + "]";
	} 
    
    
}
