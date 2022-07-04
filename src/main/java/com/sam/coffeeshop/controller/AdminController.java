package com.sam.coffeeshop.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.PageVO;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.service.AdminService;
import com.sam.coffeeshop.service.ProductService;

import lombok.extern.java.Log;
import net.sf.json.JSONArray;

@RequestMapping("/admin/**")
@Controller
@Log
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ProductService pservice;
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	// 전체 상품 리스트
	@GetMapping("adminProductList")
	public String adminProductList(Model model, String pageNum,
			@RequestParam(name="field", defaultValue = "") String field,
			@RequestParam(name="word", defaultValue = "") String word) {
		
		int currentPage = pageNum == null ? 1 : Integer.parseInt(pageNum);
		int pageSize = 3;
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("field", field);
		hm.put("word", word);
		hm.put("pageStart", (currentPage-1)*pageSize);
		hm.put("pageSize", pageSize);
		//System.out.println("===================" + hm.get("pageStart") + hm.get("pageSize"));
		
		List<Product> list = adminService.findAll(hm);
		int count = adminService.productCount(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		
		model.addAttribute("plist", list);
		model.addAttribute("count", count);
		model.addAttribute("page", page);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
		
		return "admin/adminProductList";
	}
	
	// 상품 등록 페이지로 이동
	@GetMapping("productRegist")
	public String pRegist(Model model) throws Exception {
		List<Category> category = null;
		category = adminService.category();
		model.addAttribute("category", JSONArray.fromObject(category));
		return "admin/productRegist";
	}
	
	// 회원 목록 출력
	@GetMapping("memberManage")
	public String memberList(Model model, String pageNum,
			@RequestParam(name="field", defaultValue = "") String field,
			@RequestParam(name="word", defaultValue = "") String word) {
		
		int currentPage = pageNum == null ? 1 : Integer.parseInt(pageNum);
		int pageSize = 3;
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("field", field);
		hm.put("word", word);
		hm.put("pageStart", (currentPage-1)*pageSize);
		hm.put("pageSize", pageSize);
		//System.out.println("===================" + hm.get("pageStart") + hm.get("pageSize"));
		
		List<Member> list = adminService.mfindAll(hm);
		int count = adminService.memberCount(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		
		model.addAttribute("mlist", list);
		model.addAttribute("count", count);
		model.addAttribute("page", page);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
		
		return "admin/memberManage";
	}
	
	// 개별 회원 삭제
	@GetMapping("memberManage/delete/{id}")
	public String memberDelete(@PathVariable("id") Long id) {
		Member member = adminService.getMember(id);
		adminService.mDelete(member);
		return "redirect:/admin/memberManage";
	}
	
	// 선택 회원 삭제
	@PostMapping("memberManage/mDeleteAll")
	public String mDeleteAll(@RequestParam(value="chbox[]") List<String> chArr, Member member) {
		long memberId = 0;
		
		for(String i : chArr) {
			memberId = Long.parseLong(i);
			member = adminService.getMember(memberId);
			//member.setId(memberId);
			//System.out.println("-=-=================="+memberId);
			//System.out.println(member);
			adminService.mDelete(member);
		}
		return "redirect:/admin/memberManage";
	}
	
	// 상품 등록
	@PostMapping("regist")
	public String productRegister(Product product, HttpServletRequest request) throws IOException {
		String saveDir = request.getSession().getServletContext().getRealPath("/");
		saveDir += "resources/productImg/";
		MultipartFile f = product.getUploadFile();
		String fileName="";
		if(!f.isEmpty()) {
			String orifileName = f.getOriginalFilename();
			System.out.println("getOriginalFilename:"+orifileName);
			UUID uuid = UUID.randomUUID();
			fileName = uuid+"_"+orifileName;
			FileCopyUtils.copy(f.getBytes(), new File(saveDir+fileName));
			product.setProduct_img(fileName);
		}
		
		System.out.println("saveDir:"+saveDir);
		adminService.pRegist(product);
		
		return "redirect:/admin/adminProductList";
	}
	
	// 상품 삭제
	@GetMapping("adminProductList/delete/{id}")
	public String pDelete(@PathVariable("id") int id) {
		Product product = adminService.getProduct(id);
		adminService.pDelete(product);
		return "redirect:/admin/adminProductList";
	}
	
	// 선택 상품 삭제
	@PostMapping("adminProductList/pDeleteAll")
	public String pDeleteAll(@RequestParam(value="chbox[]") List<String> chArr, Product product) {
		int productId = 0;
		
		for(String i : chArr) {
			productId = Integer.parseInt(i);
			product.setProduct_id(productId);
			adminService.pDelete(product);
			
		}
		return "redirect:/admin/adminProductList";
	}
	
	// 상품 수정 페이지
	@GetMapping("productUpdate/{id}")
	public String pUpdate(@PathVariable("id") int id, Model model) throws Exception {
		List<Category> category = null;
		category = adminService.category();
		model.addAttribute("category", JSONArray.fromObject(category));
		model.addAttribute("product", adminService.getProduct(id));
		return "admin/productUpdate";
	}
	
	// 상품 수정
	@PostMapping("pUpdate")
	public String pUpdate(Product product, HttpServletRequest request) throws IOException {
		String saveDir = request.getSession().getServletContext().getRealPath("/");
		saveDir += "resources/productImg/";
		MultipartFile f = product.getUploadFile();
		String fileName="";
		if(!f.isEmpty()) {
			String orifileName = f.getOriginalFilename();
			System.out.println("getOriginalFilename:"+orifileName);
			UUID uuid = UUID.randomUUID();
			fileName = uuid+"_"+orifileName;
			FileCopyUtils.copy(f.getBytes(), new File(saveDir+fileName));
			product.setProduct_img(fileName);
		}
		
//		System.out.println("saveDir:"+saveDir);
		adminService.pUpdate(product);
		
		return "redirect:/admin/adminProductList";
	}
	
	// 주문 목록
	@GetMapping("adminOrderList")
	public String orderListAll(Model model, String pageNum,
			@RequestParam(name="field", defaultValue = "") String field,
			@RequestParam(name="word", defaultValue = "") String word) {
		
		int currentPage = pageNum == null ? 1 : Integer.parseInt(pageNum);
		int pageSize = 5;
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("field", field);
		hm.put("word", word);
		hm.put("pageStart", (currentPage-1)*pageSize);
		hm.put("pageSize", pageSize);
//		System.out.println("===================" + hm.get("pageStart") + hm.get("pageSize"));
		
		List<Order> list = adminService.ofindAll(hm);
		int count = adminService.orderCount(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		
		model.addAttribute("olist", list);
		model.addAttribute("count", count);
		model.addAttribute("page", page);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
		
		return "admin/adminOrderList";
	}
	
	// 주문 목록 상태 변경(배송완료)
	@PostMapping("orderStatusUpdate")
	public String orderStatusUpdate(@PathVariable("tracking") String tracking, Order order) {
		order.setStatus("배송완료");
		adminService.orderStatusUpdate(order);
		return "redirect:/admin/adminOrderList";
	}
	
	// 트래킹넘버 입력
	@PostMapping("/updateTracking")
	public String updateTracking(Order order) {
		String order_id=order.getOrder_id();
		Order order1 = pservice.orderView(order_id);
		order1.setTracking(order.getTracking());
		//System.out.println("========================="+order);
		adminService.orderTrackingUpdate(order);
		return "redirect:/member/myOrderdetail/"+order_id;
	}

}
