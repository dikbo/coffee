package com.sam.coffeeshop.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sam.coffeeshop.domain.Qnaboard;
import com.sam.coffeeshop.mappers.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public Long getQnaBoardCnt(Qnaboard qnaboard) {
		return boardMapper.getQnaBoardCnt(qnaboard);
	}

	@Override
	public List<Qnaboard> getQnaBoardList() {
		return boardMapper.getQnaBoardList();
	}

	@Override
	public Qnaboard getQnaBoardDetail(Long board_id) {
		return boardMapper.getQnaBoardDetail(board_id);
	}

	@Override
	public void insertQnaBoard(Qnaboard qnaboard) {
		boardMapper.insertQnaBoard(qnaboard);
	}

	@Override
	public Long deleteQnaBoard(Qnaboard qnaboard) {
		return boardMapper.deleteQnaBoard(qnaboard);
	}

	@Override
	public void updateQnaBoard(Qnaboard qnaboard) {
		boardMapper.updateQnaBoard(qnaboard);
	}

	@Override
	public Qnaboard getQnaBoardReply(Qnaboard qnaboard) {
		return boardMapper.getQnaBoardReply(qnaboard);
	}

	@Override
	public void updateQnaBoardReSeq(Qnaboard qnaboard) {
		boardMapper.updateQnaBoardReSeq(qnaboard);
	}

	@Override
	public void insertQnaBoardReply(Qnaboard qnaboard) {
		boardMapper.insertQnaBoardReply(qnaboard);
	}

	@Override
	public List<Qnaboard> qfindPage(HashMap<String, Object> hm) {
		return boardMapper.qfindPage(hm);
	}

	@Override
	public List<Qnaboard> qfindAll(HashMap<String, Object> hm) {
		return boardMapper.qfindAll(hm);
	}

	@Override
	public int getQnaBoardCnt(HashMap<String, Object> hm) {
		return boardMapper.getQnaBoardCnt(hm);
	}
	
	@Override
	public List<Qnaboard> getmyQnaBoardList(String member_id) {
		return boardMapper.getmyQnaBoardList(member_id);
	}
}
