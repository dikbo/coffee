<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="include/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="initial-scale=1.0, width=device-width">
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="/css/coffeetest.css">
</head>
<body>
	<section>
		<div>
			<button type="button" class="backToIndexBtn" onclick="location.href='/index'">MAIN</button>
		</div>
		<div id="coffee_test">
		    <div id="test">
			    <div id="intro" class="intro-wrap">
			        <div class="intro">
			        	<div class="title-wrap">
				            <h2 class="title">
				                나에게 어울리는 커피를 찾고 싶으신가요?<br>
				                몇 가지 질문으로 원하는 커피를 찾아드릴게요.<br><br>
				            </h2>
				        </div>
			            <div class="intro-story">
			            	<button type="button" class="startTestBtn" v-on:click="start" style="cursor:pointer;">테스트를 시작합니다</button>
			            </div>
			        </div>
			    </div>
		    
		    <form id="coffee_test_form" action="testResult" method="post">
			    <div id="main1">
				    <div class="main-wrap">
				        <div class="question-wrap">
				            <h3 class="question">
				                어떤 방식으로 내린 커피를 선호하시나요?
				            </h3>
				        </div>
				        <div class="answer-wrap">
				            <div class="answer">
				                 <input type="radio" name="categorycode_ref" id="categorycode_ref" value="100">핸드드립 혹은 에스프레소 &emsp;
								 <input type="radio" name="categorycode_ref" id="categorycode_ref" value="200">차가운 물로 커피를 내린 콜드브루
				            </div>
				        </div>
				        <div class="bottom">
				            <div class="controller-wrap">
				                <button type="button" class='prev-btn' v-on:click="retr">처음으로</button>
				                <button type="button" class='next-btn' v-on:click="next">다음</button>
				            </div>
				        </div>
				    </div>    
			    </div>
			    
			  	<div id="main2">
				    <div class="main-wrap">
				
				        <div class="question-wrap">
				            <h3 class="question">
				                어떤 스타일의 커피 원두를 선호하시나요?
				            </h3>
				        </div>
				        <div class="answer-wrap">
				            <div class="answer">
				                 <input type="radio" name="product_origin" id="product_origin" value="브라질">다른 커피와도 잘 어울리는 원두<br>
								 <input type="radio" name="product_origin" id="product_origin" value="콜롬비아">세계 1위 품질의 믿을 수 있는 원두<br>
								 <input type="radio" name="product_origin" id="product_origin" value="과테말라">화산지대에서 재배된 스모키한 향의 원두<br>
								 <input type="radio" name="product_origin" id="product_origin" value="자메이카">영국 왕실에서 선택한, 여러가지 맛이 함께 어우러지는 원두<br>
								 <input type="radio" name="product_origin" id="product_origin" value="에티오피아">쓴맛이 부담스러운 당신을 위한 원두
				            </div>
				        </div>
				        <div class="bottom">
				            <div class="controller-wrap">
				                <button type="button" class='prev-btn' v-on:click="retr">처음으로</button>
				                <button type="button" class='next-btn' v-on:click="next2">다음</button>
				            </div>
				        </div>
				    </div>    
			    </div>
			    
			    <div id="main3">
				    <div class="main-wrap">
				
				        <div class="question-wrap">
				            <h3 class="question">
				                어떤 맛을 선호하시나요?
				            </h3>
				        </div>
				        <div class="answer-wrap">
				            <div class="answer">
				                 <input type="radio" name="product_taste" id="product_taste" value="초콜릿">초콜릿처럼 달콤한 맛<br>
								 <input type="radio" name="product_taste" id="product_taste" value="부드러움">깊고 부드러운 맛<br>
								 <input type="radio" name="product_taste" id="product_taste" value="과일">상큼하고 산미 있는 맛<br>
								 <input type="radio" name="product_taste" id="product_taste" value="고소함">고소한 향과 맛<br>
								 <input type="radio" name="product_taste" id="product_taste" value="쌉쌀함">혀끝에 남는 쌉쌀한 맛<br>
				            </div>
				        </div>
				        <div class="bottom">
				            <div class="controller-wrap">
				                <button type="button" class='prev-btn' v-on:click="retr">처음으로</button>
				                <button type="button" class='next-btn' v-on:click="next3">다음</button>
				            </div>
				        </div>
				    </div>    
			    </div>
			    
			    <div id="main4">
				    <div class="main-wrap">
				
				        <div class="question-wrap">
				            <h3 class="question">
				                카페인 함량은 괜찮으신가요?
				            </h3>
				        </div>
				        <div class="answer-wrap">
				            <div class="answer" id="cate100">
				                 <input type="radio" name="category_code" id="category_code" value="101">카페인도 괜찮아요 &emsp;
								 <input type="radio" name="category_code" id="category_code" value="102">카페인은 부담스러워요<br>		
				            </div>
				            <div class="answer" id="cate200">
				                 <input type="radio" name="category_code" id="category_code" value="201">카페인도 괜찮아요 &emsp;
								 <input type="radio" name="category_code" id="category_code" value="202">카페인은 부담스러워요<br>		
				            </div>
				        </div>
				        <div class="bottom">
				            <div class="controller-wrap">
				                <button type="button" class='prev-btn' v-on:click="retr">처음으로</button>
				                <button type="button" class='next-btn' v-on:click="next4">다음</button>
				            </div>
				        </div>
				    </div>    
			    </div>			    
		  
		        <div id="result" class="result-wrap">
		            <div class="result"><h3>당신을 위한 커피는...</h3><br>
		            <button type="submit" class="goToResultBtn">확인하러 가기</button></div>
		        </div>
		        </form>
		    </div>
		</div>
	</section>
	
<script src="/js/coffeetest.js"></script>
<script type="text/javascript">

/* var value = $('input[name="categorycode_ref"]:checked').val();

if(value == '100') {
	$('#cate100').show();
	$('#cate200').hide();
}else if(value == '200') {
	$('#cate100').hide();
	$('#cate200').show(); 
} */

</script>

<%-- <%@ include file="include/footer.jsp" %> --%>
</body>
</html>