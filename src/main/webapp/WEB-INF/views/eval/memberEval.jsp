<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="myctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>Evaluation - MEMBER</title>
<script src="https://jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
}

h1, h4{
	text-align: center;
	margin-top: 1em;
}

.rating-container {
	margin: 0 auto;
	margin-top: 30px;
	max-width: 400px;
}

.rating-container p {
	font-weight: bold;
	margin-bottom: 10px;
}

.rating-container .range-value {
	font-weight: bold;
	margin-bottom: 20px;
}

.rating-container .range-slider {
	width: 80%;
	margin-bottom: 5px;
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

#evalMem{
	margin: 1em;
	text-align: center;
}
</style>
</head>
<body>
	<h1>모임원 평가</h1>
	<form name="evalMem" id="evalMem" action="../eval/memberEval" method="post">
		<!-- 중복평가 방지; 세션 -->
<%-- 		<c:if test="${sessionScope.evalDone}">
            <script>
                alert("이미 평가를 완료하셨습니다");
                window.location.href = "../room/roomView";
            </script>
        </c:if> --%>
		<input type="hidden" name="whoid" value="${MemberEvalVO.whoid}"><!-- 현재 로그인한 회원 -->
		<c:forEach var="member" items="${memberArr}" varStatus="stat"><!-- 모임방 참여 회원 -->
			<!-- memberArr에서 userid가 whoid와 같으면 나오면 안되는데 전부 나오고 있음.. -->
			<c:if test="${member.userid ne whoid}">
				<div class="member-rating">
					<h4>${member.nickname}님 평가</h4>
					<div class="rating-container">
						<c:forEach var="question" items="${question}" varStatus="stat2">
							<p>${question.key}:${question.value}?</p>
							<input type="range" name="range_${member.userid}" class="range-slider" min="1" max="100"
								value="0"
								onchange="updateRangeValue(this, ${stat.index}, ${stat2.index})">
							<p class="range-value">0</p>
						</c:forEach>
						<input type="hidden" name="userid" id="memberEvals[${stat.index}].userId" value="${member.userid}">
					</div>
				</div>
			</c:if>
		</c:forEach>
		<br> 
		<input type="hidden" name="ranges" id="avgRange">
		<button type="submit" class="btn btn-success">제출</button>
	</form>
<script>
	let sliderChanged = false;//슬라이더 변경여부
	
  //range 값 업데이트
  function updateRangeValue(rangeSlider, userid, rangePoint) {
	//alert(rangePoint);
    const rangeValue = rangeSlider.nextElementSibling;
    rangeValue.innerText = rangeSlider.value;
    setRanges(rangeSlider.value,userid, rangePoint);
  //슬라이더 값 변경=비활성화
    sliderChanged = true;
  	rangeSlider.disabled = true;
  }
  
  //맴버 range 체크
  let ranges = [];
  let arr = [];
  let obj={userid:'', score:[]};
  
  //ranges[]에 저	장
  function setRanges(value, userid, rangePoint) {//평점, userid, 문항번호
	if(rangePoint%3==0){
		  obj={userid:userid, score:[]};
	}
	  //obj.score.push(value);
    if (!obj.score.includes(value)) {//슬라이더 값 누적 방지
    	obj.score.push(value);
  	}
	if(rangePoint%3==2){
    	ranges.push(obj);
    }
   	 console.log(ranges);
  }
  
  //submit
  $(function(){
	   $('#evalMem').submit(function(e){ 
		   var sliderDisabled = $('.range-slider:not(:disabled)').length === 0;
		   var sliderDefault = $('.range-slider[value="0"]:not(:disabled)').length > 0;
		   if (!(sliderDisabled || sliderDefault == 0)) {
		      e.preventDefault();
		      alert('모든 평가를 완료해주세요');
		    }
	     var avgRanges = calculateAverageRanges(ranges);
	     $('#avgRange').val(avgRanges.join(', '));
	     return true;
	   });
	});
	
	//맴버별 평점 구하기
    function calculateAverageRanges(ranges) {
    	var avgRanges = [];
       		for (var i = 0; i < ranges.length; i++) {
            	var sum = 0;
             	console.log(ranges[i].userid+"/"+ranges[i].score)
             	for (var j = 0; j < ranges[i].score.length; j++) {
               		sum += parseInt(ranges[i].score[j]);  
               		console.log('sum='+sum)             
             	}
             	var avg = sum / ranges[i].score.length;
             	avgRanges.push(avg.toFixed(1));
          	}
   		return avgRanges;   
	}
</script>
</body>
</html>
