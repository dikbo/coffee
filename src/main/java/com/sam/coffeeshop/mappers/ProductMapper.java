package com.sam.coffeeshop.mappers;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sam.coffeeshop.domain.Cart;
import com.sam.coffeeshop.domain.CartList;
import com.sam.coffeeshop.domain.Category;
import com.sam.coffeeshop.domain.Order;
import com.sam.coffeeshop.domain.OrderDetail;
import com.sam.coffeeshop.domain.Product;
import com.sam.coffeeshop.domain.Review_Board;
import com.sam.coffeeshop.domain.orderProduct;

@Mapper
public interface ProductMapper {
	//상품 전체조회
	public List<Product> productAllList(HashMap<String, Object> hm);
	
	//상품조회
	public List<Product> productList(HashMap<String, Object> hm);
	
	//상품 상세보기
		public Product productView(int product_id);
		
		//리뷰 작성
		public void reviewRegister(Review_Board review);
		
		//리뷰 조회
		public List<Review_Board> reviewList(HashMap<String, Object> hm);

		//카트 담기
		public void addCart(Cart cart);

		//카트 리스트
		public List<CartList> cartList(String userid);

		//카트 삭제
		public void cartDelete(Cart cart);

		public void addOrder(Order order);

		public void addOrderDetails(OrderDetail orderDetails);

		public CartList findByCartId(int cartId);

		public void cartAllDelete(String userid);

		public List<Order> orderList(String userid);

		public List<Order> orderAllList(HashMap<String, Object> hm);

		public Order orderView(String orderId);

		public List<orderProduct> orderProduct(String orderId);

		public int cartSize(String userid);

		public void cartDeleteOrder(HashMap<String, Object> hm);

		public void cartDelete2(Cart cart);

		public void favDelete(int favId);

		public int findProductId(int cartId);

		public void deleteReview(int reviewId);

		public int getOrderCount(HashMap<String, Object> hm);

		public int reviewCheck(HashMap<String, Object> hm);

		public int cartCheck(Cart cart);

		public int[] getReviewStar(int productId);

		public int getReviewCount(int product_id);

		public int getCategoryCount(String categoryCode);

		public int getProductAllCount(HashMap<String, Object> hm);

		public String getOrderTitle(String orderId);

		public List<OrderDetail> getOrderDetails(String orderId);

		public void addSales(HashMap<String, Object> hm);

		public Cart getCart(Long cartId);

		public void cartDeleteByCartId(Long cartId);

		public List<Product> getBestSeller();

		public List<Product> getLatestProducts();

		public Category productCategory(int productId);

		public int[] getTotalAmount(String userid);

		public void orderDetailsDelete(String orderId);

		public void orderDelete(String orderId);
		
		public List<Product> getProductCate(Product product);
		
		public int productCateCount(String category_code);
		
		public List<Review_Board> getReviewList(int product_id);
		//getmyOrderdetail
		public OrderDetail getmyOrderdetail(String order_id);
		// 수량 변경
		public void cartProductQtyUpdate(Cart cart);
		
		public Cart getCartforQty(HashMap<String, Object> hm);
		
}
