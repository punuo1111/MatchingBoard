<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.myPageTable {
	width: 70%;
	margin: 1em auto;
}

td {
	padding: 7px;
	text-align: center;
	vertical-align: middle;
}

td:last-child {
	text-align: left;
}

.attendance {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	text-align: center;
	font-size: 1.2em;
	weight: bold;
	color: white;
	line-height: 50px;
}

#attend {
	background-color: #2268aa;
}

#late {
	background-color: #ecba10;
}

#absent {
	background-color: #de352e;
}

tr:first-child td span.prograss-text {
	font-size: 0.8em;
	width: 4em;
	margin-top: 0.5em;
	display: inline-block;
}

.progress {
	appearance: none;
	height: 0.8em;
	display: inline-block;
}

.progress::-webkit-progress-bar {
	background: #cdcdcd;
	border-radius: 15px;
	/* box-shadow: inset 3px 3px 10px #ccc; */
}

.progress::-webkit-progress-value {
	border-radius: 10px;
	background: #28c231;
	overflow: hidden;
}

#modal_manner::-webkit-progress-value {
	background: #6da2ff;
}

#profile_img {
	display: inline-block;
	width: 100px;
	height: 100px;
	overflow: hidden;
	object-fit: cover;
	border-radius: 50%;
}

.ac_link_logo_img {
	width: 35px;
	height: 35px;
}
</style>

<div class="container text-center">
	<h1>MyPage-${loginUser.nickname} 님 정보</h1>
	<p>회원 인증 페이지 - 로그인 해야 들어올 수 있는 페이지입니다</p>
	<div class="row">
	<div class="col-4" style="padding: 10px;">
		<table class="table mt-3 text-center" style="width:100%;">
			<tr>
				<td width="25%">
				<c:if test="${loginUser.profile_img ne null}">
					<img id="profile_img" src="../resources/profileimg_upload/${loginUser.profile_img}">
				</c:if>
				<c:if test="${loginUser.profile_img eq null}">
					<img id="profile_img" src="../images/profile_example.png">
				</c:if>
				</td>
				<td width="75%">
					<div style="margin: auto 0;">
					
						<a href=""><img src="../images/grades/grade${loginUser.grade}.png" style="width:1.2em; height:1.2em;"></a>
						<b style="color: #505050;">${loginUser.nickname}</b>
						<%--
						<a href=""><img src="../images/grades/grade1.png" style="width:1.2em; height:1.2em;"></a>
						<b style="color: #505050;">유저 닉네임</b>
						--%>
						<br>
						<span class="prograss-text">경험치</span>
						<span class="prograss-span">
							<progress class="progress" value="${loginUser.exp}" max="${(loginUser.grade+1)*100}"></progress>
						</span>
						<br>
						<span class="prograss-text">매너점수</span>
						<span class="prograss-span">
							<progress class="progress" id="modal_manner" value="${loginUser.manner}" max="100"></progress>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>지역</td>
				<td><b>${loginUser.area_text}</b></td>
			</tr>
			<tr>
				<td>선호 장르</td>
				<td><b>
					<c:if test="${loginUser.fgenre1 ne null}">
					${loginUser.fgenre1}
					</c:if>
					<c:if test="${loginUser.fgenre2 ne null}">
					, ${loginUser.fgenre2}
					</c:if>
					<c:if test="${loginUser.fgenre3 ne null}">
					, ${loginUser.fgenre3}
					</c:if>
				</b></td>
				<!-- <td><b>장르1, 장르2, 장르3</b></td> -->
			</tr>
			<tr>
				<td>선호 게임 Top3</td>
				<td><b>
					<c:if test="${loginUser.fgame1 ne null}">
					${loginUser.fgame1}
					</c:if>
					<c:if test="${loginUser.fgame2 ne null}">
					, ${loginUser.fgame2}
					</c:if>
					<c:if test="${loginUser.fgame3 ne null}">
					, ${loginUser.fgame3}
					</c:if>
				</b></td>
				<!-- <td><b>게임1, 게임2, 게임3</b></td> -->
			</tr>
			
			<tr>
				<td colspan="2" style="text-align: center;">
					<table border="0" class="tb-attend table table-sm table-borderless " style="margin:0 auto;">
						<tr>
							<td><div class="attendance" id="attend" style="margin:0 auto;">${loginUser.attend}</div></td>
							<td><div class="attendance" id="late" style="margin:0 auto;">${loginUser.late}</div></td>
							<td><div class="attendance" id="absent" style="margin:0 auto;">${loginUser.absent}</div></td>
						</tr>
						<tr>
							<td style="text-align: center">출석</td>
							<td style="text-align: center">지각</td>
							<td style="text-align: center">결석</td>
						</tr>
					</table>
	
				</td>
			</tr>
			<!-- 계정 연동 파트 -->
			<tr>
				<td colspan="2">
					<div>
						<img class="ac_link_logo_img" src="../images/google_icon.png" style="width: 29px; height: 29px; margin: 3px;"> 
		<!-- 				<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="none" viewBox="0 0 18 18">
							<path fill="#4285F4"
								d="M17.785 9.169c0-.738-.06-1.276-.189-1.834h-8.42v3.328h4.942c-.1.828-.638 2.073-1.834 2.91l-.016.112 2.662 2.063.185.018c1.694-1.565 2.67-3.867 2.67-6.597z"></path>
							<path fill="#34A853"
								d="M9.175 17.938c2.422 0 4.455-.797 5.94-2.172l-2.83-2.193c-.758.528-1.774.897-3.11.897-2.372 0-4.385-1.564-5.102-3.727l-.105.01-2.769 2.142-.036.1c1.475 2.93 4.504 4.943 8.012 4.943z"></path>
							<path fill="#FBBC05"
								d="M4.073 10.743c-.19-.558-.3-1.156-.3-1.774 0-.618.11-1.216.29-1.774l-.005-.119L1.254 4.9l-.091.044C.555 6.159.206 7.524.206 8.969c0 1.445.349 2.81.957 4.026l2.91-2.252z"></path>
							<path fill="#EB4335"
								d="M9.175 3.468c1.684 0 2.82.728 3.468 1.335l2.531-2.471C13.62.887 11.598 0 9.175 0 5.667 0 2.638 2.013 1.163 4.943l2.9 2.252c.727-2.162 2.74-3.727 5.112-3.727z"></path>
						</svg> -->
					    <div class="float-right">
						<span> 연동정보 / 연동하기 </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
						<img class="ac_link_logo_img" src="../images/naver_icon.png">
						<div class="float-right">
						    <c:choose>
						        <c:when test="${connectedNaver}">
						            연동 완료
						        </c:when>
						        <c:otherwise>
						            <a href="${connecturlNaver}">연동하기</a>
						        </c:otherwise>
						    </c:choose>
					    </div>
					</div>
			 	</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
