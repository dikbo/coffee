package com.sam.coffeeshop.mappers;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.TestVO;

@Mapper
public interface AdminMapper {
	
	// 회원 관리
	public List<Member> getMemberList();
	public Member getMember(Long id);
	public void mDelete(Member member);
	
	// 상품 관리
	public List<Product> getAdminProductList();
	public void pRegist(Product product);
	public void pDelete(Product product);
	public void pUpdate(Product product);
	
	public List<Category> category();
	public Category categoryName(String category_code);
	public Product getProduct(int id);
	
	// 상품 페이징, 검색
	public List<Product> findPage(HashMap<String, Object> hm);
	public List<Product> findAll(HashMap<String, Object> hm);
	public int productCount(HashMap<String, Object> hm);
	
	// 회원 페이징, 검색
	public List<Member> mfindPage(HashMap<String, Object> hm);
	public List<Member> mfindAll(HashMap<String, Object> hm);
	public int memberCount(HashMap<String, Object> hm);
	
	// 커피 테스트
	public List<Product> testResult(TestVO testVO);
	
	// 주문 관리
	public List<Order> orderListAll();
	public void orderStatusUpdate(Order order);
	
	public void orderTrackingUpdate(Order order);
	// 주문 페이징, 검색
	public List<Order> ofindPage(HashMap<String, Object> hm);
	public List<Order> ofindAll(HashMap<String, Object> hm);
	public int orderCount(HashMap<String, Object> hm);
}

