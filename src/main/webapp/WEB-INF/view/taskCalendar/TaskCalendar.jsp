<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 캘린더  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.3.1/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.3.1/main.min.js'></script>
<script src='/assets/demo-to-codepen.js'></script>
<!-- fullCalendar js import -->
<script src='${CTX_PATH}/js/fullcalendar/main.js'></script>
<script src='${CTX_PATH}/js/fullcalendar/ko.js'></script>
<script src='${CTX_PATH}/js/fullcalendar/moment.js'></script>
<style>
	.fc-toolbar-chunk{
		float:left;
	}
</style>
	
	
<script type="text/javascript">
	var calendarEl;
	var calendar;
	var TaskCalendarList;
	
	document.addEventListener('DOMContentLoaded', function() {
	    	calendarEl = document.getElementById('calendar');
    		calendar = new FullCalendar.Calendar(calendarEl, {
    	    initialView: 'dayGridMonth',
    	    contentHeight: 'auto',
    	    locale : 'ko',
    	    headerToolbar: {
    	      left : '',
    	      center: 'prev title next',
    	      right : 'today'
    	    },
    	   	events : function (info, callback){
    	   		$.ajax({
    	   			url : '/taskCalendar/TaskCalendarList.do',
    	   			type : 'POST',
    	   			data : {
    	   				  startDate: moment(info.start).format('YYYY-MM-DD')
    	   				, endDate: moment(info.end).format('YYYY-MM-DD')   				
    	   			},
    	   			dataType : 'json',
    	   			success : function(data){
    	   				var list = data.TaskCalendarList;
    	   				TaskCalendarList = [];
    	   				for(var i = 0; i < list.length; i++){
    	   					
	    	   					var vac_statColor = "";
	    	   					if(list[i].vac_stat == '대기'){
	    	   						vac_statColor = "#ff0000";
	    	   					}else if (list[i].vac_stat == '승인'){
	    	   						vac_statColor = "#006600";
	    	   					}else if (list[i].vac_stat == '반려'){
	    	   						vac_statColor = "#800080";
	    	   					} 
	    	   					
	    	   					var vac_stat = list[i].vac_stat;
	    	   					
	    	   					
	    	   				var CalendarList = {	
	    	   					// 이벤트 추가
    	   				        title : vac_stat +' '+list[i].vac_cnt+ '건 ',
    	   				        start : list[i].vac_rdate,
    	   				        color : vac_statColor,
    	   				        textColor : 'white',
    	   				        allDay : true,
    	   					};
	    	   				TaskCalendarList.push(CalendarList);
    	   				}//for문
	    	   			callback(TaskCalendarList);
    	   			}//success
    	   		});//ajax 
    	   	}, //events
    	   	eventClick : function(info){
    	   		var taDate = moment(info.event.start).format('YYYY-MM-DD');
    	   		var ta_info = info.event.title.split(' ');
    	   		var ta_info2 = ta_info[0];
    	   		var vac_stat;
    	   		if (ta_info2 == '대기'){
    	   			vac_stat = 1;
    	   		}else if (ta_info2 == '승인'){
    	   			vac_stat = 2;
    	   		}if (ta_info2 == '반려'){
    	   			vac_stat = 3;
    	   		}
    	   		
    	   		var ta_datail_title = '';
				$('#ta_detail_title').empty();
				ta_datail_title += '<strong>' + taDate + ' ' + ta_info2 + ' 건 현황</strong>';
				$('#ta_detail_title').append(ta_datail_title);
    	   		
    	   		$.ajax({
    	   			url : '/taskCalendar/TaskCalendarDetailList.do',
    	   			type : 'POST',
    	   			data : {
    	   				  taDate : taDate
    	   				, vac_stat : vac_stat  				
    	   			},
    	   			dataType : 'json',
    	   			success : function(data){
						var detailList = data.TaskCalendarDetailList;
						var vac_detailList = '';
						for(var i = 0; i < detailList.length; i++){
							$('#ta_detail').empty();
							vac_detailList += '<tr>';
							vac_detailList += '<td>'+ detailList[i].dept_name + '</td>';
							vac_detailList += '<td>'+ detailList[i].name + '</td>';
							vac_detailList += '<td>'+ detailList[i].vac_type + '</td>';
							vac_detailList += '</tr>';
							
							$('#ta_detail').append(vac_detailList);
						} //for
						
						gfModalPop('#layer1');
    	   			}//success
    	   		});//ajax 
    	   	}//eventClick
	    });
	    calendar.render();
	    
   	});
	
	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->
<body>

<!-- 모달 배경 -->
<div id="mask"></div>

<div id="wrap_area">

	<h2 class="hidden">header 영역</h2>
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

	<h2 class="hidden">컨텐츠 영역</h2>
	<div id="container">
		<ul>
			<li class="lnb">
				<!-- lnb 영역 --> <jsp:include
					page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
			</li>
			<li class="contents">
				<!-- contents -->
				<h3 class="hidden">contents 영역</h3> <!-- content -->
				<div class="content">

					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
							class="btn_nav bold">인사•급여</span> <span class="btn_nav bold">근태현황조회</span> <a href="/employee/empMgt.do" class="btn_set refresh">새로고침</a>
					</p>

					<p class="conTitle">
						<span>근태 현황 조회</span> 
					</p>
					<div id='calendar'></div>
					</div> <!--// content -->
				<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul>
	</div>
</div>

<!-- 모달팝업 -->
<div id="layer1" class="layerPop layerType2" style="width: 500px;">
	<dl>
		<dt id = "ta_detail_title">
		</dt>
		<dd class="content">
			<!-- s : 여기에 내용입력 -->
			<div style = "overflow-y : auto; overflow-x : hidden; height : 300px; width : 443px;">
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="30%">
						<col width="30%">
						<col width="35%">
					</colgroup>
					<thead>	
						<tr>
							<th scope = "col">부서</th>
							<th scope = "col">사원명</th>
							<th scope = "col">신청구분</th>
						</tr>
					</thead>
					<tbody id = "ta_detail">
					</tbody>
				</table>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
</body>

</body>
</html>
