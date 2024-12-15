package com.oneshop.model;

import java.time.LocalDate;

public class RevenueData {
    private LocalDate createat; 
    private Double price;
	public LocalDate getCreateat() {
		return createat;
	}
	public void setCreateat(LocalDate createat) {
		this.createat = createat;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public RevenueData(LocalDate createat, Double price) {
		this.createat = createat;
		this.price = price;
	}

    
}
