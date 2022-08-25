<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<title> 월별매출현황  </title>

<!-- google 차트 불러오기 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 원형 그래프 -->
<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
	 
	  var data = google.visualization.arrayToDataTable([
	
	    ['dog', 'options 아무거나'],
	    ['Work',     11],
	    ['Eat',      2],
	    ['Commute',  2],
	    ['Watch TV', 2],
	    ['Sleep',    7]
	  ]);
	  
	  var options = {
	    title: '강아지 야옹야옹'
	  };	  
	  
	  var itemdata = google.visualization.arrayToDataTable([
	                                                	
   	    ['cat', 'options 아무거나'],
   	    ['Work',     2],
   	    ['Eat',      5],
   	    ['Commute',  2],
   	    ['Watch TV', 1],
   	    ['Sleep',    20]
   	  ]);
	  
	  var itemoptions = {
	    title: '고양이 야옹야옹'
	  };	  
	
	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	  
	  var itemchart = new google.visualization.PieChart(document.getElementById('itemchart'));
	
	  chart.draw(data, options);
	  
	  itemchart.draw(itemdata, itemoptions);
	}
</script>
<!-- 원형 그래프 끝 -->

<!-- 막대 그래프 -->
<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(drawLineColors);
	
	function drawLineColors() {
	      var data = new google.visualization.DataTable();
	      data.addColumn('number', 'X');
	      data.addColumn('number', 'Dogs');
	      data.addColumn('number', 'Cats');
	
	      data.addRows([
	                    
	        [0, 0, 0],
	        [1, 10, 5],
	        [2, 23, 15],
	        [3, 17, 9],
	        [4, 18, 10],
	        [5, 9, 5],
	        [6, 11, 3], 
	        [7, 27, 19],
	        [8, 33, 25],
	        [9, 40, 32], 
	        [10, 32, 24],
	        [11, 35, 27]
	        
	      ]);
	
	      var options = {
	        hAxis: {
	          title: 'Time'
	        },
	        vAxis: {
	          title: 'Popularity'
	        },
	        colors: ['#a52714', '#097138']
	      };
	
	      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	      chart.draw(data, options);
	    }
</script>
<!-- 막대 그래프  끝 -->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 3;		// 화면에 뿌려질 데이터 수
	var pageBlock = 10;		// 블럭으로 잡히는 페이징 수 < 사실 무슨소린지 잘 모르겠 그러니까 블럭? 데이터 들어올 칸을 10칸 만들겠다는 소리?
	
	// ready 시켜놓는 함수들		
	$(document).ready(function () {
		
		$("#accall").change(function() {
			selectComCombo("cli", "cilall", "all", "", "");
		});
		selectComCombo("acc", "accall", "all", $("#accall").val(), "");
		
		selectComCombo("cli", "cilall", "all", "", "");
		selectComCombo("pro", "proall", "all", "", "");
		selectComCombo("dept", "deptall", "all", "", "");
		
		// 영업실적 리스트 불러오기
		fn_mmrvenuelist();
		
		// 버튼 누를때 작동하는것들
		fRegisterButtonClickEvent();	
		
		// 테이블 뒤집기
		convertTable();
		
	});
</script>	
<script type="text/javascript">
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_mmrvenuelist();
					console.log("searchBtn 작동함");
					break;
			}
		});
	}

	function fn_mmrvenuelist(curpage) {
		
		console.log("mmrvenuelist 작동함");
		curpage = curpage || 1;
			
		var param = {
			cilall : $("#cilall").val()
		   ,search : $("#search").val()
	       ,year : $("#year").val()  
	       ,to_date : $("#to_date").val() 
	       ,curpage : curpage
	       ,pageSize : pageSize
			};
		   
	    var mmrvenuelistcallback = function(returndata) {
	    	fn_mmrvenuelistcallback(returndata,curpage) ;  
	        }

	    callAjax("/sales/listMmRevenueModel.do", "post", "text", true, param, mmrvenuelistcallback);
	    
	}	
	
	function fn_mmrvenuelistcallback(returndata,curpage) {	   
	    console.log("fn_mmrvenuelistcallback 작동함");
	   
	    $("#mmrvenuelist").empty().append(returndata);	   
	    var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_mmrvenuelist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }	

	function convertTable(tbl) {
		console.log("convertTable 작동함");
	    var rows = tbl.rows.length;
	    var cols = tbl.rows[0].cells.length;
	    var tbl2 = document.createElement('table');

	    for (var i = 0; i < cols; i++) {
	        var tr = document.createElement('tr');
	        for (var j = 0; j < rows; j++) {
	            var td = document.createElement('td');
	            var tdih = tbl.rows[j].cells[i].innerHTML;
	            td.innerHTML = tdih;
	            tr.appendChild(td);
	        }
	        tbl2.appendChild(tr);
	    }
	    return tbl2;
	}
	
</script>	
</head>

<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
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
							<span>월별 매출 현황 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
							</span>
						</p>
						
					<!--검색창  -->
                     <table width="100%" cellpadding="5" cellspacing="0" border="1"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue" items="${listMmRevenueModel}" var="list" align="center">
                        	<!-- 사번, 달성률, 부서명, 사원명, 실적수량 확인 박스 -->
                           <td width="40" height="25" style="font-size: 100%">거래처</td>
                           
                           <td width="40" height="25" style="font-size: 100%">
                           	<select id="cilall" name="cilall" v-model="cilall"></select>
                           </td> 
                           
                           <td width="50" height="25" style="font-size: 100%">기간 조회</td>
                            <td width="50" height="25" style="font-size: 100%">
                            <input type="year" style="width: 120px" id="year" name="year"></td>
                           <td width="50" height="25" style="font-size: 100%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조  회</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table> 
						<div class="divmmrvenuelist">
							<table class="col" > <!-- style="table-layout: fixed;  text-overflow:ellipsis; overflow:hidden; white-space:nowrap;" -->
								<caption>caption</caption>
		                            <colgroup>
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">수주날짜</th>
							              <th scope="col">기업 코드</th>
							              <th scope="col">기업 명</th>
							              <th scope="col">직원 코드</th>
							              <th scope="col">제품 대분류 명</th>
							              <th scope="col">제품 이름</th>
							              <th scope="col">제품 가격</th>
							              <th scope="col">주문 갯수</th>
							              <th scope="col">총액</th>
									</tr>
								</thead>
								<tbody id="mmrvenuelist"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>
					<table>
						<tr>
						
							<!-- 막대 그래프 -->
							<th id="chart_div" style="width: 450px; height: 250px;"></th>
							
							
						</tr>	
						
						<tr>
						
							<!-- 원형 차트 -->
							<th id="piechart" style="width: 450px; height: 250px;"></th>
							<!-- 원형 차트 -->
							<th id="itemchart" style="width: 450px; height: 250px;"></th>
							
						</tr>
						
					</table>
					
					
		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>						

</body>
</html>