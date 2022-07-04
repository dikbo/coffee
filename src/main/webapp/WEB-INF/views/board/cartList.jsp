<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>




<%@ include file="../include/header.jsp"%>



<div class="main">
	<section class="module bg-dark-60 shop-page-header" data-background="/images/coffeeshop/main1.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<br/><br/>
					<h2 class="module-title font-alt">Cart</h2>
					<br/><br/><br/>
				</div>
			</div>
		</div>
	</section>
	<br/>
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<form id="order-form" action="orderForm" method="post">
					<table class="table">
						<colgroup>
							<col class="col1">
							<col class="col2">
							<col class="col3">
							<col class="col4">
							<col class="col5">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">Product</th>
								<th scope="col">Price</th>
								<th scope="col">Quantity</th>
								<th scope="col">Total</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:set var="sum1" value="0" />
							<c:forEach items="${cartList}" var="cartList">
								<tr>
									<td>
										<div class="media">
											<div class="d-flex">
												<img src="/resources/productImg/${cartList.product.product_img}" alt="" width="70" height="70">
												<a href="productView?productId=${cartList.product.product_id}">${cartList.product.product_name}</a>
											</div>
										</div>
									</td>
									<td>
										<h5><fmt:formatNumber pattern="###,###,###" value="${cartList.product.product_price}" />원</h5>
									</td>
									<td>
										<br>
										<div class="product_count">
										<input type="hidden" id="cart_id" name="cart_id" value="${cartList.cart.cart_id}">
										<input type="hidden" id="product_id" name="product_id" value="${cartList.cart.product_id}">
											<input type="text" name="qty"
												id="sst${cartList.cart.cart_id}" maxlength="12"
												value="${cartList.cart.qty}" title="Quantity:"
												class="input-text qty">
											<button
												onclick="var result = document.getElementById('sst${cartList.cart.cart_id}'); var sst${cartList.cart.cart_id} = result.value; if( !isNaN(sst${cartList.cart.cart_id})) result.value++;return false;"
												class="btn btn-d btn-round" type="button" id="qtyUpBtn">
												<i class="fa fa-chevron-up"></i>
											</button>
											<button
												onclick="var result = document.getElementById('sst${cartList.cart.cart_id}'); var sst${cartList.cart.cart_id} = result.value; if( !isNaN(sst${cartList.cart.cart_id}) &amp;&amp; sst${cartList.cart.cart_id} > 0 ) result.value--;return false;"
												class="btn btn-d btn-round" type="button" id="qtyDownBtn">
												<i class="fa fa-chevron-down"></i>
											</button>
											<button type="button" class="btn btn-d btn-round" id="qtyUpdateBtn${cartList.cart.cart_id}">변경</button>
										</div>
									</td>
									<td>
										<h5><fmt:formatNumber pattern="###,###,###" value="${cartList.product.product_price * cartList.cart.qty}" />원</h5>
									</td>
									<td>
										<div class="checkBox">
											<input type="checkbox" name="chBox" class="chBox" value="${cartList.cart.cart_id}" data-cart_id="${cartList.cart.cart_id}"
												data-qty="${cartList.cart.qty}" data-productPrice="${cartList.product.product_price}" onClick="itemSum(this.form);" checked />
										</div>
									</td>
								</tr>
								<c:set var="sum1" value="${sum1 + (cartList.product.product_price * cartList.cart.qty)}" />
							</c:forEach>
							<tr>
								<td></td>
								<td></td>
								<td><h5>Subtotal</h5></td>
								<td>
									<div id="area">
										<h5><fmt:formatNumber pattern="###,###,###" value="${sum1}" />원</h5>
									</div>
								</td>
							</tr>
							<tr class="bottom_button">
								<td><a href="" class="btn btn-d btn-round" id="selectDeleteBtn">선택 삭제</a>&nbsp;&nbsp;&nbsp; <a href="" class="btn btn-d btn-round" id="allDeleteBtn">장바구니 비우기</a></td>
								<td></td>
								<td></td>
								<td><input type="submit" value="주문" class="btn btn-d btn-round"></td>
							</tr>
						</tbody>
					</table>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="../include/footer.jsp"%>

<!-- js -->
<jsp:include page="../include/js.jsp" />

<script>

$(document).ready(function(){	
	// 개수 변경
	$("button[id^='qtyUpdateBtn']").on("click", function() {
		var product_id = $("#product_id").val();
		var cart_id = $("#cart_id").val();
		var qty = $(".qty").val();
		
		$.ajax({
			url : "/cartUpdate",
			type : "post",
			data : JSON.stringify({"product_id" : product_id,
					"cart_id" : cart_id,
					"qty" : qty}),
			contentType: "application/json",
			success : function(){
				location.href="cartList";
				alert("수량이 변경되었습니다.");
				
			}
		});
	});
	
	
	//전체삭제
	$(document).on("click", "#allDeleteBtn", function(){
		var confirm_val = confirm("장바구니를 비우시겠습니까?");

		if(confirm_val){
			$.ajax({
				url : "/cartAllDelete",
				type : "get",
				success : function(){
					location.href="cartList";
				}
			});
		}
	});
	
	
	//선택삭제
	$(document).on("click", "#selectDeleteBtn", function(){
		var confirm_val = confirm("정말 삭제하시겠습니까?");
	
		if(confirm_val){
			var checkArr = new Array();
	
			$("input[class='chBox']:checked").each(function(){
				checkArr.push($(this).attr("data-cart_id"));
			});
	
			$.ajax({
				url : "/cartDelete",
				type : "post",
				data : {chbox : checkArr},
				success : function(){
					location.href="cartList";
				}
			});
		}
	});
});	

//선택합계
function itemSum(frm) {
   var sum = 0;
   var htmlStr="";
   var count = frm.chBox.length;
   
	   $("input[class='chBox']:checked").each(function(){
		
		     sum += parseInt($(this).attr("data-productPrice"))*parseInt($(this).attr("data-qty"));
		});

	sum = addComma(sum);
 
	htmlStr += "<h5>" +sum + "원</h5>" ;
 	$("#area").html(htmlStr);
}


//콤마 추가
function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
}


	
</script>