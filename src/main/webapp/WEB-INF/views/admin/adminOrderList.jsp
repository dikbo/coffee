<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../include/header.jsp" %>
    
<section class="module">
  <div class="container">  
    <div class="row">
      <div>
      <h2>주문 관리<small>(${count})</small></h2>
        <hr class="divider-w mt-10 mb-20">
			<table class="table table-border checkout-table">
				<tbody>
					<tr>
						<th>주문번호</th>
						<th>주문자명</th>
						<th>주문내역</th>
						<th>총 금액</th>
						<th>주문일</th>
						<th>주문상태</th>
					</tr>
					<c:forEach items="${olist}" var="o">
					<tr>
						<td sytle="width:200px;"><a href="#">${o.order_id}</a></td>
						<td>${o.member_id}</td>
						<td><a href="/member/myOrderdetail/${o.order_id}">
							<c:choose>
								<c:when test="${fn:length(o.order_title) gt 41}">
									<c:out value="${fn:substring(o.order_title, 0, 40)}" />...
				        		</c:when>
								<c:otherwise>
									<c:out value="${o.order_title}">
									</c:out>
								</c:otherwise>
							</c:choose>
							</a>
						</td>
						<td>${o.total_amount}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${o.order_date}"/></td>
						<td>
							${o.status} &emsp;
							<c:if test="${o.status ne '배송완료'}">
							<button type="button" id="pDeleteBtn" class="btn btn-d btn-round" onclick="location.href='/orderStatusUpdate/${o.order_id}'">배송완료 확인</button>
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>	
		<hr class="divider-w mt-10 mb-20">
      </div>
    </div>
  </div>
</section>
<section class="module-small">
<div class="container">
	<div class="col-sm-8 col-sm-offset-2 paginationblock">
		<div>
			<ul class="pagination">
			<!-- 이전 -->
			<c:if test="${page.startPage > page.blockSize}">
			<li class="page-item"><a class="page-link" href="/admin/adminOrderList?pageNum=${page.startPage - page.blockSize}&field=${field}&word=${word}">Previous</a></li>
			</c:if>
			<!--페이지 리스트-->
			<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
			<li class="page-item"><a class="page-link" href="adminOrderList?pageNum=${i}&field=${field}&word=${word}">${i}</a></li>
			</c:forEach>
			<!-- 다음 -->
			<c:if test="${page.endPage < page.totPage}">
			<li class="page-item"><a class="page-link" href="adminOrderList?pageNum=${page.endPage + 1}&field=${field}&word=${word}">Next</a></li>
			</c:if>
			</ul>
		</div>	
	
			<form class="form" action="/admin/adminOrderList" id="searchFrm">
				<select name="field" class="form">
					<option value="" disabled selected>--</option>
					<option value="member_id" ${(field == 'member_id') ? 'selected' : ''}>주문자명</option>
				</select> 
				<input type="text" class="form-control-search"
					placeholder="Enter Search" name="word" value="${word}">
				<button type="submit" class="btn btn-d btn-round">Search</button>
			</form>
		</div>
</div>		
</section>

<script type="text/javascript">

</script>
<%@ include file="../include/footer.jsp" %>