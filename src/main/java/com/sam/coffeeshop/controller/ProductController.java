package com.sam.coffeeshop.controller;

import java.security.Principal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sam.coffeeshop.domain.Cart;
import com.sam.coffeeshop.domain.CartList;
import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.OrderDetail;
import com.sam.coffeeshop.domain.PageVO;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.Review_Board;
import com.sam.coffeeshop.service.AdminService;
import com.sam.coffeeshop.service.MemberService;
import com.sam.coffeeshop.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	private ProductService pservice;

	@Autowired
	private MemberService mservice;

	@Autowired
	private AdminService adminService;

	// 리뷰 작성(다른방법)
	// 리뷰 작성 페이지로 이동
	@GetMapping("/reviewSelect/{order_id}")
	public String rSelect(@PathVariable("order_id") String id, Principal principal, Model model) {

		// System.out.println("================"+id);
		Order orders = pservice.orderView(id);
		model.addAttribute("order", orders);
		String member_id = principal.getName();

		List<OrderDetail> orderDetail = pservice.getOrderDetails(id);
		
		// System.out.println("================"+orderDetail);
		List<Product> list = new ArrayList<Product>();
		
		HashMap<String, Object> hm = new HashMap<>();
		
		List<Integer> rcList = new ArrayList<Integer>();
		
		for (OrderDetail order : orderDetail) {
			Product product = pservice.productView(order.getProduct_id());
			// System.out.println("==============="+product);
			list.add(product);

			// 해당 주문건에 대해서만...
			// review_board 중에서 member_id와 product_id가 모두 일치하는 리뷰의 존재 여부 
			// 예를 들어 해당하는 리뷰 개수 rcount == 0 일 때만 버튼 출력하도록
			// rcount를 리스트로 받아 model로 뷰단에 전달
			int product_id = order.getProduct_id();
			String order_id = order.getOrder_id();
			
			hm.put("product_id", product_id);
			hm.put("member_id", member_id);
			hm.put("order_id", order_id);
			
			int rcount = pservice.reviewCheck(hm);
			
			System.out.println(rcount);
			rcList.add(rcount);
		}
		model.addAttribute("rcList", rcList);
		model.addAttribute("pInfo", list);
		model.addAttribute("member_id", member_id);
		// System.out.println("==============="+list);

		return "/member/reviewSelect";
	}

	@GetMapping("/reviewRegist/{pid}/{oid}")
	public String rRegist(@PathVariable("pid") int id, @PathVariable("oid") String order_id, Principal principal, Model model) {

		String member_id = principal.getName();
		Product product = pservice.productView(id);

		model.addAttribute("member_id", member_id);
		model.addAttribute("product", product);
		model.addAttribute("order_id", order_id);
		return "/member/reviewRegist";
	}

	// 리뷰 작성(제출)
	@PostMapping("/rRegist")
	public String rRegistSubmit(@ModelAttribute Review_Board review, Principal principal) {
		pservice.reviewRegister(review);
		
		// orderdetail에 리뷰수 업데이트
		String member_id = principal.getName();
		String order_id = review.getOrder_id();
		int product_id = review.getProduct_id();

		HashMap<String, Object> hm = new HashMap<>();
		hm.put("product_id", product_id);
		hm.put("member_id", member_id);
		hm.put("order_id", order_id);
		int review_count = pservice.reviewCheck(hm);
		
		return "redirect:/member/myPage";
	}

	// 주문 완료로 변경
	@GetMapping("/orderStatusUpdate/{order_id}")
	public String orderStatusUpdate(@PathVariable("order_id") String id, Order order) {
		order = pservice.orderView(id);
		String status = "배송완료";
		// System.out.println("======================"+order);
		order.setStatus(status);
		adminService.orderStatusUpdate(order);
		// System.out.println("======================"+order);

		return "redirect:/admin/adminOrderList";
	}

	// 상품 리스트(전체)
	@GetMapping("/board/list")
	public String productAllList(Model model, String field, String word, String strPageNum) {

		strPageNum = (strPageNum == null) ? "1" : strPageNum;
		int pageNum = Integer.parseInt(strPageNum);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("field", field);
		hm.put("word", word);

		int totalCount = pservice.getProductAllCount(hm);
		int pageSize = 12;
		int pageBlock = 5;
		int pageCount = (int) Math.ceil((double) totalCount / pageSize);
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		PageVO page = new PageVO();
		page.setPageCount(pageCount);
		page.setPageBlock(pageBlock);
		page.setStartPage(startPage);
		page.setEndPage(endPage);
		page.setTotalCount(totalCount);
		page.setPageNum(pageNum);

		int startRow = (pageNum - 1) * pageSize;
		hm.put("startRow", startRow);
		hm.put("pageSize", pageSize);
		List<Product> list = pservice.productAllList(hm);

		model.addAttribute("list", list);
		model.addAttribute("count", totalCount);
		model.addAttribute("pageDto", page);
		model.addAttribute("field", field);
		model.addAttribute("word", word);
		model.addAttribute("categoryCode", null); // 되는지확인

		return "/board/list";
	}

	// 상품 리스트(카테고리별)
	@GetMapping("/board/list/cate")
	public String productList(Model model, @RequestParam("cate") String categoryCode, String strPageNum) {
		strPageNum = (strPageNum == null) ? "1" : strPageNum;
		int pageNum = Integer.parseInt(strPageNum);
		HashMap<String, Object> hm = new HashMap<>();

		// System.out.println("=================" + categoryCode); // 카테고리 코드 출력됨
		int totalCount = pservice.productCateCount(categoryCode);
		// System.out.println("=================" + totalCount); // 카테고리내 상품수 출력됨
		int pageSize = 12;
		int pageBlock = 5;
		int pageCount = (int) Math.ceil((double) totalCount / pageSize);
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		PageVO page = new PageVO();
		page.setPageCount(pageCount);
		page.setPageBlock(pageBlock);
		page.setStartPage(startPage);
		page.setEndPage(endPage);
		page.setTotalCount(totalCount);
		page.setPageNum(pageNum);

		int startRow = (pageNum - 1) * pageSize;
		hm.put("startRow", startRow);
		hm.put("pageSize", pageSize);
		hm.put("category_code", categoryCode);
		List<Product> list = pservice.productList(hm);
		// System.out.println("=================" + list); // 카테고리내 상품 리스트 출력됨 (테이블 내
		// 컬럼명이랑 일치해야 함: category_code)

		model.addAttribute("list", list);
		model.addAttribute("count", totalCount);
		model.addAttribute("pageDto", page);
		model.addAttribute("categoryCode", categoryCode);

		return "/board/list";
	}

	// 상품 디테일 페이지 이동
	@GetMapping("/board/productDetail")
	public String productDetail(@RequestParam("product_id") int id,
			@RequestParam(name = "pageNum", defaultValue = "") String pageNum,
			@RequestParam(name = "field", defaultValue = "") String field,
			@RequestParam(name = "word", defaultValue = "") String word, Model model, String rePageNum) {

		model.addAttribute("product", adminService.getProduct(id));

		String code1 = adminService.getProduct(id).getCategorycode_ref();
		String code2 = adminService.getProduct(id).getCategory_code();

		model.addAttribute("cate1", adminService.categoryName(code1));
		model.addAttribute("cate2", adminService.categoryName(code2));

		// 별점 계산
		int[] stars = pservice.getReviewStar(id);
		int count = pservice.getReviewCount(id);
		int sum = 0;
		int star1 = 0;
		int star2 = 0;
		int star3 = 0;
		int star4 = 0;
		int star5 = 0;

		for (int i : stars) {
			sum += i;
			if (i == 5)
				star5 += 1;
			else if (i == 4)
				star4 += 1;
			else if (i == 3)
				star3 += 1;
			else if (i == 2)
				star2 += 1;
			else
				star1 += 1;
		}

		double avg = (double) sum / (double) count;
		if (Double.isNaN(avg))
			avg = 0;
		String avg1 = String.format("%.1f", avg);

		model.addAttribute("avg", avg1);
		model.addAttribute("count", count);
		model.addAttribute("star1", star1);
		model.addAttribute("star2", star2);
		model.addAttribute("star3", star3);
		model.addAttribute("star4", star4);
		model.addAttribute("star5", star5);

		// 리뷰 페이징
		int totalCount = pservice.getReviewCount(id);
		int pageSize = 3;

		int currentPage = (rePageNum == "" || rePageNum == null ? 1 : Integer.parseInt(rePageNum));

		HashMap<String, Object> hm = new HashMap<>();
		hm.put("pageStart", (currentPage - 1) * pageSize);
		hm.put("pageSize", pageSize);
		hm.put("product_id", id);

		List<Review_Board> review = pservice.reviewList(hm);
		PageVO page = new PageVO(count, currentPage, pageSize);
		page.setBlockSize(5);

		model.addAttribute("review", review);
		System.out.println(review);
		model.addAttribute("count", totalCount);
		model.addAttribute("page", page);

		return "/board/productDetail";
	}

	// 카트 담기
	@ResponseBody
	@PostMapping("/addCart")
	public int addCart(Cart cart, Principal principal) {
		int result = 0;

		if (principal != null) {
			String member_id = principal.getName();
			System.out.println("==================" + member_id);
			cart.setMember_id(member_id);
			int cartCheck = pservice.cartCheck(cart);
			if (cartCheck == 0) {
				pservice.addCart(cart);
				result = 1;
			} else {
				result = 2;
			}
		}
		System.out.println(result);
		return result;
	}

	// 카트리스트
	@GetMapping("/board/cartList")
	public String cartList(Model model, Principal principal) {
		if (principal != null) {
			String member_id = principal.getName();
			List<CartList> cartList = pservice.cartList(member_id);
			model.addAttribute("cartList", cartList);
		}
		return "/board/cartList";
	}

	// 카트 선택 삭제
	@ResponseBody
	@PostMapping("/cartDelete")
	public void cartDelete(Principal principal, @RequestParam(value = "chbox[]") List<String> chArr, Cart cart) {
		String member_id = principal.getName();
		cart.setMember_id(member_id);

		long cart_id = 0;

		for (String l : chArr) {
			cart_id = Long.parseLong(l);
			cart.setCart_id(cart_id);
			pservice.cartDelete(cart);
		}
	}

	// 카트 전체 삭제
	@ResponseBody
	@GetMapping("/cartAllDelete")
	public void cartAllDelete(Principal principal) {
		String member_id = principal.getName();
		pservice.cartAllDelete(member_id);
	}

	
	// 수량 변경
	//@GetMapping("/cartUpdate") 
