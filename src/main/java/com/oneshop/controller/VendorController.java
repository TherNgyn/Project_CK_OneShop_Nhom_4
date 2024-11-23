package com.oneshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vendor")
public class VendorController {
    @GetMapping("/home")
    public String userHome() {
        return "vendor/home"; // File JSP của user
    }
}
