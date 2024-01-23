package com.kh.coddy.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override public void addResourceHandlers(ResourceHandlerRegistry registry) { registry.addResourceHandler("/summernoteImage/**").addResourceLocations("file:///C:\\dev\\java\\Coddy\\coddy\\src\\main\\webapp\\resources\\file_upload\\hboard\\content"); }
}