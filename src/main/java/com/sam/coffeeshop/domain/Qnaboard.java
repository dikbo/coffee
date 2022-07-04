package com.sam.coffeeshop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Qnaboard {
	private Long board_id;
	
	private Long board_re_ref;
	private Long board_re_lev;
	private Long board_re_seq;

	private String subject;
	private String content;
	private Date regdate;
	private String status;
	private String member_id;
}
