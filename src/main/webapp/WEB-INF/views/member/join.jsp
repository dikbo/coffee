<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/resources/js/addressapi.js"></script>
</head>
<section class="module">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<h1>회원가입</h1>
				<hr class="divider-w mt-10 mb-20">
				<form class="form" role="form"
					action="<c:url value='/member/join'/>" method="post">
					<div class="form-group">
						<label>아이디:</label> <input class="form-control" id="member_id"
							name="member_id" type="text" placeholder="아이디 입력" />
						<button class="btn btn-d btn-round" type="button" id="idUseBtn"
							onclick="idCheck()">중복 확인</button>
					</div>
					<div class="form-group">
						<label>비밀번호:</label> <input class="form-control" id="password"
							name="password" type="password" placeholder="비밀번호 확인" />
					</div>
					<div class="form-group">
						<label>비밀번호 확인:</label> <input class="form-control"
							id="password_Check" name="password_Check" type="password"
							placeholder="비밀번호 재확인" />
					</div>
					<div class="form-group">
						<label>이름:</label> <input class="form-control" id="member_name"
							name="member_name" type="text" placeholder="이름을 입력하세요." />
					</div>
					<div class="form-group">
						<label>연락처:</label> <input class="form-control" id="member_phone"
							name="member_phone" type="text" placeholder="전화번호를 입력하세요." />
					</div>
					<div class="form-group">
						<label>email:</label> <input class="form-control" id="email"
							name="email" type="text" placeholder="이메일을 입력하세요." />
							<button class="btn btn-d btn-round" type="button" id="emailUseBtn"
							onclick="emailCheck()">중복 확인</button>
					</div>
					
<!-- 					<div class="form-group"> -->
<!-- 						<label>주소:</label> <input class="form-control" id="member_addr1" -->
<!-- 							name="member_addr1" type="text" placeholder="주소를 입력하세요." /> <input -->
<!-- 							class="form-control" id="member_addr2" name="member_addr2" -->
<!-- 							type="text" placeholder="상세주소를 입력하세요." /> <input -->
<!-- 							class="form-control" id="member_addr3" name="member_addr3" -->
<!-- 							type="text" placeholder="우편번호를 입력하세요." /> -->
<!-- 					</div> -->
					<div class="form-group">
						<label>우편번호:</label>
								<input type="text" id="member_addr1" name="member_addr1" placeholder="우편번호" class="form-control" readonly="readonly">
								<input type="button" onclick="execPostCode();" value="주소검색" class="btn btn-d btn-round" />
							</div>
							<div class="form-group">
							<label>주소:</label>
								<input type="text" id="member_addr2"  name="member_addr2" placeholder="도로명주소" class="form-control" readonly="readonly">
							
								<input type="text" id="member_addr3"  name="member_addr3" placeholder="상세주소" class="form-control">
							</div>

<!-- 					<div class="form-group"> -->
<!-- 						<label for="role">role:</label> <select class="form-control" -->
<!-- 							id="role" name="role"> -->
<!-- 							<option value="ROLE_USER">USER</option> -->
<!-- 						</select> -->
<!-- 					</div> -->

				</form>
				<button class="btn btn-d btn-round" id="submit" disabled="disabled"
					onclick="joinCheck()">회원가입</button>
			</div>
		</div>
	</div>
</section>
<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=member_addr1]").val(data.zonecode);
           $("[name=member_addr2]").val(fullRoadAddr);
           
            document.getElementById('member_addr1').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('member_addr2').value = fullRoadAddr;
       }
    }).open();
}



</script>
<%@ include file="../include/footer.jsp"%>