<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 견적서 작성 및 조회  </title>

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
 width:5%;
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

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	var pageSize = 5;
	var pageBlock = 5;	

	$(document).ready(function() {
		fn_scb();
		fn_estManagementlist();
		fRegisterButtonClickEvent();
		
		
	});

	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	 		
			switch (btnId) {
				case 'searchBtn' :
					fn_estManagementlist();
					break;
				case 'estManagementModal' :
					fn_estManagementModal();
					break;
				case 'btnSaveEmt' :
					break;
				case 'btnClosedn' :
					gfCloseModal();
					break;
				case 'btnClosednEMt' :
					gfCloseModal();
					break;
				case 'updateBtn' :
					
					break;
			}
		});
	}
//===============================================================================

	
function fn_estManagementlist(curpage){

	curpage = curpage || 1;

	var param = {
				    cilall : $("#cilall").val()
				   ,from_date : $("#from_date").val()  
	               ,to_date : $("#to_date").val()  
    			   ,curpage : curpage
    			   ,pageSize : pageSize
				};
       var estManagementlistcallback = function(returndata) {
		    fn_estManagementlistcallback(returndata,curpage) ;  
	   }
	   
   	   callAjax("/business/estManagementlist.do", "post", "text", true, param, estManagementlistcallback);
}


	  function fn_estManagementlistcallback(returndata,curpage) {	   
		   console.log(returndata);
		   
		   //tbody에전달?
		   $("#estManagementList").empty().append(returndata);	   
		   var totcnt = $("#totcnt").val();
					
			// 페이지 네비게이션 생성			
			var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_estManagementlist');
			console.log("paginationHtml : " + paginationHtml);
			$("#pagingnavi").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPage").val(curpage);
	   }
	   
	

//================== 콤보박스 =============================================================
	function fn_scb(){
		selectComCombo("cli", "cilall", "all", "", "");
		selectComCombo("cli", "cilallis", "all", "", "");
	
		//console.log("1111111111111111 : " + $("#cilall").length);
		
		
		$("#prolall").change(function() {
	        productCombo("m", "promall", "all", $("#prolall").val(), "");
	           
	        //대분류를 바꾸면 중,제,부서가 지워져야지 새로운 조건이 보이기 때문에 remove를 사용한다.
	        $('#prodall').children('option').remove();
	     });

	     $("#promall").change(function() {
	        productCombo("p", "prodall", "all", $("#promall").val(), "");
	     });
	     productCombo("l", "prolall", "all", "", "");
	     
	     //console.log("222222222222222222222 : " + $("#prolall").length);

	     
}
//======================== 견적서상세조회 =======================================================
	
	function fn_estManagementModal(est_no){
	
	fn_selectestManagement(est_no);
	
	}


//===============================================================================
	function fn_selectestManagement(est_no){
		var param = {
				est_no : est_no
	  	 };
	    var estManagementModalcallback = function(selectresult) {
		    console.log("estManagementModalcallback : " + selectresult );
		//JSON.stringity 는 값이나 객체를 json형식으로 바꿔준다
		
		
		$("#estManagementModal").empty().append(selectresult);
		//모달 불러와서 지우고 만든다.
		gfModalPop("#estManagementModal");
		//모달 팝업 띄우기
		
		//fn_forminit(selectresult);
	   }
	   callAjax("/business/selectestmanagement.do", "post", "text", true, param, estManagementModalcallback);
}

// ====================================견적서 상세조회 명함 JSTL =======================================================
	function fn_listcardTot(est_no){
		var param = {
				est_no : est_no

		};
		
		 var listcardTotcallback = function(data) {
			 console.log("listcardTotcallback : " + JSON.stringify(data) );
			    fn_listcardTotcallback(data) ;  
		   }

		 callAjax("/business/selectestmanagement.do", "post", "json", true, param, listcardTotcallback);
	}

