<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 급여관리  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	
	//일괄지급확인창
	function confirmAlert(){
	  window.confirm("일괄지급처리하시겠습니까?");
	  $("button[name='AllPay']").click(function(){
	  });
	}	  
	//일괄지급 기능
	
	function AllPay(){
		 var param = {
				 
				 
		   };
		         
	}
	
	
	

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		fn_payAccMnglist();		
		
		fSearchButtonClickEvent();
	});
	
	function fSearchButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'searchBtn' :
					fn_payAccMnglist();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnConfirmpayAccMng' :
					fn_payAccMngconfirm();
					break;	
				case 'confirmAlert' :
					confirmAlert();
					break;
			
			}
		})
	};
	
	
	/*사원급여정보조회 - 검색조건*/
	
   function 	fn_payAccMnglist(curpage) {
	      
	   curpage = curpage || 1;
	   
	   var param = {
			 salmonth : $("#salmonth").val()  //급여년월
			 , deptsearchKey : $("#deptsearchKey").val()//부서	
			 , jobsearchKey : $("#jobsearchKey").val()//직급
			 , catesearchKey : $("#catesearchKey").val()//분류
	    	 , name : $("#name").val()//사원명
			 , paysearchKey : $("#paysearchKey").val()//지급여부
	         ,curpage : curpage
	         ,pageSize : pageSize
	       
	       
	   };
	   
	   var payAccMnglistcallback = function(returndata) {
		    fn_payAccMnglistcallback(returndata,curpage) ;  
	   }
	   
	   callAjax("/employee/listpayAccMng.do", "post", "text", true, param, payAccMnglistcallback);
	   
	         
   }
	
   function fn_payAccMnglistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#payAccMngList").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_payAccMnglist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }
   
   /* 지급내역조회 - 설아 */
   /*사원급여정보조회 - 검색조건*/
	// 페이징 설정 
	var dtlpageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var dtlpageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
   
   function 	fn_payAccMngModal(log) {
	      
	   var curpagedtl = curpagedtl || 1;
	   
	   var param = {
	          curpagedtl : curpagedtl
	         ,dtlpageSize : dtlpageSize
	         ,loginID : log
	       
	   };
	   
	   var payAccMnglistcallbackdtl = function(returndata) {
		    fn_payAccMnglistcallbackdtl(returndata,curpagedtl) ;  
	   }
	   
	   callAjax("/employee/payAccMngDtlList.do", "post", "text", true, param, payAccMnglistcallbackdtl);
	   
	         
   }
   
   function fn_payAccMnglistcallbackdtl(returndata,curpagedtl) {	   
	   console.log(returndata);
	   
	   $("#payAccMngListdtl").empty().append(returndata);	   
	   var totcntdtl = $("#totcntdtl").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpagedtl, totcntdtl, dtlpageSize, dtlpageBlock, 'fn_payAccMngModal');
		console.log("paginationHtml : " + paginationHtml);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPagedtl").val(curpagedtl);
   }

   /*
   function fn_forminit(payAccMngModel) {
	   
	   if( payAccMngModel == "" || payAccMngModel == null || payAccMngModel == undefined) {   // 신규
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);	   
		   $("#payAccMngMonth").val("");
		   $("#payAccMngDept").val("");
		   $("#btnDeletepayAccMng").hide();		
		   $("#action").val("I");
	   } else {
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);
		   $("#seletsalno").val(payAccMngModel.sal_no);//급여지출코드
		   $("#payAccMngMonth").val(payAccMngModel.sal_date);//해당월
		   $("#payAccMngJob").val(payAccMngModel.job_cd);//직급
		   $("#payAccMngDept").val(payAccMngModel.dep_cd);//부서
		   $("#payAccMngCode").val(payAccMngModel.loginID);//사번
		   $("#payAccMngSalary").val(payAccMngModel.sal_ad);//연봉
		   $("#payAccMngBSalary").val(payAccMngModel.sal_bt);//기본급
		   $("#payAccMngKuk").val(payAccMngModel.sal_kuk);//국민연금
		   $("#payAccMngKun").val(payAccMngModel.sal_kun);//건강보험
		   $("#payAccMngSan").val(payAccMngModel.sal_san);//산재보험
		   $("#payAccMngKo").val(payAccMngModel.sal_ko);//고용보험
		   $("#payAccMngEtc").val("");//지출결의서금액
		   $("#payAccMngAPay").val(payAccMngModel.sal_price);//실급여
		   $("#btnDeletepayAccMng").show();	
		   $("#action").val("U");
	   }
   }
   */
   function fn_selectpayAccMng(loginID) {
	   
	   var param = {
			   loginID : loginID
	   };
	   
	   var selectpayAccMngcallback = function(selectresult) {
		    console.log("selectpayAccMngcallback : " + JSON.stringify(selectresult) );
		    
		    fn_forminit(selectresult.payAccMngModel);
		    
		    gfModalPop("#payAccMng");
	   }
	   
	   callAjax("/employee/selectpayAccMng.do", "post", "json", true, param, selectpayAccMngcallback);
   }	
	   /*설아추가*/
	   function fn_payAccMngconfirm() {
	   
	   var param = {
			   loginID :  $("#loginID").val()
			 , payAccMngMonth : $("#payAccMngMonth").val()  
			 , payAccMngDept : $("#payAccMngDept").val()
			 , payAccMngJob : $("#payAccMngJob").val()	
			 , payAccMngCode : $("#payAccMngCode").val()
			 , payAccMngSalary : $("#payAccMngSalary").val()  
			 , payAccMngBSalary : $("#payAccMngBSalary").val()
			 , payAccMngKuk : $("#payAccMngKuk").val()	
			 , payAccMngKun : $("#payAccMngKun").val()
			 , payAccMngSan : $("#payAccMngSan").val()
			 , payAccMngKo : $("#payAccMngKo").val()
			 , payAccMngEtc : $("#payAccMngEtc").val()	
			 , payAccMngAPay : $("#payAccMngAPay").val()
			 , payAccMngPay : $("#payAccMngPay").val()	
			 , action : $("#action").val()	
	   }
   }
	   </script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="mypayAccMng" action="mypayAccMng" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="currentPagedtl" value="1">
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="selectsalno" id="selectsalno" value=""> 
	<input type="hidden" id="swriter"  name="swriter"  value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
    <input type="hidden" id="sal_no"  name="sal_no"  value="">
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
								<span class="btn_nav bold">급여관리</span> 
								<a onclick="window.location.reload()" style="crusor:pointer;" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>사원 급여정보 </span> <span class="fr"> 
								<c:set var="Month" value=""></c:set>
								<span>날짜<input type="month" style="width: 120px" id="salmonth" name="salmonth"></span>
								<a class="btnType blue" href="javascript:confirmAlert();" id="AllPay" name="AllPay" >
								<span>일괄지급</span></a>
							</span>
						</p>
						
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="60" height="30" style="font-size: 100%">사원명
                               <input type="text" style="width: 120px" id="name" name="name"> </td>                    
                           <td width="50" height="30" style="font-size: 100%">날짜
                            <input type="month" style="width: 120px" id="salmonth" name="salmonth"></td>
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                           <td><a href="" class="btnType blue" id="searchBtn" name="btn" style="text-align:right"><span>검  색</span></a><p></td>
                            </tr>
                            <tr>
                           <td width="50" height="30" style="font-size: 100%">분류
                            <select id="catesearchKey" name="catesearchKey" style="width: 150px;" >
									<option value="none" >전체</option>
									<option value="salary" >급여</option>
									<option value="DV" >지출결의서</option>
							</select>
							</td>
							<td width="50" height="30" style="font-size: 100%">부서
                            <select id="deptsearchKey" name="deptsearchKey" style="width: 150px;">
									<option value="none" >전체</option>
									<option value="10" >배송부</option>
									<option value="20" >구매부</option>
									<option value="30" >영업부</option>
									<option value="40" >총무부</option>								
									<option value="50" >관리부</option>
									<option value="60" >scm부</option>
									
							</select> 
							</td>
							<td width="50" height="30" style="font-size: 100%">직급
                            <select id="jobsearchKey" name="jobsearchKey" style="width: 150px;">
									<option value="none" >전체</option>
									<option value="1" >사원</option>
									<option value="2" >대리</option>
									<option value="3" >과장</option>
									<option value="4" >차장</option>
									<option value="5" >부장</option>
									<option value="6" >임원</option>
							</select> 
							</td>
							<td width="50" height="30" style="font-size: 100%">지급여부
                            <select id="paysearchKey" name="paysearchKey" style="width: 150px;" >
									<option value="none" >전체</option>
									<option value="Y" >지급</option>
									<option value="N" >미지급</option>
							</select> 
							</td>
                        </tr>
                     </table>    
						
						
						<div class="divpayAccMngList">
							<table class="col">
								<caption>사원 급여정보</caption>
	
		                            <colgroup>
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">급여년월</th>
							              <th scope="col">부서</th>
							              <th scope="col">직급</th>
							              <th scope="col">사번</th>
							              <th scope="col">사원명</th>
							              <th scope="col">연봉</th>
							              <th scope="col">기본급</th>
							              <th scope="col">국민연금</th>
							              <th scope="col">건강보험</th>
							              <th scope="col">장기요양보험</th>
							              <th scope="col">고용보험</th>
							              <th scope="col">지출결의서</th>
							              <th scope="col">실급여</th>
							              <th scope="col">지급</th>
									</tr>
								</thead>
								<tbody id="payAccMngList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>
