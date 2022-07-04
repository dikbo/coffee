<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../include/header.jsp" %>


<section class="module">
  <div class="container">  
    <div class="row">
      <div>
      <h2>회원 관리<small>(${count})</small></h2>
        <hr class="divider-w mt-10 mb-20">
        <form class="form" role="form" method="post" action="/admin/memberManage/delete">
			<table class="table table-border checkout-table">
				<tbody>
					<tr>
						<th><input type="checkbox" id="allCheck" name="allCheck"></th>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>주소</th>
						<th></th>
					</tr>
					<c:forEach items="${mlist}" var="m">
					<tr>
						<td><input type="checkbox" data-id="${m.id}" class="chBox" name="chBox" id="chBox"></td>
						<td>${m.member_id}</td>
						<td>${m.member_name}</td>
						<td>${m.member_phone}</td>
						<td>${m.email}</td>
						<td>(${m.member_addr1}) ${m.member_addr2} ${m.member_addr3}</td>
						<c:if test="${m.member_id != 'admin'}">
							<td><input type="button" id="memDeleteBtn" class="btn btn-d btn-round" onclick="location.href='/admin/memberManage/delete/${m.id}'" value="삭제"></td>
						</c:if>	
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="divider-w mt-10 mb-20">
          <button id="allMemDeleteBtn" class="btn btn-d btn-round" type="button">선택 회원 삭제</button>
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
		<li class="page-item"><a class="page-link" href="/admin/memberManage?pageNum=${page.startPage - page.blockSize}&field=${field}&word=${word}">Previous</a></li>
		</c:if>
		<!--페이지 리스트-->
		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
		<li class="page-item"><a class="page-link" href="memberManage?pageNum=${i}&field=${field}&word=${word}">${i}</a></li>
		</c:forEach>
		<!-- 다음 -->
		<c:if test="${page.endPage < page.totPage}">
		<li class="page-item"><a class="page-link" href="memberManage?pageNum=${page.endPage + 1}&field=${field}&word=${word}">Next</a></li>
		</c:if>
		</ul>
	</div>	

		<form class="form" action="/admin/memberManage" id="searchFrm">
			<select name="field" class="form">
				<option value="" disabled selected>--</option>
				<option value="member_name" ${(field == 'member_name') ? 'selected' : ''}>아이디</option>
			</select> 
			<input type="text" class="form-control-search"
				placeholder="Enter Search" name="word" value="${word}">
			<button type="submit" class="btn btn-d btn-round">Search</button>
		</form>
	</div>
</div>	
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	// 체크박스 모두 선택
	$("#allCheck").change(function() {
		if(this.checked) {
			$(".chBox").prop("checked",true);
		}else {
			$(".chBox").prop("checked",false);
		}
	})
		
	$(".chBox").click(function(){
		$("#allCheck").prop("checked", false);
	});
	
	// 개별 회원 삭제
	$("#memDeleteBtn").click(function(){
		if(confirm("회원을 삭제합니다.")) {
			location.href="/admin/memberManage/${m.id}"
		}
	});
	
	// 선택 삭제
	$("#allMemDeleteBtn").click(function(){
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val) {
			var checkArr = new Array();
		
			$("input[class='chBox']:checked").each(function(){
				checkArr.push($(this).attr("data-id"));
			});
			//alert("==========checkArr" + checkArr);
			$.ajax({
				"url" : "/admin/memberManage/mDeleteAll",
				"type" : "post",
				"data" : { chbox : checkArr },
				success : function(){
					location.href = "memberManage";
				}
			});
		} 
	});
});
</script>

<%@ include file="../include/footer.jsp" %>