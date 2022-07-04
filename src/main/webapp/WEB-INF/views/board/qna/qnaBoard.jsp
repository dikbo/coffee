<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
    
<section class="module">
  <div class="container">  
    <div class="row">
      <div>
      <h2>QnA</h2>
        <hr class="divider-w mt-10 mb-20">
        <form class="form" role="form" method="post" action="#">
			<table class="table table-border">
				<tbody>
					<tr>
						<th>No</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
					<c:forEach items="${qlist}" var="q">
					<tr>
						<td>${q.board_id}</td>
						<td>
						<c:if test="${q.board_re_lev > 0}">
	                        <c:forEach begin="1" end="${q.board_re_lev}">
	                            &nbsp;&emsp;
	                        </c:forEach>
                    	</c:if>
						<a href="board/qna/qnaDetail?board_id=${q.board_id}&pageNum=${page.currentPage}&field=${field}&word=${word}">${q.subject}</a>
						</td>
						<td>${q.member_id}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${q.regdate}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="divider-w mt-10 mb-20">
			<sec:authorize access="isAuthenticated()">
         		<button class="btn btn-d btn-round" type="button" onclick="location.href='board/qna/qnaRegist'">글쓰기</button>
        	</sec:authorize>
        </form>
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
		<li class="page-item"><a class="page-link" href="/board/qna/qnaBoard?pageNum=${page.startPage - page.blockSize}&field=${field}&word=${word}">Previous</a></li>
		</c:if>
		<!--페이지 리스트-->
		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
		<li class="page-item"><a class="page-link" href="/board/qna/qnaBoard?pageNum=${i}&field=${field}&word=${word}">${i}</a></li>
		</c:forEach>
		<!-- 다음 -->
		<c:if test="${page.endPage < page.totPage}">
		<li class="page-item"><a class="page-link" href="/board/qna/qnaBoard?pageNum=${page.endPage + 1}&field=${field}&word=${word}">Next</a></li>
		</c:if>
		</ul>
	</div>
		<form class="form" action="/board/qna/qnaBoard" id="searchFrm">
			<select name="field" class="form">
				<option value="" disabled selected>--</option>
				<option value="subject" ${(field == 'subject') ? 'selected' : ''}>제목</option>
				<option value="member_id" ${(field == 'member_id') ? 'selected' : ''}>작성자</option>
			</select> 
			<input type="text" class="form-control-search"
				placeholder="Enter Search" name="word" value="${word}">
			<button type="submit" class="btn btn-d btn-round">Search</button>
		</form>
	</div>
</div>
</section>

<%@ include file="../../include/footer.jsp" %>