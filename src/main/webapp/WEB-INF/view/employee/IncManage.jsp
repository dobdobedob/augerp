<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 인센티브  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	var ipageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var ipageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	
	var nowdate = new Date();
	$(document).ready(function() {
		fn_init();
		selectComCombo("dept", "deptall", "all", "", "");
		fn_IncManagelist();
		fRegisterButtonClickEvent();
	});
	   
	function fn_init() {
		$("#to_month").val($("#todayDate"));
		$("#todayDD").val($("#todayDD"));
		
		console.log("오늘 날짜는 "+JSON.stringify($("#todayDate")));
		   
	}
	
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_IncManagelist();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSaveIncManage' :

					$("#action").val("I");
					fn_IncManagesave(1,$("#eloginID").val(),$("#ename").val());
					break;
				case 'btnClosedn' :
					gfCloseModal();
					break;	
				case 'btniSearch' :
					fn_IncManageilist();
					break;
					
			}
		});
	}	
	
   function fn_IncManagelist(curpage) {
	    
	   
	   curpage = curpage || 1;
	   var param = {
				     sname : $("#sname").val()
	       			,to_montha : $("#to_month").val()
	       			,to_monthb : $("#to_month").val()
	       			,curpage : curpage
	       			,pageSize : pageSize
	       			,todayDate : $("#todayDate").val()
					,sloginID : $("#sloginID").val()
					,deptall : $("#deptall").val()
	   };
	   console.log("papa : " + JSON.stringify(param));
	   
		
	   var IncManagelistcallback = function(returndata) {
		    fn_IncManagelistcallback(returndata,curpage) ;  
	   }
	   
	   callAjax("/employee/listIncManage.do", "post", "text", true, param, IncManagelistcallback);
	   
	         
   }
   function fn_IncManagelistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#IncManageList").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_IncManagelist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }
   
	function fn_IncManageilist(icurpage,loginID, name) {
	    
		
	   
	   icurpage = icurpage || 1;
	   //$("#isname").val(isname);
	   $("#isloginID").val(loginID);
	   $("#isname").val(name);
	   
	   
	   
	   var param = {
				     loginID : $("#isloginID").val()
	       			,to_imonth : $("#to_imonth").val()
	       			,from_imonth : $("#from_imonth").val()
	       			,icurpage : icurpage
	       			,ipageSize : ipageSize
	       			,todayDate : $("#todayDate").val()
					,sloginID : loginID
					,deptall : $("#deptall").val()
	   };
	    
	   console.log("papaa : " + JSON.stringify(param));
	   
	   var listIncManageicallback = function(returndata) {
		    fn_listIncManageicallback(returndata,icurpage) ;  
	   }
	   
	   callAjax("/employee/listIncManagei.do", "post", "text", true, param, listIncManageicallback);
	   
	   
	         
     }
	
	function fn_listIncManageicallback(returndata,icurpage){
		console.log(returndata);
			$("#IncManageiList").empty().append(returndata);	   
		    var toticnt = $("#toticnt").val();
					
			// 페이지 네비게이션 생성		
			var ipaginationHtml = getPaginationHtml(icurpage, toticnt, ipageSize, ipageBlock, 'fn_IncManageilist');
			console.log("paginationHtml : " + ipaginationHtml);
			$("#ipagingnavi").empty().append( ipaginationHtml );
			
			// 현재 페이지 설정
			$("#icurrentPage").val(icurpage);
		
	}
	 
    function fn_IncentiveModal() {
    	console.log("papaF : " +  JSON.stringify($("#isloginID")));
		
    	var ID = $("#isloginID").val();
    	if (ID == null || ID=="") {   // 신규
    		swal("대상을 선택해주세요.");
			return;
			} else {
			$("#action").val("I");
 		   //alert(ann_no);
 			fn_selIncentive(ID);
 			gfModalPop("#incentive");
 			fn_IncManageilist(ID);
 	   }
    	  	
    	
    	
    }
   
    function fn_selIncentive(ID){
    	var param = {
    			loginID : ID
    			
    	}
    	
    	var selIncentivecallback = function(returnvalue){
			console.log("selIncentivecallback : " + JSON.stringify(returnvalue) );
		    
		    fn_forminc(returnvalue.IncManageModel);
		    
		    gfModalPop("#incentive");
    	}
    	
    	callAjax("/employee/selectIncManage.do", "post", "json", true, param, selIncentivecallback);
    	
    }
    
    function fn_forminc(IncManageModel) {
 	   
    	   
 	   	   $("#dept").val(IncManageModel.dept_cd);
		   $("#dept").attr("readonly", true);
		   $("#eloginID").val(IncManageModel.loginID);
 		   $("#eloginID").attr("readonly", true);
		   $("#ename").val(IncManageModel.name);
 		   $("#ename").attr("readonly", true);
 	 	   $("#sal").val(IncManageModel.sal_ad);
		   $("#sal").attr("readonly", true);
		   $("#career").val(IncManageModel.career);
 		   $("#career").attr("readonly", true);
		   $("#incRID").val($("#loginname").val());
 		   $("#incRID").attr("readonly", true);
 		   $("#incRDate").val(IncManageModel.curdate);
		   $("#incRDate").attr("readonly", true);
		   
		   $("#action").val("i");
	
 	   }
    
    function fn_IncManagesave(icurpage,eloginID, ename){
    	
		console.log("fn_IncManagesave 실행 했어요qq"+$("#todayDD").val()); 

    	
    	var checkincentive = $("#incentiveprice");
    	if(checkincentive ==null || checkincentive == "" ){
    	 	alert("지급액을 입력해주세요.");
    	} else{
    	
    	var param ={
    			loginID : $("#eloginID").val()
    			,ict_bo : $("#incRID").val()
    			,ict_price : $("#incentiveprice").val()
    			, action : $("#action").val()	
    	  	}
    	var saveInccallback = function(savereturn) {
	 		   console.log("saveInccallback : " + JSON.stringify(savereturn) );
	 			
	 		   
	 		   if(savereturn.result = "SUCCESS"){
	 			alert("저장 되었습니다.")
	 		   
	 		   gfCloseModal();
	 		   var icurpage = 1;
			   var loginID = $("#eloginID").val();
			   var name = $("#ename").val();
	 		   fn_IncManageilist(icurpage,loginID, name);
 		   	   }
	 		  console.log("88888888param : " + JSON.stringify(param)); 
    		}
    	console.log("77777777777param : " + JSON.stringify(param));
    	callAjax("/employee/saveIncManage.do", "post", "json", true, param, saveInccallback);
    	}
    	
    	console.log("9999999999param : " + JSON.stringify(param)); 
    	
    }
    
    
    	
    
    
      
 
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myIncManage" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="icurrentPage" value="1">
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="Fselectannno" id="selectannno" value=""> 
	<input type="hidden" id="swriter"  name="swriter"  value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	<input type="hidden" id="loginname"  name="loginname"  value="${loginname}">
    <input type="hidden" id="todayDD"  name="todayDD"  value="${todayDD}">
    <input type="hidden" id="todayDate"  name="todayDate"  value="${todayDate}">
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
							<a href="#" class="btn_nav bold">인사/급여</a> 
								<span class="btn_nav bold">인센티브</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>실적 조회 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">
                                 <select id="deptall" name="deptall">
                                 
                                 </select>
                           </td>

                           <td width="50" height="25" style="font-size: 100%">이름</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="sname" name="sname"></td>
                           <td width="50" height="25" style="font-size: 100%">사번</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="sloginID" name="sloginID"></td>                     
                           <td width="50" height="25" style="font-size: 100%">월별 검색</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="month" style="width: 120px" id="to_month" name="to_month"></td>
                       
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						<!-- 실적 조회 -->
						<div class="divIncManageList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="20%">
						                   <col width="20%">
						                   <col width="10%">
						                   <col width="20%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">근무 부서</th>
							              <th scope="col">사원 명</th>
							              <th scope="col">달성률</th>
							              <th scope="col">실적액수</th>
							              <th scope="col">최근 지급일</th>
							              <th scope="col">사번</th>
									</tr>
								</thead>
								<tbody id="IncManageList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>
						
					<div class="paging_area"  id="comnGrpCodPagination"> </div>
						 <!-- 인센티브 조회 -->
                         <p class="conTitle">
							<span>개인 인센티브 조회 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								
							</span>
						</p>
						<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           

                           <td width="50" height="25" style="font-size: 100%">   이름</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="isname" name="isname" readonly></td>
                           <td width="50" height="25" style="font-size: 100%" text-align: right;>사번</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="isloginID" name="isloginID" readonly></td>
                           <td width="50" height="25" style="font-size: 100%">
                           <input type="month" style="width: 120px" id="from_imonth" name="from_imonth"></td>
                           <td width="50" height="25" style="font-size: 100%">
                           <input type="month" style="width: 120px" id="to_imonth" name="to_imonth"></td>
                      	     
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="btniSearch" name="btn"><span>검  색</span></a>
                           <td width="110" height="60" style="font-size: 120%">
                           <a class="btnType blue" href="javascript:fn_IncentiveModal();" name="incbtn" id="incbtn" ><span>인센티브 지급</span></a>
                          
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>
								  

						</p>
						 			<div id="vuetable">
									<div class="bootstrap-table">
									<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">	</div>
									</div>
									<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuedatatable" class="col2 mb10" style="width: 99%;">
											<colgroup>
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="20%">
												<col width="10%">
											</colgroup>
				
											<thead>
												<tr>
													<th scope="col">인센티브 코드</th>
													<th scope="col">사원명</th>
													<th scope="col">사번</th>
													<th scope="col">승인자</th>
													<th scope="col">지급액</th>
													<th scope="col">등록 일자</th>
												</tr>
											</thead>
											<tbody id="IncManageiList"></tbody>						
										</table>
										<div class="paging_area" id="ipagingnavi">
							</div>
		
					 <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업 -->
	<div id="incentive" class="layerPop layerType2" style="width: 600px;">
		
		<input type="hidden" id="ict_no" name="ict_no" value="${ict_no}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">부서<span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100" name="dept" id="dept" /></td>
						</tr>
						<tr>
							<th scope="row">사번<span class="font_red"></span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="eloginID" id="eloginID" /></td>
						</tr>
						<tr>
							<th scope="row">이름<span class="font_red"></span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="ename" id="ename" /></td>
						</tr>
						<tr>
							<th scope="row">기준연봉<span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100" name="sal" id="sal" /></td>
						</tr>
						<tr>
							<th scope="row">근무연차<span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100" name="career" id="career" /></td>
						</tr>
						<tr>
							<th scope="row">지급액<span class="font_red">*</span></th>
							<td><input type="number" min="0" class="inputTxt p100" name="incentiveprice" id="incentiveprice" /></td>
						</tr>
						<tr>
							<th scope="row">승인자<span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100" name="incRID" id="incRID" /></td>
						</tr>
						<tr>
							<th scope="row">등록일자<span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100" name="incRDate" id="incRDate" /></td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveIncManage" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateNotice" name="btn" style="display:none"><span>수정</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

		


</form>

</body>
</html>
