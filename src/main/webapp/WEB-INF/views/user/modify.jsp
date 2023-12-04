<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.user_modify_page{
	text-align: center;
}

.location-selection {
	display: flex;
	align-items: center;
}

.location-select {
	margin-left: 10px;
}

/* 첫 번째 select 요소의 margin 제거 */
.location-select:first-child {
	margin-left: 0;
}

.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modal_body {
	position: absolute;
	top: 50%;
	left: 100%;
	width: 750px;
	height: 100%;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-100%) translateY(-50%);
}

.m_head {
	height: 10%;
	padding: 20px;
	display: flex;
	justify-content: space-between;
	background-color: #e7e5e5;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.m_body {
	height: 80%;
	padding: 20px;
}

.m_footer {
	height: 10%;
	padding: 15px;
	background-color: #e7e5e5;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	display: flex;
	justify-content: end;
}

.modal_title {
	font-size: 18px;
	color: gray;
	font-weight: 500;
}

.close_btn {
	font-size: 20px;
	color: rgb(139, 139, 139);
	font-weight: 900;
	cursor: pointer;
}

.input_box {
	width: 100%;
	border: 1px solid rgb(189, 189, 189);
	height: 30px;
}

.modal_btn {
	width: 80px;
	height: 30px;
	border-radius: 5px;
	text-align: center;
	font-size: 14px;
	font-weight: bolder;
	padding-top: 5px;
	margin-left: 5px;
	font-family: sans-serif;
}

.cancle {
	background-color: white;
	color: black;
}

.save {
	background-color: rgb(50, 77, 158);
	color: white;
}

label{
	margin: 0;
}

#m_body {
	display: flex;
	flex-wrap: wrap;
	overflow: auto;
}

#m_body>div {
	display: flex;
	align-items: center;
	margin-right: 10px;
	margin-bottom: 10px;
}

#m_body input[type="checkbox"] {
	margin-right: 5px;
}

#selectedGames {
	display: flex;
	flex-wrap: wrap;
}

#selectedGames p {
	padding-right: 8px;
}

.profile_img_preview {
	display: inline-block;
	width: 100px;
	height: 100px;
	overflow: hidden;
	object-fit: cover;
	border-radius: 50%;
}

table{
	vertical-align: middle;
}

td:first-child {
	text-align: right;
	vertical-align: middle;
}

td:last-child {
	text-align: left;
	vertical-align: middle;
}
</style>


<div class="user_modify_page mt-3 mb-3">
	<h1>정보 수정</h1>
	<form id="userForm" action="submitUserInfo" method="post" enctype="multipart/form-data">
		<table class="table mt-3" style="width:80%; margin:auto;">
			<tr>
				<td width="25%">
					<label for="profile_img_preview">프로필 이미지</label>
				</td>
				<td width="75%">
					<c:if test="${loginUser.profile_img ne null}">
						<img class="profile_img_preview" id="preview" src="../resources/profileimg_upload/${loginUser.profile_img}">
					</c:if>
					<c:if test="${loginUser.profile_img eq null}">
						<img class="profile_img_preview" id="preview" src="../images/profile_example.png">
					</c:if>
					<input type="file" id="profile_img" name="profile_img" onchange="readImg(this);" accept="image/*">
				</td>
			</tr>
			<tr>
				<td width="25%">
					<label for="nickname">닉네임</label>
				</td>
				<td width="75%">
					<div style="margin: auto 0;">
						<input type="text" id="nickname" name="nickname" value="${loginUser.nickname}">
						
					</div>
				</td>
			</tr>
			<tr>
				<td><label for="sido_code">지역</label></td>
				<td>
					<b id="area_text_bold">${loginUser.area_text}</b>
					<input type="hidden" name="area_text" id="area_text" readonly value="${loginUser.area_text}">
					<input type="hidden" name="area_code" id="area_code" readonly value="${loginUser.area_code}">
					<button type="button" class="btn btn-sm btn-secondary" onclick="openAreaSelect()" style="margin:0em 1em;">지역 재설정</button>
					
					<div id="select_area" style="display: none; margin: 1em;">
						<select id="sido_code" name="sido_code">
							<option>선택</option>
						</select>
						<select id="sigoon_code" name="sigoon_code">
							<option>선택</option>
						</select>
						<select id="dong_code" name="dong_code">
							<option>선택</option>
						</select>
						<button type="button" class="btn btn-sm btn-secondary" onclick="doneAreaSelect()" style="margin:0em 1em;">완료</button>
					</div>
				</td>
			</tr>
			<tr>
				<td>선호 장르</td>
				<td>
					<input type="checkbox" id="genre1" name="genre" value="IQ"
						onclick="count_check_genre(this)">
					<label for="genre1">IQ</label>
					<input type="checkbox" id="genre2" name="genre" value="전략"
						onclick="count_check_genre(this)">
					<label for="genre2">전략</label>
					<input type="checkbox" id="genre3" name="genre" value="심리"
						onclick="count_check_genre(this)">
					<label for="genre3">심리</label>
					<input type="checkbox" id="genre4" name="genre" value="추리"
						onclick="count_check_genre(this)">
					<label for="genre4">추리</label>
					<input type="checkbox" id="genre5" name="genre" value="협동"
						onclick="count_check_genre(this)">
					<label for="genre5">협동</label>
					<input type="checkbox" id="genre6" name="genre" value="협상"
						onclick="count_check_genre(this)">
					<label for="genre6">협상</label>
					<input type="checkbox" id="genre7" name="genre" value="순발력"
						onclick="count_check_genre(this)">
					<label for="genre7">순발력</label>
					<input type="checkbox" id="genre8" name="genre" value="손기술"
						onclick="count_check_genre(this)">
					<label for="genre8">손기술</label>
				</td>
			</tr>
			<tr>
				<td>선호 게임 Top3</td>
				<td>
					<div id="selectedGames"></div>
					<button type="button" class="btn btn-sm btn-secondary" onclick="openGameModal()">게임 찾기</button>
				</td>
			</tr>
		</table>
		
		
	<div class="modal" id="modal">
		<div class="modal_body">
			<div class="m_head">
				<div class="modal_title">게임 목록</div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body" id="m_body">
				<c:forEach var="game" items="${gameList}">
					<div>