//============================= 견적서 등록  모달=================================================================
function fn_estManagementinsert() {
	
		   var param = {
			   cilallis :  $("#cilallis").val() //거래처코드가 이걸로 넘어옴	
			 , prodall : $("#prodall").val()
			 , de_nmt : $("#de_nmt").val()	
			 , de_price : $("#de_price").val()	
			 , de_due : $("#de_due").val()
			 
		   }
		   
		   var estManagementinsertcallback = function(savereturn) {
			   console.log("estManagementinsertcallback : " + savereturn );
			   
			   $("#saveEstmodal").empty().append(savereturn);
				//모달 불러와서 지우고 만든다.
				
				fn_scb();
				 $("#esNum").val("");
				 $("#esdNum").val("");
				gfModalPop("#saveEstmodal");
				
		   }
		   
		   callAjax("/business/estManagementinsert.do", "post", "text", true, param, estManagementinsertcallback);
		   
	   }
  //=============== 세이브 하는 ajax =======================================================================
	   function fn_estisave(){
		   
		   var param = {
				   cilallis :  $("#cilallis").val() //거래처코드가 이걸로 넘어옴	
				 , prodall : $("#prodall").val()
				 , de_nmt : $("#de_nmt").val()	
				 , de_price : $("#de_price").val()	
				 , de_due : $("#de_due").val()
				 , est_no : $("#esNum").val() 
			   }
		   
		   var estilistcallback = function(estiinsert) {
			   console.log("estilistcallbackaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa : " + estiinsert );
			   
				$("#esNum").val(estiinsert.sqlresult);
				fn_saveEstmodal(estiinsert.sqlresult);
				$("#cilallis").attr("disabled",true);
			   }
		  
		   
		   callAjax("/business/saveEmti.do", "post", "json", true, param, estilistcallback);
		  
	   }
 // =============================== 모달창 안의 테이블 =========================================================
	   function fn_saveEstmodal(data){
		   var param = {
				   est_no :  $("#est_no").val() 
		   }
		   var apinsertlistcallback = function(estiinsert) {
				
			   $("#listEm").empty().append(estiinsert);
			   
			   }
		   callAjax("/business/selectEstNo.do", "post", "text", true, param, apinsertlistcallback);
			 
	   }



//=============== 삭제 하는 ajax ===============================================================
	   function fn_estidelete(est_no,si_cd){ //parameter 값은 삭제버튼에서 바로 받아온다.
		   
		   var param = {//컨트롤러로 데이터값을 보내 삭제가 이루어진다.
				   si_cd : si_cd
				  ,est_no : est_no
				
			   };
		   
		   var estideletecallback = function(estidelete) {
			   
			   $("#esdNum").val(estidelete.sqlresultd);
			
			   gfCloseModal();
			   }
		   callAjax("/business/deleteEmti.do", "post", "json", true, param, estideletecallback);
	   }
//======================================================================================================
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->
<form id="myNotice" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="selectannno" id="selectannno" value=""> 
	<input type="hidden" id="swriter" value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->

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
							<a href="#" class="btn_nav bold">영업 관리</a> 
								<span class="btn_nav bold">견적서관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>견적서 작성 및 조회 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fn_estManagementinsert()" name="modal">
								<span>견적서작성</span></a>
								
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%"  height="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse;
                               border: 1px solid black;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%"></td>

                           <td width="50" height="25" style="font-size: 100%">수주일</td>
                           <td width="10" height="25" style="font-size: 100%;">                          
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                            <td width="50" height="25" style="font-size: 100%"></td>
                            
                            <td width="5%" height="25" style="font-size: 100%;">견적날짜</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                            <td width="50" height="25" style="font-size: 100%"></td>
                            
                           <td width="50" height=25 style="font-size: 100%">거래처<td>
                  				<select id="cilall" name="cilall" v-model="cilall">	</select>
                			</td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                        </tr>
                        
    
                     </table>    
                     <div class="divestManagementList">
							<table class="col">
								<caption>caption</caption>
		                            <colgroup>
						                   <col width="11%">
						                   <col width="27%">
						                   <col width="10%">
						                   <col width="16%">
						                   <col width="16%">
						                   <col width="16%">
						                  
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">견적서번호</th>
							              <th scope="col">거래처명</th>
							              <th scope="col">담당자명</th>
							              <th scope="col">담당자번호</th>
							              <th scope="col">견적날짜</th>
							              <th scope="col">납기일</th>
							              <th scope="col">견적서 조회</th>
									</tr>
								</thead>
							
								<tbody id="estManagementList"></tbody>
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


	<!-- 모달팝업 -->
	<div id="estManagementModal" class="layerPop layerType2" style="width: 800px; height:750px"></div>
	<div id="saveEstmodal" class="layerPop layerType2" style="width: 800px; height:750px;">
	
	</div>
	<!-- 모달끝 -->
</form>

</body>
</html>