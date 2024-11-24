package com.oneshop.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartModel {
	private Integer id;
	private Integer userid;
	private Integer storeid;
	private Date createat;
	private Date updateat;
	private Boolean isEdit = false;
}
