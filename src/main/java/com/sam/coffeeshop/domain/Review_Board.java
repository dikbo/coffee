package com.sam.coffeeshop.domain;

import lombok.Data;

@Data
public class Review_Board {
	private Long review_id;
	private String content;
	private int rating;
	private String member_id;
	private int product_id;
	private String order_id;
}
