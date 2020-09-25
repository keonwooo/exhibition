<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>메인 페이지</title>
	<script type="text/javascript">
	</script>
</head>
<body>
	<center>
	<h1>[ 메인 페이지 ]</h1>
		<c:choose>
			<c:when test="${sessionScope.loginID != null }">
				<h2> 로그인 성공</h2>
				<h3> '${sessionScope.loginID }'님 환영합니다</h3>
				<h4><a href="logout">로그아웃</a></h4>
			</c:when>
			<c:otherwise>
				<a href="member/memberLoginPage">로그인</a>
				<a href="member/memberJoinForm">회원가입</a>
			</c:otherwise>
		</c:choose>
	</center>
</body>
</html>
