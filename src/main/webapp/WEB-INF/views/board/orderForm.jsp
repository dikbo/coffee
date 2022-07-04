<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/resources/js/addressapi.js"></script>

<%@ include file="../include/header.jsp" %>    

<section class="module">
  <div class="container">  
    <div class="row"> 
	 <section class="checkout_area section_gap">
        <div class="container">
            <div class="billing_detail">
                <div class="row">
                    <div class="col-lg-8">
                        <h3>배송지 정보 입력</h3>
                        <hr class="divider-w mt-10 mb-20">
                        <form class="row contact_form" id="orderForm" action="/order" method="post" novalidate="novalidate">
                        <div class="form-group">
                            <div class="form-group">
							<label>받으시는분:</label> <input class="form-control" id="order_name"
								name="order_name" type="text"  value="${user.member_name}" />
							</div>
                            
                            <div class="form-group">
							<label>연락처:</label> <input class="form-control" id="order_phone"
								name="order_phone" type="text"  value="${user.member_phone}"  placeholder="연락처"/>
							</div>
							
							<div class="form-group">
							<label>우편번호:</label> <input class="form-control" id="order_addr1" readonly="readonly"
								name="order_addr1" type="text"  value="${user.member_addr1}" />
								<input type="button" class="btn btn-d btn-round" value="주소검색" onclick="execPostCode();">
							</div>
                            
							<div class="form-group">
							<label>도로명주소:</label> <input class="form-control" id="order_addr2" readonly="readonly"
								name="order_addr2" type="text"  value="${user.member_addr2}" />
							</div>
							
							<div class="form-group">
							<label>상세주소:</label> <input class="form-control" id="order_addr3"
								name="order_addr3" type="text"  value="${user.member_addr3}" />
							</div>
						</div>
                    
                    <div class="col-lg-4">
                        <div class="order_box">
                            <h2>주문 내역</h2>
                            <ul class="list">
                                <li><a href="#">Product <span>Total</span></a></li>
                                <c:set var="sum" value="0" /> 
                                <c:forEach items="${cartList}" var="cartList">
                                <input type="hidden" name="order_title" value="${cartList.product.product_name}">
                                <input type="hidden" name="product_id" value="${cartList.cart.product_id}">
                                <input type="hidden" name="cart_id" value="${cartList.cart.cart_id}">
                                <li><a href="#">
	                                <c:choose>
								        <c:when test="${fn:length(cartList.product.product_name) gt 10}">
								        <c:out value="${fn:substring(cartList.product.product_name, 0, 9)}"/>...
								        </c:when>
								        <c:otherwise>
								        <c:out value="${cartList.product.product_name}">
								        </c:out>
								        </c:otherwise>
									</c:choose>
                                
                                <span class="middle">x ${cartList.cart.qty}</span> <span class="last"><fmt:formatNumber pattern="###,###,###" value="${cartList.product.product_price}" />원</span></a></li>
                            	<c:set var="sum" value="${sum + (cartList.product.product_price * cartList.cart.qty)}" />
                            	</c:forEach>
                            </ul>
                            <ul class="list list_2">
                                <li><a href="#">Subtotal <span><fmt:formatNumber pattern="###,###,###" value="${sum}" />원</span></a></li>
                                <li><a href="#">Shipping <span><c:if test="${sum>=20000}">0원<c:set var="shipping" value="0"></c:set></c:if><c:if test="${sum<20000}">2,000원<c:set var="shipping" value="2000"></c:set></c:if></span></a></li>
                                <li><a href="#">Total <span><fmt:formatNumber pattern="###,###,###" value="${sum+shipping}" />원</span></a></li>
                                <input type="hidden" name="total_amount" value="${sum+shipping}"/>
                            </ul>
                            <div class="payment_item">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option5" name="payment" value="${sum+shipping}" checked>
                                    <label for="f-option5">Check payments</label>
                                    <div class="check"></div>
                                </div>
                                <p>받으실 분 이름과 주소를 확인해주세요.</p>
                            </div>
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option6" name="payment" value="card">
                                    <label for="f-option6">Paypal</label>
                                    <img src="images/coffeeshop/product/card.jpg" alt="">
                                    <div class="check"></div>
                                </div>
                                <p>PayPal로 결제합니다(PayPal 계정이 없다면 크레딧 카드로 결제할 수 있습니다)</p>
                            </div>
                            <div class="creat_account">
                                <input type="checkbox" id="f-option4" name="selector">
                                <label for="f-option4">배송 정보 제3자 공개 및 약관에 동의합니다.</label>
                            </div>
                            <button type="button" id="orderSubBtn" class="btn btn-d btn-round" value="주문하기">주문하기</button>
                        </div>
                    </div>
                    </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </div>
  </div>
</section>
	

<%@ include file="../include/footer.jsp" %>

<!-- js -->
	<jsp:include page="../include/js.jsp"/>

<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=order_addr1]").val(data.zonecode);
           $("[name=order_addr2]").val(fullRoadAddr);
           
            document.getElementById('order_addr1').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('order_addr2').value = fullRoadAddr;
       }
    }).open();
}

$(function() {
	$('#orderSubBtn').click(function() {
		if ($("input:checkbox[id='f-option4']").is(":checked") == false) {
			alert('배송 정보 제3자 공개 및 약관에 동의해주세요.');
			return false;
		}
		
		$('#orderForm').submit();
	});
});
</script>