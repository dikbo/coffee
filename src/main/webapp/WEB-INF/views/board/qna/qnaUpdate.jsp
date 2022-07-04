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
        <form id="qna_up_form" class="form" role="form" action="qUpdate" method="post">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
         <input type="hidden" name="board_id" id="board_id" value="${qna.board_id}"/>
         <div class="form-group">
          <label>제목:</label>
            <input class="form-control" type="text"  id="subject" name="subject" value="${qna.subject}"/>
          </div>
          <div class="form-group">
           <label>작성자:</label>
            <input class="form-control" type="text"  id="member_id" name="member_id" value="<sec:authentication property='principal.member.member_id'/>" readonly/>
          </div>
          <div class="form-group">
           <label>문의 내용:</label>
            <textarea class="form-control" rows="15"  id="content" name="content">${qna.content}</textarea>
          </div>
          <button type="submit" class="btn btn-d btn-round" id="qnaRegBtn">등록</button>
          <button type="button" class="btn btn-d btn-round" id="qnaListBtn" onclick="location.href='/board/qna/qnaBoard'">목록으로</button>
        </form>
      </div>
    </div>
  </div>
</section> 


<%@ include file="../../include/footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#qnaRegBtn').click(function() {
		if (!$('#subject').val()) {
			alert('제목을 입력하세요');
			$('#subject').focus();
			return false;
		}
		if (!$('#content').val()) {
			alert('내용을 입력하세요');
			$('#content').focus();
			return false;
		}
		
		$('#qna_up_form').submit();
	});
});
</script> 