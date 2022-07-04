package com.sam.coffeeshop.service;

import java.util.HashMap;
import java.util.List;

import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.TestVO;

public interface AdminService {
	
	public List<Member> getMemberList();
	public Member getMember(Long id);
	public void mDelete(Member member);
	
	public List<Product> getAdminProductList();
	public void pRegist(Product product);
	public void pDelete(Product product);
	public Product getProduct(int id);
	public void pUpdate(Product product);
	
	public List<Category> category();
	public Category categoryName(String category_code);
	
	public List<Product> findPage(HashMap<String, Object> hm);
	public List<Product> findAll(HashMap<String, Object> hm);
	public int productCount(HashMap<String, Object> hm);
	
	public List<Member> mfindPage(HashMap<String, Object> hm);
	public List<Member> mfindAll(HashMap<String, Object> hm);
	public int memberCount(HashMap<String, Object> hm);
	
	public List<Product> testResult(TestVO testVO);
	
	public List<Order> orderListAll();
	public void orderStatusUpdate(Order order);
	//운송장
	public void orderTrackingUpdate(Order order);
		
	public List<Order> ofindPage(HashMap<String, Object> hm);
	public List<Order> ofindAll(HashMap<String, Object> hm);
	public int orderCount(HashMap<String, Object> hm);
}
