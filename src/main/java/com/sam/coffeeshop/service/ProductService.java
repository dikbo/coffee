package com.sam.coffeeshop.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sam.coffeeshop.domain.Cart;
import com.sam.coffeeshop.domain.CartList;
import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.OrderDetail;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.Review_Board;
import com.sam.coffeeshop.domain.orderProduct;
import com.sam.coffeeshop.repository.ProductRepository;

@Service
public class ProductService {
	@Autowired
	private ProductRepository productRepository;
	
	//상품전체조회
		public List<Product> productAllList(HashMap<String, Object> hm){
			return productRepository.productAllList(hm);
		}
		
		//상품조회
		public List<Product> productList(HashMap<String, Object> hm){
			return productRepository.productList(hm);
		}
		
		//상품 상세보기
		public Product productView(int productId) {
			return productRepository.productView(productId);
		}
		
		//리뷰 작성
		public void reviewRegister(Review_Board review) {
			productRepository.reviewRegister(review);
		}
		
		//리뷰 조회
		public List<Review_Board> reviewList(HashMap<String, Object> hm){
			return productRepository.reviewList(hm);
		}

		//카트 담기
		public void addCart(Cart cart) {
			productRepository.addCart(cart);		
		}

		//카트 리스트
		public List<CartList> cartList(String userid) {
			return productRepository.cartList(userid);
		}

		//카트 삭제
		public void cartDelete(Cart cart) {
			productRepository.cartDelete(cart);		
		}
		//카트 수량 변경
		public void cartProductQtyUpdate(Cart cart) {
			productRepository.cartProductQtyUpdate(cart);
		}

		public void addOrder(Order order) {
			productRepository.addOrder(order);		
		}

		public void addOrderDetails(OrderDetail orderDetails) {
			productRepository.addOrderDetails(orderDetails);
		}

		public CartList findByCartId(int cartId) {
			return productRepository.findByCartId(cartId);
		}

		public void cartAllDelete(String userid) {
			productRepository.cartAllDelete(userid);
			
		}

		public List<Order> orderList(String userid) {
			return productRepository.orderList(userid);
		}

		public List<Order> orderAllList(HashMap<String, Object> hm) {
			return productRepository.orderAllList(hm);
		}

		public Order orderView(String orderId) {
			return productRepository.orderView(orderId);
		}

		public List<orderProduct> orderProduct(String orderId) {
			return productRepository.orderProduct(orderId);
		}

		public int cartSize(String userid) {
			return productRepository.cartSize(userid);
		}

		public void cartDeleteOrder(HashMap<String, Object> hm) {
			productRepository.cartDeleteOrder(hm);		
		}

		public void cartDelete2(Cart cart) {
			productRepository.cartDelete2(cart);
			
		}

		public int findProductId(int cartId) {
			return productRepository.findProductId(cartId);
		}

		public void deleteReview(int reviewId) {
			productRepository.deleteReview(reviewId);
			
		}

		public int getOrderCount(HashMap<String, Object> hm) {
			return productRepository.getOrderCount(hm);
		}

		public int reviewCheck(HashMap<String, Object> hm) {
			return productRepository.reviewCheck(hm);
		}

		public int cartCheck(Cart cart) {
			return productRepository.cartCheck(cart);
		}

		//리뷰 점수
		public int[] getReviewStar(int productId) {
			return productRepository.getReviewStar(productId);
		}

		//리뷰 전체 개수
		public int getReviewCount(int product_id) {
			return productRepository.getReviewCount(product_id);
		}

		//카테고리별 전체 개수
		public int getCategoryCount(String categoryCode) {
			return productRepository.getCategoryCount(categoryCode);
		}

		//상품 전체 개수
		public int getProductAllCount(HashMap<String, Object> hm) {
			return productRepository.getProductAllCount(hm);
		}

		public String getOrderTitle(String orderId) {
			return productRepository.getOrderTitle(orderId);
		}

		public List<OrderDetail> getOrderDetails(String orderId) {
			return productRepository.getOrderDetails(orderId);
		}

		//배송완료->판매량 증가
		public void addSales(HashMap<String, Object> hm) {
			productRepository.addSales(hm);
			
		}

		public Cart getCart(Long cartId) {
			return productRepository.getCart(cartId);
		}

		public void cartDeleteByCartId(Long cartId) {
			productRepository.cartDeleteByCartId(cartId);		
		}

		public List<Product> getBestSeller() {
			return productRepository.getBestSeller();
		}

		public List<Product> getLatestProducts() {
			return productRepository.getLatestProducts();
		}

		//product+category join
		public Category productCategory(int productId) {
			return productRepository.productCategory(productId);
		}

		public int[] getTotalAmount(String userid) {
			return productRepository.getTotalAmount(userid);
		}

		public void orderDetailsDelete(String orderId) {
			productRepository.orderDetailsDelete(orderId);
			
		}

		public void orderDelete(String orderId) {
			productRepository.orderDelete(orderId);
			
		}
		
		public List<Product> getProductCate(Product product) {
			return productRepository.getProductCate(product);
		}
		
		public int productCateCount(String category_code) {
			return productRepository.productCateCount(category_code);
		}
		
		public List<Review_Board> getReviewList(int product_id) {
			return productRepository.getReviewList(product_id);
		}
		
		//getmyOrderdetail
		public OrderDetail getmyOrderdetail(String order_id) {
			return productRepository.getmyOrderdetail(order_id);
		}
		
		public Cart getCartforQty(HashMap<String, Object> hm) {
			return productRepository.getCartforQty(hm);
		}
		
}
