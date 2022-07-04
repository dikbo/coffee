package com.sam.coffeeshop.mappers;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sam.coffeeshop.domain.Qnaboard;

@Mapper
public interface BoardMapper {
	
	public Long getQnaBoardCnt(Qnaboard qnaboard);
	// qna 리스트 출력
	public List<Qnaboard> getQnaBoardList();
	public Qnaboard getQnaBoardDetail(Long board_id);
	// qna 작성
	public void insertQnaBoard(Qnaboard qnaboard);
	public Long deleteQnaBoard(Qnaboard qnaboard);
	public void updateQnaBoard(Qnaboard qnaboard);
	
	public Qnaboard getQnaBoardReply(Qnaboard qnaboard);
	public void updateQnaBoardReSeq(Qnaboard qnaboard);
	public void insertQnaBoardReply(Qnaboard qnaboard);
	
	// qna 페이징, 검색
	public List<Qnaboard> qfindPage(HashMap<String, Object> hm);
	public List<Qnaboard> qfindAll(HashMap<String, Object> hm);
	public int getQnaBoardCnt(HashMap<String, Object> hm);
	public List<Qnaboard> getmyQnaBoardList(String member_id);
}
