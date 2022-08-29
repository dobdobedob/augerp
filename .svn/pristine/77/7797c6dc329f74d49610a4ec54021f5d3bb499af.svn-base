<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 승진 관리  </title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수

	
	$(document).ready(function() {
		
		fn_empPromotionList();

		fn_init(); //직급 리스트 출력
		
		fRegisterButtonClickEvent();
	
	});
	
	//직급 리스트 출력
	function fn_init() {
		comcombo("POScd", "search_job_cd", "sel", "");
	}
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_empPromotionList();
					break;
				case 'btnListClose' :
					gfCloseModal();
					break;
				
			}
		});
	}
	
	function fn_empPromotionList(curpage){
		curpage = curpage || 1;
		
		var param = {
				selectDepart : $("#selectDepart").val()
			   ,search_job_cd : $("#search_job_cd").val()
			   ,selectOP : $("#selectOP").val()
			   ,search_input : $("#search_input").val()
			   ,from_date : $("#from_date").val()
			   ,to_date : $("#to_date").val()  
		       ,curpage : curpage
		       ,pageSize : pageSize
		};
		
		var EmpPromotionlistcallback = function(returndata){
			fn_EmpPromotionlistcallback(returndata, curpage);
		}
		callAjax("/employee/empPromotionList.do", "post", "text", true, param, EmpPromotionlistcallback);
	}
	
	function fn_EmpPromotionlistcallback(returndata, curpage){
		console.log(returndata)
		
		$("#empPromotionList").empty().append(returndata);	   
		 var totcnt = $("#totcnt").val();
		 
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_empPromotionList');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
		
		
	}
	
	// 페이징 설정 
	var pageSizelogin = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlocklogin = 5;		// 블럭으로 잡히는 페이징처리 수
	
	function fn_empPromotionListlogin(loginID, curpagelogin){
		curpagelogin = 1;
		
		var param = {
				loginID : loginID
				,curpagelogin : curpagelogin
			    ,pageSizelogin : pageSizelogin
		};
		
		var EmpPromotionlogininfocallback = function(returndata){
			console.log(returndata);
			$("#loginID_info").val(returndata.empManagement.loginID);
			$("#name_info").val(returndata.empManagement.name);
			$("#dept_info").val(returndata.empManagement.dept_name);
			$("#job_info").val(returndata.empManagement.detail_name);
		}
		
		var EmpPromotionlistlogincallback = function(returndata){
			fn_EmpPromotionlistlogincallback(returndata, curpagelogin);
			}
	
		
		callAjax("/employee/listEmpManagementlogininfo.do", "post", "json", true, param, EmpPromotionlogininfocallback);
		callAjax("/employee/listEmpManagementlogin.do", "post", "text", true, param, EmpPromotionlistlogincallback);
		
		
	}
	
	function fn_EmpPromotionlistlogincallback(returndata, curpage){
		
		$("#empPromotionloginID").empty().append(returndata);	   
		 var totcnt = $("#totcnt_loginID").val();
		 
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSizelogin, pageBlocklogin, 'fn_empPromotionListlogin');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi_loginID").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPagelogin").val(curpage);
		
		gfModalPop("#empPromotion_loginID");
	}
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="empPromotion" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="currentPagelogin" value="1"> 
	<input type="hidden" name="selecthr_no" id="selecthr_no" value=""> 


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
								<span class="btn_nav bold">승진 내역 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>승진 내역 관리 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
							</span>
						</p>
					<!--검색창  -->
					<table width="100%"  cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="40" height="25" style="font-size: 100%">부서</td>
                           <td width="10" height="25" style="font-size: 120%">
                                 <select id="selectDepart" name="selectDepart" style="width: 100px;">
                                 	<option value="" selected="selected">선택</option>
                                  	<c:forEach items="${departmentList}" var = "list">
                                  		<option value="${list.dept_cd}">${list.dept_name}</option>
                                  	</c:forEach>
                                 </select>
                           </td> 
                           <td width="30" height="25" style="font-size: 100%">직급</td>
                           <td width="10" height="25" style="font-size: 120%">
                                 <select id="search_job_cd" name="search_job_cd" style="width: 100px;">
                                 
                                 </select>
                           </td> 

                           <td width="10" height="25" style="font-size: 120%" >
                                 <select id="selectOP" name="selectOP" style="width: 100px;">
                                 	<option value="" selected="selected">선택</option>
                                 	<option value="search_loginID">사번</option>
                                 	<option value="search_name">사원명</option>
                                 </select>
                           </td>
                           <td width="20" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px; height: 30px;" id="search_input" name="search_input"></td>                                
                           <td width="60" height="25" style="font-size: 100%">기간별 조회</td>
                           <td width="30" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px; height: 30px;" id="from_date" name="from_date"></td>
                           <td width="10" height="60" style="font-size: 100%">
                            <input type="date" style="width: 120px; height: 30px;" id="to_date" name="to_date"></td>
                           <td width="10" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
							
						<div class="divEmpPromotionList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="11%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="13%">
						                   <col width="10%">
						                   <col width="13%">
						                   <col width="12%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">사번</th>
							              <th scope="col">사원명</th>
							              <th scope="col">부서코드</th>
							              <th scope="col">부서명</th>
							              <th scope="col">직급코드</th>
							              <th scope="col">직급명</th>
							              <th scope="col">발령일자</th>
									</tr>
								</thead>
								<tbody id="empPromotionList"></tbody>
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


	<!-- 퇴사처리 모달팝업 -->
	<div id="empPromotion_loginID" class="layerPop layerType2" style="width: 800px;">
		<input type="hidden" id="loginIdre" name="loginIdre" value=""> <!-- 수정시 필요한 num 값을 넘김  -->
		<dl>
			<dt>
				<strong>사원 승진 내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div class="divEmpPromotionList">
					<table width="100%"  cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf; height: 50px; ">
                        <tr style="border: 0px; border-color: blue">
                           <td width="10" height="25" style="font-size: 100%"></td>
                           <td width="30" height="25" style="font-size: 100%">사번</td>
                           <td width="10" height="25" style="font-size: 120%">
                                 <input type="text"  style="width: 80px;" readonly="readonly" id="loginID_info" name="loginID_info">
                           </td> 
                           <td width="30" height="25" style="font-size: 100%">사원명</td>
                           <td width="10" height="25" style="font-size: 120%">
                                 <input type="text"  style="width: 80px;"  readonly="readonly" id="name_info" name="name_info" >
                           </td>  
                           <td width="30" height="25" style="font-size: 100%">부서명</td>
                           <td width="60" height="25" style="font-size: 120%">
                                 <input type="text" style="width: 80px;"  readonly="readonly" id="dept_info" name="dept_info">
                           </td> 
                           <td width="30" height="25" style="font-size: 100%"></td>
            			   <td width="40" height="25" style="font-size: 100%">현재 직급</td>
                           <td width="10" height="25" style="font-size: 120%">
                                 <input type="text"  style="width: 80px;"  readonly="readonly" id="job_info" name="job_info">
                           </td> 
                        </tr>
                     </table>    
							
					<table class="col">
						<caption>caption</caption>

                            <colgroup>
				                   <col width="12%">
				                   <col width="10%">
				                   <col width="10%">
				                   <col width="10%">
				                   <col width="10%">
			                 </colgroup>
						<thead>
							<tr>
								  <th scope="col">발령일자</th>
					              <th scope="col">부서코드</th>
					              <th scope="col">부서명</th>
					              <th scope="col">직급코드</th>
					              <th scope="col">직급명</th>
							</tr>
						</thead>
						<tbody id="empPromotionloginID"></tbody>
					</table>
					
					<!-- 페이징 처리  -->
					<div class="paging_area" id="pagingnavi_loginID">
					</div>
									
				</div>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnListClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>

</body>
</html>
