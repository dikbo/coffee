<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<section class="module">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<h1>로그인</h1>
				<hr class="divider-w mt-10 mb-20">
				<form class="form" role="form"
					action="<c:url value='/member/loginProc' />" method="post"
					name="form1">
					<div class="form-group">
						<label>아이디:</label> <input class="form-control" type="text"
							id="member_id" name="member_id" placeholder="아이디 입력" />
					</div>
					<div class="form-group">
						<label>비밀번호:</label> <input class="form-control" type="password"
							id="password" name="password" placeholder="비밀번호 입력" />
					</div>
					 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button class="btn btn-d btn-round" type="submit" id="loginCheck">로그인</button>					
				</form>
				
			</div>
		</div>
	</div>
</section>

<script>
    $(document).ready(function(){
    	$("loginCheck").click(fuction(){
    		var member_id = $("#member_id").val();
    		var password = $("#password").val();
    		if(member_id == ""){
             alert("아이디를 입력하세요.");
             $("#member_id").focus(); // 입력포커스 이동
             return; // 함수 종료
         }
         if(password == ""){
             alert("비밀번호를 입력하세요.");
             $("#password").focus();
             return;
         }
         
    		
    	})
    	
    	
//         $("#btnLogin").click(function(){
//             // 태크.val() : 태그에 입력된 값
//             // 태크.val("값") : 태그의 값을 변경 
//             var member_id = $("#member_id").val();
//             var password = $("#password").val();
            
//             if(member_id == ""){
//                 alert("아이디를 입력하세요.");
//                 $("#member_id").focus(); // 입력포커스 이동
//                 return; // 함수 종료
//             }
//             if(password == ""){
//                 alert("비밀번호를 입력하세요.");
//                 $("#password").focus();
//                 return;
//             }
//             // 폼 내부의 데이터를 전송할 주소
//             document.form1.action="${path}/member/loginForm"
//             // 제출
//             document.form1.submit();
//             location.href="/index";
//         });
//         function(res) {
// 			if (res == "success") {
// 				alert("로그인이 되었습니다.");
// 				location.href = "/member/loginForm";
// 			} else if (res == "no") {
// 				alert("회원이 아닙니다.");
// 				$("#member_id").val("")
// 			}
// 		}
    
//     });
</script>
<%@ include file="../include/footer.jsp"%>