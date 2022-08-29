<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.userType ne 'A'}">
	<c:redirect url="/dashboard/dashboard.do" />
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
	var pageSizeEmpDv = 5;
	var pageBlockSizeEmpDv = 5;

	/** OnLoad event */
	$(function() {

		//콤보박스 설정 
		fn_init();

		// 그룹코드 조회
		fListEmpDv();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	function fn_init() {

		comcombo("Okcd", "apptype", "all", "")

		//리스트 부분 
		//계정과목코드 
		$("#accall").change(function() {
			selectComCombo("accd", "accdall", "all", $("#accall").val(), "");
		});

		//계정대분류코드 
		selectComCombo("acc", "accall", "all", $("#accall").val(), "");

		//모달창 부분 
		$("#accal2").change(function() {
			selectComCombo("accd", "accdal2", "sel", $("#accal2").val(), "");
		});

		selectComCombo("acc", "accal2", "sel", $("#accal2").val(), "");

		//거래처 
		selectComCombo("cli", "cilall", "all", "", "");

	}
	$(document).ready(function(){
		$("#reason").hide();
		$("#inapp").click(function(){
			$("#reason").show();
			$("#exp_stat").val($("#inapp").val());
		})
		
		$("#app").click(function(){
			$("#reason").hide();
			$("#exp_rere").val('');
			$("#exp_stat").val($("#app").val());
		})

	})
		

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {

			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'empDvSearchBtn':
				fListEmpDv();
				break;
			case 'btnCloseEmpDv':
				gfCloseModal();
				break;
			case 'btnUpdateEmpDv':
				fn_updateAccept();
				break;
			}
		});

	var upfile = document.getElementById('upfile');
	upfile.addEventListener('change',
					function(event) {
						$("#fileinfo").empty();
						var image = event.target;
						var imgpath = "";
						if (image.files[0]) {
							imgpath = window.URL
									.createObjectURL(image.files[0]);
						}

						//var action = $("#action").val();
						var filearr = $("#upfile").val().split(".");

						var previewhtml = "";

						if (filearr[1] == "jpg" || filearr[1] == "png") {
							previewhtml = "<img src='" + imgpath + "' style='width: 130px; height: 130px;' />";
						}

						$("#fileinfo").empty().append(previewhtml);

					});
	}

	/* 지출결의 저장 validation */
	function fValidateEmpDv() {

		var chk = checkNotEmpty([ 
                [ "exp_pdate", "승인 일자를 입력해주세요" ],


		]);

		if (!chk) {
			return;
		}

	}

	/*Insert 지출결의 폼 */
	function fPopModalInsertEmpDv() {

		// 모달 팝업 
		gfModalPop("#layer2");



	}

	/** 지출결의서 조회 */
	function fListEmpDv(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		console.log('from_date value:', $("#from_date").val());
		console.log('to_date value:', $("#to_date").val());

		var param = {

			accdall : $("#accdall").val(),
			accall : $("#accall").val(),
			apptype : $("#apptype").val(),
			from_date : $("#from_date").val(),
			to_date : $("#to_date").val(),
			currentPage : currentPage,
			pageSize : pageSizeEmpDv

		}

		var resultCallback = function(data) {
			flistEmpDvResult(data, currentPage);
		};

		callAjax("/accounting/listDVApprove.do", "post", "text", true, param,resultCallback);
	}

	/** 지출결의 리스트 조회 콜백 함수 */
	function flistEmpDvResult(data, currentPage) {

		//swal(data);
		console.log(data);

		// 기존 목록 삭제
		$('#listEmpDv').empty();

		// 신규 목록 생성
		$("#listEmpDv").append(data);

		// 총 개수 추출

		var totalCntEmpDv = $("#totalCntEmpDv").val();

		//swal(totalCntComnGrpCod);

		// 페이지 네비게이션 생성

		var paginationHtml = getPaginationHtml(currentPage, totalCntEmpDv,
				pageSizeEmpDv, pageBlockSizeEmpDv, 'fListEmpDv');

		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#empDvPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageEmpDv").val(currentPage);
	}


	

	/*지출결의서 상세 조회 */
	function fn_empDvDtlModal(exp_no, exp_stat) {

		$("#btnUpdateEmpDv").show();

		$("#exp_no").val(exp_no);


		//정보 단건조회해서 모달창에 정보 넣기 

		var param = {
			exp_no : exp_no
		};

		var resultCallback = function(data) {
			fn_EmpDvDtlModalResult(data.EmpDvOneModel);
			// 모달창 열기 
			gfModalPop("#layer2");
		}

		callAjax("/accounting/empDVApproveModal.do", "post", "json", true, param,resultCallback);

	}

	/*모달창 결의번호 클릭시도 여기로 옴 */
	function fn_EmpDvDtlModalResult(data) {

		var user = '${userType}';
			if(data != null)  {
			//모달창에 상세정보 넣기 

			$("#exp_no").val(data.exp_no);
			$("#expend_num").val(data.exp_no);
			$("#use_date").val(data.exp_sdate)
			$("#apply_date").val(data.exp_date);
			$("#loginID").val(data.loginID);
			$("#empName").val(data.name);
			$("#use_dept").val(data.dept_name);
			selectComCombo("acc", "accal2", "sel", $("#accal2").val(), data.acc_no);
			selectComCombo("accd", "accdal2", "sel", data.acc_no, data.dac_no);
			$("#cilall").val(data.exp_snm);
			$("#expense").val(data.exp_cost);
			if(data.exp_stat == '1' && user == 'A'){
				$("#inapp").prop('checked',false); 
				$("#app").prop('checked',true); 
				$("#app").attr("disabled", false);
				$("#inapp").attr("disabled", false);
				$("#exp_pdate").attr("readonly", false);
				$("#exp_rere").attr("readonly", false);
				$("#exp_rere").val('');
				$("#reason").hide();
				$("#exp_stat").val($("#app").val());
			}else if(data.exp_stat == '1' &&( user == 'B' || user == 'C')){
				$("#app").attr("disabled", true);
				$("#inapp").attr("disabled", true);
				$("#exp_pdate").attr("readonly", true);
				$("#btnUpdateEmpDv").hide();
				$("#exp_stat").val($("#app").val());
			}else if(data.exp_stat == '2'){
				$("#app").prop('checked', true);
				$("#app").attr("disabled", true);
				$("#inapp").attr("disabled", true);
				$("#exp_pdate").attr("readonly", true);
				$("#reason").hide();
				$("#btnUpdateEmpDv").hide();
			}else if(data.exp_stat == '3'){
				$("#inapp").prop('checked',true); 
				$("#app").attr("disabled", true);
				$("#inapp").attr("disabled", true);
				$("#exp_pdate").attr("readonly", true);
				$("#reason").show();
				$("#exp_rere").attr("readonly", true);
				$("#btnUpdateEmpDv").hide();
			}
			$("#exp_pdate").val(data.exp_pdate); 
			$("#exp_cont").val(data.exp_cont);
			$("#fileinfo").text(data.att_ori);
			$("#att_mul").val(data.att_mul);
			$("#exp_rere").val(data.exp_rere);

			$("#upfile").css("display", "none");
			//파일명이 null이면.. fileinfo의 fileinfo를 비워준다. 
			if (data.att_ori == ""
					|| data.att_ori == null
					|| data.att_ori == undefined) {
				var previewhtml = "";
				previewhtml = "<span>첨부파일이 없습니다</span>";
				$("#fileinfo").empty().append(previewhtml);
			} else {
				//미리 파일 이미지 볼 수 있도록 작성한 코드 
				var filearr = data.att_ori.split(".");

				console.log('filearr' + filearr);

				var previewhtml = "";
				if (filearr[1] == "jpg" || filearr[1] == "png") {
					previewhtml = "<a href='javascript:download("
							+ data.exp_no
							+ ")'>"
							+ "<img src='" + data.att_nli + "' style='width: 130px; height: 130px;' />"
							+ "</a>";
				} else {
					previewhtml = "<a href='javascript:download("
							+ data.exp_no + ")'>"
							+ data.att_ori + "</a>";
				}

				$("#fileinfo").empty().append(previewhtml);
			}
			$("#upfile").attr("display", "none");
		}

		$("#exp_no").val(data.exp_no);
		

	}

	//download controller 통신 
	function download(exp_no) {
		if(exp_no == null){
			return;
		}
		var params = "<input type='hidden' name='exp_no' value='"+ exp_no +"' />";

		jQuery(
				"<form action='/accounting/empdvdownloadfileee.do' method='post'>"
						+ params + "</form>").appendTo('body').submit()
				.remove();
	
	}

	function fn_updateAccept(){
		
		var param = {
				exp_stat : $("#exp_stat").val()
			   ,exp_pdate : $("#exp_pdate").val()
			   ,exp_rere : $("#exp_rere").val()
			   ,expend_num : $("#expend_num").val()
			   ,exp_bo : $("#exp_bo").val()
		}
		var updateAcceptcallback = function (savereturn){
			  console.log("saveUserRetirecallback : " + JSON.stringify(savereturn) );
			  if(savereturn.result == "SUCCESS"){
				  alert("승인처리 되었습니다.");
				  gfCloseModal();
				  fListEmpDv();
			  }
		}
		callAjax("/accounting/updateDVApprove.do", "post", "json", true, param, updateAcceptcallback);
	}
	

