package com.oneshop.model;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryModel {
	private Integer id;
	private String name;
	private Double price;
	private String desciption;
	private Boolean isdeleted;
	private Date createat;
	private Date updateat;
	private Boolean isEdit = false;
}
