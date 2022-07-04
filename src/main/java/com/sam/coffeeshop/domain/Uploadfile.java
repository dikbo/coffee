package com.sam.coffeeshop.domain;

import lombok.Data;

@Data
public class Uploadfile {
	private int fno;
	private Long id;
	private String savefolder;
	private String originfile;
	private String savefile;
	private String filetype;
}
