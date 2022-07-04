package com.sam.coffeeshop.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private String product_des;
	private String product_img;
	private String product_name;
	private String product_price;
	private String product_taste;
	private String category_code;
	private String categorycode_ref;
	private String product_origin;
	
	private MultipartFile uploadFile;
}
