<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="myctx" value="${pageContext.request.contextPath}" />

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>간단한 지도 표시하기</title>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fbgfk756mi&submodules=geocoder"></script>
<style type="text/css">
#foot-container {
	display: none;
}

.navbar {
	display:none;
}

.container{
	margin:0px;
	max-width: none;
}

#total_container{
	margin:0px;
	min-width: 100px;
}

#wrap .buttons {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1000;
	padding: 5px;
}

#wrap .buttons .control-btn {
	margin: 0 5px 5px 0;
}
#search-container {
	position: absolute;
	top: 0;
	left: 50%;
	transform: translateX(-50%);
	z-index: 1000;
}

#search-container input[type="text"] {
	width: 250px;
}

#search-container input[type="submit"] {
	padding: 5px 10px;
	background-color: #337ab7;
	color: #fff;
	border: none;
	cursor: pointer;
}
#map{
//	position: absolute; 
//	top: 40px; 
//	left: 0; 
//	right: 0; 
//	bottom: 0;
}

.shopList{
	overflow:auto;
	height: 85vh;
}

.shopList_detail{
	font-size: 0.9em;
}

#shopList_name{
	font-weight: bold;
	font-size: 1.15em;
}

</style>	

<!--<div id="map" style="width:100%;height:400px;"></div>-->
<div class="row ml-1 mr-1" style="height:95vh;">
	<div class="col-4">
		<div class="mt-3 mb-2 text-center" id="shopSearchDiv">
			<input type="text" name="keyword" id="keyword">
			<button type="button" onclick="searchShop()" class="btn btn-sm btn-outline-primary">Search</button>
		</div>
		<div class="shopList" id="shopList">
		<!-- Shop List -->
		</div>
	</div>
	<div class="col-8" id="map" ></div>
	<!-- 
	<div id="search-container">
		<input type="text" id="address" placeholder="지역을 검색하세요.">
		<input type="submit" id="submit" value="검색">
	</div>
	 -->
</div>

<script type="text/javascript">

	const searchShop=function(){
		var keyword=$('#keyword').val();//키워드 입력값 가져오기
		if(!keyword){
			alert('검색어를 입력하세요');
			$('#keyword').focus();
			return;
		}
		console.log('keyword: '+keyword);
		//alert(encodeURIComponent(keyword));
		
		$.ajax({
			type:'get',
			url:'shops?keyword=' + encodeURIComponent(keyword),
			dataType:'json',
			cache:false
		})
		.done((res)=>{
			//alert(JSON.stringify(res))
			showShopList(res);
		})
		.fail((err)=>{
			alert(err.status)
		})
	}//--------------------------------

	$(function(){
		//모든 게임 목록 가져오기
		getAllShop();
	});
	
	const getAllShop=function(){
		$.ajax({
			type:'get',
			url:'shops',
			dataType:'json',
			success:function(res){
				//alert(JSON.stringify(res))
				showShopList(res);
			},
			error:function(err){
				alert(err.status);
			}
		})
	}//-------------------

	var markers = [];
	
	const showShopList=function(res){
		$('#shopList').html('결과가 없습니다.');
		let str='<table class=" table-sm table-bordered table-hover"><tbody>';
		$.each(res, (i, shop)=>{

			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(shop.mapx, shop.mapy),
			    map: map
		  	});
		  	naver.maps.Event.addListener(marker, 'click', function() {
			  	var content = '<div style="padding:10px;">'
			  		+ '<h5>' + shop.sname + '</h5>'
			  		+ '<button class="btn btn-sm btn-outline-secondary" onclick="selectStore(&#39;' + shop.sname + '&#39; , &#39;' + shop.shopid + '&#39;)">선택하기</button>'	// &#34; => 따옴표(")
			  		+ '</div>';
			  	infowindow.setContent(content);
			  	infowindow.open(map, marker);
		  	});
			markers.push(marker);
			
			
			str+='<tr>';
			str+='<td onclick="setMapCenterShop(' + shop.mapx + ',' + shop.mapy + ')">';
			
			str+='<button class="btn btn-light font-weight-bold" onclick="selectStore(&#39;' 
				+ shop.sname + '&#39; , &#39;' + shop.shopid + '&#39;)">' + shop.sname + '</button>'
			str+='<span class="float-right" style="color: #32CD32;">&bigstar;' + shop.stars + '</span>';
			str+='<br><p style="font-size:0.8em;">' + shop.saddr + '</p>';
			
			str+='<a class="shopList_detail" href="#" onclick="">메뉴판 보기 </a>';
			if(shop.hour_price > 0)
				str+='<span class="shopList_detail float-right">' + shop.hour_price + ' / 1시간</span>';
			str+='<br><a class="shopList_detail" href="#" onclick="">가격표 보기 </a>';
			if(shop.unlim_price > 0)
				str+='<span class="shopList_detail float-right">' + shop.unlim_price + ' / 무제한</span>';
			
			str+='</td>';
			str+='</tr>';
			
		});
		str+='</tbody></table>';
		$('#shopList').html(str);
	}//------------------------
	
	function setMapCenterShop(shop_mapx, shop_mapy){
		var location = new naver.maps.LatLng(shop_mapx, shop_mapy);
	    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정.
	    
    }
	
