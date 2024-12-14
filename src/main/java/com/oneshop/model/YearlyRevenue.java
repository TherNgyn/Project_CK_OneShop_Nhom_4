package com.oneshop.model;

public class YearlyRevenue {
    private int year;
    private double revenue;

    public YearlyRevenue(int year, double revenue) {
        this.year = year;
        this.revenue = revenue;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }
}

