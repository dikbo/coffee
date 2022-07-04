package com.sam.coffeeshop.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sam.coffeeshop.domain.Cart;
import com.sam.coffeeshop.domain.CartList;
import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.OrderDetail;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.Review_Board;
import com.sam.coffeeshop.domain.orderProduct;
import com.sam.coffeeshop.mappers.ProductMapper;

@Repository
public class ProductRepository {
	
	@Autowired
	private ProductMapper productMapper;
	
	//상품전체조회
		public List<Product> productAllList(HashMap<String, Object> hm){
			return productMapper.productAllList(hm);
		}

		//상품조회
		public List<Product> productList(HashMap<String, Object> hm){
			return productMapper.productList(hm);
		}
		
		//상품 상세보기
		public Product productView(int productId) {
			return productMapper.productView(productId);
		}
		
		//리뷰 작성
		public void reviewRegister(Review_Board review) {
			productMapper.reviewRegister(review);
		}
		
		//리뷰 조회
		public List<Review_Board> reviewList(HashMap<String, Object> hm){
			return productMapper.reviewList(hm);
		}

		//카트 담기
		public void addCart(Cart cart) {
			productMapper.addCart(cart);		
		}

		//카트 리스트
		public List<CartList> cartList(String userid) {
			return productMapper.cartList(userid);
		}

		//카트 삭제
		public void cartDelete(Cart cart) {
			productMapper.cartDelete(cart);
			
		}

		public void addOrder(Order order) {
			productMapper.addOrder(order);		
		}

		public void addOrderDetails(OrderDetail orderDetails) {
			productMapper.addOrderDetails(orderDetails);		
		}

		public CartList findByCartId(int cartId) {
			return productMapper.findByCartId(cartId);
		}

		public void cartAllDelete(String userid) {
			productMapper.cartAllDelete(userid);
			
		}

		public List<Order> orderList(String userid) {
			return productMapper.orderList(userid);
		}

		public List<Order> orderAllList(HashMap<String, Object> hm) {
			return productMapper.orderAllList(hm);
		}

		public Order orderView(String orderId) {
			return productMapper.orderView(orderId);
		}

		public List<orderProduct> orderProduct(String orderId) {
			return productMapper.orderProduct(orderId);
		}

		public int cartSize(String userid) {
			return productMapper.cartSize(userid);
		}

		public void cartDeleteOrder(HashMap<String, Object> hm) {
			productMapper.cartDeleteOrder(hm);
			
		}

		public void cartDelete2(Cart cart) {
			productMapper.cartDelete2(cart);
			
		}

		public int findProductId(int cartId) {
			return productMapper.findProductId(cartId);
		}

		public void deleteReview(int reviewId) {
			productMapper.deleteReview(reviewId);
		}

		public int getOrderCount(HashMap<String, Object> hm) {
			return productMapper.getOrderCount(hm);
		}

		public int reviewCheck(HashMap<String, Object> hm) {
			return productMapper.reviewCheck(hm);
		}

		public int cartCheck(Cart cart) {
			return productMapper.cartCheck(cart);
		}

		public int[] getReviewStar(int productId) {
			return productMapper.getReviewStar(productId);
		}

		public int getReviewCount(int product_id) {
			return productMapper.getReviewCount(product_id);
		}

		public int getCategoryCount(String categoryCode) {
			return productMapper.getCategoryCount(categoryCode);
		}

		public int getProductAllCount(HashMap<String, Object> hm) {
			return productMapper.getProductAllCount(hm);
		}

		public String getOrderTitle(String orderId) {
			return productMapper.getOrderTitle(orderId);
		}

		public List<OrderDetail> getOrderDetails(String orderId) {
			return productMapper.getOrderDetails(orderId);
		}

		public void addSales(HashMap<String, Object> hm) {
			productMapper.addSales(hm);
			
		}

		public Cart getCart(Long cartId) {
			return productMapper.getCart(cartId);
		}

		public void cartDeleteByCartId(Long cartId) {
			productMapper.cartDeleteByCartId(cartId);
			
		}

		public List<Product> getBestSeller() {
			return productMapper.getBestSeller();
		}

		public List<Product> getLatestProducts() {
			return productMapper.getLatestProducts();
		}

		public Category productCategory(int productId) {
			return productMapper.productCategory(productId);
		}

		public int[] getTotalAmount(String userid) {
			return productMapper.getTotalAmount(userid);
		}

		public void orderDetailsDelete(String orderId) {
			productMapper.orderDetailsDelete(orderId);
			
		}

		public void orderDelete(String orderId) {
			productMapper.orderDelete(orderId);
			
		}
		
		public List<Product> getProductCate(Product product) {
			 return productMapper.getProductCate(product);
		}
		
		public int productCateCount(String category_code) {
			return productMapper.productCateCount(category_code);
		}
		
		public List<Review_Board> getReviewList(int product_id) {
			return productMapper.getReviewList(product_id);
		}
		
		//getmyOrderdetail
		public OrderDetail getmyOrderdetail(String order_id) {
			return productMapper.getmyOrderdetail(order_id);
		}
		
		public void cartProductQtyUpdate(Cart cart) {
			productMapper.cartProductQtyUpdate(cart);
		}
		
		public Cart getCartforQty(HashMap<String, Object> hm) {
			return productMapper.getCartforQty(hm);
		}
		
}
