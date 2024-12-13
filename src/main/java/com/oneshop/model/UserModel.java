package com.oneshop.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.oneshop.entity.Store;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class UserModel {

	private Integer id;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private String username;
	private String password;// mật khẩu mã hóa
	private String role;// mặt định là user, là admin hoặc user của 1 shop tạo ra
	private String address;
	private String avatar;
	private Boolean isSeller;
	private Store store;
	private MultipartFile avatarFile;
	private Date createat;
	private Date updateat;
	private Boolean isActive;
	private Boolean isEdit = false;
	private String confirmPassword;
	public UserModel(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}
	public UserModel(String password) {
		super();
		this.password = password;
	}
	
	
	
	

}
