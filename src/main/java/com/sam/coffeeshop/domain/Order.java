package com.sam.coffeeshop.domain;

import java.util.Date;

import lombok.Data;
@Data
public class Order {
	private String order_id;
	private String order_addr1;
	private String order_addr2;
	private String order_addr3;
	private Date order_date;
	private String order_name;
	private String order_phone;
	private String order_title;
	private String payment;
	private String status;
	private Long total_amount;
	private String tracking;
	private String member_id;
	
	
}
