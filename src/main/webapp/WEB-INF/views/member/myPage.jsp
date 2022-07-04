<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<section class="module">
	<div class="container">
		<div class="row">
			<div class="col-sm-10">
				<h2>마이페이지</h2>
				<hr class="divider-d mt-10 mb-40 ">
				<h3>주문 현황</h3>
				<hr class="divider-w mt-10 mb-20">
				<table class="table table-striped ">

					<thead>
						<tr>
							<th>주문번호</th>
							<th>주문내역</th>
							<th>주문금액</th>
							<th>주문일</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList}" var="order">
							<tr>
								<td>${order.order_id}</td>

								<td><a href="/member/myOrderdetail/${order.order_id}"> <c:choose>
										<c:when test="${fn:length(order.order_title) gt 26}">
											<c:out value="${fn:substring(order.order_title, 0, 25)}" />...
								        </c:when>
										<c:otherwise>
											<c:out value="${order.order_title}">
											</c:out>
										</c:otherwise>
									</c:choose>
								</a>
								</td>

								<td><fmt:formatNumber pattern="###,###,###"
										value="${order.total_amount}" />원</td>

								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${order.order_date}"/></td>

								<td>
									${order.status}&emsp;
									
									<button type="button" id="rRegBtn" class="btn btn-d btn-round" onclick="location.href='/reviewSelect/${order.order_id}'">상세목록</button>
									
								</td>
							</tr>
							<%-- <tr id="hiddenPInfo" style="display:none;">
								<td></td>
								<td colspan="3">
								<c:forEach items="${oDetail}" var="od">
								<c:if test="${order.order_id == od.order_id}">
								<c:forEach items="${pInfo}" var="p">
								<c:if test="${od.product_id == p.product_id}">
									${p.product_name} &emsp; &emsp;
									<c:if test="${order.status eq '배송완료'}">
									<button type="button" id="rRegBtn" class="btn btn-d btn-round" onclick="location.href='/reviewRegist/${order.order_id}'">리뷰 작성하기</button>
									</c:if>
								</c:if>
								</c:forEach>
								</c:if>
								</c:forEach>
								</td>
							</tr> --%>
						</c:forEach>
					</tbody>
				</table>

				<!-- Q&A BOADR -->
				<hr class="divider-w mt-20 mb-20">
				<br>
				<h3>나의 QnA</h3>
				<hr class="divider-w mt-10 mb-20">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list">
                            <tr>
                            <td>${list.board_id}</td>
<%--                                <td><a href="board/qna/qnaDetail?board_id=${list.board_id}">${list.subject}</a></td> --%>
                               <td><a href="/board/qna/qnaDetail?board_id=${list.board_id}&pageNum=${page.currentPage}&field=${field}&word=${word}">${list.subject}</a></td>
                                <td>${list.member_id }</td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}"/></td>
                            </tr>
                            </c:forEach>
					</tbody>

				</table>
				<sec:authorize access="isAuthenticated()">
         		<button class="btn btn-d btn-round" type="button" onclick="location.href='/board/qna/qnaRegist'">글쓰기</button>
        		</sec:authorize>
			</div>
		</div>
	</div>
</section>

<script>
window.onload = function() {
	 
    function onClick() {
        document.querySelector('.popup_wrap').style.display ='block';
        //document.querySelector('.black_bg').style.display ='block';
    }   
    function offClick() {
        document.querySelector('.popup_wrap').style.display ='none';
        //document.querySelector('.black_bg').style.display ='none';
    }
 
    document.getElementById('rListPopup').addEventListener('click', onClick);
    document.querySelector('.popup_close').addEventListener('click', offClick);
 
};

function tablevisiblity() {
	
}
function hideRow()  {
	const row = document.getElementById('hiddenPInfo');
	row.style.display = 'none';
}

function showRow()  {
	const row = document.getElementById('hiddenPInfo');
	row.style.display = '';
}
</script>
<%@ include file="../include/footer.jsp"%>