</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageEmpDv" value="1"> 
		<input type="hidden" id="currentPageComnDtlCod" value="1"> 
		<input type="hidden" id="tmpGrpCod" value=""> 
		<input type="hidden" id="tmpGrpCodNm" value=""> 
		<input type="hidden" name="exp_bo" id="exp_bo" value="${loginID}">
		<input type="hidden" name="exp_no" id="exp_no" value="">
		<input type="hidden" name="exp_stat" id="exp_stat" value="">
		<input type="hidden" id="appType" value="">



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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">기준정보</span> <span
									class="btn_nav bold">지출결의서 조회 및 승인</span> <a
									href="../accounting/empDv.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>지출 결의서 조회 및 승인</span> 
								 
							</p>

							<!--검색창  -->
							<table width="100%" cellpadding="5" cellspacing="0" border="1"
								align="left"
								style="border-collapse: collapse; border: 1px #50bcdf; margin-bottom: 20px;padding-left: 30px;">
								<tr style="border: 0px; border-color: blue; height: 20px;">
									 <td width="230" height="25" style="font-size: 100%;padding-left: 30px;">
									 	<div style="width: 90px;position:relative;">신청일자 </div>
									  	<input type="date" style="width: 120px" id="from_date" name="from_date">
										<input type="date" style="width: 120px"id="to_date" name="to_date">
									</td>
									<td  width="60px">
										<div style="width: 60px;position:relative;">계정대분류 </div>
									 	<select id="accall" name="accall" v-model="accall"></select>
								 	</td>
									<td width="60px">
										<div style="width: 60px;position:relative;">계정과목 </div>
										<select id="accdall" name="accdall" v-model="accdall"></select>
									</td>
									<td width="100px">
										<div style="width: 60px;position:relative;">승인여부 </div>
										<select id="apptype" name="apptype" style="width: 90px"></select>
									</td>
									<td width="60px">
										<a href="" class="btnType blue" id="empDvSearchBtn" name="btn"><span>조회 </span></a>
									</td>
								</tr>

							</table>

							<div class="empDvList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">결의번호</th>
											<th scope="col">신청일자</th>
											<th scope="col">사용일자</th>
											<th scope="col">사번</th>
											<th scope="col">사원명</th>
											<th scope="col">계정대분류명</th>
											<th scope="col">계정과목</th>
											<th scope="col">사용부서</th>
											<th scope="col">결의금액</th>
											<th scope="col">승인여부</th>
										</tr>
									</thead>
									<tbody id="listEmpDv"></tbody>
								</table>
								<div class="paging_area" id="empDvPagination"></div>
								</div>
						</div>
							
							
						</li>
				</ul>
		</div>
	</div>
			<!-- 지출결의서 모달팝업 -->
		<div id="layer2" class="layerPop layerType2" style="width: 850px;">
			<input type="hidden" id=att_mul name="att_mul"> 
			<dl>
				<dt> 
					<strong>지출 결의</strong>
				</dt>
				<dd class="content" >

					<!-- s : 여기에 내용입력 -->

					<table class="row">
						<caption>caption</caption>
						<tbody>
							<tr >
								<th scope="row" style="width: 150px !important;" >결의번호 <span class="font_red">*</span></th>
								<td><input type="text" readonly="readonly" class="inputTxt p100" id="expend_num" name="expend_num" style="width: 150px !important;" /></td>
								<th scope="row" style="width: 122px;">신청일자 <span class="font_red">*</span></th>
								<td ><input type="date" readonly="readonly" style="width: 40px" class="inputTxt p100" id="apply_date" name="apply_date" style="width: 140px !important;" /></td>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td ><input type="date" class="inputTxt p100" id="use_date" name="use_date" readonly="readonly"  style="width: 140px !important;"  /></td>
							</tr>
							<tr>
								<th scope="row">사번 <span class="font_red">*</span></th>
								<td><input type="text" readonly="readonly"  class="inputTxt p100" id="loginID" name="loginID"  style="width: 150px !important;" /></td>
								<th scope="row">사원명 <span class="font_red">*</span></th>
								<td><input type="text" readonly="readonly" style="width: 40px" class="inputTxt p100" id="empName" name="empName" /></td>
								<th scope="row">사용부서 <span class="font_red">*</span></th>
								<td><input type="text" readonly="readonly" style="width: 40px" class="inputTxt p100" id="use_dept" name="use_dept" /></td>
							</tr>
							<tr>
								<th scope="row">계정대분류명<span class="font_red">*</span></th>
								<td><select id="accal2" name="accal2" style="width: 150px !important;"  disabled="disabled"></select></td>
								<th scope="row">계정과목<span class="font_red">*</span></th>
								<td><select id="accdal2" name="accdal2"  style="width: 150px !important;"  disabled="disabled"></select></td>
								<th scope="row" style="width: 100px;">거래처명</th>
								<td ><select id="cilall" name="cilall" style="width: 140px !important;" disabled="disabled"></select></td>
							</tr>	
							<tr>
								<th scope="row">결의금액<span class="font_red">*</span></th>
								<td ><input type="text"class="inputTxt p100" id="expense" name="expense" readonly="readonly"  style="width: 150px !important;" /></td>
								<th scope="row">승인 선택<span class="font_red">*</span></th>
								<td> 
									<input type="radio" id="app" name="apptype" value="2" />승인
									<input type="radio" id="inapp" name="apptype" value="3" />반려
								</td>
								<th scope="row">승인일자 <span class="font_red">*</span></th>
								<td><input type="date"  class="inputTxt p100" id="exp_pdate" name="exp_pdate"/></td>
							</tr>
							<tr>
								<th scope="row">파일</th>
								<td colspan="5"><input type="file" id="upfile" name="upfile" readonly="readonly"/> <div id="fileinfo"></div></td>
							</tr>
							<tr>
								<th scope="row">비고<span class="font_red">*</span></th>
								<td colspan="5"><textarea cols = "200" rows = "10" id="exp_cont" name="exp_cont" style="resize:none;" readonly="readonly"></textarea></td>		
							</tr>
							<tr id = "reason"> 
								<th scope="row">반려사유<span class="font_red">*</span></th>
								<td colspan="5"><textarea cols = "200" rows = "10" id="exp_rere" name="exp_rere" style="resize:none;" ></textarea></td>		
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnUpdateEmpDv" name="btn"><span>등록</span></a>
						<a href=""class="btnType gray" id="btnCloseEmpDv" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>