<%-- 						<input type="checkbox" name="games" value="${game}" onclick="count_check_game(this)">${game} --%>
					</div>
				</c:forEach>
			</div>
			<div class="m_footer">
				<div class="modal_btn cancle" id="close_btn_cancle">CANCLE</div>
				<div class="modal_btn save" id="save_btn">SAVE</div>
			</div>
		</div>
	</div>


	<br>
	<button class="btn btn-success" type="button" id="usermodify" onclick="submitForm()">수정하기</button>
	<button class="btn btn-dark" type="button" id="testSubmit" style="display: none;">반환값 테스트</button>
	</form>
</div>

<script>
	
	function readImg(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
			  document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}
		
	// 반환값 테스트 버튼 클릭 이벤트 처리
	document.getElementById("testSubmit").addEventListener("click", function() {
	    var formData = {
	      profile_img: document.getElementById("profile_img").value,
	      nickname: document.getElementById("nickname").value,
	      sido_code: document.getElementById("sido_code").value,
	      sigoon_code: document.getElementById("sigoon_code").value,
	      dong_code: document.getElementById("dong_code").value,
	      games: [],
	      genres: []
	    };
	
	    // 선택된 게임 정보 가져오기
	    var gameCheckboxes = document.getElementsByName("game");
	    for (var i = 0; i < gameCheckboxes.length; i++) {
	      if (gameCheckboxes[i].checked) {
	        formData.games.push(gameCheckboxes[i].value);
	      }
	    }
	
	    // 선택된 장르 정보 가져오기
	    var genreCheckboxes = document.getElementsByName("genre");
	    for (var i = 0; i < genreCheckboxes.length; i++) {
	      if (genreCheckboxes[i].checked) {
	        formData.genres.push(genreCheckboxes[i].value);
	      }
	    }
	
	    console.log("반환값 테스트: ", formData);
  	});
		
	$.support.cors = true;

	var area_kor_full_name = new Array(3);
	
	$(function() {
		//기존 설정 띄우기
		
// 		$('#area_text_bold').text(area_kor_full_name.join(" "));
		
		for(let ge=1 ; ge<9 ; ge++){
			let geid='#genre'+ge;
			let geid_value=$(geid).val();
			if('${loginUser.fgenre1}' == geid_value || '${loginUser.fgenre2}' == geid_value || '${loginUser.fgenre3}' == geid_value){
				console.log(geid_value);
				$(geid).prop("checked", true);
			}
		}

		const fav_games = [];
		if(${loginUser.fgame1 ne null}) fav_games.push("${loginUser.fgame1}");
		if(${loginUser.fgame2 ne null}) fav_games.push("${loginUser.fgame2}");
		if(${loginUser.fgame3 ne null}) fav_games.push("${loginUser.fgame3}");
		$("#selectedGames").text(fav_games.join(", "));
		console.log(fav_games);
		
		openGameModal();
		document.getElementById("modal").classList.remove("show");

		//-----------------------
		
		$.ajax({
			type : "get",
			url : "https://api.vworld.kr/req/data?key=E4041AA7-D585-39C3-9DC7-A5B6EA4C7B00&domain=http://localhost:9090/matchingboard/user/modify.jsp&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIDO_INFO",
			async : false,
			dataType : 'jsonp',
			success : function(data) {
				let html = "<option>선택</option>";
				console.log(data);
				data.response.result.featureCollection.features
						.forEach(function(f) {
							console.log(f.properties)
							let regionCode = f.properties.ctprvn_cd;
							let regionName = f.properties.ctp_kor_nm;
							console.log(regionCode)
							console.log(regionName)
							html += '<option value="' + regionCode + '">' + regionName + '</option>'
							//html += `<option value="\${regionCode}">\${regionName}</option>`
						})

				$('#sido_code').html(html);
				$('#sigoon_code').html('<option>선택</option>');
				$('#dong_code').html('<option>선택</option>');

			},
			error : function(xhr, stat, err) {
			}
		});

		$(document).on("change","#sido_code",function() {
			let thisVal = $(this).val();
			$('#area_code').val(thisVal);
			area_kor_full_name[0]=$("#sido_code option:checked").text();
			area_kor_full_name[1]=null;
			area_kor_full_name[2]=null;
// 			$('#area_text_bold').text(area_kor_full_name.join(" "));
// 			$('#area_text').val(area_kor_full_name.join(" "));
			
			$.ajax({
				type : "get",
				url : "https://api.vworld.kr/req/data?key=E4041AA7-D585-39C3-9DC7-A5B6EA4C7B00&domain=http://localhost:9090/matchingboard/user/modify.jsp&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIGG_INFO",
				data : {attrfilter : 'sig_cd:like:'+ thisVal},
				async : false,
				dataType : 'jsonp',
				success : function(data) {
					let html = "<option>선택</option>";
					console.log(data)
					data.response.result.featureCollection.features.forEach(function(f) {
								console.log(f.properties)
								let regionCode = f.properties.sig_cd;
								let regionName = f.properties.sig_kor_nm;
								html += '<option value="' + regionCode + '">' + regionName + '</option>'
								//html += `<option value="\${regionCode}">\${regionName}</option>`
							})
					$('#sigoon_code').html(html);
					$('#dong_code').html('<option>선택</option>');
				},
				error : function(xhr, stat, err) {
				}
			});
		});

		$(document).on("change","#sigoon_code",function() {
			let thisVal = $(this).val();
			$('#area_code').val(thisVal);
			area_kor_full_name[1]=$("#sigoon_code option:checked").text();
			area_kor_full_name[2]=null;
// 			$('#area_text_bold').text(area_kor_full_name.join(" "));
// 			$('#area_text').val(area_kor_full_name.join(" "));
			
			$.ajax({
				type : "get",
				url : "https://api.vworld.kr/req/data?key=E4041AA7-D585-39C3-9DC7-A5B6EA4C7B00&domain=http://localhost:9090/matchingboard/user/modify.jsp&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADEMD_INFO",
				data : {attrfilter : 'emd_cd:like:'+ thisVal},
				async : false,
				dataType : 'jsonp',
				success : function(data) {
					let html = "<option>선택</option>";
					data.response.result.featureCollection.features.forEach(function(f) {
								console.log(f.properties)
								let regionCode = f.properties.emd_cd;
								let regionName = f.properties.emd_kor_nm;
								html += '<option value="' + regionCode + '">' + regionName + '</option>'
								//html += `<option value="\${regionCode}">\${regionName}</option>`
							})
					$('#dong_code').html(html);
				},
				error : function(xhr, stat, err) {
				}
			});
		});
		
		$(document).on("change","#dong_code",function() {
			let thisVal = $(this).val();
			$('#area_code').val(thisVal);
			area_kor_full_name[2]=$("#dong_code option:checked").text();
// 			$('#area_text_bold').text(area_kor_full_name.join(" "));
// 			$('#area_text').val(area_kor_full_name.join(" "));
		});

	});

		
	function count_check_genre(checkbox) {
	    var checkboxes = document.getElementsByName("genre");
	    var totalChecked = 0;
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            totalChecked++;
	        }
	    }
	    if (totalChecked > 3) {
	        alert('3개 이상 선택할 수 없습니다.');
	        checkbox.checked = false;
	    }
	}
	
	function count_check_game(checkbox) {
	    var checkboxes = document.getElementsByName('game');
	    var totalChecked = 0;
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            totalChecked++;
	        }
	    }
	    if (totalChecked > 3) {
	        alert('3개 이상 선택할 수 없습니다.');
	        checkbox.checked = false;
	    }
	}
	
	
	var gameList = [
        <c:forEach items="${gameName}" var="game">
            '<c:out value="${game}" />',
        </c:forEach>
    ];
	
	
	
	function openGameModal() {
		// 게임 목록 초기화
		$("#m_body").empty();

		// 각 게임에 대한 체크박스 생성
		for (var i = 0; i <gameList.length; i++) {
			var checkBox = document.createElement("input");
			var label = document.createElement("label");
			var div = document.createElement("div");
			checkBox.type = "checkbox";
			checkBox.name = "game";
			checkBox.id=gameList[i];
			checkBox.value = gameList[i];
			checkBox.onclick = function() { count_check_game(this); };
			label.appendChild(document.createTextNode(gameList[i]));
			label.htmlFor = gameList[i];
			
			
 			if(${loginUser.fgame1 ne null} && '${loginUser.fgame1}' === gameList[i]){
 				checkBox.setAttribute("checked", true);
 			}else if(${loginUser.fgame2 ne null} && '${loginUser.fgame2}' === gameList[i]) {
 				checkBox.setAttribute("checked", true);
 			}else if(${loginUser.fgame3 ne null} && '${loginUser.fgame3}' === gameList[i]) {
 				checkBox.setAttribute("checked", true);
 			}
 			
 			div.appendChild(checkBox);
		
			div.appendChild(label);
			document.getElementById("m_body").appendChild(div);
		}

		// 모달 표시
		document.getElementById("modal").classList.add("show");
	}

	// 모달 닫기
	document.getElementById("close_btn").addEventListener("click", function() {
		document.getElementById("modal").classList.remove("show");
	});
		
	document.getElementById("close_btn_cancle").addEventListener("click", function() {
		document.getElementById("modal").classList.remove("show");
	});

	// 게임 저장 버튼 클릭 시 실행될 함수
	document.getElementById("save_btn").addEventListener( "click", function() {
		var checkedGames = [];
		$("#m_body input:checked").each(function() {
			checkedGames.push($(this).val());
		});
		
		$("#favGamesInput").val(checkedGames.join(", "));

		// 선택한 게임을 '#selectedGames' 요소에 표시
		$("#selectedGames").empty();
		for (var i = 0; i < checkedGames.length; i++) {
			if(i>0) $("#selectedGames").append(', ');
			$("#selectedGames").append('<span>' + checkedGames[i] + '</span>');
		}

		// 모달 닫기
		document.getElementById("modal").classList.remove("show");
	});
	
		
