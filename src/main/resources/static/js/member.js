function emailCheck(){
	var Email = $("#email").val();
	
	if(Email.search(/\s/) !=-1){
		alert("이메일에는 공백이 들어갈 수 없습니다.");
	}else{
		if(Email.trim().length != 0){
			$.ajax({
				async : true,
				type : 'POST',
				data : Email,
				url : "/member/emailCheck",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success: function(count){
					if(count > 0) {
                        alert("해당 이메일 존재");    
                        $("#submit").attr("disabled", "disabled");
                        window.location.reload();
                    } else {
                        alert("사용가능 이메일");
                        $("#submit").removeAttr("disabled");
                    }       
				},
				error: function(error) {
                    alert("이메일를 입력해주세요.");
                }        
			});
		} else {
            alert("이메일를 입력해주세요.");
		}
	}	
	
}

function idCheck() {
    
    var memberId = $("#member_id").val();
    
    if(memberId.search(/\s/) != -1) { 
        alert("아이디에는 공백이 들어갈 수 없습니다.");        
    } else {             
        if(memberId.trim().length != 0) {
            $.ajax({
                async : true, 
                type : 'POST', 
                data: memberId,
                url: "/member/idCheck",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                success: function(count) {    
                    if(count > 0) {
                        alert("해당 아이디 존재");    
                        $("#submit").attr("disabled", "disabled");
                        window.location.reload();
                    } else {
                        alert("사용가능 아이디");
                        $("#submit").removeAttr("disabled");
                    }            
                },
                error: function(error) {
                    alert("아이디를 입력해주세요.");
                }        
            });
        } else {
            alert("아이디를 입력해주세요.");
        }        
    }
}

function joinCheck(){
	if ($("#member_id").val() == "") {
			alert("아이디를 입력하세요");
			$("#member_id").focus();
			return false;
		}
		if ($("#password").val() == "") {
			alert("비밀번호를 입력하세요");
			$("#password").focus();
			return false;
		}
		if ($("#password_Check").val() == "") {
			alert("비밀번호를 입력하세요");
			$("#password_Check").focus();
			return false;
		}
		if ($("#password").val() != $("#password_Check").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#password").focus();
			return false;
		}
		if ($("#member_name").val() == "") {
			alert("이름을 입력하세요");
			$("#member_name").focus();
			return false;
		}

		if ($("#member_phone").val() == "") {
			alert("연락처를 입력하세요");
			$("#member_phone").focus();
			return false;
		}
		if ($("#email").val() == "") {
			alert("이메일를 입력하세요");
			$("#email").focus();
			return false;
		}
		if ($("#member_addr1").val() == "") {
			alert("주소를 입력하세요");
			$("#member_addr1").focus();
			return false;
		}
		if ($("#member_addr2").val() == "") {
			alert("상세주소를 입력하세요");
			$("#member_addr2").focus();
			return false;
		}

		if ($("#member_addr3").val() == "") {
			alert("우편번호를 입력하세요");
			$("#member_addr3").focus();
			return false;
		}
		if(confirm("회원가입을 하시겠습니까?"))
		alert("회원가입이 완료되었습니다.감사합니다.");
		$("form").submit();
}


//$(document).ready(function() {
//	//회원가입
//	
//	$("#btnJoin").click(function() {
//		
//		location.href="/member/loginForm";
//		var data = {
//			"member_id": $("#member_id").val(),
//			"password": $("#password").val(),
//			"member_name": $("#member_name").val(),
//			"email": $("#email").val(),
//			"member_phone": $("#member_phone").val(),
//			"member_addr1": $("#member_addr1").val(),
//			"member_addr2": $("#member_addr2").val(),
//			"member_addr3": $("#member_addr3").val(),
//
//		}
//		
//		$.ajax({
//			type: "post",
//			url: "/member/join",
//			contentType: "application/json;charset=utf-8",
//			data: JSON.stringify(data)
//		,success:function(){
//						alert("회원가입을 축하합니다.");
//						location.href = "/member/loginForm";
//					
//				}		
//		
//		})
	//})
//			.done(function(res) {
//				if (res == "success") {
//					alert("회원가입을 축하합니다");
//					location.href = "/member/loginForm";
//				} else if (res == "fail") {
//					alert("아이디 중복확인하세요");
//					$("#member_id").val("")
//				}
		//}
			
		





//	$("#idUseBtn").click(function(){
//			window.open("idCheck","","width=600 height=300")
//		})
//
	//id 중복확인,회원가입 유효성 체크
//	$("#idUseBtn").click(function() {
//		if ($("#member_id").val() == "") {
//			alert("아이디를 입력하세요");
//			return false;
//		}
//		$.ajax(
//			//json변환
//			{
//			type: "post",
//			url: "/member/idCheck",
//			dataType : "JSON",
//			data: { "member_id": $("#member_id").val() },
//			success: function(jesp) {
//				if (resp.trim() == "yes") {
//					alert("사용가능한 아이디입니다.");
//					$(opener.document).find("#member_id").val($("#member_id").val());
//					self.close();
//				} else {
//					alert("사용 불가능한 아이디입니다.");
//					$("#member_id").val("");
//					$("#member_id").focus();
//				}
//				if(jesp ==1){
//					alert("중복된 아이디 입니다.");
//				}else if(jesp==0){
//					$('#idCheck').attr("value","Y");
//					alert("사용 가능한 아이디입니다.")
//				}
//
//			},
//			error: function(e) {
//				alert("오류가 났습니다." + e);
//			}
//		})
//	})
//});




function del(userid) {
	if (confirm("정말 삭제할까요?")) {
		$.getJSON("userDelete",
			{ "userid": userid },
			function(resp) {
				var str = "";
				$.each(resp.jarr, function(key, val) {
					str += "<tr>";
					str += "<td>" + val.name + "</td>"
					str += "<td>" + val.userid + "</td>"
					str += "<td>" + val.phone + "</td>"
					str += "<td>" + val.email + "</td>"
					if (val.admin == 0) {
						str += "<td>일반회원</td>"
						str += "<td onclick=del('" + val.userid + "')>삭제</td>"
					} else {
						str += "<td>관리자</td>"
						str += "<td>admin</td>"
					}
					str += "</tr>"
				})
				$("table tbody").html(str);
				$("#cntSpan").text(resp.count);
			});

	}
}