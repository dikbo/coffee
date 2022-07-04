<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<section class="module">
  <div class="container">
    <div class="row">
      <div class="col-sm-8 col-sm-offset-2">
      <h2>상품 등록</h2>
        <hr class="divider-w mt-10 mb-20">
        <form id="product_form" class="form" role="form" action="/admin/pUpdate" method="post" enctype="multipart/form-data">
         <div class="form-group">
          <label>상품명:</label>
          <input type="hidden" name="product_id" id="product_id" value="${product.product_id}"/>
            <input class="form-control" type="text"  id="product_name" name="product_name" value="${product.product_name}"/>
          </div>
          <div class="form-group">
           <label>카테고리:</label>
            <select class="category1" id="category_code">
            	<option value="">전체</option>
            </select>
            <select class="category2" name="category_code" id="category_code">
            	<option value="">전체</option>
            </select>
          </div>
          <div class="form-group">
           <label>가격:</label>
            <input class="form-control" type="text"  id="product_price" name="product_price" value="${product.product_price}"/>
          </div>
          <div class="form-group">
           <label>상품 정보:</label>
            <textarea class="form-control" rows="7"  id="product_des" name="product_des">${product.product_name}</textarea>
          </div>
          <div class="form-group">
		    <label for="fileUpload">상품 이미지:</label>
		    <input type="file" class="form-control" id="product_img" name="uploadFile" multiple>
		    <input type="hidden" name="product_img" value="${product.product_img}">
		    <div class="select_img"><img src=""></div>
          </div>
          <div class="form-group">
           <label>맛: </label>
           <div>
            초콜릿<input type="checkbox" name="product_taste" value="초콜릿" id="product_taste"/>&emsp;
            부드러움<input type="checkbox" name="product_taste" value="부드러움" id="product_taste"/>&emsp;
            과일<input type="checkbox" name="product_taste" value="과일" id="product_taste"/>&emsp;
            고소함<input type="checkbox" name="product_taste" value="고소함" id="product_taste"/>&emsp;
            쌉쌀함<input type="checkbox" name="product_taste" value="쌉쌀함" id="product_taste"/>
          	</div>
          </div>
          <div class="form-group">
           <label>원산지: </label>
           <div>
            브라질<input type="checkbox" name="product_origin" value="브라질" id="product_origin"/>&emsp;
            콜롬비아<input type="checkbox" name="product_origin" value="콜롬비아" id="product_origin"/>&emsp;
            에티오피아<input type="checkbox" name="product_origin" value="에티오피아" id="product_origin"/>&emsp;
            과테말라<input type="checkbox" name="product_origin" value="과테말라" id="product_origin"/>&emsp;
            자메이카<input type="checkbox" name="product_origin" value="자메이카" id="product_origin"/>
          	</div>
          </div>
          	<button type="submit" class="btn btn-d btn-round" id="productRegBtn">수정</button>
        	<button type="button" class="btn btn-d btn-round" id="adminProductListBtn" onclick="location.href='/admin/adminProductList'">목록으로</button>
        </form>
      </div>
    </div>
  </div>
</section> 


<%@ include file="../include/footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
var jsonData = JSON.parse('${category}');
console.log(jsonData);

var cate1Arr = new Array();
var cate1Obj = new Object();

// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
for(var i = 0; i < jsonData.length; i++) {
 
if(jsonData[i].categorycode_ref == "") {
  cate1Obj = new Object();  //초기화
  cate1Obj.category_code = jsonData[i].category_code;
  cate1Obj.category_name = jsonData[i].category_name;
  cate1Arr.push(cate1Obj);
 }
}

// 1차 분류 셀렉트 박스에 데이터 삽입
var cate1Select = $("select.category1")

for(var i = 0; i < cate1Arr.length; i++) {
 cate1Select.append("<option value='" + cate1Arr[i].category_code + "'>"
      + cate1Arr[i].category_name + "</option>"); 
}


//2차분류
$(document).on("change", "select.category1", function(){

	 var cate2Arr = new Array();
	 var cate2Obj = new Object();
	 
	 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	 for(var i = 0; i < jsonData.length; i++) {
	  
	  if(jsonData[i].categorycode_ref != "" ) {
	   cate2Obj = new Object();  
	   cate2Obj.category_code = jsonData[i].category_code;
	   cate2Obj.category_name = jsonData[i].category_name;
	   cate2Obj.categorycode_ref = jsonData[i].categorycode_ref;
	   
	   cate2Arr.push(cate2Obj);
	  }
	 }


	 var cate2Select = $("select.category2");
	 cate2Select.children().remove();

	 $("option:selected", this).each(function(){
	  
	  var selectVal = $(this).val();  
	  cate2Select.append("<option value='" + selectVal + "'>전체</option>");
	  
		for(var i = 0; i < cate2Arr.length; i++) {
			if(selectVal == cate2Arr[i].categorycode_ref) {
				cate2Select.append("<option value='" + cate2Arr[i].category_code + "'>"
				     + cate2Arr[i].category_name + "</option>");
	    	}
		} 
	});
});

// 썸네일
$("#product_img").change(function(){
	   if(this.files && this.files[0]) {
	    var reader = new FileReader;
	    reader.onload = function(data) {
	     $(".select_img img").attr("src", data.target.result).width(100);        
	    }
	    reader.readAsDataURL(this.files[0]);
	   }
	  });


$(function() {
	$('#productRegBtn').click(function() {
		if (!$('#product_name').val()) {
			alert('상품명을 입력하세요');
			$('#product_name').focus();
			return false;
		}
		if (!$('#category_code').val()) {
			alert('카테고리를 선택하세요');
			return false;
		}
		if (!$('#product_price').val()) {
			alert('가격을 입력하세요');
			$('#product_price').focus();
			return false;
		}
		if (!$('#product_des').val()) {
			alert('상품 정보를 입력하세요');
			$('#product_des').focus();
			return false;
		}
		if ($("input:checkbox[name='product_taste']").is(":checked") == false) {
			alert('맛을 선택하세요');
			return false;
		}
		if ($("input:checkbox[name='product_origin']").is(":checked") == false) {
			alert('원산지를 선택하세요');
			return false;
		}
		/* 
		$('#product_form').submit(); */
	});
});
</script> 