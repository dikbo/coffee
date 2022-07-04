<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
    
<section class="module">
  <div class="container">  
    <div class="row">
      <div>
      <h2>상품 관리<small>(${count})</small></h2>
        <hr class="divider-w mt-10 mb-20">
        <form class="form" role="form" method="post" action="/admin/memberManage/delete">
			
			<table class="table table-border checkout-table">
				<tbody>
					<tr>
						<th><input type="checkbox" id="allCheck" name="allCheck"></th>
						<th>카테고리</th>
						<th>상품명</th>
						<th>가격</th>
						<th>원산지</th>
						<th>특징</th>
						<th></th>
					</tr>
					<c:forEach items="${plist}" var="p">
					<tr>
						<td><input type="checkbox" data-product_id="${p.product_id}" class="chBox" name="chBox"></td>
						<td>${p.category_code}</td>
						<td><a href="/board/productDetail?product_id=${p.product_id}&pageNum=${page.currentPage}&field=${field}&word=${word}">${p.product_name}</a></td>
						<td>${p.product_price}</td>
						<td>${p.product_origin}</td>
						<td>${p.product_taste}</td>
						<td>
						<input type="button" id="pDeleteBtn" class="btn btn-d btn-round" onclick="location.href='/admin/adminProductList/delete/${p.product_id}'" value="삭제">
						<input type="button" id="pDeleteBtn" class="btn btn-d btn-round" onclick="location.href='/admin/productUpdate/${p.product_id}'" value="수정">
						</td>	
					</tr>
					</c:forEach>
				</tbody>
			</table>	
			<hr class="divider-w mt-10 mb-20">
          <button id="allPDeleteBtn" class="btn btn-d btn-round" type="button">선택 상품 삭제</button>
          <button class="btn btn-d btn-round" type="button" onclick="location.href='/admin/productRegist'">상품 등록</button>
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
			<li class="page-item"><a class="page-link" href="/admin/adminProductList?pageNum=${page.startPage - page.blockSize}&field=${field}&word=${word}">Previous</a></li>
			</c:if>
			<!--페이지 리스트-->
			<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
			<li class="page-item"><a class="page-link" href="adminProductList?pageNum=${i}&field=${field}&word=${word}">${i}</a></li>
			</c:forEach>
			<!-- 다음 -->
			<c:if test="${page.endPage < page.totPage}">
			<li class="page-item"><a class="page-link" href="adminProductList?pageNum=${page.endPage + 1}&field=${field}&word=${word}">Next</a></li>
			</c:if>
			</ul>
		</div>	
	
			<form class="form" action="/admin/adminProductList" id="searchFrm">
				<select name="field" class="form">
					<option value="" disabled selected>--</option>
					<option value="product_name" ${(field == 'product_name') ? 'selected' : ''}>상품명</option>
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

$("#allCheck").click(function(){
	var chk = $("#allCheck").prop("checked");
	if(chk) {
		$(".chBox").prop("checked", true);
	} else {
		$(".chBox").prop("checked", false);
	}
});

$(".chBox").click(function(){
	$("#allCheck").prop("checked", false);
});

// 선택 삭제
$("#allPDeleteBtn").click(function(){
	var confirm_val = confirm("정말 삭제하시겠습니까?");
	
	if(confirm_val) {
		var checkArr = new Array();
		
		$("input[class='chBox']:checked").each(function(){
			checkArr.push($(this).attr("data-product_id"));
		});
		$.ajax({
			"url" : "/admin/adminProductList/pDeleteAll",
			"type" : "post",
			"data" : { chbox : checkArr },
			success : function(){
				location.href = "adminProductList";
			}
		});
	} 
});
</script>
<%@ include file="../include/footer.jsp" %>