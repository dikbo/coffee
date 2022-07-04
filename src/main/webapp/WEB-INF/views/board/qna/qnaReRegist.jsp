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
        <form id="qna_re_form" class="form" role="form" action="qReRegist" method="post" enctype="multipart/form-data">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
         <input type="hidden" name="board_re_ref" value="${qnareinfo.board_re_ref}"/>
         <input type="hidden" name="board_re_lev" value="${qnareinfo.board_re_lev}"/>
         <input type="hidden" name="board_re_seq" value="${qnareinfo.board_re_seq}"/>
         <div class="form-group">
          <label>제목:</label>
            <input class="form-control" type="text" id="subject" name="subject" value="└[답변] 문의 주신 내용의 답변입니다." readonly/>
          </div>
          <div class="form-group">
           <label>작성자:</label>
            <input class="form-control" type="text" id="member_id" name="member_id" value="<sec:authentication property='principal.member.member_id'/>" readonly/>
          </div>
          <div class="form-group">
           <label>내용:</label>
            <textarea class="form-control" rows="15"  id="content" name="content"></textarea>
          </div>
          <button type="submit" class="btn btn-d btn-round" id="qnaReRegBtn">등록</button>
        </form>
      </div>
    </div>
  </div>
</section> 


<%@ include file="../../include/footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#qnaReRegBtn').click(function() {
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
		
		$('#qna_re_form').submit();
	});
});
</script> 