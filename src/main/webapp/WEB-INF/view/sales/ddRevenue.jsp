<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<title> 일별매출현황  </title>

<!-- 그래프 시작 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load('visualization', '1', {packages: ['corechart']});
</script>
<script type="text/javascript">    
function drawVisualization() {
// Some raw data (not necessarily accurate)
var data = google.visualization.arrayToDataTable([
['날짜', '2011년', '2010년', '2009년'],
['1월 1주',  30,      40,         20],
['1월 2주',  40,      20,        30],
['1월 3주',  25,      30,        50],
['1월 4주',  50,      70,        80],
['2월 1주',  70,      70,         60],
['2월 2주',  200,      200,         150],
['2월 3주',  100,      120,         10],
['2월 4주',  25,      30,         50],
['3월 1주',  28,      50,         80],
['3월 2주',  83,      90,         80],
['3월 3주',  78,      80,         30],
['3월 4주',  120,      50,         80],
['4월 1주',  405,      350,         280],
['4월 2주',  203,      100,         120],
['4월 3주',  10,      50,         30],
['4월 4주',  11,      30,         50]
]);
 
var options = {
title : '2011년 ',
vAxis: {title: "인원"},
hAxis: {title: "날짜"},
seriesType: "bars",
series: {1: {type: "line"},2: {type: "line"}}
};
var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
chart.draw(data, options);
}
google.setOnLoadCallback(drawVisualization);
</script>
<!-- 그래프 끝 -->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;		// 화면에 뿌려질 데이터 수
	var pageBlock = 10;		// 블럭으로 잡히는 페이징 수 < 사실 무슨소린지 잘 모르겠 그러니까 블럭? 데이터 들어올 칸을 10칸 만들겠다는 소리?
	
	// ready 시켜놓는 함수들		
	$(document).ready(function () {
		
		// 영업실적 리스트 불러오기
		fn_ddrvenuelist();
		
		// 버튼 누를때 작동하는것들
		fRegisterButtonClickEvent();
	});	
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_ddrvenuelist();
					console.log("searchBtn 작동함");
					break;
			}
		});
	}

	function fn_ddrvenuelist(curpage) {
		
		console.log("ddrvenuelist 작동함");
		curpage = curpage || 1;
			
		var param = {
			searchitem : $("#searchitem").val()
		   ,search : $("#search").val()
	       ,to_month : $("#to_month").val()  
	       ,curpage : curpage
	       ,pageSize : pageSize
			};
		   
	    var ddrvenuelistcallback = function(returndata) {
	    	fn_ddrvenuelistcallback(returndata,curpage) ;  
	        }

	    callAjax("/sales/listDdRevenueModel.do", "post", "text", true, param, ddrvenuelistcallback);
	    
	}	
	
	function fn_ddrvenuelistcallback(returndata,curpage) {	   
	    console.log("fn_ddrvenuelistcallback 작동함");
	   
	    $("#ddrvenuelist").empty().append(returndata);	   
	    var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_ddrvenuelist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }	

</script>

</head>

<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
<div id="chart_div" style="width: 900px; height: 500px;"></div>	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="selectannno" id="selectannno" value=""> 
    <input type="hidden" id="pln_no"  name="pln_no"  value="">
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav bold">시스템 관리</a> 
								<span class="btn_nav bold">공지 사항</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>일별 매출 현황 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue" items="${listDdRevenueModel}" var="list">
                        	<!-- 사번, 달성률, 부서명, 사원명, 실적수량 확인 박스 -->
                           <td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='searchitem'>
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
                           
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="search" name="search"></td>

                           <td width="50" height="25" style="font-size: 100%">월 조회</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="month" style="width: 120px" id="to_month" name="to_month"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조  회</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                        <tr style="border: 0px; border-color: blue">
                           <td align="center" width="50" height="25" style="font-size: 100%">품목별</td>
							
							<td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='searchitem'>
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
							
                           <td width="50" height="25" style="font-size: 100%">제품 이름</td>
                           <td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='si_nm'>
                                  
                                 
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
                        </tr>
                     </table>    
						
						
						<div class="divddrvenuelist">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="20%">
						                   <col width="20%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">수주날짜</th>
							              <th scope="col">기업 코드</th>
							              <th scope="col">기업 명</th>
							              <th scope="col">직원 코드</th>
							              <th scope="col">제품 대분류 명</th>
							              <th scope="col">제품 이름</th>
							              <th scope="col">수주 총액</th>
							              <th scope="col">미수 금액</th>
									</tr>
								</thead>
								<tbody id="ddrvenuelist"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>



</body>
</html>