</script>

<script>
		//현재 위치 얻어오기
		var infowindow = new naver.maps.InfoWindow();
		//지도 생성 시에 옵션을 지정할 수 있습니다.
		var map = new naver.maps.Map('map', {
			//center : location, //지도의 초기 중심 좌표
			//zoom : 14, //지도의 초기 줌 레벨
			minZoom : 7, //지도의 최소 줌 레벨
			zoomControl : true, //줌 컨트롤의 표시 여부
			zoomControlOptions: {//줌 컨트롤러의 옵션
	            style: naver.maps.ZoomControlStyle.SMALL,
	            position: naver.maps.Position.TOP_RIGHT
	        }
		});
		console.log("지도 초기화 완료");

		function onSuccessGeolocation(position) {
			var location = new naver.maps.LatLng(position.coords.latitude,
					position.coords.longitude);
			var zoom = 16;

			map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
			map.setZoom(zoom); // 지도의 줌 레벨을 변경합니다.

			//infowindow.setContent('<div style="padding:3px;">' + '현재위치' + '</div>');

			//infowindow.open(map, location);//현 위치 설명 말풍선
			//console.log('Coordinates: ' + location.toString());
		}

		function onErrorGeolocation() {
			var center = map.getCenter();

			infowindow.setContent('<div style="padding:20px;">'
							+ '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'
							+ "latitude: " + center.lat() + "<br />longitude: "
							+ center.lng() + '</div>');

			infowindow.open(map, center);
		}
		
		$(window).on("load",function() {
			if (navigator.geolocation) {
				/**
				 * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
				 * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
				 * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
				 */
				navigator.geolocation.getCurrentPosition(
						onSuccessGeolocation,
						onErrorGeolocation);
			} else {
				var center = map.getCenter();
				infowindow
						.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
				infowindow.open(map, center);
				map.add(markers);
			}
		});

		function selectStore(sname, shopid) {
			   alert("매장이 선택되었습니다.");
			   opener.document.getElementById("rplace").value = sname;
			   opener.document.getElementById("shopid").value = shopid;
			   window.close(); // 팝업 창을 닫습니다.
			}
		
		//지도 컨트롤
		$("#controls").on("click", function(e) {
			e.preventDefault();

			if (map.getOptions("scaleControl")) {
				map.setOptions({ //모든 지도 컨트롤 숨기기
					scaleControl : false,
					logoControl : false,
					mapDataControl : false,
					zoomControl : false,
					mapTypeControl : false
				});
				$(this).removeClass('control-on');
			} else {
				map.setOptions({ //모든 지도 컨트롤 보이기
					scaleControl : false,
					logoControl : false,
					mapDataControl : false,
					zoomControl : true,
					mapTypeControl : false
				});
				$(this).addClass('control-on');
			}
		});

//		var locationBtnHtml = '<a href="#" class="btn_mylct"><span class="spr_trff spr_ico_mylct">To Current Location</span></a>';
		var locationBtnHtml = '<button style="padding:2px;"><img src="${myctx}/images/curLocation.png" style="width:30px; height:30px;"></button>';
		
		naver.maps.Event.once(map, 'init', function() {
			//customControl 객체 이용하기
			var customControl = new naver.maps.CustomControl(locationBtnHtml, {
				position : naver.maps.Position.TOP_LEFT
			});

			customControl.setMap(map);

			naver.maps.Event.addDOMListener(customControl.getElement(),'click', function() {
				if (navigator.geolocation) {
			        navigator.geolocation.getCurrentPosition(function(position) {
			            var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
			            map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
			        }, function() {
			            alert("현재 위치 정보를 받아오는데 실패했습니다.");
			        });
			    } else {
			        alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.");
			    }
			});
		});
		
// 		function searchAddressToCoordinate(address) {
// 		    naver.maps.Service.geocode({
// 		        query: address
// 		    }, function(status, response) {
// 		        if (status === naver.maps.Service.Status.ERROR) {
// 		            return alert('Something Wrong!');
// 		        }
// 		        if (response.v2.meta.totalCount === 0) {
// 		            return alert('올바른 주소를 입력해주세요.');
// 		        }
// 		        var htmlAddresses = [],
// 		            item = response.v2.addresses[0],
// 		            point = new naver.maps.Point(item.x, item.y);
// 		        if (item.roadAddress) {
// 		            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
// 		        }
// 		        if (item.jibunAddress) {
// 		            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
// 		        }
// 		        if (item.englishAddress) {
// 		            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
// 		        }
// 		        map.setCenter(point);
// 		        insertAddress(item.roadAddress, item.x, item.y);
// 		    });
// 		}

		// 주소 검색 이벤트 처리
// 		$('#address').on('keydown', function(e) {
// 		    var keyCode = e.which;
// 		    if (keyCode === 13) { // Enter Key
// 		        searchAddressToCoordinate($('#address').val());
// 		    }
// 		});
		
// 		$('#submit').on('click', function(e) {
// 		    e.preventDefault();
// 		    searchAddressToCoordinate($('#address').val());
// 		});
</script>