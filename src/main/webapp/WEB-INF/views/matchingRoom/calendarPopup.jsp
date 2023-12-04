<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
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
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<div class="calendar-outer-container">
	<div id='calendar-container'>
	    <div id='calendar'></div>
	</div>
</div>

<script>
	$(function(){
		var eventArr=[];
		var etitle = '${rplace}';
		let rdatetime = '${rstart}';
		
		jsonData={
			title: etitle,
			start: rdatetime
		};

		eventArr.push(jsonData);
		
		var calendarEl = $('#calendar')[0];
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			height: 'auto',
			expandRows: true, // 화면에 맞게 높이 재설정
			slotMinTime: '00:00', // Day 캘린더에서 시작 시간
			slotMaxTime: '24:00', // Day 캘린더에서 종료 시간
			// 해더에 표시할 툴바
			headerToolbar: {
			  left: 'prev,next',
			  center: 'title',
			  right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
			},
			initialView: 'listMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
			fixedWeekCount: false, //비활성화 주 표시
			editable: false, // 수정 가능?
			selectable: false, // 달력 일자 드래그 설정가능
			nowIndicator: true, // 현재 시간 마크
			dayMaxEvents: 3, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
			locale: 'ko', // 한국어 설정
			
			// 이벤트 
			events: eventArr
	    });
		// 캘린더 랜더링
		calendar.render();
	});
</script>