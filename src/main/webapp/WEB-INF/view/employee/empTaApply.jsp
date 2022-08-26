<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeEmpTaApply = 5;
	var pageBlockSizeEmpTaApply = 5; 
	
	/** OnLoad event */ 
	$(function() {
	
		//로그인한 사람 연차 조회 
		//fListEmpTaApplyVac();  
		
		//콤보박스 설정
		fn_init(); 
		
		//로그인한 사람 휴가일수 조회 
		fListLoginVac(); 
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function fn_init() {
		comcombo("VACcd", "vactype", "all", "")	
		comcombo("Okcd", "apptype", "all", "");
		comcombo("VACcd", "fvactype", "all", "")
		
		console.log('usertype 호출'+ $("#userType").val()  ); 
		 
	}
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		 $('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'empTaApplySearchBtn' :
					fListEmpTaApply();
					break;
				case 'SaveBtnEmpTaApply' :
					$("#btnUpdateEmpDtlTaApply").hide();
					fPopModalEmpTaApply();
					
					break;
				case 'btnInsertEmpFormTaApply' :
					fSaveModalEmpTaApply(); 
					break;
				case 'btnDeleteEmpDtlTaApply' :
					$("#action").val("D");
					fUpDelEmpDtlTaApply();
					break;
				 case 'btnUpdateEmpDtlTaApply':
					 $("#action").val("U");
					 fUpDelEmpDtlTaApply();
					break; 				
				case 'btnCloseEmpDtlTaApply' :
					gfCloseModal();
					break;
				case 'btnapproveEmpDtlTaApply' :
					$("#action").val("U");
					 fn_approveEmpDtlTaApply();
					break; 				
				case 'btnrejectEmpDtlTaApply' :
					$("#action").val("U");
					fn_rejectEmpDtlTaApply();
					break; 				
					

		 	}
		}); 
	}
	
	 /* 휴가일수 조회 */
	  function fListLoginVac() {
		 console.log('fListLoginVac func 호출'); 
		 
		 var param = {}
		
		 var resultCallback = function(data){
			 
			 console.log("resultCallback : " + data);
			 
			 fListLoginVacResult(data); 
		 }; 
		 
		 callAjax("/employee/listLoginVac.do", "post", "text", true,param,resultCallback); 
		
	} 
	
	 /*휴가일수 콜백함수 조회 */
	function fListLoginVacResult(data){
		
		console.log('fListLoginVacResult data',data); 
		
		//기존 목록 삭제 	
   		$("#vacRemain").empty();
		
		//신규 목록 생성 
		$("#vacRemain").append(data); 
		
		// 그룹코드 조회
		fListEmpTaApply();
	
	}  
	
	/* 휴가신청서 폼 초기화 */
	   function fInitFormEmpTaApply(object) {
		
		if( object == "" || object == null || object == undefined) {
			
			
			$("#start_date").val("");
			$("#end_date").val("");
			$("#vac_content").val("");
			$("#tel").val("");

		   $("#action").val("I");
		  
		
		} /* else {
			
		 	$("#start_date").val(object.start_date);
			$("#end_date").val(object.end_date);
			$("#vac_content").val(object.vac_content);
			$("#tel").val(object.tel);
			
			$("#btnDeleteEmpDtlTaApply").show();	
			   
		    $("#action").val("U"); */
			  
	 	
	}    
	
    /*휴가신청 저장  정보 데이터 삽입 함수*/
	function fSaveModalEmpTaApply(){
		
		//수정버튼 안보이게 
		$("#btnUpdateEmpDtlTaApply").hide();
    	
		// vaildation 체크
		if ( ! fValidateEmpTaApply() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveModalEmpTaApplyResult(data);
		};
		
		callAjax("/employee/saveEmpTaApply.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
			
	}
	
	/*휴가신청 저장  콜백함수*/
	function fSaveModalEmpTaApplyResult(data){
		
		 // 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageEmpTaApply").val();
		}
		
		if(data.result = "SUCCESS"){
			 if($("#action").val() == "D") {
				   alert("삭제 되었습니다.");
			   } else {
				   alert("저장 되었습니다.");
			   }
		}
			// 모달 닫기
			gfCloseModal();
			
			// 그룹코드 조회
			fListEmpTaApply();
		
		// 입력폼 초기화
		fInitFormEmpTaApply(); 
		
	}
	
	
	
	/* 휴가신청서 폼 저장 validation */
	 function fValidateEmpTaApply() {

		var chk = checkNotEmpty(
				[
						[ "vac_content", "휴가 사유를 입력해 주세요." ]
					,	[ "tel", "전화번호를 입력해 주세요" ]
					,	["start_date", "시작일 입력"]
					,	["end_date","종료일 입력"]
					,   ["fvactype", "휴가 종류 입력"]
					
				]
		);

		if (!chk) {
			return;
		}

		return true;
	} 
	
		/* 그룹코드 저장 콜백 함수 */
		/*  function fSaveGrpCodResult(data) {
			
			
		}  */
	
	/** 휴가리스트 조회 */
	 function fListEmpTaApply(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);
		
		
		var param = {	
					vactype : $("#vactype").val()  
				,   apptype : $("#apptype").val()  
				,	from_date : $("#from_date").val() 
				,	to_date : $("#to_date").val() 
				, 	currentPage : currentPage
				,	pageSize : pageSizeEmpTaApply
		}
		
		var resultCallback = function(data) {
			flistEmpTaApplyResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/employee/listEmpTaApply.do", "post", "text", true, param, resultCallback);
	} 
	
	/* 휴가리스트  조회 콜백 함수 */
	 function flistEmpTaApplyResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listEmpTaApply').empty();
		
		// 신규 목록 생성
		$("#listEmpTaApply").append(data);
		
		// 총 개수 추출
		
		var totalCntEmpTaApply = $("#totalCntEmpTaApply").val();

		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntEmpTaApply, pageSizeEmpTaApply, pageBlockSizeEmpTaApply, 'fListEmpTaApply');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#empTaApplyPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageEmpTaApply").val(currentPage);
	} 
	
	function fPopModalEmpTaApply(){
		
		
		$("#action").val("I");
		
		$("#btnInsertEmpFormTaApply").show();
		$("#btnDeleteEmpDtlTaApply").hide();
		
		
		if( $("#vac_check").val()>0){
			// 모달 팝업
			gfModalPop("#layer2");	
			
		}else{
			alert('사용할 수 있는 연차가 존재하지 않습니다.')
		}

		//기본정보 자동 입력 
		fPersonalInfo(); 
		
	}; 
	
	
	 /* 폼 정보 자동입력을 위한 정보 조회  */
	 function fPersonalInfo(){
		 
			//반려일때만 반려사유창 팝업이 열림. 
			var param = {};
			
			var resultCallback = function(data) {
				fPersonalInfoResult(data);
			};
			
			callAjax("/employee/empTaLoginInfo.do", "post", "json", true, param, resultCallback);
		
	 }; 
	
	 //date formatting 함수 
	 Date.prototype.format = function (f) {

		    if (!this.valueOf()) return " ";
		    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
		    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		    var d = this;
		    
		    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

		        switch ($1) {
		            case "yyyy": return d.getFullYear(); // 년 (4자리)
		            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
		            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
		            case "dd": return d.getDate().zf(2); // 일 (2자리)
		            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
		            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
		            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
		            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
		            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
		            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
		            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
		            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
		            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
		            default: return $1;
		        }
		    });
		};

		String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
		String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
		Number.prototype.zf = function (len) { return this.toString().zf(len); };	 
	 
	 /* 폼 정보 자동입력을 위한 정보 조회  콜백*/
	 function fPersonalInfoResult(data){
		 
		 		console.log("fPersonalInfoResult data:", data); 
		 
				
				console.log('로그인 기본 정보 조회 콜백 함수 data:',data);
				
				$("#department").val(data.empTaLoginInfoModel.dept_name);
				$("#name").val(data.empTaLoginInfoModel.name);
				$("#loginID").val(data.empTaLoginInfoModel.loginID);
				$("#currentDate").val(new Date().format("yyyy-MM-dd a/p hh:mm:ss")); 
	
	 }; 
	
	/* 반려사유 단건 조회 */
	 function fn_EmpTaApplyDtlModal(idx,state) {
		
		console.log('idx:'+idx); 
		console.log('state:'+state); 
		
		if($("#userType").val()=="A"){
			$("#btnInsertEmpFormTaApply").hide();	
			$("#btnUpdateEmpDtlTaApply").hide();	
			$("#btnDeleteEmpDtlTaApply").hide();
			$("#btnapproveEmpDtlTaApply").show();	
			$("#btnrejectEmpDtlTaApply").show();	
			
			
		}else{
			$("#btnInsertEmpFormTaApply").show();	
			$("#btnUpdateEmpDtlTaApply").show();	
			$("#btnDeleteEmpDtlTaApply").show();
			$("#btnapproveEmpDtlTaApply").hide();	
			$("#btnrejectEmpDtlTaApply").hide();	
			
		}
		//반려일때만 반려사유창 팝업이 열림. 
		if(state =="반려"){
			
		var param = { row_num : idx };
		
		var resultCallback = function(data) {
			fn_EmpDtlTaApplyResult(data);
		}
		
		callAjax("/employee/empDtlTaApply.do", "post", "json", true, param, resultCallback);
		
		
		}else if(state == "승인대기중"){
			
			
			$("#vac_no").val(idx);
			
			var param = {row_num : idx }; 
			
			var resultCallback = function(data){
				fn_EmpDtlWaitingApplyResult(data); 
			}
			
			callAjax("/employee/empSelectWaitingTaApply.do", "post", "json", true, param, resultCallback);
		
		}
	} 

		
	/* 반려사유 조회 콜백 함수*/
	 function fn_EmpDtlTaApplyResult(data) {

			// 모달 팝업
			gfModalPop("#layer1");
			
			console.log('반려사유 단건 조회 콜백 함수 data:',data);
			
			$("#app_person").val(data.empDtlTaApplyModel.vac_bo);
			$("#reject_content").val(data.empDtlTaApplyModel.vac_rere);

	} 
	
	/*신청서 정보 단건조회 자동입력를 위한 콜백 함수*/
	function fn_EmpDtlWaitingApplyResult(data){
		
			//단건 조회에서는 수정,삭제 버튼 보이게 
			$("#btnUpdateEmpDtlTaApply").show();
			$("#btnDeleteEmpDtlTaApply").show();
		
		   	//모달팝업 연 상태에서 정보 등록 초기화  
		   	 gfModalPop("#layer2");

		   	console.log('fn_EmpDtlWaitingApplyResult data:', data); 
		   					
		   	$("#department").val(data.empSelectWaitingApplyModel.dept_name); 
		   	$("#loginID").val(data.empSelectWaitingApplyModel.loginID);
		   	$("#name").val(data.empSelectWaitingApplyModel.name);
		   	$("#vac_content").val(data.empSelectWaitingApplyModel.vac_re);
		   	$("#end_date").val(data.empSelectWaitingApplyModel.vac_edate);
		   	$("#start_date").val(data.empSelectWaitingApplyModel.vac_sdate);
		   	$("#tel").val(data.empSelectWaitingApplyModel.vac_tel);
		   	$("#fvactype").val(data.empSelectWaitingApplyModel.vac_type);

			$("#form_content").text('승인대기중에는 수정 또는 삭제 가능'); 
			$("#currentDate").val(new Date().format("yyyy-MM-dd a/p hh:mm:ss")); 
			
			$("#btnInsertEmpFormTaApply").hide();	
		
	}
	
	//휴가정보 수정 
	function fUpDelEmpDtlTaApply(){
		
		//var param = {};
		
		var resultCallback = function(data) {
			fUpdateDelEmpDtlTaApplyResult(data);
		}
		
		callAjax("/employee/empUpDeldateDtlTaApply.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	function fUpdateDelEmpDtlTaApplyResult(data){
		
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageEmpTaApply").val();
		}
		
		if(data.result == "SUCCESS"){
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListEmpTaApply(currentPage)
			
		}else{
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
	}
	//승인
	function fn_approveEmpDtlTaApply(){
		currentPage = $("#currentPageEmpTaApply").val();
		
    	var approvecallback = function(){
			alert("승인 되었습니다.");
			gfCloseModal();
			fListEmpTaApply(currentPage);
			   
		} 	
		
		callAjax("/employee/approve.do", "post", "json", true, $("#myForm").serialize(), approvecallback);
		   
	}
	//반려
	function fn_rejectEmpDtlTaApply(){
		currentPage = $("#currentPageEmpTaApply").val();
		
		
		var approvecallback = function(){
			alert("반려 되었습니다.");
			gfCloseModal();
			fListEmpTaApply(currentPage);
			   
		}
		callAjax("/employee/reject.do", "post", "json", true, $("#myForm").serialize(), approvecallback);
		 
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageEmpTaApply" value="1">
	<input type="hidden" id="currentPageEmpDtlTaApply" value="1">
	<input type="hidden" id="tmpEmpTaApply" value="">
	<input type="hidden" id="tmpEmpTaApplyNm" value="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="vac_no" id="vac_no" value="">
	<input type="hidden" name="userType" id="userType" value="${userType}">
	
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
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold">휴가신청관리</span>
								 <a href="../employee/empTaApply.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
								<span>직원 근태 </span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                          
					   <tr>       
                            <td><input type="date" style="width: 120px" id="from_date" name="from_date"> &nbsp;&nbsp;
                          	-
                          																				&nbsp;&nbsp;
                            <input type="date" style="width: 120px" id="to_date" name="to_date">
                           &nbsp;&nbsp;&nbsp;
                           	휴가종류 : <select id = "vactype" name = "vactype" style="width: 90px">
                           			</select>
                           	&nbsp;&nbsp;&nbsp;
                           	결재상태 : <select id = "apptype" name = "apptype" style="width: 90px">
                           		   </select>
                           	
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="" class="btnType blue" id="empTaApplySearchBtn" name="btn"><span>조  회</span></a></td>
                        </tr>
                       
                 
                     </table>    
						연차
						<div class="empTaVac" >
							<table class="col">
								<colgroup>
									<col width="30%">
									<col width="40%">
									<col width="40%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">총 연차</th>
										<th scope="col">사용 연차</th>
										<th scope="col">남은 연차</th>
									</tr>
								</thead>
								<tbody id = "vacRemain"></tbody>
							</table>
						</div>
						<div>
						연차리스트
						</div>
						<div class="empTaApplyList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="17%">
									<col width="18%">
									<col width="15%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
	
								<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">휴가종류</th>
											<th scope="col">사번</th>
											<th scope="col">사원명</th>
											<th scope="col">시작일</th>
											<th scope="col">종료일</th>
											<th scope="col">결재자</th>
											<th scope="col">결재상태</th>
										</tr>
								</thead>
								<tbody id="listEmpTaApply"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="empTaApplyPagination"> </div>
						
						
				<!-- <div class="btn_areaC mt30" style = "display:inline-block; float:right;"> -->
					<div style = "display:inline-block; float:right;">
					<a href="" class="btnType blue" id="SaveBtnEmpTaApply" name="btn"><span>개인근태신청</span>
					</a></div>
				<!-- </div> -->
						
	<!-- 반려사유 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 500px;height:200px;" >
		<dl>
			<dt>
				<strong>반려사유</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div>
					결재자:
					<input type="text" readonly="readonly" name="app_person" id="app_person" />
				</div>
				
				<div>
					반려 사유:
					<textarea cols = "100" style = "resize:none;" readonly="readonly" rows = "100" name="reject_content" id="reject_content" ></textarea>
				</div>
			</dd>			
		</dl>
		<a href="" class="closePop"><span class="hidden"></span></a>
	</div>

	<!-- 휴가신청서 모달팝업 -->
 	<div id="layer2" class="layerPop layerType2" style="width: 600px; height: 550px">
		<dl>
			<dt>
				<strong>휴가 신청서</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">근무부서 <span class="font_red">*</span></th>
							<td><input type="text" readonly="readonly" class="inputTxt p100" id="department" name="department" /></td>
							<th scope="row">휴가종류 <span class="font_red">*</span></th>
							<td><select id = "fvactype" name = "fvactype" style="width: 90px"></select></td>
						</tr>
						<tr>
							<th scope="row">성명 <span class="font_red">*</span></th>
							<td><input readonly="readonly" type="text" class="inputTxt p100" id="name" name="name" /></td>
							<th scope="row">사번 <span class="font_red">*</span></th>
							<td><input readonly="readonly" type="text" class="inputTxt p100" id="loginID" name="loginID" /></td>
						</tr>
						
						<tr>
							<th scope="row">기간</th>
							<td colspan="3"><input type="date"  id="start_date" name="start_date" />
								- <input type="date" id="end_date" name="end_date" />
							</td>
						</tr>
					
						<tr>
							<th scope="row">휴가 사유 <span class="font_red">*</span></th>
							<td colspan="3"><textarea cols = "200" rows = "10" id="vac_content" name="vac_content" ></textarea></td>							
						</tr>
						<tr>
							<th scope="row">비상연락처 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"  id="tel" name="tel"/> 								
						</tr>
						</tbody>
						<c:if test="${userType eq 'A' }">
						<tr>
						<td colspan="4">
						<textarea class="inputTxt p100" name="rejectre" id="rejectre" placeholder="반려 사유">
								</textarea>
						</tr>
						</c:if>
						 <c:if test="${userType ne 'A' }">
						 <tr>
						 
								<td colspan="4" name = "form_content" id = "form_content" style = "text-align:center"><p>상기와 같은 사유로 휴가를 신청합니다.</p></td>
						</tr>
						</c:if>
						<tr>
							<td colspan="4" style = "text-align:center">신청일<p><input type="text" style = "text-align:center" readonly="readonly" class="inputTxt p100" id="currentDate" name="currentDate"/></p></td>						
						</tr> 	
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnInsertEmpFormTaApply" name="btn"><span>신청</span></a>
					<a href="" class="btnType blue" id="btnUpdateEmpDtlTaApply" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnapproveEmpDtlTaApply" name="btn"><span>승인</span></a>
					<a href="" class="btnType blue" id="btnrejectEmpDtlTaApply" name="btn"><span>반려</span></a>
					<a href="" class="btnType blue" id="btnDeleteEmpDtlTaApply" name="btn"><span>삭제</span></a>   
					<a href="" class="btnType gray" id="btnCloseEmpDtlTaApply" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div> 
	<!--// 모달팝업 -->
</form>
</body>
</html>