// 지역선택===========================
	function openAreaSelect() {
		// 숨겨진 선택 오픈
		$('#select_area').css("display", "block");
	}

	function doneAreaSelect(){
		$('#area_text').val(area_kor_full_name.join(" "));
		$('#area_text_bold').text(area_kor_full_name.join(" "));
		$('#select_area').css("display", "none");
	}
	
	
	function submitForm() {
		var formData = new FormData();
		
		// 프로필 이미지
		var profileImg = document.getElementById("profile_img").files[0];
		formData.append("profile_img", profileImg);
		
		// 닉네임
		var nickname = document.getElementById("nickname").value;
		formData.append("nickname", nickname);
		
		// 시도, 시군구, 동, 리 코드
// 		var sidoCode = document.getElementById("sido_code").value;
// 		var sigoonCode = document.getElementById("sigoon_code").value;
		var dongCode = document.getElementById("area_code").value;
		var areaText = document.getElementById("area_text").value;
// 		formData.append("sido_code", sidoCode);
// 		formData.append("sigoon_code", sigoonCode);
		formData.append("dong_code", dongCode);
		formData.append("area_text", areaText);

	 	 // 선택된 장르
		 var genres = [];
		 var genreCheckboxes = document.getElementsByName("genre");
		 for (var i = 0; i < genreCheckboxes.length; i++) {
 					if (genreCheckboxes[i].checked) {
	   					genres.push(genreCheckboxes[i].value);
	   					console.log(genreCheckboxes[i].value);
	   					formData.append("genres", genreCheckboxes[i].value);
 					}
		 }

		 var games = [];
		 var gameCheckboxes = document.getElementsByName("game");
		 for (var i = 0; i < gameCheckboxes.length; i++) {
 					if (gameCheckboxes[i].checked) {
	   					games.push(gameCheckboxes[i].value);
	   					console.log(gameCheckboxes[i].value);
	   					formData.append("games", gameCheckboxes[i].value);
 					}
		 }
		 //formData.append("genres", genres);
		 //formData.append("games", games);
		console.log(formData.getAll('games'));
		console.log(formData.getAll('genres'));

		// AJAX 요청
		$.ajax({
		  url: "submitUserInfo",
		  type: "POST",
		  data: formData,
		  processData: false,
		  contentType: false,
		  success: function(response) {
		    console.log("서버 응답: ", response);
		    if (response === 'success') {
		          window.location.href = "http://localhost:9090/matchingBoard/";
		      } else {
		          alert(response);
		      }
		  },
		  error: function(xhr, status, error) {
		    // 요청 실패 시 처리 로직
		    console.error("요청 실패: ", error);
		  }
		});
	}
</script>
