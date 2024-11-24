package com.oneshop.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransactionModel {
	private Integer id;

	private Integer userid;
	private Integer storeid;
	
	private Boolean isup;
	private Double amount;
	
	private Date createat;
	private Date updaeat;
	  private Boolean isEdit = false;
	
}
