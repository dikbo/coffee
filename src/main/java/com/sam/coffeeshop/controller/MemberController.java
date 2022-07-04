package com.sam.coffeeshop.controller;

import java.lang.reflect.Array;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.OrderDetail;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.ProductInfo;
import com.sam.coffeeshop.domain.Qnaboard;
import com.sam.coffeeshop.service.BoardService;
import com.sam.coffeeshop.service.MemberService;
import com.sam.coffeeshop.service.ProductService;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/member/**")
@Log
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	// 회원가입 화면
	@GetMapping("join")
	public String join() {
		return "/member/join";
		
	}

	// 회원 가입 버튼
	@PostMapping("join")
	public String join(Member member) {
		
		if(memberService.idCheck(member.getMember_id())!=0) {
			return "redirect:/member/join";
		}
		String rowPassword=member.getPassword();
		String encPassword=bCryptPasswordEncoder.encode(rowPassword);
		member.setPassword(encPassword);
		member.setRole("ROLE_MEMBER");
		memberService.join(member);
		return "redirect:/";
	}
	//아이디 중복 체크
	@PostMapping("idCheck")
	@ResponseBody
	public int idCheck(@RequestBody String member_id) {
		int result =0; 
		if(member_id != null)result = memberService.idCheck(member_id);
		return result;
	}
	// 이메일 중복 체크
	@PostMapping("emailCheck")
	@ResponseBody
	public int emailCheck(@RequestBody String email) {
		int result =0; 
		if(email != null)result = memberService.emailCheck(email);
		return result;
	}
	
	
	
	

	// 로그인 화면
	@GetMapping("loginForm")
	public String loginForm() {
		return "/member/loginForm";
	}

	@GetMapping("memberUpdateView")
	public String registerUpdateView(Principal principal,Model model) {
		String member_id =principal.getName();
		Member member = memberService.getMemberById(member_id);
		model.addAttribute("member",member);
		return "/member/memberUpdateView";
	}

	@PostMapping("memberUpdateView")
	//@ResponseBody
	public String registerUpdate(Member member) {
		//rowPassword 암호화되지않은 비밀번호
		String rowPassword=member.getPassword();
		String encPassword=bCryptPasswordEncoder.encode(rowPassword);
		member.setPassword(encPassword);
		memberService.update(member);
		SecurityContextHolder.clearContext();
		return "redirect:/member/loginForm";
	}
	
	
	
	@PostMapping("memberDelete")
	@ResponseBody
	public String delete(Principal principal) {
		String member_id =principal.getName();
		memberService.delete(member_id);
		SecurityContextHolder.clearContext();
		return "redirect:/";
	}
//	@PostMapping("memberDelete")
//	@ResponseBody
//	public String delete(@RequestParam("member_id")String member_id,RedirectAttributes redirectAttr,
//											SessionStatus sessionStatus) {
//		memberService.delete(member_id);
//		SecurityContextHolder.clearContext();
//		
//		return "redirect:/";
//	}
	//마이페이지 화면
	@GetMapping("myPage")
	public String showmyPage(Model model,Principal principal) {
		String member_id = principal.getName();
		Member member = memberService.getMemberById(member_id);
		model.addAttribute("member", member);
		//주문
		List<Order> orderList = pservice.orderList(member_id);
		model.addAttribute("orderList", orderList);
		
		//상세 주문
		for(Order o : orderList) {
			List<OrderDetail> orderDetail = pservice.getOrderDetails(o.getOrder_id());
			List<Product> plist = new ArrayList<Product>();
			
			for(OrderDetail order : orderDetail) {
				Product product = pservice.productView(order.getProduct_id());
				//System.out.println("==============="+product);
				plist.add(product);
			}
			model.addAttribute("pInfo", plist);
			//System.out.println(plist);
			model.addAttribute("oDetail", orderDetail);
			//System.out.println(orderDetail);
		}
		
		//myqna
		List<Qnaboard> myQnalist = boardService.getmyQnaBoardList(member_id);
		model.addAttribute("list",myQnalist);
		return "/member/myPage";
	}
	
//	@GetMapping("/myOrderdetail/{order_id}")
//	public String myorderView(@PathVariable("order_id")String order_id,Integer product_id, Principal principal,Model model) {
//		String member_id = principal.getName();
//		Member member = memberService.getMemberById(member_id);
//		model.addAttribute("member", member);
//		
//		Order order = pservice.orderView(order_id);
//		model.addAttribute("orders", order);
//		
//		List<OrderDetail> orderDetail = pservice.getmyOrderdetail(product_id);
//		model.addAttribute("orderDetail", orderDetail);
//		return	"/member/myOrderdetail";
//	}
	
	//----------------------------여기서부터 확인---------------------------------
	@GetMapping("/myOrderdetail/{order_id}")
	   public String rSelect(@PathVariable("order_id")String id, Principal principal, Model model,String order_id) {
	      
	      int result = 0; 

	      String member_id = principal.getName();
	      
		  Order orders = pservice.orderView(id);
	      List<OrderDetail> orderDetail = pservice.getOrderDetails(id);
	      List<ProductInfo> list = new ArrayList<ProductInfo>();	      
	      //Map<String,Object> map = new HashMap<>();
	      	 
	      for(OrderDetail order : orderDetail) {
	    	 ProductInfo proInfo = new ProductInfo();
	         Product product = pservice.productView(order.getProduct_id());
	         proInfo.setQty(order.getDetail_qty());
	         proInfo.setPname(product.getProduct_name());
	         proInfo.setPprice(product.getProduct_price());
	         
	         list.add(proInfo);
	      }
	      	System.out.println(list);
	      model.addAttribute("pInfo", list);
		  model.addAttribute("orders", orders);
	      model.addAttribute("orderDetail",orderDetail);
	      model.addAttribute("member_id", member_id);
	    
	      return "/member/myOrderdetail";
	   }
	
	
//	@GetMapping("myOrderdetail")
//	public String myorderView(Principal principal,String order_id,Model model) {
//		String member_id = principal.getName();
//	Member member = memberService.getMemberById(member_id);
//		model.addAttribute("member", member);
//		
//		Order order = pservice.orderView(order_id);
//		model.addAttribute("order", order);
//		List<orderProduct> orderProduct = pservice.orderProduct(order_id);
//		model.addAttribute("orderProduct", orderProduct);
//		return	"member/myOrderdetail";
//	}
	
//	@GetMapping("myqna")
//	public String myqna(Principal principal,Model model) {
//		String member_id = principal.getName();
//		Member member = memberService.getMemberById(member_id);
//		model.addAttribute("member",member);
//		
//		List<Qnaboard> list = boardService.getmyQnaBoardList(member_id);
//		model.addAttribute("list",list);
//		
//		return "member/myqna";
//	}
	
	
}
