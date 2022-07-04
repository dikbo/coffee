<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="zxx" class="no-js">
<head>
<style>
.flex-container {
	display: flex;
	margin: 3%;
	flex-wrap: nowrap;
	flex-direction: column;
	justify-content: center;
	font-size: 14px;
}

.details_item>.list>li {
	list-style: none;
}
</style>
</head>

<section class="module">
	<div class="flex-container">

		<div class="updivleft">
			<div class="col-sm-8 col-sm-offset-2">

				<h3>주문정보</h3>
				<hr class="divider-w mt-10 mb-20">
				<form action="/admin/updateTracking" method="post" name="frm2" id="frm2">
					<div class="details_item">
					<input type="hidden" name="order_id" value="${orders.order_id}">
						<ul class="list">
							<li><a href="#"><span>주문번호</span> : ${orders.order_id}</a></li>
							<li><a href="#"><span>주문날짜</span> : <fmt:formatDate
										pattern="yyyy-MM-dd" value="${orders.order_date}" /> </a></li>
							<li><a href="#"><span>총금액</span> : <fmt:formatNumber
										pattern="###,###,###" value="${orders.total_amount}" />원</a></li>
							<li><a href="#"><span>지불방식</span> : ${orders.payment}</a></li>
							<li><a href="#"><span>주문상태</span> : ${orders.status}</a></li>
							<li><a href="#"><span>운송장번호</span> : ${orders.tracking}</a></li>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
							<c:if test="${orders.tracking eq null}">
								<li>
								<input type="text" size="16" id="tracking" name="tracking">
								<button type="submit" class="btn btn-d btn-round" value="운송">운송장번호 입력</button>
								</li>
							</c:if>
							</sec:authorize>
						</ul>
					</div>
				
			</div>
		</div>
		<div class="updivright">
			<div class="col-sm-8 col-sm-offset-2">

				<h3>배송주소</h3>
				<hr class="divider-w mt-10 mb-20">
				<div class="details_item">
					<ul class="list">
						<li><a href="#"><span>받으시는분</span> : ${orders.order_name}</a></li>
						<li><a href="#"><span>우편번호</span> : ${orders.order_addr1}</a></li>
						<li><a href="#"><span>주소</span> : ${orders.order_addr2}
								${orders.order_addr3}</a></li>
						<li><a href="#"><span>연락처</span> : ${orders.order_phone}</a></li>
					</ul>
				</div>
			</div>
		</form>
		</div>
	<div class="col-sm-8 col-sm-offset-2">
		<div class="details_item">
			<h2>주문상세</h2>
			<div class="tablex">
				<table class="table">
					<thead>
						<tr>
							<th>제품</th>
							<th>수량</th>
							<th>가격</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="sum" value="0" />
						<c:forEach items="${pInfo}" var="p">
							<tr>
								<td>
									<p>${p.pname}</p>
								</td>
								<td>
									<h5>${p.qty}</h5>
								</td>
								<td>
									<p>
										<fmt:formatNumber pattern="###,###,###"
											value="${p.pprice}" />
										원
									</p>
								</td>
							</tr>
							<c:set var="sum"
								value="${sum + (p.pprice * p.qty)}" />
						</c:forEach>
						<tr>
							<td>
								<h4>총 금액</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p>
									<fmt:formatNumber pattern="###,###,###" value="${sum}" />
									원
								</p>
							</td>
						</tr>
						<tr>
							<td>
								<h4>Shipping</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p>
									<c:if test="${sum>=20000}">0원<c:set var="shipping"
											value="0"></c:set>
									</c:if>
									<c:if test="${sum<20000}">2,000원<c:set var="shipping"
											value="2000"></c:set>
									</c:if>
								</p>
							</td>
						</tr>
						<tr>
							<td>
								<h4>Total</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p>
									<fmt:formatNumber pattern="###,###,###" value="${sum+shipping}" />
									원
								</p>
							</td>
						</tr>
					</tbody>
				</table>
				<div>
				<c:if test="${orders.status=='배송준비중'}">
					<br>
					<a href="orderCancle?orderId=${orders.order_id}"
						class="btn btn-d btn-round">주문취소</a>
						&nbsp; <a href="/member/myPage" class="btn btn-d btn-round">목록으로</a>
				</c:if>
				<c:if test="${orders.status=='배송완료'}">
					&nbsp; <a href="/member/myPage" class="btn btn-d btn-round">목록으로</a>
				</c:if>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					&nbsp; <a href="/admin/adminOrderList" class="btn btn-d btn-round">전체 주문목록</a>
				</sec:authorize>
			</div>
			</div>
		</div>
		</div>
	</div>
</section>
</html>
<script>
	
</script>
<%@ include file="../include/footer.jsp"%>