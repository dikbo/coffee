package com.sam.coffeeshop.domain;

import lombok.Data;

@Data
public class orderProduct {
	private OrderDetail orderDetails;
	private Product product; 

}
