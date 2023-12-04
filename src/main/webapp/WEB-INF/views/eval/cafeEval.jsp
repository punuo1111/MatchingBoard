<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="myctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>Evaluation - CAFE</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
	text-align: center;
}

h1 {
	text-align: center;
	margin-top: 1em;
}

.rating-container {
	margin: 0 auto;
	margin-top: 30px;
	max-width: 400px;
	text-align: center;
}

.rating-container p {
	font-weight: bold;
	margin-bottom: 10px;
}

.rating-container .stars {
	display: inline-block;
	font-size: 24px;
	cursor: pointer;
	caret-color: transparent; /* 깜빡이는 커서 숨김 */
}

.rating-container .stars .star {
	color: gray;
	transition: color 0.3s;
}

.rating-container .stars .star:hover, .rating-container .stars .star.active
	{
	color: red;
	content: "\2605";
}

.rating-container button {
	display: block;
	margin-top: 20px;
	background-color: #4CAF50;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}

.rating-container button:hover {
	background-color: #45a049;
}

#evalCafe{
	margin: 1em;
}
</style>
</head>
<body>
	<h1>${rplace} 매장평가</h1>
	<form name="evalCafe" id="evalCafe" action="../eval/cafeEval" method="post">
		<div class="rating-container">
			<p>질문 1: 해당 카페의 게임 종류는 다양했나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 1)">&#9734;</span> <span
					class="star" onclick="setRating(2, 1)">&#9734;</span> <span
					class="star" onclick="setRating(3, 1)">&#9734;</span> <span
					class="star" onclick="setRating(4, 1)">&#9734;</span> <span
					class="star" onclick="setRating(5, 1)">&#9734;</span>
			</div>
		</div>

		<div class="rating-container">
			<p>질문 2: 해당 카페의 매장 청결도는 깨끗했나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 2)">&#9734;</span> <span
					class="star" onclick="setRating(2, 2)">&#9734;</span> <span
					class="star" onclick="setRating(3, 2)">&#9734;</span> <span
					class="star" onclick="setRating(4, 2)">&#9734;</span> <span
					class="star" onclick="setRating(5, 2)">&#9734;</span>
			</div>
		</div>

		<div class="rating-container">
			<p>질문 3: 해당 카페의 보드게임 상태는 좋았나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 3)">&#9734;</span> <span
					class="star" onclick="setRating(2, 3)">&#9734;</span> <span
					class="star" onclick="setRating(3, 3)">&#9734;</span> <span
					class="star" onclick="setRating(4, 3)">&#9734;</span> <span
					class="star" onclick="setRating(5, 3)">&#9734;</span>
			</div>
		</div>

		<div class="rating-container">
			<p>질문 4: 보드게임카페의 게임 종류는 다양했나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 4)">&#9734;</span> <span
					class="star" onclick="setRating(2, 4)">&#9734;</span> <span
					class="star" onclick="setRating(3, 4)">&#9734;</span> <span
					class="star" onclick="setRating(4, 4)">&#9734;</span> <span
					class="star" onclick="setRating(5, 4)">&#9734;</span>
			</div>
		</div>

		<div class="rating-container">
			<p>질문 5: 보드게임카페의 게임 종류는 다양했나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 5)">&#9734;</span> <span
					class="star" onclick="setRating(2, 5)">&#9734;</span> <span
					class="star" onclick="setRating(3, 5)">&#9734;</span> <span
					class="star" onclick="setRating(4, 5)">&#9734;</span> <span
					class="star" onclick="setRating(5, 5)">&#9734;</span>
			</div>
		</div>

		<div class="rating-container">
			<p>질문 6: 보드게임카페의 게임 종류는 다양했나요?</p>
			<div class="stars">
				<span class="star" onclick="setRating(1, 6)">&#9734;</span> <span
					class="star" onclick="setRating(2, 6)">&#9734;</span> <span
					class="star" onclick="setRating(3, 6)">&#9734;</span> <span
					class="star" onclick="setRating(4, 6)">&#9734;</span> <span
					class="star" onclick="setRating(5, 6)">&#9734;</span>
			</div>
		</div>

		<br>
		<input type="hidden" name="saddr" value="addr"><!-- 받아올 카페 주소 -->
		<input type="hidden" name="userid" value="2222"><!-- 평가할 유저 id 받기 -->
		<input type="hidden" name="stars" id="averageRating">
		<button type="submit" class="btn btn-success">제출</button>
		<button type="button" class="btn btn-secondary" onclick="window.location.href='/matchingBoard/room/roomView'">건너뛰기</button>
		<!-- <button type="button" onclick="redirectMemEval()">모임원 평가 이동</button> -->
	</form>

<script type="text/javascript">
//평균별점 계산 및 전송
$(function(){
	$('#evalCafe').submit(function(e){
		var sum = ratings.reduce((total, rating) => total + rating, 0);
		var avg = (sum / 6).toFixed(1);
		alert(avg);
		$('#averageRating').val(avg);
		
        this.submit();
	});
});

//별점 체크
let ratings = [];

function setRating(value, questionNumber) {
  ratings[questionNumber-1] = value;

  const stars = document.querySelectorAll('.rating-container:nth-child(' + questionNumber + ') .star');
  for (let i = 0; i < stars.length; i++) {
    if (i < value) {
      stars[i].classList.add('active');
    } else {
      stars[i].classList.remove('active');
    }
  }
}


</script>
</body>
</html>
