<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
div{
	text-align: center;
	vertical-align: middle;
}
select{
	padding:5px;
	margin:5px;
}
.search_wrap{
	margin:10px;
}
td{
	vertical-align: middle;
	max-height: 190px;
}
</style>

<script type="text/javascript">
	$(function(){
		//모든 게임 목록 가져오기
		getAllGame();
	});
	
	const getAllGame=function(){
		$.ajax({
			type:'get',
			url:'games',
			dataType:'json',
			success:function(res){
				//alert(JSON.stringify(res))
				showGames(res);
			},
			error:function(err){
				alert(err.status);
			}
		})
	}//-------------------
	
	const showGames=function(res){
		$('#game_data').html('결과가 없습니다.');
		let str='<table class=" table-sm table-bordered table-hover"><tbody>';
		$.each(res, (i, game)=>{
			str+='<tr>';
			
			str+='<td width="15%">';
			str+='<img src="./images/gimages/' + game.gimage + '" style="width: 100%;"><br>';
			str+=game.name;
			str+='</td>';
			
			str+='<td width="30%">';
			str+=game.explane;
			str+='</td>';
			
			str+='<td width="7%">';
			str+=game.genre;
			str+='</td>';
			
			str+='<td width="10%">';
			str+=game.playtime + '분';
			str+='</td>';
			
			str+='<td width="7%">';
			str+=game.minPeople + ' ~ ' + game.maxPeople;
			str+='</td>';
			
			str+='<td width="10%">';
			str+=game.age + '세 이상';
			str+='</td>';
			
			str+='<td width="7%">';
			if(game.youtube_link!=null){
			str+='<a href="' + game.youtube_link + '"  target="_blank" rel="noopener noreferrer">열기</a>';
			}else{
				str+='-';
			}
			str+='</td>';
			
			str+='<td width="7%">';
			if(game.namu_link!=null){
			str+='<a href="' + game.namu_link + '"  target="_blank" rel="noopener noreferrer">열기</a>';
			}else{
				str+='-';
			}
			str+='</td>';

			str+='<td width="7%">';
			if(game.shop_link!=null){
			str+='<a href="' + game.shop_link + '"  target="_blank" rel="noopener noreferrer">열기</a>';
			}else{
				str+='-';
			}
			str+='</td>';
			
			str+='</tr>';
		})
		str+='</tbody></table>';
		$('#game_data').html(str);
	}//------------------------
	
	const getGameByGenre=function(genre){
		//alert(genre);
		$.ajax({
			type:'get',
			url:'genreSearch?genre='+genre,
			dataType:'json',
			cache:false
		})
		.done((res)=>{
			showGames(res);
		})
		.fail((err)=>{
			alert(err.status);
		})
		
	}//--------------------------------
	
	const gameInfo=function(){
	
		var keyword=$('#keyword').val();//키워드 입력값 가져오기
		var sType=$('#searchType').val();
		if(!keyword){
			alert('검색어를 입력하세요');
			$('#keyword').focus();
			return;
		}
		console.log('keyword: '+keyword);
		console.log('searchType: '+sType);
		//alert(encodeURIComponent(keyword));
		$.ajax({
			type:'get',
			url:'games?keyword='+encodeURIComponent(keyword)+'&searchType='+encodeURIComponent(sType),
			dataType:'json',
			cache:false
		})
		.done((res)=>{
			//alert(JSON.stringify(res))
			showGames(res);
		})
		.fail((err)=>{
			alert(err.status)
		})
	}//--------------------------------
	
	
</script>

<div>
	<div class="search_wrap">
		<div class="search_area">
			<select class="form-select" name="genreList" id="genre_select" onchange="getGameByGenre(this.value)">
				<option value="">::장르로 검색::</option>
				<option value="IQ">IQ</option>
				<option value="전략">전략</option>
				<option value="심리">심리</option>
				<option value="추리">추리</option>
				<option value="협동">협동</option>
				<option value="협상">협상</option>
				<!-- <option value="speed">스피드</option> -->
				<option value="순발력">순발력</option>
				<option value="손기술">손기술</option>
			</select>
			<span> / </span>
			<select name="searchType" class="form-select" id="searchType">
				<option value="T" <c:if test="${findType eq 'T'}">selected</c:if> >게임이름</option>
				<option value="P" <c:if test="${findType eq 'P'}">selected</c:if> >플레이시간</option>
				<option value="N" <c:if test="${findType eq 'N'}">selected</c:if> >인원</option>
				<option value="A" <c:if test="${findType eq 'A'}">selected</c:if> >연령</option>
			</select>
			<input type="text" name="keyword" id="keyword">
			<button type="button" onclick="gameInfo()" class="btn btn-outline-primary">Search</button>
		</div>
	</div>
	<table class="table table-sm table-bordered" border="1" style='margin-bottom:0'>
		<tr class="table-info info">
			<th style="width:15%;">게임 이름</th>
			<th style="width:30%;">게임 설명</th>
			<th style="width:7%;">장르</th>
			<th style="width:10%;">플레이시간</th>
			<th style="width:7%;">인원</th>
			<th style="width:10%;">연령</th>
			<th style="width:7%;"><img alt="" src="./images/youtube_logo.png" style="height: 1.2em;"></th>
			<th style="width:7%;"><img alt="" src="./images/namuwiki_logo.png" style="height: 1.2em;"></th>
			<th style="width:7%;">쇼핑</th>
		</tr>
	</table>
	<!-- ----------------------- -->
	<div id="game_data">결과가 없습니다.</div>
	<!-- ----------------------- -->
</div>