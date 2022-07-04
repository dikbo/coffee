<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<section class="module">
	  <div class="container">
	    <div class="row">
	      <input type="hidden" id="product_id" name="product_id" value="${product.product_id}">
	      <div class="col-sm-6 mb-sm-40"><a class="gallery" href="/resources/productImg/${product.product_img}"><img src="/resources/productImg/${product.product_img}" alt="Single Product Image"/></a>
	        <ul class="product-gallery">
	          <li><a class="gallery" href="/resources/productImg/${product.product_img}"></a><img class="img-fluid" src="/resources/productImg/${product.product_img}" alt="">
	          </ul>
	      </div>
	      <div class="col-sm-6">
	      	<div class="row mb-20">
	          <div class="col-sm-12">
	            <div class="product_meta">Categories > <a href="#"> ${cate1.category_name} </a> > <a href="#"> ${cate2.category_name} </a>
	            </div>
	          </div>
	        </div>
	        <div class="row">
	          <div class="col-sm-12">
	            <h1 class="product-title font-alt">${product.product_name}</h1>
	          </div>
	        </div>
	        <div class="row mb-20">
	          <div class="col-sm-12"><span>${avg}<i class="fa fa-star star"></i></span><a class="open-tab section-scroll"> - ${count} customer reviews</a>
	          </div>
	        </div>
	        <div class="row mb-20">
	          <div class="col-sm-12">
	            <div class="price font-alt"><span class="amount"><fmt:formatNumber value="${product.product_price}" pattern="###,###,###"/>원</span></div>
	          </div>
	        </div>
	        <div class="row mb-20">
	          <div class="col-sm-12">
	            <div class="description">
	              <p>${product.product_des}</p>
	              
	            </div>
	          </div>
	        </div>
	        <div class="row mb-20">
	          <div class="col-sm-4 mb-sm-20">
	            <input class="form-control input-lg" type="number" name="qty" id="sst" value="1" max="40" min="1" required="required"/>
	          </div>
	          <div class="col-sm-8"><a class="btn btn-lg btn-block btn-round btn-b" href="#" id="cartBtn">Add To Cart</a></div>
	        </div>
	      </div>
	    </div>
	    
	    
	    <div class="row mt-70">
	      <div class="col-sm-12">
	        <div class="tab-title-border">
	        <div class="tab-title"><a href="#description" ><span class="icon-tools-2"></span>&emsp;Description</a></div>
	        </div>
	        <div class="tab-content">
	          <div class="tab-pane active" id="description">
	            <p>${product.product_des}</p>
	          </div>
	          
	          <div class="tab-title-border">
	          <div class="tab-title"><a href="#data-sheet" ><span class="icon-tools-2"></span>&emsp;Data sheet</a></div>
	          </div>
	          <div class="tab-pane active" id="data-sheet">
	            <table class="table table-striped ds-table ">
	              <tbody>
	                <tr>
	                  <th>Title</th>
	                  <th>Info</th>
	                </tr>
	                <tr>
	                  <td>제품명</td>
	                  <td>${product.product_name}</td>
	                </tr>
	                <tr>
	                  <td>원산지</td>
	                  <td>${product.product_origin}</td>
	                </tr>
	                <tr>
	                  <td>카테고리</td>
	                  <td>${cate1.category_name} > ${cate2.category_name}</td>
	                </tr>
	                <tr>
	                  <td>특징</td>
	                  <td>${product.product_des}</td>
	                </tr>
	              </tbody>
	            </table>
	          </div>
	          
	          <div class="tab-title-border">
	          <div class="tab-title"><a href="#reviews" ><span class="icon-tools-2"></span>&emsp;Reviews(${count})</a></div>
	          </div>
	          <div class="tab-pane active" id="reviews">
	            <div class="comments reviews">
	            <c:forEach items="${review}" var="r">
	              <div class="comment clearfix">
	                <div class="comment-content clearfix">
	                  <div class="comment-author font-alt">${r.member_id}</div>
	                  <div class="comment-body">
	                    <p>${r.content}</p>
	                  </div>
	                  <div class="comment-meta font-alt"><span><i class="fa fa-star star"></i>&emsp;<Strong>${r.rating}</Strong> </span>
	                  </div>
	                </div>
	              </div>
	              <hr class="divider-w mt-10 mb-20">
	              </c:forEach>
	            </div>
	            <section class="module-small">
					<div class="container">
						<div class="col-sm-8 col-sm-offset-2 paginationblock">
						<div>
							<ul class="pagination">
							<!-- 이전 -->
							<c:if test="${page.startPage > page.blockSize}">
							<li class="page-item"><a class="page-link" href="/board/productDetail?product_id=${product.product_id}&pageNum=${pageNum}&rePageNum=${page.startPage - page.blockSize}#reviews">Previous</a></li>
							</c:if>
							<!--페이지 리스트-->
							<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
							<li class="page-item"><a class="page-link" href="productDetail?product_id=${product.product_id}&pageNum=${pageNum}&rePageNum=${i}#reviews">${i}</a></li>
							</c:forEach>
							<!-- 다음 -->
							<c:if test="${page.endPage < page.totPage}">
							<li class="page-item"><a class="page-link" href="productDetail?product_id=${list.product_id}&pageNum=${pageNum}&rePageNum=${page.endPage + 1}#reviews">Next</a></li>
							</c:if>
							</ul>
						</div>
						</div>
					</div>
				</section>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
        
<%@ include file="../include/footer.jsp" %>

<script>
	//카트담기
	$("#cartBtn").click(function(){
		var product_id = $("#product_id").val();
		var qty = $("#sst").val();
		var data = {
				product_id : product_id,
				qty : qty 
				};
	
		$.ajax({
			url : "/addCart",
			type : "post",
			data : data,
			success : function(result){
				if(result==1){
					alert("상품을 장바구니에 담았습니다");
					$("#sst").val("1");
				}else if(result==2){
					alert("이미 장바구니에 담았습니다");
				}else{
					alert("로그인 해주세요");
				} 
			}, 
			error : function(){
				alert("장바구니에 담는데 실패했습니다.");
			}
		});
	});
</script>