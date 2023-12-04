<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.search {
	position: relative;
	width: 300px;
}

input {
	width: 100%;
	border: 1px solid #bbb;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
}

img {
/* 	position: absolute; */
	width: 17px;
	top: 10px;
	right: 12px;
	margin: auto;
	display: block;
}

/* 좋아요 */
.btn-like {
	color: transparent;
	text-shadow: 0 0 2px rgba(255, 255, 255, .7), 0 0 0 #000;
}

.btn-like:hover {
	text-shadow: 0 0 0 #ea0;
}

.btn-like.done {
	color: inherit;
	text-shadow: 0;
}

.btn-like.done:hover {
	color: transparent;
	text-shadow: 0 0 0 #777;
}

.ac_link_logo_img {
	width: 35px;
	height: 35px;
}

.col {
	margin-bottom: 15px;
}

 
.pageInfo{
//	list-style : none;
//	display: inline-block;
//	margin: 50px 0 0 100px;      
}
/*
.pageInfo li{
    float: left;
    font-size: 20px;
    margin-left: 18px;
    padding: 7px;
    font-weight: 500;
}
*/
 a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: none;}
 
.search_wrap{
    margin-top: 30px;
    height: 3em;
 }
 
.search_area{
    display: inline-block; 
    margin-right: 60px;
}
.search_area input{
	height: 30px;
    width: 250px;
}
.search_area button{
    width: 100px;
    height: 36px;
}

.search_area select{
  	height: 35px;
}

.active{
      background-color: #cdd5ec;
}
 
.blinking{
	-webkit-animation: blink 2s ease-in-out infinite alternate;
	-moz-animation: blink 2s ease-in-out infinite alternate;
	animation: blink 2s ease-in-out infinite alternate;
}

@-webkit-keyframes blink{
	60% {opacity: 0.6;}
	100% {opacity: 1;}
}

@-moz-keyframes blink{
  	60% {opacity: 0.6;}
  	100% {opacity: 1;}
}

@keyframes blink{
 	60% {opacity: 0.6;}
	100% {opacity: 1;}
}

#totheTop {
	position: fixed;
	bottom: 20px;
	right: 5%;
	
	text-align: center;
	vertical-align: middle;
	width: 2em;
	height: 2em;
	background-color: #8fa2ec;
	border-radius: 50%;
	
	font-size: 1.5em;
}

.cRoom_area{
	display: inline-block;
	margin-left: 30px;
}

</style>

	<!-- 검색바  -->
<div class="search_wrap">
	<div class="cRoom_area float-left ">
		<button class="btn blinking" style="background-color:#6d72f4; color: #fff;" onclick="location.href='./createRoom'">모임방 만들기</button>
	</div>
	<div class="search_area float-right">
		<select name="type">
			<option value="" <c:out value="${pageMaker.pagingvo.type == null?'selected':'' }"/>>--</option>
			<option value="T" <c:out value="${pageMaker.pagingvo.type eq 'T'?'selected':'' }"/>>제목</option>
			<option value="P" <c:out value="${pageMaker.pagingvo.type eq 'P'?'selected':'' }"/>>지역</option>
			<option value="S" <c:out value="${pageMaker.pagingvo.type eq 'S'?'selected':'' }"/>>내용</option>
			<option value="TS" <c:out value="${pageMaker.pagingvo.type eq 'TS'?'selected':'' }"/>>제목 + 내용</option>
		</select>
		<input type="text" name="keyword" value="${pageMaker.pagingvo.keyword}">
		<button class="btn btn-info" style="opacity: 0.85;">Search</button>
	</div>
</div>

<br>
<div class="container">

	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
		<!-- 보드게임 모임방 목록 -->
		<!-- ---------------------------------------------------------------------- -->
		<c:forEach var="list" items="${list}">
			<div class="col">
				<div class="card shadow-sm">

					<div class='my-div'
						onclick="openPopup('${list.roomid}')">

						<svg class="bd-placeholder-img card-img-top" width="100%"
							height="170" xmlns="http://www.w3.org/2000/svg" role="img"
							aria-label="Placeholder: pla"
							preserveAspectRatio="xMidYMid slice" focusable="false"
							viewbox="0 0 500 500">        
           					<rect width="100%" height="100%" fill="#4A4846" style="cursor:pointer;"/>                    
       						 <image href="${pageContext.request.contextPath}/images/gimages/${list.rgame}.png"
       						 	 height="600" width="500" style="opacity: 0.4;"/>                                                      
        					 	<!-- 방이름 -->             				 	  	           
           					<text style="font-weight:bold; font-size:1.6em;" x="50%" y="40%" fill="#e0e0e0" dy=".3em" > <c:out value="${list.rname}" /></text>
           					<!-- 방설명  -->
           					<text x="50%" y="55%" width="80%" style="font-weight:bold; font-size:1.2em; font-color:#ffffff; overflow:auto; white-space:nowrap; width: 80%;" fill="#e0e0e0" dy=".3em">
								<c:out value="${list.rstr}" /></text>
          					</svg>
					</div>

					<div class="card-body">
						<!-- 글자 앞에 이미지 넣기 가 안됨!-->

						<!-- 장르 -->
						<p class="card-text" style="font-size: 12px;">
							<c:out value="${list.rgenre}" />
						</p>
						<!-- 위치 -->
						<p class="card-text" style="font-size: 12px;">
							<c:out value="${list.rplace}" />
						</p>
						<div class="d-flex justify-content-between align-items-center"
							style="float: right;">
							<c:if test="${loginUser ne null}">
							<div class="btn-group">
								<!-- 좋아요 버튼 -->
