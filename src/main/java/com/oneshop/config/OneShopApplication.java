package com.oneshop.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class OneShopApplication {
    public static void main(String[] args) {
        SpringApplication.run(OneShopApplication.class, args);
    }
}
