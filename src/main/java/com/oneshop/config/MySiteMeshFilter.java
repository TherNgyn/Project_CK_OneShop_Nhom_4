package com.oneshop.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
	    builder.addDecoratorPath("/admin/*", "admin.jsp")
	           .addDecoratorPath("/vendor/*", "vendor.jsp")
	           .addDecoratorPath("/user/*", "user.jsp")
	           .addDecoratorPath("/*", "web.jsp");
	}
}
