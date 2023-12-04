<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#foot-container {
	display: none;
}

.navbar {
		display:none;
	}
	
#total_container{
    min-width: 550px;
}


</style>
</head>
<body>


	<div>
		<div class="bd-example-snippet bd-code-snippet">
			<div class="bd-example">
				<ul class="list-group">
					<li class="list-group-item">방이름: <c:out value="${room.rname}" /></li>
					<li class="list-group-item">장르: <c:out value="${room.rgenre}" /></li>
					<li class="list-group-item">기본보드게임: <c:out value="${room.rgame}" /></li>
					<li class="list-group-item">최대인원: <c:out value="${room.rmaxpeople}" /></li>
					<li class="list-group-item">장소: <c:out value="${room.rplace}" /></li>
					<li class="list-group-item" id="rdatetime">모임일시: <c:out value="${room.rdatetime}" /></li>
					<li class="list-group-item">방설명: <c:out value="${room.rstr}" /></li>
				</ul>
				
				<br>

				<div class="bd-example-snippet bd-code-snippet"
					style="text-align: center;">
					<div class="bd-example">
						<button onclick="closeTabClick()" class="btn btn-secondary" id="list_room">닫기</button>
						<button type="button" class="btn btn-secondary" id="enter_room">모임방 참가</button>
					</div>
					<!-- 모임방 목록으로 돌아가기 
					<form id="infoForm" action="boardSearch" method="get">
						<input type ="hidden" id="roomid" name="roomid" value='<c:out value="${room.roomid}"/>'>
						<input type="hidden" name="pageNum" value='<c:out value="${pagingvo.pageNum}"/>'>
						<input type="hidden" name="amount" value='<c:out value="${pagingvo.amount}"/>'>
						
						-->
						<!--  
						<input type="hidden" name="keyword" value="${pagingvo.keyword}">
						<input type="hidden" name="type" value="${pagingvo.type }">
						-->
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

<script>

// 모임방 목록으로 돌아가기
/**
let form = $("#infoForm");
	$("#list_room").on("click", function(e){
		form.find("#roomid").remove();
		form.attr("action", "boardSearch");
		form.submit();
	});
*/	
	
	$("#enter_room").on("click", function(e){
		opener.location.href="./roomView/"+'${room.roomid}';
		window.close(); // 팝업 창을 닫습니다.
	});
	
	//팝업창 닫기 
	 function closeTabClick() {
     window.close();
   }
	
	var rdt = '${room.rdatetime}'.split(/-|T|:/);
	var str = '모임일시 : ' + rdt[0] + "년 " + rdt[1] + "월 " + rdt[2] + "일 - " + rdt[3] + "시 " + rdt[4] + "분";
	document.getElementById('rdatetime').innerHTML = str;
</script>
</html>
