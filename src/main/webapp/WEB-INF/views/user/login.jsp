<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MatchingBoard- 보드게임카페 동행를 찾는 커뮤니티</title>
<style>
.container.container-fluid {
  display: none;
}
#foot-container {
	display: none;
}

.button-group {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}

.button {
  margin: 0 10px;
}

.container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  max-height: 95vh;
  text-align: center; /* 추가 */
/*   padding: 5px; */
 
}
</style>
</head>
<body>
	<div class="container text-center">
	  <div style="padding-top:100px; padding-bottom: 100px; margin-top:100px; margin-bottom: 100px; border-radius: 10px;">
	  	<img src="../images/matchingBoard_logo.png" style="width: 250px; height: 250px; margin-bottom: 30px;">
		<h2 style="padding:30px;">MatchingBoard에 오신 것을 환영합니다.</h2>
		<h4 style="padding:30px;">로그인 하기</h4>
		<div class="button-group" style="padding:30px;">
			<div><a class="button Naver" href="${urlNaver}"><img src="../images/naver_login.png" style="width: 180px; height: 50px; margin: 3px;"></a></div>
			<div><a class="button Kakao" href="${urlKakao}"><img src="../images/kakao_login.png" style="width: 180px; height: 50px; margin: 3px;"></a></div> 
			<div><a class="button Google" href="${urlGoogle}"><img src="../images/google_login.png" style="width: 180px; height: 50px; margin: 3px;"></a></div>
		</div>
	  </div>
	</div>

</body>
</html>