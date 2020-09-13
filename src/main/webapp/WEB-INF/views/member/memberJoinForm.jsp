<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function idCheck(){
		var user_id = $('#member_id').val();
		$.ajax({
			url:"member/idCheck?member_id"+user_id,
			type: "GET",
			data:{member_id:member_id},
			
			success: function(data){
				console.log(data);
				if(data==1){
					$("idCheck").text("사용중인 아이디입니다");
					$("idCheck").css("color","red");
				}else{
					$("idCheck").text("사용 가능한 아이디입니다");
					$("idCheck").css("color","green");
				}
			},
			error: function(e){
				alert("통신 실패.");
				console.log(e);
			}
		});
		return false;
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
		<form action="/member/join" method="post">
			<span id="span"><span class="important">(*)</span>부분은 필수 입력사항입니다.</span><br>
			<table border="1">
					<tr>
						<td>아이디<span class="important">(*)</span></td>
						<td><input type="text" name="member_id" id="member_id"><button onclick="idCheck();">중복 검사</button><div id="idCheck"></div>
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
						<td><input type="text" name="member_email" id="member_email"><input type="button" value="인증"><div id="emailCheck"></div></td>
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
						<td><input type="text" name="member_address"><input type="button" value="우편번호 찾기"></td>
					</tr>
					
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="member_address_detail"></td>
					</tr>
			</table>
			<input type="button" value="취소">
			<input type="submit" value="가입">
		</form>
</body>
</html>