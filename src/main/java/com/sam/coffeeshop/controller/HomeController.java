package com.sam.coffeeshop.controller;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sam.coffeeshop.domain.PageVO;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.TestVO;
import com.sam.coffeeshop.service.AdminService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	AdminService adminService;
	
	// 최신 상품 리스트 추가
	@GetMapping(value = {"/", "index"})
	public String index(Model model, String pageNum) {
		
		int currentPage = pageNum == null ? 1 : Integer.parseInt(pageNum);
		int pageSize = 4;
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("pageStart", (currentPage-1)*pageSize);
		hm.put("pageSize", pageSize);
		
		List<Product> list = adminService.findAll(hm);
		int count = adminService.productCount(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		
		model.addAttribute("plist", list);
		model.addAttribute("count", count);
		model.addAttribute("page", page);
		
		return "index";
	}
	
	@GetMapping("/test")
	public String test() {
		return "/test";
	}
	
	@PostMapping("testResult")
	public String testResult(@ModelAttribute("testVO") TestVO testVO, Model model) {
		
		List<Product> testResultList = adminService.testResult(testVO);
		model.addAttribute("testlist", testResultList);
		
		return "/testResult";
	}

}