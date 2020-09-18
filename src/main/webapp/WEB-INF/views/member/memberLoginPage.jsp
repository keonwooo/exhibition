<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<center>
		<h1>
			[ 로그인 페이지 ]
		</h1>
		<form action="/member/Login" method="post" style="width:470px;">
			<input type="text" name="member_id" placeholder="아이디"> <br>
			<input type="password" name="member_pw" placeholder="비밀번호" > <br>
			<input type="submit" value="로그인" > <br>
		</form>
		<br>
		<!-- 네이버 로그인 창으로 이동 -->
		<div id="naver_id_login" style="text-align:center"><a href="${url}">
		<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
		<br>
	</center>

</body>
</html>