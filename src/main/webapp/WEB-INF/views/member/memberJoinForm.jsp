<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(function () {
	    var chk = -1;
	    var data = {"member_email": $("#member_email").val()};
        var authNum = "";
	    
	    $("#auth_btn").click(function () {

	        $.ajax({
				url:"/member/emailCheck",
				data:{
					member_email:$("#member_email").val()
					},
				success:function(data){
					if(data==1){
						$("#lab1").text("사용중인 이메일입니다");
						$("#lab1").css("color","red");
					}else{
						$("#auth_btn").click(function () {
					        $.ajax({
					            url : "/member/emailAuth.do",
					            data : {"member_email": $("#member_email").val()},
					            success : function (data) {
					                authNum = data;
					                alert("인증번호 전송완료.");
					            }
					            
					        });

						});
					}
				},
				error:function(e){
					alert("통신 실패");
					console.log(e);
					}
			});
			
	    });// 이메일 인증 버튼 end
	    
		$("#email_check").click(function(){
			var chk = 0;
	        var user_authNum = document.getElementById("user_authNum").value;

	    	// 인증번호 비교
	        if (authNum == user_authNum) {
	            chk = 1;
	        } else {
	            chk = -1;
	        }

	        if( chk > 0){
                alert("인증완료");
                chk = 1;
                $("#lab1").html("<label>인증완료</label>");
            }else{
                alert("인증실패");
                $("#lab1").html("<label>인증실패</label>");
            }

		});
			
	    // 회원가입
	    $("#join_submit").click(function () {
	        if( chk > 0  ){
	            return true;
	        }else{
	            alert("이메일 인증을 완료하여 주세요.");
	            return false;
	        }
	        
	    });
	    
	});

    function join_cancel(){
    	location.href = "/member/memberLoginPage";
    } 

	function join_submit(){
		var member_id = document.getElementById("member_id").value;
		var member_pw = document.getElementById("member_pw").value;
		var member_pwck = document.getElementById("member_pwck").value;
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
		
		if(member_id==''||member_id.length==0){
			alert("아이디를 입력해 주세요");
			return false;
			}else if(member_id.length<=2||member_id.length>=9){
				alert("아이디는 3~8글자 입니다");
				return false;
			}

		if(member_pw==''||member_pw.length==0){
			alert("비밀번호를 입력해 주세요");
			return false;
			}else if(member_pw.length<=2||member_pw.length>=11){
				alert("비밀번호는 3~10글자 입니다");
				return false;
			}
		
		if(member_pw!=member_pwck){
			alert("동일한 비밀번호를 입력해 주세요");
			return false;
			}
		
		if(member_phone==''||member_phone.length==0){
			alert("전화번호를 입력해 주세요");
			return false;
			}

		if(member_name==''||member_name.length==0){
			alert("이름을 입력해 주세요");
			return false;
			}
		
		if(member_birth==''||member_birth.length==0){
			alert("생년월일을 입력해 주세요");
			return false;
			}

		if(member_email==''||member_email.length==0){
			alert("이메일을 입력해 주세요");
			return false;
			}
		
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
						$("#id_hidden").text("1");
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
	<center>
		<h1>[ 회원가입 ]</h1>
		<span id="span"><span class="important">(*)</span>부분은 필수 입력사항입니다.</span><br>
		<table border="1">
			<tr>
				<td>아이디<span class="important">(*)</span></td>
				<td><input type="text" name="member_id" id="member_id"><button onclick="checkId()">중복 검사</button><div id="idCheck"></div>
				<input type="hidden" id="id_hidden" value="0" readonly="readonly">
			</tr>
			
			<tr>
				<td>비밀번호<span class="important">(*)</span></td>
				<td><input type="password" name="member_pw" id="member_pw"><div id="pwCheck"></div>	
				</td>
			</tr>
			
			<tr>
				<td>비밀번호 확인<span class="important">(*)</span></td>
				<td><input type="password" id="member_pwck">	
				</td>
			</tr>
			
			<tr>
				<td>연락처<span class="important">(*)</span></td>
				<td><input type="text" name="member_phone"  id="member_phone" placeholder="'-'없이 입력"></td>
			</tr>
	
			<tr>
				<td>이름<span class="important">(*)</span></td>
					<c:choose>
						<c:when test="${map.name!=null }">
							<td><input type="text" name="member_name" id="member_name" value="${map.name }" readonly="readonly"></td>
						</c:when>
						<c:otherwise>
							<td><input type="text" name="member_name" id="member_name"></td>
						</c:otherwise>
					</c:choose>
			</tr>
			
			<tr>
				<td>생년월일<span class="important">(*)</span></td>
				<td><input type="text" name="member_birth" id="member_birth" placeholder="YYYYMMDD"><div id="birthCheck"></div></td>
			</tr>
			
			<tr>
				<td>이메일<span class="important">(*)</span></td>
				<c:choose>
					<c:when test="${map.email!=null }">
						<td><input type="text" name="member_email" id="member_email" value="${map.email }" readonly="readonly"></td>
					</c:when>
					<c:otherwise>
						<td><input type="text" name="member_email" id="member_email"><input type="button" id="auth_btn" value="인증"><br>
						인증번호:<input type="text" id="user_authNum" name="user_authNum"><input type="button" id="email_check" value="확인"><div id="lab1"></div></td>
					</c:otherwise>
				</c:choose>
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
				<td><input type="text" name="member_address" id="member_address"></td>
			</tr>
			
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="member_address_detail" id="member_address_detail"></td>
			</tr>
		</table>
		<input type="button" value="취소" onclick="join_cancel()">
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
	</center>
</body>
</html>