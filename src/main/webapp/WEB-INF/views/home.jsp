<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>로그인</title>
	<script type="text/javascript">
		function memberJoinForm(){
			location.href = "/member/memberJoinForm";
		}
	</script>
</head>
<body>
<h1>
	[ 로그인 ]
</h1>
	<form action="/member/Login" method="post">
		ID : <input type="text"><br>		
		PW : <input type="password"><br>
		<input type="button" value="회원가입" onclick="memberJoinForm()">	
		<input type="submit" value="로그인">
	</form>
</body>
</html>
