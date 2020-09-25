<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="/resources/kakao.min.js"></script>
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
		<a id="kakao-login-btn"></a>
		<a href="http://developers.kakao.com/logout"></a>
		<script type='text/javascript'>
		  //<![CDATA[
		    // 사용할 앱의 JavaScript 키를 설정해 주세요.
		    Kakao.init('64ee8ae4ffd93e00255b26611c1fec74');  //여기서 아까 발급받은 키 중 javascript키를 사용해준다.
		    // 카카오 로그인 버튼을 생성합니다.
		    Kakao.Auth.createLoginButton({
		      container: '#kakao-login-btn',
		      success: function(authObj) {
		    	  Kakao.API.request({

		    	       url: '/v2/user/me',

		    	       success: function(res) {

		    	             alert(JSON.stringify(res)); //<---- kakao.api.request 에서 불러온 결과값 json형태로 출력

		    	             alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton에서 불러온 결과값 json형태로 출력

		    	             console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)

		    	             console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)

		    	             console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력

		    	           }

					})
		      },
		      fail: function(err) {
		         alert(JSON.stringify(err));
		      }
		    });
		  //]]>
		</script>

	</center>

</body>
</html>







