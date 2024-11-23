package com.oneshop.model;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemModel {
	private Integer id;
	private Integer orderid;
	private Integer productid;
	private Integer count;
	private Date createat;
	private Date updateat;
	private Boolean isEdit = false;
}
