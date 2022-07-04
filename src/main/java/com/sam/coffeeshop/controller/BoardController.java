package com.sam.coffeeshop.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sam.coffeeshop.domain.PageVO;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.Qnaboard;
import com.sam.coffeeshop.domain.Review_Board;
import com.sam.coffeeshop.service.AdminService;
import com.sam.coffeeshop.service.BoardService;
import com.sam.coffeeshop.service.MemberService;
import com.sam.coffeeshop.service.ProductService;

@RequestMapping("/board/**")
@Controller
public class BoardController {
	@Autowired
	AdminService adminService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProductService pservice;
	
	@GetMapping("list")
	public String list() {
		return "/board/list";
	}
	
	@GetMapping("cartList")
	public String cartList() {
		return "/board/cartList";
	}
	
	// qna 게시판 목록
	@GetMapping("qna/qnaBoard")
	public String qnaList(String pageNum,
			@RequestParam(name="field", defaultValue="") String field, 
			@RequestParam(name="word", defaultValue ="") String word,
			Model model) {		
		int currentPage = pageNum == null ? 1 : Integer.parseInt(pageNum);
		int pageSize = 5;
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("field", field);
		hm.put("word", word);
		hm.put("pageStart", (currentPage-1)*pageSize);
		hm.put("pageSize", pageSize);
		
		List<Qnaboard> list = boardService.qfindAll(hm);
		int count = boardService.getQnaBoardCnt(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		
		model.addAttribute("qlist", list);
		model.addAttribute("count", count);
		model.addAttribute("page", page);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
	
		return "/board/qna/qnaBoard";
	}
	
	// qna 작성 페이지
	@GetMapping("qna/qnaRegist")
	public String qnaRegist() {
		return "/board/qna/qnaRegist";
	}
	
	// qna 작성
	@PostMapping("qRegist")
	public String qnaRegister(Qnaboard qnaboard) {
		boardService.insertQnaBoard(qnaboard);
		return "redirect:/board/qna/qnaBoard";
	}
	
	// qna 수정 페이지
	@GetMapping("qna/qnaUpdate")
	public String qnaUpdate(@RequestParam("board_id") Long id, Model model) {
		model.addAttribute("qna", boardService.getQnaBoardDetail(id));
		return "/board/qna/qnaUpdate";
	}
	
	// qna 수정
	@PostMapping("qUpdate")
	public String qnaUpdater(Qnaboard qnaboard) {
		boardService.updateQnaBoard(qnaboard);
		return "redirect:/board/qna/qnaBoard";
	}
	
	// qna 삭제
	@GetMapping("qnaDelete")
	public String qnaDelete(@RequestParam("board_id") Long id) {
		Qnaboard qnaboard = boardService.getQnaBoardDetail(id);
		boardService.deleteQnaBoard(qnaboard);
		return "redirect:/board/qna/qnaBoard";
	}
	
	// qna 상세 페이지
	@GetMapping("qna/qnaDetail")
	public String qnaDetail(@RequestParam("board_id") Long id, String pageNum,
			@RequestParam(name="field", defaultValue="") String field, 
			@RequestParam(name="word", defaultValue ="") String word,
			Model model) {
		
		model.addAttribute("qna", boardService.getQnaBoardDetail(id));
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
		return "/board/qna/qnaDetail";
	}
	
	// qna 답변 작성 페이지
	@GetMapping("qna/qnaReRegist/{id}")
	public String qnaReRegist(@PathVariable("id") Long id, Model model) {
		model.addAttribute("qnareinfo",  boardService.getQnaBoardDetail(id));
		
		System.out.println(boardService.getQnaBoardDetail(id).getBoard_re_ref());
		return "/board/qna/qnaReRegist";
	}
	
	// qna 답변 작성
	@PostMapping("qReRegist")
	public String qnaReRegister(Qnaboard qnaboard) {
		boardService.insertQnaBoardReply(qnaboard);
		boardService.updateQnaBoardReSeq(qnaboard);
		return "redirect:/board/qna/qnaBoard";
	}
	
}
