<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/resources/js/addressapi.js"></script>

<section class="module">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<h2>회원 정보수정</h2>
				<hr class="divider-w mt-10 mb-20  ">

				<form action="/member/memberUpdateView" method="post" name=frm1 id="frm1">
					<div class="form-group">
						<label>아이디:</label> <input class="form-control" id="member_id"
							name="member_id" type="text" value="${member.member_id }"
							readonly="readonly" />
					</div>
					<div class="form-group">
						<label>새로운 비밀번호:</label> <input class="form-control" id="password"
							name="password" type="password" placeholder="변경할 비밀번호를 입력하세요." />
					</div>
<%-- 					<input type="hidden" id="pw" value="${member.password }"> --%>
<!-- 					<div class="form-group"> -->
<!-- 						<label>새로운 비밀번호:</label> <input class="form-control" -->
<!-- 							id="nowpassword" name="nowpassword" type="password" -->
<!-- 							placeholder="수정할 비밀번호를 입력하세요." /> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label>새로운 비밀번호 확인:</label> <input class="form-control" -->
<!-- 							id="nowpassword2" name="nowpassword2" type="password" -->
<!-- 							placeholder="수정할 비밀번호를 재입력하세요." /> -->
<!-- 					</div> -->

					<div class="form-group">
						<label>이름:</label> <input class="form-control" id="member_name "
							name="member_name" type="text"
							placeholder="${member.member_name}" />
					</div>
					<div class="form-group">
						<label>연락처:</label> <input class="form-control" id="member_phone "
							name="member_phone" type="text"
							placeholder="${member.member_phone}" />
					</div>
					<div class="form-group">
						<label>이메일:</label> <input class="form-control" id="email "
							name="email" type="text" placeholder="${member.email}"
							readonly="readonly" />
					</div>
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
					<button class="btn btn-d btn-round" type="submit"
						id="memberUpdateBtn" onclick="updateCheck()">수정하기</button>
					<button class="btn btn-d btn-round" type="button" id="#"
						onclick="cancel()">취소하기</button>
					<button class="btn btn-d btn-round" type="button"
						id="memberDeleteBtn" onclick="idDelete()">회원탈퇴</button>
				</form>


			</div>
		</div>
	</div>
</section>


<script type="text/javascript">
	function updateCheck() {
		if (confirm("정말 수정하시겠습니까?")) {
			alert("수정이 처리되었습니다.");
			location.href = "/index";
		}
// 		if ($("#password").val() != $("pw").val()) {
// 			alert("기존비밀번호가 일치하지 않습니다.");
// 			$("#password").focus();
// 			return false;
// 		}

// 		if ($("#nowpassword").val() != $("#nowpassword2").val()) {
// 			alert("새비밀번호가 일치하지 않습니다.");
// 			$("#nowpassword").focus();
// 			return false;
// 		}
	}

	function idDelete() {
		$.ajax({
			async : true,
			type : 'POST',
			data : idDelete,
			url : "/member/memberDelete",
			dataType : "text",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				if (confirm("정말 탈퇴하시겠습니까?")) {
					alert("탈퇴가 처리되었습니다.");
					location.href = "/index";
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("ERROR : " + textStatus + " : " + errorThrown);
			}
		})

	}
	function cancel() {
		if (confirm("메인페이지로 돌아가시겠습니까?")) {
			location.href = "/index";
		}
	}

	// $(document).ready(function(){
	//     $("#memberUpdateBtn").click(function(){
	//         // 태크.val() : 태그에 입력된 값
	//         // 태크.val("값") : 태그의 값을 변경 
	//         var password = $("#password").val();
	//         var member_name = $("#member_name").val();
	//         var member_addr1 = $("#member_addr1").val();
	//         var member_addr2 = $("#member_addr2").val();
	//         var member_addr3 = $("#member_addr3").val();
	//         var email = $("#email").val();
	//         var role = $("#role").val();
	//         var member_phone = $("#member_phone").val();
	//         // 폼 내부의 데이터를 전송할 주소
	//         document.frm1.action="memberUpdateView"
	//         // 제출
	//         document.frm1.submit();
	//         location.href="/member/login"
	//     });

	// });

	// $(document).ready(function(){
	// 	$("#memberUpdateBtn").click(function(){

	// 	var data2 = {
	// 		"name": $("#name").val(),
	// 		"pass": $("#pass").val(),
	// 		"addr": $("#addr").val()
	// 	}
	// 	$.ajax({
	// 		type:"post",
	// 		url: "/member/memberUpdate",
	// 		contentType:"application/json;charset=utf-8",
	// 		data:JSON.stringify(data2)
	// 	})
	// 	.done(function(res){
	// 		if(res=="success"){
	// 			alert("회원수정에 성공했습니다.");
	// 			location.href="login";
	// 		}
	// 	}
	// })

	// })
	// });
	
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