<!--  설아추가 그리드 -->

	<input type="hidden" id="currentPagedtl" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="selectsalno" id="selectsalno" value=""> 
	<input type="hidden" id="swriter"  name="swriter"  value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
    <input type="hidden" id="sal_no"  name="sal_no"  value="">
	<div id="wrap_area" style="width:100%">

					<p class="conTitle">
							<span>지급내역</span> <span class="fr"> 
							</span>
						</p>
						<div class="divComDtlCodList">
							<table class="col">
								<caption>지급내역</caption>
	
		                            <colgroup>
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">급여년월</th>
							              <th scope="col">부서</th>
							              <th scope="col">직급</th>
							              <th scope="col">사번</th>
							              <th scope="col">사원명</th>
							              <th scope="col">연봉</th>
							              <th scope="col">기본급</th>
							              <th scope="col">국민연금</th>
							              <th scope="col">건강보험</th>
							              <th scope="col">장기요양보험</th>
							              <th scope="col">고용보험</th>
							              <th scope="col">지출결의서</th>
							              <th scope="col">실급여</th>
							              <th scope="col">지급</th>
									</tr>
								</thead>
								<tbody id="payAccMngListdtl"></tbody>
					
				<!--설아 지급내역리스트 출력 -->
							</table>
						</div>
						
						<div class="paging_area"  id="comnDtlCodPagination"> </div>

				


		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업 -->
	<div id="payAccMngModal" class="layerPop layerType2" style="width: 1000px; height:800px">
		<input type="hidden" id="payAccMngModal" name="payAccMngModal" value="${payAccMngNodtl}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>급여 지급내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="6%">
						                   <col width="8%">
						                   <col width="6%">
						                   <col width="6%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">급여년월</th>
							              <th scope="col">부서</th>
							              <th scope="col">직급</th>
							              <th scope="col">사번</th>
							              <th scope="col">사원명</th>
							              <th scope="col">연봉</th>
							              <th scope="col">기본급</th>
							              <th scope="col">국민연금</th>
							              <th scope="col">건강보험</th>
							              <th scope="col">장기요양보험</th>
							              <th scope="col">고용보험</th>
							              <th scope="col">지출결의서</th>
							              <th scope="col">실급여</th>
							              <th scope="col">지급</th>
									</tr>
								</thead>
								<tbody id="payAccMngList"></tbody>
							</table>

				<!-- e : 여기에 내용입력 -->
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>

</body>
</html>