<%-- 								 		${list.wishroomid} / ${list.roomid }/${list.uuid} /${loginUser.userid} --%>
						 		<button class="btn-like 
									<c:forEach var="likeRoomId" items="${likeRoomIds}">
										<c:if test="${list.roomid eq likeRoomId}">
											done
										</c:if>
									</c:forEach>
								" data-id="${list.roomid}">❤️</button>
						<!--
								<c:if test="${list.roomid eq likeRoomId}">
								<button class="btn-like done" data-id="${list.roomid}">❤️</button>
								</c:if>
								<c:if test="${list.roomid ne likeRoomIds}">
								<button class="btn-like" data-id="${list.roomid}">❤️</button>
								</c:if>
						 -->
							</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		<!-- ---------------------------------------------------------------------- -->
	
	</div>
</div>
		<!-- 페이징 처리 -->
		<div class="pageInfo_wrap justify-content-center">
			<div class="pageInfo_area">
				<ul id="pageInfo" class="pageInfo pagination pagination-sm justify-content-center">
		
					<!-- 이전페이지 버튼 -->
					<c:if test="${pageMaker.prev}">
					<li class="page-item pageInfo_btn previous"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
					</c:if>
		
					<!-- 각 번호 페이지 버튼 | pageMaker에 저장된 시작.끝 페이지 값을 가지고 페이지 번호를 화면에 출력| <a>태그에 번호-->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="page-item pageInfo_btn ${pageMaker.pagingvo.pageNum == num ? "active":"" }"><a class="page-link" href="${num}">${num}</a></li>
					</c:forEach>
					
					<!-- 다음페이지 버튼 -->
					<c:if test="${pageMaker.next}">
					<li class=" page-itempageInfo_btn next"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
					</c:if>
		
				</ul>
			</div>
		</div>
		
		<form id="moveForm" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.pagingvo.pageNum}"> 
		<input type="hidden" name="amount" value="${pageMaker.pagingvo.amount}">
		<input type="hidden" name="keyword" value="${pageMaker.pagingvo.keyword}">
		<input type="hidden" name="type" value="${pageMaker.pagingvo.type }">
		</form>



	<p class="" id="totheTop">
		<a href="#" style="color: black; margin-top:10px;">&uarr;</a>
	</p>

<!-- 좋아요 버튼 -->
<script src="//code.jquery.com/jquery.min.js"></script>
<script>

	$(".btn-like").click(function() {
		$(this).toggleClass("done");
		
		roomid = $(this).attr('data-id');
	
		
		$.ajax({
			type: 'put',
			url: 'like/' + roomid,
			dataType: 'json',
			cache: false
		})
		.done((res) =>{
		//	alert(JSON.stringify(res));
			if(res.result == '-2'){
				alert(res.msg);
			}
		})
		.fail((err) =>{
			alert(err.status);
		})
	})

	//팝업창 - 모임방 목록 상세조회
	function openPopup(roomid) {
		//alert(roomid)
		window.open(
					"clickRoom?roomid=" + roomid,
					"new", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=700, height=700, left=0, top=0");
	}
	
	
	let moveForm = $("#moveForm");
	$(".move").on("click", function(e){
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='roomid' value='"+ $(this).attr("href")+ "'>");
		moveForm.attr("action", "/room/roomList");
		moveForm.submit();
	});
	
	//페이지번호(a태그)클릭 했을 때 동작하는 메서드
	 $(".pageInfo a").on("click", function(e){
		 
		    e.preventDefault(); //a태그 동작을 멈춤
   //<form> 태그 내부 pageNum과 관련된 <input>태그의 vlaue 속성값을 클릭한 <a> 태그의 페이지 번호를 삽입
	        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
   //<form>태그 action 속성 추가 및 '/search/boardSearch'을 속성값으로 추가
	        moveForm.attr("action", "roomList");
   //<form>태그 서버 전송
	        moveForm.submit();
	        
	    });
	
	//검색버튼
	 $(".search_area button").on("click", function(e){
        e.preventDefault();
        
        let type = $(".search_area select").val();
        let keyword = $(".search_area input[name='keyword']").val();
        
        if(!type){
            alert("검색 종류를 선택하세요.");
            return false;
        }
        
//         if(!keyword){
//             alert("키워드를 입력하세요.");
//             return false;
//         }        
        
        moveForm.find("input[name='type']").val(type);
        moveForm.find("input[name='keyword']").val(keyword);
        moveForm.find("input[name='pageNum']").val(1);
        moveForm.submit();
    });

</script>
