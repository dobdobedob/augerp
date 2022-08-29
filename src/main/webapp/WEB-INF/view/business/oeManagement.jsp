<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<style>
.sel_emp_left{
	width:55%;
	height:100%;
	float:left;
	margin:0;

}
.sel_emp_right{
	width:43%;
	height:100%;
	margin:0;
	float:left;
	margin-left:2%;


}
 #tth{
 width:15%;
 height:20px;
 border:1px solid black;
  text-align:center;
  padding :7px;
  margin-bottom:8px;
  margin-left:10px;
 }

  #ttg{

 border:1px solid black;
  text-align:center;
  padding :5px;

 }

</style>


<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeOeManagement = 5;
	var pageBlockSizeOeManagement = 5;
	
	var pageSizeDtlOeManagement = 5;
	var pageBlockSizeDtlOeManagement = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		//콤보박스 설정 
		fn_init(); 
		
		// 그룹코드 조회
		fListOeManagement();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	function fn_init(){
		
		 
		//제품 대분류, 중분류, 소분류 
		$("#prolall").change(function() {
			productCombo("m", "promall", "all", $("#prolall").val(), "");
			            
			//대분류를 바꾸면 중,제,부서가 지워져야지 새로운 조건이 보이기 때문에 remove를 사용한다.
			$('#prodall').children('option').remove();
		});

		$("#promall").change(function() {
			productCombo("p", "prodall", "all", $("#promall").val(), "");
		});
		productCombo("l", "prolall", "all", "", "");
	
		//제품 대분류, 중분류, 소분류 
		$("#prolall2").change(function() {
			productCombo("m", "promall2", "all", $("#prolall2").val(), "");
			            
			//대분류를 바꾸면 중,제,부서가 지워져야지 새로운 조건이 보이기 때문에 remove를 사용한다.
			$('#prodall2').children('option').remove();
		});

			$("#promall2").change(function() {
				productCombo("p", "prodall2", "all", $("#promall2").val(), "");
			});
			productCombo("l", "prolall2", "all", "", "");	
			
			
		//계정대분류코드 
		selectComCombo("acc", "accall", "all", $("#accall").val(), "");
		
		$("#accall").change(function() {
		selectComCombo("accd", "accdall", "all", $("#accall").val(), "");
		}); 
		
		//계정대분류코드 
		selectComCombo("acc", "accall2", "all", $("#accall2").val(), "");
		
		$("#accall2").change(function() {
		selectComCombo("accd", "accdall2", "all", $("#accall2").val(), "");
		}); 
			
		//거래처 
		selectComCombo("cli", "cilall", "all", "", "");
		
		//거래처 
		selectComCombo("cli", "com_cop_no2", "all", "", "");
		
		//견적
		selectComCombo("estn", "com_est_no2", "all", "", "");
		
		//수주 
		//selectComCombo("ord", "com_ord_no2", "all", "", "");
		
		//수주 
		selectComCombo("stt", "supply_st2", "all", "", "");
		
	}
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'oeManageSearchBtn' :
				 	fListOeManagement();
					break;
				case 'btnInsertOeManagement2' :
					fInsertOeManagement2();
					break;
				case 'btnInsertOeManagement3' :
					fInsertOeManagement3();
					break;
				case 'btnDeleteOeManagement3' : 
					fDeleteOeManagement3();
				case 'btnCloseOeManagement' : 
					  gfCloseModal();
					  break;
				case 'btnCloseOeManagement2' :
					  gfCloseModal();
					  break;
				case 'btnCloseOeManagement3' :
					  gfCloseModal();
					  break;
			}
		});
	}
	
	/* 수주서작성 폼 초기화 */
	 function fInitFormDtlOeManagement() {
			
			$("#com_est_no").val("");
			$("#com_cop_no").val("");
			$("#com_tot").val("");
			$("#inbalance").val("");
			$("#accall").val("");
			$("#accdall").val("");
			$("#supply_st2").attr("disabled", "true"); 
		
	}
	
	/* 수주서작성 폼 초기화2*/
	function fInitFormDtlOeManagement2(){
		
			//$("#com_ord_no2").val("");
			$("#prolall2").val("");
			$("#promall2").val("");
			$("#prodall2").val("");
			$("#do_nmt2").val("");
			$("#do_price2").val("");
			$("#do_date2").val("");
			$("#do_due2").val("");
			
			$("#btnUpdateOeManagement3").hide();
			$("#btnDeleteOeManagement3").hide();
			$("#btnInsertOeManagement3").show();
			
	}
	
	/* 수주서작성 Insert*/
	function fInsertOeManagement2(){
		
		$("#action").val("I"); 
		
		
		
		// vaildation 체크
		if ( ! fValidateOeManagement() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fInsertOeResult(data);
		};
		
		callAjax("/business/InsertOeModal.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	$(document).ready(function(){
		//총액이 변하면 
		$("#com_tot2").change(function(){
			//미수금의 input 창에 총액 value가 들어가도록 
			$("#inbalance2").val($("#com_tot2").val());
		})
	})
	
	/* 수주서상세작성 Insert3*/
	function fInsertOeManagement3(){
		
		$("#action").val("I"); 
		
		if ( ! fValidateOeManagement2() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fInsertOeDtlResult(data);
		};
		
		callAjax("/business/InsertOeDtlModal.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	function fInsertOeResult(data){
		
		console.log('fInsertOeResult data', data); 
		
	 	if (data.result == "SUCCESS") {
			
			// 모달 닫기
			gfCloseModal();
			
			console.log('데이터 요청 성공'); 
			alert('요청 성공'); 
			
			
		}else{
			alert('요청 실패'); 
		}
	 	$("#com_ord_no2").val(data.suju.ord_no);
	 	$("#loginID").val(data.suju.loginID);
	 	$("#dac_no").val(data.suju.dac_no);
	 	$("#cop_no2").val(data.suju.cop_no);
	 	//$("#do_com2"),val(data.suju.do_com); 
	 	
	 	
	 	
		console.log(data.suju.ord_no);
		console.log(data.suju.loginID);
		console.log(data.suju.dac_no);
		console.log(data.suju.cop_no);
		//console.log(data.suju.do_com);

	}
	
	function fInsertOeDtlResult(data){
		
		console.log('fInsertOeDtlResult data', data); 
		
		if (data.result == "SUCCESS") {
			
			console.log('데이터 요청 성공'); 
			alert('요청 성공');
		}else{
			alert('데이터 중복입니다.'); 
		}
		
	}

	 /* 수주관리 저장 validation */
	 function fValidateOeManagement() {

		var chk = checkNotEmpty(
				[
						[ "com_est_no", "견적서 번호를 입력해 주세요." ]
					,	[ "com_cop_no", "거래처코드를 입력해 주세요." ]
					,	[ "com_tot", "총액을 입력해 주세요." ]
					,   [ "inbalance", "미수금을 입력해 주세요."]
					,   [ "supply_st", "납품여부를 입력해주세요."]	
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
 	
	
	/* 상세수주관리  저장 validation */
	 function fValidateOeManagement2() {

		var chk = checkNotEmpty(
				[
						[ "com_ord_no2", "그룹 코드를 선택해 주세요." ]
					,	[ "prolall2", "상품 대분류 입력해 주세요" ]
					,	[ "promall2", "상품 중분류 입력해 주세요" ]
					,	[ "prodall2", "상품 소분류 입력해 주세요" ]
					,	[ "do_nmt2", "수량을 입력해 주세요." ]
					,	[ "do_price2", "판매가격을 입력해 주세요." ]
					,	[ "do_date2", "수주날짜를 입력해 주세요." ]
					,	[ "do_due2", "납기일을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}  
 	
	
 	function modalRevert(){
		 gfCloseModal();
		 fListOeManagement($("#currentPageOeManagement").val());
 	}
 
 
 	 function fPopModalOeManagement(){
		 
			// Tranjection type 설정
			$("#action").val("I");
			
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 초기화
			fInitFormDtlOeManagement();

	} 
	
	 function fPopModalOeManagement2(){
		 
				// Tranjection type 설정
				$("#action").val("I");
				
				// 그룹코드 폼 초기화
				fInitFormDtlOeManagement2();
				
				// 모달 팝업
				gfModalPop("#layer2");

 	} 
	 
	
	
	/** 수주리스트 조회 */
	function fListOeManagement(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					  order_date : $("#order_date").val()
					, due_date : $("#due_date").val()  
					, prodall : $("#prodall").val()
					, cilall : $("#cilall").val() 
					, currentPage : currentPage
					, pageSize : pageSizeOeManagement 
		}
		
		var resultCallback = function(data) {
			flistOeManagementResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/business/listOeManagement.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 수주리스트 조회 콜백 함수 */
	function flistOeManagementResult(data, currentPage) {
		
		console.log(data);
		
		//검색 초기화 
		
		$("#order_date").val("");
		$("#due_date").val("");
		$("#prolall").val("");
		$("#promall").val("");
		$("#prodall").val("");
		$("#cilall").val("");
		
		// 기존 목록 삭제
		$('#listOeManagement').empty();
		
		// 신규 목록 생성
		$("#listOeManagement").append(data);
		
		// 총 개수 추출
		
		var totalCntOeManagement = $("#totalCntOeManagement").val();
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntOeManagement, pageSizeOeManagement, pageBlockSizeOeManagement, 'fListOeManagement');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#oeManagementPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageOeManagement").val(currentPage);
	}
	
	
	/* 수주관리 상세(단건)조회 */
	 function fPopModalDtlOeManagement(currentPage) {
		
		 currentPage = currentPage || 1;
		
		 //console.log($("#ord_no").val()); 
		 //alert($("#ord_no").val());
		 var ord_no = $("#ord_no").val(); 
		 //var do_due = $("#do_due").val(); 
		 //var do_date = $("#do_date").val(); 
		 
		 console.log('fPopModalDtlOeManagement ord_no:',ord_no); 
		 console.log("currentPage : " + currentPage);
		
		
		var param = { 	  ord_no : ord_no 
						, currentPage : currentPage
						, pageSize : pageSizeDtlOeManagement 
					};
		
		var resultCallback = function(data) {
			fSelectOeManagement(data, currentPage);
		};
		
		callAjax("/business/DtlOeManagement.do", "post", "text", true, param, resultCallback);
	} 
	
	
	/* 수주관리 상세(단건)조회 콜백 함수*/
	 function fSelectOeManagement(data,currentPage) {

		$("#oeManagementModal").empty()
		
		$("#oeManagementModal").append(data);
		
		//모달 불러와서 지우고 만든다.
		gfModalPop("#oeManagementModal");
	
		
		// 총 개수 추출
		
		var totalCntModalOeManagement = $("#totalCntModalOeManagement").val();
		console.log('totalCntModalOeManagement:', totalCntModalOeManagement)
		console.log('fSelectOeManagement currentPage', currentPage); 
		console.log('fSelectOeManagement data', data); 
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntModalOeManagement, pageSizeDtlOeManagement , pageBlockSizeDtlOeManagement , 'fPopModalDtlOeManagement');
		console.log(" fSelectOeManagement paginationHtml : " + paginationHtml);
	
		$("#oeModalPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageDtlOeManagement").val(currentPage);
		
	} 
	
	function fn_oneProDel(ord_no,si_cd,si_nm){
		
		//alert(si_nm); 
		//alert(si_cd); 
		//alert(ord_no); 
		
		console.log('fn_oneProDel ord_no::::', ord_no);
		console.log('fn_oneProDel si_cd::::', si_cd);
		console.log('fn_oneProDel si_nm::::', si_nm);
		
		var ord_no = ord_no; 
		var si_cd = si_cd; 
		var si_nm = si_nm; 
		
		
		fn_oedtl(ord_no,si_cd,si_nm); 
		
	}
	
	function fn_oedtl(ord_no, si_cd, si_nm){ 
		
		
		//alert(si_nm); 
		//alert(si_cd); 
		//alert(ord_no); 
		//$("#com_ord_no2").val(ord_no); 
		
		console.log('fn_oedtl ord_no', ord_no); 
		console.log('fn_oedtl si_nm', si_cd);
		console.log('fn_oedtl si_nm', si_nm);
		
		
		
		var param = {ord_no : ord_no
					, si_cd : si_cd 
					, si_nm : si_nm
					}; 
		
		var resultCallback = function(data) {
			fn_selectOneOeManagement(data);
		}
		
		callAjax("/business/OeManagementOne.do", "post", "json", true, param, resultCallback);
		
	}
	
	function fn_selectOneOeManagement(data){
		
		console.log('fn_selectOneOeManagement data', data); 
		
		$("#btnDeleteOeManagement3").hide();
		$("#btnInsertOeManagement3").hide();
		
		// 모달 팝업
		//gfModalPop("#layer2");
		
		var data = data.oeManagementOne; 
		
		$("#loginID").val(data.loginID); 
		$("#dac_no").val(data.dac_no); 
		$("#cop_no2").val(data.cop_no); 
		$("#com_ord_no2").val(data.ord_no);

		productCombo("l", "prolall2", "sel", "", data.bi_cd);
		productCombo("m", "promall2", "sel", data.bi_cd, data.mi_cd);
		productCombo("p", "prodall2", "sel", data.mi_cd, data.si_cd);
		
		$("#do_nmt2").val(data.do_nmt); 
		$("#do_price2").val(data.do_price); 
		$("#do_date2").val(data.do_date); 
		$("#do_due2").val(data.do_due); 
		$("#si_nm2").val(data.si_nm); 
		
		fDeleteOeManagement3(); 
		
	}
	
	function fDeleteOeManagement3(){
		
		$("#action").val("D");
		
		var resultCallback = function(data) {
			fDelOeDtl(data);
		}
		
		callAjax("/business/fDelOeDtl.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
		
	}
	
	function fDelOeDtl(data){
		
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageOeManagement").val();
		}
		
			if(data.result == "SUCCESS"){
					
					// 응답 메시지 출력
					alert(data.resultMsg);
					
					// 모달 닫기
					gfCloseModal();
					
					// 목록 조회
					fListOeManagement(currentPage)
					
				}else{
					// 오류 응답 메시지 출력
					alert(data.resultMsg);
				}
		
	}

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageOeManagement" value="1">
	<input type="hidden" id="currentPageDtlOeManagement" value="1">
	<input type="hidden" id="currentPageDtlOeManagement" value="1">
	<input type="hidden" id="tmpOeManagement" value="">
	<input type="hidden" id="tmpDtlOeManagement" value="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" style="width: 40px" readonly="readonly" class="inputTxt p100" id="loginID" name="loginID" />
	<input type="hidden" style="width: 40px" readonly="readonly" class="inputTxt p100" id="dac_no" name="dac_no" />
	<input type="hidden" style="width: 40px" readonly="readonly" class="inputTxt p100" id="cop_no2" name="cop_no2" />
	<input type="hidden" style="width: 40px" readonly="readonly" class="inputTxt p100" id="si_nm2" name="si_nm2" />
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
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold">수주 관리</span> <a href="../business/oeManagement.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수주 관리 </span> <span class="fr"> 
							<a class="btnType blue" href="javascript:fPopModalOeManagement();" name="modal"><span>수주서작성</span></a>
							<a class="btnType blue" href="javascript:fPopModalOeManagement2();" name="modal"><span>수주상세정보작성</span></a>
							</span>
						</p>
						
								<!--검색창  -->
			<table width="100%" cellpadding="5" cellspacing="0" border="1"
                      align="left"
                      style="border-collapse: collapse; border: 1px #50bcdf;">
                      <tr style="border: 0px; border-color: blue">
                          	수주일 : <input type="date" style="width: 120px" id="order_date" name="order_date">
                        	납기일 : <input type="date" style="width: 120px" id="due_date" name="due_date"> 
                         <tr>	
                         	<td width="40" height="25" style="font-size: 100%">제품대분류</td><td><select id="prolall" name="prolall"  v-model="prolall">	</select></td>
							<td width="40" height="25" style="font-size: 100%">제품중분류</td><td><select id="promall" name="promall" v-model="promall">	</select></td>   
							<td width="40" height="25" style="font-size: 100%">제품</td><td><select id="prodall" name="prodall" v-model="prodall">	</select>
                         	&nbsp;&nbsp;&nbsp;
                         	거래처 : <select id = "cilall" name = "cilall" style="width: 90px"></select>
                         	
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="" class="btnType blue" id="oeManageSearchBtn" name="btn"><span>조  회</span></a></td>
   
                      </tr>
                   </table>    
				
						<div class="empTaApplyList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">수주번호</th>
										<th scope="col">수주직원 </th>
										<th scope="col">수주일</th>
										<th scope="col">거래처이름</th>
										<th scope="col">제품코드</th>
										<th scope="col">납기일</th>
										<th scope="col">납품갯수</th>
										<th scope="col">공급가</th>
										<th scope="col">세액</th>
										<th scope="col">제품단가</th>
										<th scope="col">수주서상세조회</th>										
									</tr>
								</thead>
								<tbody id="listOeManagement"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="oeManagementPagination"> </div>
						
     <!-- 수주관리 모달팝업 -->
 	<div id="layer1" class="layerPop layerType2" style="width: 1100px; height: 450px">
		<dl>
			<dt>
				<strong>수주 신청</strong>
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
							<th scope="row">견적서 번호<span class="font_red">*</span></th>
							<td><select id="com_est_no2" name="com_est_no2"  v-model="com_est_no2"></select></td>
							<th scope="row">거래처 코드<span class="font_red">*</span></th>
							<td><select id="com_cop_no2" name="com_cop_no2"  v-model="com_cop_no2"></select></td>
						</tr>
						<tr>
							<th scope="row">총액 <span class="font_red">*</span></th>
							<td><input type="text" style="width: 40px" class="inputTxt p100" id="com_tot2" name="com_tot2"/></td>
								
							<th scope="row">미수금 <span class="font_red">*</span></th>
							<td><input type="text" style="width: 40px" readonly="readonly" class="inputTxt p100" id="inbalance2" name="inbalance2" /></td>
						</tr>
						
						<tr>
							<th scope="row">계정대분류명
						<td><select id="accall2" name="accall2"  v-model="accal12"></select></td>
                           		  
							<th scope="row">계정과목
						<td><select id="accdall2" name="accdall2" v-model="accdal12"></select></td>
						</tr>
						<tr>
							<th scope="row">납품여부</th>
							<td><select id="supply_st2" name="supply_st2"  v-model="supply_st2"></select></td>
						</tr>
						
						<!-- 	승인은 2  반려는 3 B는 임원-->
							
						</tbody>
				</table>

				<div class="btn_areaC mt30"> 
					<a href="" class="btnType blue" id="btnInsertOeManagement2" name="btn"><span>신청</span></a>
					<!-- <a class="btnType3 color1" href="javascript:fPopModalDtlOeManagement();"><span>수주서</span></a> -->
					<a href="" class="btnType gray" id="btnCloseOeManagement2" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<div id="layer2" class="layerPop layerType2" style="width: 1100px; height: 450px">
		<dl>
			<dt>
				<strong>수주 상세</strong>
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
							<th scope="row">수주 번호<span class="font_red">*</span></th>
							<td><input type="text" style="width: 40px" readonly="readonly" class="inputTxt p100" id="com_ord_no2" name="com_ord_no2" /></td>
						</tr>
							<th scope="row">제품대분류<span class="font_red">*</span></th>
							<td><select id="prolall2" name="prolall2"  v-model="prolal2">	</select></td>
							<th scope="row">제품중분류<span class="font_red">*</span></th>
							<td><select id="promall2" name="promall2" v-model="promal2">	</select></td>   
							<th scope="row">제품<span class="font_red">*</span></th>
							<td><select id="prodall2" name="prodall2" v-model="prodal2">	</select>
						</tr>
						<tr>
							<th scope="row">제품수량</th>
							<td><input type="text" style="width: 40px" class="inputTxt p100" id="do_nmt2" name="do_nmt2" /></td>
							<th scope="row">판매가격</th>
							<td><input type="text" style="width: 40px" class="inputTxt p100" id="do_price2" name="do_price2"/></td>
						</tr>
						<tr>
							<th scope="row">수주날짜</th>
							<td><input type="date" style="width: 40px" class="inputTxt p100" id="do_date2" name="do_date2" /></td>
							<th scope="row">납기일</th>
							<td><input type="date" style="width: 40px" class="inputTxt p100" id="do_due2" name="do_due2" /></td>
						</tr>
				
						<!-- 	승인은 2  반려는 3 B는 임원-->
							
						</tbody>
				</table>

				<div class="btn_areaC mt30"> 
					<a href="" class="btnType blue" id="btnInsertOeManagement3" name="btn"><span>신청</span></a>				   
					<a href="" class="btnType blue" id="btnDeleteOeManagement3" name="btn"><span>삭제</span></a>   
					<a href="" class="btnType gray" id="btnCloseOeManagement3" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업 -->
	<div id="oeManagementModal" class="layerPop layerType1" style="width: 800px; height:900px"></div>
	
	 
</form>
</body>
</html>