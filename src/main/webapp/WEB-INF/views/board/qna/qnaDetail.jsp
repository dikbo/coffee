<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../include/header.jsp" %>

<section class="module">
  <div class="container">
    <div class="row">
      <div class="col-sm-8 col-sm-offset-2">
      <h2>QnA</h2>
        <hr class="divider-w mt-10 mb-20">
        <form id="qna_form" class="form" role="form" action="qRegist" method="post" enctype="multipart/form-data">
         <table class="table table-border checkout-table">
				<tbody>
					<tr>
						<th>No</th>
						<td>${qna.board_id}</td>
					</tr>	
					<tr>
						<th>제목</th>
						<td>${qna.subject}</td>
					</tr>	
					<tr>
						<th>작성자</th>
						<td>${qna.member_id}</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${qna.regdate}"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${qna.content}</td>
					</tr>
				</tbody>
			</table>
			<hr class="divider-w mt-10 mb-20">
			<sec:authorize access="hasRole('ROLE_ADMIN')">	
        	<button type="button" class="btn btn-d btn-round" id="qnaReRegBtn" onclick="location.href='/board/qna/qnaReRegist/${qna.board_id}'">답변 작성</button>
        	</sec:authorize>
        	<sec:authentication property="principal" var="principal"/>
		    <sec:authorize access="isAuthenticated()">
		    <c:if test="${principal.member.member_id eq qna.member_id}">
        	<button type="button" class="btn btn-d btn-round" id="qnaUpBtn" onclick="location.href='board/qna/qnaUpdate?board_id=${qna.board_id}'">수정</button>
        	<button type="button" class="btn btn-d btn-round" id="qnaDelBtn" onclick="location.href='/board/qna/qnaDelete?board_id=${qna.board_id}'">삭제</button>
        	</c:if>
        	</sec:authorize>
        	<button type="button" class="btn btn-d btn-round" id="qnaListBtn" onclick="location.href='/board/qna/qnaBoard'">목록으로</button>
        </form>
      </div>
    </div>
  </div>
</section> 


<%@ include file="../../include/footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

</script> 