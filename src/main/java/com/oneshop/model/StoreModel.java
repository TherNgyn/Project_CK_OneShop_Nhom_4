package com.oneshop.model;

import java.util.*;


import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreModel {
	private Integer id;
	private String name;	
	private String bio;
	private Integer ownerId;// từ user nào id useradmin
	private Boolean isactive = false;// được duyệt đưa vào bán	
	private String avatar;// ảnh của shop
	private MultipartFile avatarFile;
	private String featuredimages;
	private MultipartFile featuredimagesFile;
	private float rating;
	private Date createAt;
	private Date updaeAt;	
	private Boolean isEdit = false;
}
