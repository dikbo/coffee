package com.sam.coffeeshop.domain;

import lombok.Data;

@Data
public class PageVO {
	private int totalCount; // 전체 글갯수
	private int pageCount; // 총 필요한 페이지 수(마지막 페이지 번호)
	private int pageBlock;	// 한 페이지 당 표시되는 게시물의 수
	private int startPage;	// 페이지블록 내에서 시작페이지 번호
	private int endPage;	// 페이지블록 내에서 끝페이지 번호
	private int pageNum;	// 현재 페이지
	
	
	private int totPage; // total page
	private int blockSize; // 페이지당 게시글 수
	private int currentPage; // 현재 페이지
	
	public PageVO() {}
	
	public PageVO(int count, int currentPage, int pageSize) {
		// 정수로 만듦(둘 중 하나 택일)
		totPage = count/pageSize + (count % pageSize == 0 ? 0 : 1);
		//totPage = (int)Math.ceil((double)count/pageSize);
		blockSize = 10;
		startPage = ((currentPage - 1)/blockSize)*blockSize + 1;
		endPage = startPage + blockSize - 1;
		
		if(endPage > totPage) endPage = totPage;
		setBlockSize(blockSize);
		setCurrentPage(endPage);
		setStartPage(startPage);
		setTotPage(totPage);
	}
	
}
