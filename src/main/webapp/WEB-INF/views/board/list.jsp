<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<%@ include file="../include/header.jsp"%>


<div class="main">
	<section class="module bg-dark-60 shop-page-header"
		data-background="/images/coffeeshop/productlist1.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Coffee</h2>
					<div class="module-subtitle font-serif">엄선된 원두와 수천 번의 테스팅을 통해 완성된 다양한 옵션의<br>Titan 시그니처 블렌드를 둘러보세요</div>
				</div>
			</div>
		</div>
	</section>
	<section class="module-small">
		<div class="container">
			<form class="row" method="post" action="/board/list/cate">
				<div class="col-sm-3">
					<button class="btn btn-block btn-round btn-g" type="button" name="category_code" value="101" onclick="location.href='/board/list/cate?cate=101'">원두커피 (오리지널)</button>
				</div>
				<div class="col-sm-3">
					<button class="btn btn-block btn-round btn-g" type="button" name="category_code" value="102" onclick="location.href='/board/list/cate?cate=102'">원두커피 (디카페인)</button>
				</div>
				<div class="col-sm-3">
					<button class="btn btn-block btn-round btn-g" type="button" name="category_code" value="201" onclick="location.href='/board/list/cate?cate=201'">콜드브루 (오리지널)</button>
				</div>
				<div class="col-sm-3">
					<button class="btn btn-block btn-round btn-g" type="button" name="category_code" value="202" onclick="location.href='/board/list/cate?cate=202'">콜드브루 (디카페인)</button>
				</div>
			</form>
		</div>
	</section>
</div>
<hr class="divider-w">


<!-- Start Best Seller -->
<section class="module-small">
	<div class="container">
		<div class="row multi-columns-row">
			<!-- single product -->
			<c:forEach items="${list}" var="list">
			<div class="col-sm-6 col-md-4 col-lg-4">
				<div class="shop-item">
				<input type="hidden" id="product_id" value="${list.product_id}">
					<div class="shop-item-image"><img src="/resources/productImg/${list.product_img}" alt="" onclick="href='productDetail?product_id=${list.product_id}'"/>
                  </div>
                  <h2 class="shop-item-title font-alt"><a href="/board/productDetail?product_id=${list.product_id}&pageNum=${page.currentPage}&field=${field}&word=${word}">${list.product_name}</a></h2>
                  <h5><fmt:formatNumber value="${list.product_price}" pattern="###,###,###" />원</h5>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</section>
<!-- End Best Seller -->
<section class="module-small">	
<div class="container">	
	<div class="col-sm-8 col-sm-offset-2 paginationblock">
	<div>
		<ul class="pagination ">
		<!-- 이전 -->
		<c:if test="${page.startPage > page.blockSize}">
		<li class="page-item"><a class="page-link" href="/board/list?pageNum=${page.startPage - page.blockSize}&field=${field}&word=${word}">Previous</a></li>
		</c:if>
		<!--페이지 리스트-->
		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
		<li class="page-item"><a class="page-link" href="list?pageNum=${i}&field=${field}&word=${word}">${i}</a></li>
		</c:forEach>
		<!-- 다음 -->
		<c:if test="${page.endPage < page.totPage}">
		<li class="page-item"><a class="page-link" href="list?pageNum=${page.endPage + 1}&field=${field}&word=${word}">Next</a></li>
		</c:if>
		</ul>
	</div>
		<form class="form" action="/board/list" id="searchFrm">
			<select name="field" class="form">
				<option value="" disabled selected>--</option>
				<option value="product_name"
					${(field == 'product_name') ? 'selected' : ''}>제품명</option>
				<option value="product_origin"
					${(field == 'product_origin') ? 'selected' : ''}>원산지</option>
			</select> 
			<input type="text" class="form-control-search"
				placeholder="Enter Search" name="word" value="${word}">
			<button type="submit" class="btn btn-d btn-round">Search</button>
		</form>
	</div>
</div>	
</section>

<%@ include file="../include/footer.jsp"%>

<!-- js -->
<jsp:include page="../include/js.jsp" />

<script>

</script>

