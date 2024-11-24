package com.oneshop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/images/user/**")
	            .addResourceLocations("file:D:/Nam 3/Project_CK_OneShop_Nhom_4/src/main/resources/META-INF/WEB-INF/view/images/user/");
	}

}

