<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>



<section class="module">
	<div class="container">
		<div class="row">
			<div>
				<h2>Your Taste is...</h2>
				<hr class="divider-w mt-10 mb-20">
				   
				<c:forEach items="${testlist}" var="t">
					<div class="col-sm-6 col-md-4 col-lg-4">
					<div class="shop-item">
					<div class="shop-item-image">
						<img src="/resources/productImg/${t.product_img}" alt="Accessories Pack" onclick="location.href='/board/productDetail?product_id=${t.product_id}'"/>
					</div>
					<h4 class="shop-item-title font-alt"><a href="/board/productDetail?product_id=${t.product_id}">${t.product_name}</a></h4>
					<fmt:formatNumber value="${t.product_price}" pattern="###,###,###"/>원
					</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<section class="module-small">
  <div class="container">
    <div class="col-sm-8 col-sm-offset-2 paginationblock">
      	<div>
      		<button class="btn btn-d btn-round" type="button" onclick="location.href='/board/list'">다양한 커피 더보기</button>
    	</div>	
    </div>
  </div>
</section>

<%@ include file="include/footer.jsp" %>