//	public String cartUpdate1(@RequestParam(value="product_id") int product_id, @RequestParam(value="cart_id") Long cart_id, @RequestParam(value="qty") String qty, Cart cart) {
//		HashMap<String, Object> hm = new HashMap<>();
//		hm.put("cart_id", cart_id);
//		hm.put("product_id", product_id);
//		
//		Long qtyUp = Long.parseLong(qty);
//		
//		System.out.println("========" + product_id + "========" + cart_id + "========" + qty);
//		
//		cart = pservice.getCartforQty(hm);
//		cart.setQty(qtyUp);
//		pservice.cartProductQtyUpdate(cart);
//		
//		return "redirect:/board/cartList";
//	}
	
	 // 장바구니 수량 변경
	@ResponseBody
	@PostMapping("/cartUpdate") 
	public String cartUpdate2(@RequestBody HashMap<String, Object> map, Cart cart) {
		long cart_id = Long.valueOf((String) map.get("cart_id"));
		//System.out.println("========" + cart_id);
		int product_id = Integer.parseInt(String.valueOf(map.get("product_id")));
		//System.out.println("========" + product_id);
		long qty = Long.valueOf((String)map.get("qty"));
		//System.out.println("========" + qty);
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("cart_id", cart_id);
		hm.put("product_id", product_id);
		
		System.out.println("========" + product_id + "========" + cart_id + "========" + qty);
		
		cart = pservice.getCartforQty(hm);
		cart.setQty(qty);
		pservice.cartProductQtyUpdate(cart);
		//System.out.println(cart);
		return "redirect:/board/cartList";
	}
 
	// 주문하기
	@PostMapping("/board/orderForm")
	public String orderForm(Model model, Principal principal, HttpServletRequest request) {
		String member_id = principal.getName();
		Member member = mservice.getMemberById(member_id);
		model.addAttribute("user", member);

		List<CartList> selectArr = new ArrayList<CartList>();
		String[] arr = request.getParameterValues("chBox"); // 장바구니에서 가져올 상품 리스트
		int cartId = 0;
		for (int i = 0; i < arr.length; i++) {
			cartId = Integer.parseInt(arr[i]);
			selectArr.add(pservice.findByCartId(cartId));
		}

		model.addAttribute("cartList", selectArr);

		return "/board/orderForm";
	}

	// 주문 추가
	@Transactional
	@PostMapping("/order")
	public String addOrder(Principal principal, Order order, HttpServletRequest request) {
		String member_id = principal.getName();
		order.setMember_id(member_id);

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}

		String order_id = ymd + "_" + subNum;

		order.setOrder_id(order_id);
		pservice.addOrder(order);

		String[] arr = request.getParameterValues("cart_id");

		Long cart_id = 0l;
		OrderDetail details = new OrderDetail();

		for (int i = 0; i < arr.length; i++) {
			cart_id = Long.parseLong(arr[i]); // 카트리스트-> details
			Cart cart = pservice.getCart(cart_id);
			details.setProduct_id(cart.getProduct_id());
			details.setDetail_qty(cart.getQty());
			details.setOrder_id(order_id);
			pservice.addOrderDetails(details);
			// 카트삭제
			pservice.cartDeleteByCartId(cart_id);
		}

		return "redirect:/member/myPage";
	}

	// 카트 수량
	@ResponseBody
	@GetMapping("/cartSize")
	public int cartSize(Principal principal) {
		int cartCount = 0;
		if (principal != null) {
			String member_id = principal.getName();
			cartCount = pservice.cartSize(member_id);
		}
		return cartCount;
	}

	// 주문취소
	@GetMapping("member/myOrderdetail/orderCancle")
	@Transactional
	public String orderCancle(@RequestParam("orderId") String orderId) {
		System.out.println(orderId);
		// 주문디테일삭제
		pservice.orderDetailsDelete(orderId);
		// 주문삭제
		pservice.orderDelete(orderId);

		return "redirect:/member/myPage";
	}

}