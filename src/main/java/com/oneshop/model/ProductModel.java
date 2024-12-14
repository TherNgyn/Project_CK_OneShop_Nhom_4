package com.oneshop.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductModel {
	private Integer id;	
    private String name;
    private String description;
    private Double price;
    private Double promotionaprice;
    private Integer quantity;
    private Integer sold;
    private Boolean isselling;
    private String status;
    private String listimage;
    private MultipartFile listImageFile;
    private Integer categoryid=null;
    private Integer storeid=null;
    private float rating;
    private Date createat;
    private Date updateat;
    
    private Boolean isEdit = false;
    
}
