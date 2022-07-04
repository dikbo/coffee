<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<section class="module">
  <div class="container">
    <div class="row">
      <div class="col-sm-8 col-sm-offset-2">
      <h2>리뷰 작성</h2>
        <hr class="divider-w mt-10 mb-20">
        <div class="tab-pane" id="reviews">
           <div class="comment-form mt-30">
             <h4 class="comment-form-title font-alt">상품명:${product.product_name}</h4>
             <form method="post" action="/rRegist">
             <input type="hidden" name="order_id" value="${order_id}">
             <input type="hidden" name="member_id" value="${member_id}">
             <input type="hidden" name="product_id" value="${product.product_id}">
               <div class="row">
                 <div class="col-sm-4">
                   <div class="form-group">
                     <select class="form-control" id="rating" name="rating">
                       <option selected="true" disabled="">Rating</option>
                       <option value="1">1</option>
                       <option value="2">2</option>
                       <option value="3">3</option>
                       <option value="4">4</option>
                       <option value="5">5</option>
                     </select>
                   </div>
                 </div>
                 <div class="col-sm-12">
                   <div class="form-group">
                     <textarea class="form-control" id="content" name="content" rows="10" placeholder="리뷰를 작성해주세요."></textarea>
                   </div>
                 </div>
                 <div class="col-sm-12">
                   <button class="btn btn-round btn-d" id="reviewRegBtn" type="submit">리뷰 작성</button>
                 </div>
               </div>
             </form>
           </div>
         </div>
        
       </div>
     </div>
  </div>
</section>   

<script>

</script>

<%@ include file="../include/footer.jsp" %>