<!-- 						<div style="border-radius: 3px; background-color: #f8e20a; width: 35px; height: 35px; text-align: center; display: inline-block;"> -->
<!-- 							<img class="ac_link_logo_img" src="../images/kakaoicon.png"> -->
							<!-- <img class="ac_link_logo_img" src="../images/kakao_icon.png"> -->
							<!-- <svg width="18px" xmlns="http://www.w3.org/2000/svg" height="17" viewBox="0 0 18 17">
								<g transform="translate(0.000000,17.000000) scale(0.100000,-0.100000)" stroke="none">
								<path fill="#212529"
									d="M38 154 c-15 -8 -30 -25 -34 -38 -6 -26 10 -66 27 -66 7 0 9 -10 5 -26 -7 -25 -6 -25 16 -10 12 9 31 16 41 16 29 0 75 28 82 50 10 31 -3 59 -35 75 -36 19 -67 18 -102 -1z"></path>
								</g>
							</svg> -->
<!-- 						</div> -->
						<img class="ac_link_logo_img" src="../images/kakaoicon1.png">
					    <div class="float-right">
						    <c:choose>
						        <c:when test="${connectedKakao}">
						            연동 완료
						        </c:when>
						        <c:otherwise>
						            <a href="${connecturlKakao}">연동하기</a>
						        </c:otherwise>
						    </c:choose>
					    </div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center">
					<form name='f' method='GET' action='modify'>
						<input type="hidden" name="idx" value="${loginUser.userid}">
						<button class="btn btn-secondary">정보수정 | 탈퇴</button>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<div class="col-8" style="padding: 10px;">
		<div class="container my_calendar mt-3" id="my_calendar">
			<!-- Calendar 보여주기 -->
			<%@ include file="/inc/calendar.jspf" %>
		</div>
	</div>
	</div>
</div>