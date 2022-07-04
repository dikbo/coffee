package com.sam.coffeeshop.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private Long id;
	private String email;
	private String member_addr1;
	private String member_addr2;
	private String member_addr3;
	private String member_id;
	private String member_name;
	private String password;
	private Date regdate;
	private String role;
	private String member_phone;
	
}
