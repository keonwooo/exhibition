<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(function () {
	    var chk = -1;
	    
	    
	    $("#auth_btn").click(function () {
	        var data = {"member_email": $("#member_email").val()};
	        var authNum = "";
	        
	        $.ajax({
	            url : "/member/emailAuth.do",
	            data : data,
	            success : function (data) {
	                authNum = data;
	                alert("인증번호 전송완료.");
	                
	                chk = checkNum(authNum);
	                
	                if( chk > 0){
	                    alert("인증완료");
	                    chk = 1;
	                    $("#lab1").html("<label>인증완료</label>");
	                }else{
	                    alert("인증실패");
	                    $("#lab1").html("<label>인증실패</label>");
	                }
	                
	            }
	            
	        });
	        
	    });// 이메일 인증 버튼 end
	    
	    // 회원가입
	    $("#signUp_btn").click(function () {
	        if( chk > 0  ){
	            return true;
	        }else{
	            alert("이메일 인증을 완료하여 주세요.");
	            return false;
	        }
	        
	    });
	    
	});

	function checkNum(authNum) {
        var chk = 0;
        var user_authNum = prompt("인증번호를 입력하세요.");
        // 인증번호 비교
        if (authNum == user_authNum) {
            chk = 1;
            $("#user_authNum").val(user_authNum);
        } else {
            chk = -1;
        }
 
        return chk;
    };

	function join_submit(){
		var member_id = document.getElementById("member_id").value;
		var member_pw = document.getElementById("member_pw").value;
		var member_phone = document.getElementById("member_phone").value;
		var member_name = document.getElementById("member_name").value;
		var member_birth = document.getElementById("member_birth").value;
		var member_email = document.getElementById("member_email").value;
		var member_gender = document.getElementsByName("member_gender").value;
		var member_address = document.getElementById("member_address").value;
		var member_address_detail = document.getElementById("member_address_detail").value;
	
		document.getElementById("user_id").value = member_id;
		document.getElementById("user_pw").value = member_pw;
		document.getElementById("user_phone").value = member_phone;
		document.getElementById("user_name").value = member_name;
		document.getElementById("user_birth").value = member_birth;
		document.getElementById("user_email").value = member_email;
		document.getElementsByName("user_gender").value = member_gender;
		document.getElementById("user_address").value = member_address;
		document.getElementById("user_address_detail").value = member_address_detail;
	
		document.getElementById("joinForm").submit();
		
	}
	function checkId(){
			$.ajax({
				url:"/member/idCheck",
				data:{
					member_id:$("#member_id").val()
					},
				success:function(data){
					if(data==1){
						$("#idCheck").text("사용중인 아이디입니다");
						$("#idCheck").css("color","red");
					}else{
						$("#idCheck").text("사용가능한 아이디입니다");
						$("#idCheck").css("color","green");
					}
				},
				error:function(e){
					alert("통신 실패");
					console.log(e);
					}
			});
	}
</script>

<style type="text/css">
	.important{
		color : red;
	}
</style>
</head>
<body>
	<h1>[ 회원가입 ]</h1>
			<span id="span"><span class="important">(*)</span>부분은 필수 입력사항입니다.</span><br>
			<table border="1">
					<tr>
						<td>아이디<span class="important">(*)</span></td>
						<td><input type="text" name="member_id" id="member_id"><button onclick="checkId()">중복 검사</button><div id="idCheck"></div>
					</tr>
					
					<tr>
						<td>비밀번호<span class="important">(*)</span></td>
						<td><input type="password" name="member_pw" id="member_pw"><div id="pwCheck"></div>	
						</td>
					</tr>
					
					<tr>
						<td>연락처<span class="important">(*)</span></td>
						<td><input type="text" name="member_phone" placeholder="'-'없이 입력" id="member_phone"><input type="button" value="인증"><div id="phoneCheck"></div></td>
					</tr>
					
					<tr>
						<td>이름<span class="important">(*)</span></td>
						<td><input type="text" name="member_name" id="member_name"><div id="nameCheck"></div></td>
					</tr>
		
					<tr>
						<td>생년월일<span class="important">(*)</span></td>
						<td><input type="text" name="member_birth" id="member_birth" placeholder="YYYYMMDD"><div id="birthCheck"></div></td>
					</tr>
		
					<tr>
						<td>이메일<span class="important">(*)</span></td>
						<td><input type="text" name="member_email" id="member_email"><input type="button" id="auth_btn" value="인증"><br>
						인증번호:<input type="text" id="user_authNum" name="user_authNum" readonly="readonly"><div id="lab1"></div></td>
					</tr>
		
					<tr>
						<td>성별</td>
						<td>
						남 : <input type="radio" name="member_gender" value="m" checked="checked">
						여 : <input type="radio" name="member_gender" value="f">
						</td>
					</tr>
		
					<tr>
						<td>주소</td>
						<td><input type="text" name="member_address" id="member_address"><input type="button" value="우편번호 찾기"></td>
					</tr>
					
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="member_address_detail" id="member_address_detail"></td>
					</tr>
			</table>
			<input type="button" value="취소">
			<input type="button" id="join_submit" onclick="join_submit()" value="가입">
			
		<form action="/member/join" method="post" id="joinForm">
			<input type="hidden" name="member_id" id="user_id">
			<input type="hidden" name="member_pw" id="user_pw">
			<input type="hidden" name="member_phone" id="user_phone">
			<input type="hidden" name="member_name" id="user_name">
			<input type="hidden" name="member_birth" id="user_birth">
			<input type="hidden" name="member_email" id="user_email">
			<input type="hidden" name="member_gender" id="user_gender">
			<input type="hidden" name="member_address" id="user_address">
			<input type="hidden" name="member_address_detail" id="user_address_detail">
		</form>
</body>
</html>