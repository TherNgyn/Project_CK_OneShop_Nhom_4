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
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true) // Chỉ sử dụng các trường được đánh dấu
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include // Bao gồm ID trong hashCode và equals
    private Integer id;

    @Column(length = 255)
    private String firstName;

    @Column(length = 255)
    private String lastName;

    @Column(length = 255, unique = true, nullable = false)
    @EqualsAndHashCode.Include // Bao gồm email để nhận dạng duy nhất
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
    @ToString.Exclude // Ngăn vòng lặp trong toString
    @EqualsAndHashCode.Exclude // Loại bỏ khỏi hashCode
    private List<Order> orders;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Store store;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Cart> carts;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Review> reviews;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Address> addresses;

	@Override
	public String toString() {
		return "User [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", phone=" + phone + ", username=" + username + ", password=" + password + ", address=" + address
				+ ", avatar=" + avatar + ", role=" + role + ", isActive=" + isActive + ", resetpasswordtoken="
				+ resetpasswordtoken + ", createat=" + createat + ", updateat=" + updateat + "]";
	} 
    
    
}


