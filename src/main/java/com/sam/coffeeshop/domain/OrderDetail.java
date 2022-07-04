package com.sam.coffeeshop.domain;

import lombok.Data;

@Data
public class OrderDetail {
	private Long detail_id;
	private Long detail_qty;
	private int product_id;
	private String order_id;
}
