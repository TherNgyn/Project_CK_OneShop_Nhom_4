package com.oneshop.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryModel {
	private Integer id;
	private String name;
	private String image;
	private Date createat;
	private Date updateat;
	private MultipartFile listImageFile;
	private Boolean isdeleted;
}
