package com.oneshop.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductModel {
	private Integer id;	
    private String name="123";
    private String desciption="123";
    private Double price=123.0;
    private Double promotionaprice=123.0;
    private Integer quantity=123;
    private Integer sold;
    private Boolean isselling = true;
    private String listimage;
    private MultipartFile listImageFile;
    private Integer categoryid=null;
    private Integer storeid=null;
    private float rating =3;
    private Date createat;
    private Date updateat;
    
    private Boolean isEdit = false;
    
}
