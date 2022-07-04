package com.sam.coffeeshop.domain;

import java.util.Date;

import lombok.Data;
@Data
public class Cart {
	private Long cart_id;
	private Long qty;
	private Date regdate;
	private String member_id;
	private int product_id;
	
}
