<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<title> 일별매출현황  </title>

<!-- google 차트 불러오기 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 원형 그래프 -->
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
	  
    var data = google.visualization.arrayToDataTable([

      ['Task', 'options 아무거나'],
      ['Work',     11],
      ['Eat',      2],
      ['Commute',  2],
      ['Watch TV', 2],
      ['Sleep',    7]
    ]);
	
    var options = {
      title: '매출 별 기업 비율'
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  }
</script>
<!-- 원형 그래프 끝 -->


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 6;		// 화면에 뿌려질 데이터 수
	var pageBlock = 10;		// 블럭으로 잡히는 페이징 수 < 사실 무슨소린지 잘 모르겠 그러니까 블럭? 데이터 들어올 칸을 10칸 만들겠다는 소리?
	
	// ready 시켜놓는 함수들		
	$(document).ready(function () {
		
	    //  selectComCombo(comtype, combo_name, type, searchkey,selvalue)	
		//  comtype    dept : 부서      acc  : 회계계정 대분류  accd  : 회계계정 분류   cli : 거래처    pro : 제품(전채) 
		//  combo_name   select id
		//  type    sel : 선택   all : 전체
		//  searchkey    comtype이 회계계정 중분류인 경우  회계 계정 대분류 코드
		$("#accall").change(function() {
				selectComCombo("cli", "cilall", "all", "", "");
			});
			selectComCombo("acc", "accall", "all", $("#accall").val(), "");
			
			selectComCombo("cli", "cilall", "all", "", "");
			selectComCombo("pro", "proall", "all", "", "");
			selectComCombo("dept", "deptall", "all", "", "");		
	    
		$("#prolall").change(function() {
			productCombo("m", "promall", "all", $("#prolall").val(), "");
            
			//대분류를 바꾸면 중,제,부서가 지워져야지 새로운 조건이 보이기 때문에 remove를 사용한다.
			$('#prodall').children('option').remove();
		});
		
		// 영업실적 리스트 불러오기
		fn_ddrvenuelist();
		
		// 버튼 누를때 작동하는것들
		fRegisterButtonClickEvent();
	});	
	</script>
<!-- 	<!-- 그래프 시작 -->
	<script type="text/javascript">
	google.load('visualization', '1', {packages: ['corechart']});
	</script>
	<script type="text/javascript">    
	function drawVisualization() {
		
		 var param = {
				    cilall : $("#cilall").val()
				   ,search : $("#search").val()
			       ,from_date : $("#from_date").val()  
			       ,to_date : $("#to_date").val() 
			       ,curpage : 1
			       ,pageSize : pageSize
		};

	
		 

	//var graphparm = [['종류', '매출']];
	var graphparm = [];
	//graphparm.push("['종류', '매출']");
	//graphparm.push(["['" + "종류" + "'," + "'매출" + "']"]);
    var returndatacallback;
	
	
	var ddrvenuelistcallback = function(returndata) {
			 
		   console.log("returndata " + JSON.stringify(returndata));
		   returndatacallback = returndata;
		   //data.addRows(returndata.listCopItemOrdercnt);
		   
		   var insertkey = "";
		   var insertvalue = 0;
		   var lloop = 0;
		   
		   			//graphparm.push("[[\'종류\', \'매출\']")
		   
				   $.each(returndata.listCopItemOrder, function(key, lvalue){
					   //console.log('key:' + key + ' / ' + 'value:' + JSON.stringify(lvalue));
					   $.each(lvalue, function(key, value){
				 		   //console.log('key:' + key + ' / ' + 'value:' + JSON.stringify(value));
				 		   if(key == "bi_nm") {
				 			   insertkey = String(value);
				 		   }
				 		   if(key == "sumtotal") {
				 			   insertvalue = parseInt(value);
				 		   }				    		   
			 	       });
					   
					   //graphparm += "[\'" + insertkey + "\', " + insertvalue + "],";
					   //var item = "[\'" + insertkey + "\', " + insertvalue + "],";
					   var item= [];
					   item.push("[\'" + insertkey + "\'");
					   item.push(insertvalue + "]");
					   
					   //item.push(insertkey);
					   //item.push(insertvalue);
					   
					   console.log("item : " + item);
					   //graphparm.setCell(lloop, 0, insertkey);
					   //graphparm.setCell(lloop, 1, insertvalue);
					   
					   graphparm.push(item);
					   
					   console.log("graphparm : " + graphparm);
					   //graphparm.push(["['" + insertkey + "'",insertvalue + "]"]);
					   //graphparm.push([insertkey ,insertvalue]);
					   
					  
					   lloop ++;
				   });
				   
				   //graphparm += "]";
		   			//graphparm.push("]");
				   console.log("graphparm : " + graphparm);
					
					/* var graphparm = {
							graphparm : $("#graphparm").val()
							};	 */			
			}
			

			callAjax("/sales/selectlduv.do", "post", "json", true, param, ddrvenuelistcallback);

			console.log("graphparm2 : " + graphparm.toString());
			
			var data = google.visualization.arrayToDataTable(graphparm); 
			data.addColumn('string', '종류');  
			data.addColumn('number', '매출');
	        
			//var data = google.visualization.arrayToDataTable([['종류', '매출'],['Router', 10320000],['UPS', 1400000],['서버', 7000000],]);
			data = google.visualization.arrayToDataTable([['종류', '매출'],['Router', 10320000],['UPS', 1400000],['서버', 7000000],]);
			
			var options = {
			title : '분류 별 매출',
			vAxis: {title: "총 매출"},
			hAxis: {title: "분류"},
			seriesType: "bars",
			series: {} // vartical 축 기준으로 0번,1번,2번 타입 변경 할수 있음 ex > 1: {type: "line"}
			};
			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			chart.draw(data, options);
			}
			
			google.setOnLoadCallback(drawVisualization);
	</script>
	그래프 끝	 -->
<script type="text/javascript">
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
			cilall : $("#cilall").val()
		   ,search : $("#search").val()
	       ,from_date : $("#from_date").val()  
	       ,to_date : $("#to_date").val() 
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
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue" items="${listDdRevenueModel}" var="list" align="center">
                        	<!-- 사번, 달성률, 부서명, 사원명, 실적수량 확인 박스 -->
                           <td width="40" height="25" style="font-size: 100%">거래처</td>
                           
                           <td width="40" height="25" style="font-size: 100%">
                           	<select id="cilall" name="cilall" v-model="cilall"></select>
                           </td> 
                           
                           <td width="50" height="25" style="font-size: 100%">기간 조회</td>
                            <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조  회</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table> 
						<div class="divddrvenuelist">
							<table class="col">
								<caption>caption</caption>
		                            <colgroup>
						                   <col width="10%">
						                   <col width="7%">
						                   <col width="20%">
						                   <col width="8%">
						                   <col width="10%">
						                   <col width="20%">
						                   <col width="8%">
						                   <col width="7%">
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
							              <th scope="col">제품 가격</th>
							              <th scope="col">주문 갯수</th>
							              <th scope="col">총액</th>
									</tr>
								</thead>
								<tbody id="ddrvenuelist"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>
					<table>
						<tr>
							<!-- 차트 -->
							<!-- <th id="chart_div" style="width: 450px; height: 250px;"></th> -->
							<!-- 원형 차트 -->
							<th id="piechart" style="width: 450px; height: 250px;"></th>
						</tr>	
						
			<c:forEach items="${listCopItemOrder}" var="list">			
						<td>${list.sumtotal}</td>
			</c:forEach>
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