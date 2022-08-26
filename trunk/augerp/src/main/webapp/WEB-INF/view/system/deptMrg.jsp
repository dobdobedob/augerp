<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 부서관리  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">


	// 페이징 설정 
	var pageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		fn_deptMrglist();		
		
		fRegisterButtonClickEvent();
	});
	
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' : //검색
					fn_deptMrglist();
					break;
				case 'btnClose' :  //닫기
					gfCloseModal();
					break;
				case 'btnUpdate' : //수정
					fn_deptMrgsave();
					break;	
				case 'btnInsert' : //등록
					fn_deptMrgsave();
					break;		
				case 'btnDelete' : //삭제
					$("#action").val("D");
					fn_deptMrgsave();
					alert("삭제되었습니다.");
					break;
				case 'insertBtn' :
					fn_deptMrg();
					break;
					
			}
		});
	}
		
   function 	fn_deptMrglist(curpage) {
	      
	   curpage = curpage || 1;
	   
	   var param = {
	        title : $("#title").val()  	
	       ,curpage : curpage
	       ,pageSize : pageSize
	   };
	   
	   var deptMrglistcallback = function(returndata) {
		    fn_deptMrglistcallback(returndata,curpage) ;  
	   }
	   
	   callAjax("/system/deptMrg.do", "post", "text", true, param, deptMrglistcallback);
	         
   }
	
   function fn_deptMrglistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#deptMrgList").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_deptMrglist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#curpage").val(curpage);
   }
   
   //모달실행???설아
   function fn_deptMrg(dept_cd) {
	   
	   if (dept_cd == null || dept_cd == "") {   // 신규
		   fn_forminit();		   
		   gfModalPop("#deptMrg");
	   } else {
		   //alert(dept_cd);
		   fn_selectDeptMrg(dept_cd);
	   }
   }
   /*부서관리 등록 모달 실행-설아*/
   function dept_insert(dept_cd){
	// 신규 저장
		if (dept_cd == null || dept_cd == "") {
			// 모달 팝업
			gfModalPop("#deptMrg");
			
			if ($("#btnInsert").css("display") == "none") {
				$("#btnInsert").show();
				$("#action").val("I");
				return;
			}
		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#btnInsert").hide();
			$("#btnUpdate").show();
			$("#action").val("U");
			// 상세코드 단건 조회
			fSelectDtlCod(dept_cd, dept_name);
		}
   }
   
   
   
   
   function fn_forminit(DeptMrgModel) {
	   
	   if( DeptMrgModel == "" || DeptMrgModel == null || DeptMrgModel == undefined) {   // 신규
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);	  
		   $("#dept_cd").val("");
		   $("#dept_name").val("");
		   $("#btnInsert").show();
		   $("#btnUpdate").hide();		
		   $("#action").val("I");
	   } else {
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);	  
		   $("#dept_cd").val(DeptMrgModel.dept_cd);
		   $("#dept_name").val(DeptMrgModel.dept_name);
		   $("#action").val("U");
		   $("#dept_cdh").val(DeptMrgModel.dept_cd);
		   $("#btnInsert").hide();
		   $("#btnUpdate").show();	
	   }
   }
   /*
   //등록버튼 이벤트-설아
   function fn_btnInsert(){
	   $(document).ready(function(){
		   $("#btnInsert").on("click", function(){
			alert("등록되었습니다.")   
		   });
	   });
	   let sendData = $("#dept_cd").val();
	   				  $("#dept_name").val();
	   $.ajax({
		 type:'post',
		 data:sendData
	   })
	   
	   
   }
   */
   
   function fn_selectDeptMrg(dept_cd) {
	   
	   var param = {
			   dept_cd : dept_cd
	   };
	   
	   var selectDeptMrgcallback = function(selectresult) {
		    console.log("selectDeptMrgcallback : " + JSON.stringify(selectresult) );
		    
		    fn_forminit(selectresult.DeptMrgModel);
		    $("#dept_cd").attr("disabled", true); //부서코드 선택불가
		    gfModalPop("#deptMrg");
	   }
	   callAjax("/system/selectDeptMrg.do", "post", "json", true, param, selectDeptMrgcallback);
   }	
   /*부서명 검색기능-설아 */
   	// 검색기능
	function fn_search(curpage) {
        
        var title = $('#title');
        //var title = document.getElementById("title");
		
		curpage = curpage || 1;
		
        var param = {
        		  title : $("#title").val()
              ,   curpage : curpage
              ,   pageSize : pageSize
        };
        var resultCallback = function(data) {
        	fn_deptMrgsaveResult(data, curpage);
        };
        
        callAjax("/system/selectDeptMrg.do", "post", "text", true, param, resultCallback);
        
  } 

   
   
	   
   /*부서관리 모달창 수정-설아 */
	function fn_deptMrgsave() {

		var resultCallback = function(data) {
			fn_deptMrgsaveResult(data);
		};
		
		callAjax("/system/saveDeptMrg.do", "post", "json", true, $("#myform").serialize(), resultCallback);
	}
	   
	/** 부서관리 모달창 수정 콜백 함수-설아*/
	function fn_deptMrgsaveResult(data) {
		
		// 목록 조회 페이지 번호
		var curpage = "1";
		if ($("#action").val() != "I") {
			curpage = $("#curpage").val();
		}
		
		if (data.result == "SUCCESS") {
			// 모달 닫기
			gfCloseModal();
			// 목록 조회
			fn_deptMrglist(curpage);
		} else {
			// 오류 응답 메시지 출력
			//alert(data.resultMsg);
		}
	}
   
	   var savedeptMrgcallback = function(savereturn) {
		   console.log("savedeptMrgcallback : " + JSON.stringify(savereturn) );
		   var curpage = 1;
		   
		   if(savereturn.result == "SUCCESS") {
			   if($("#action").val() == "D") {
				   alert("삭제 되었습니다.");
			   } else {
				   alert("저장 되었습니다.");
			   }
			   
			   gfCloseModal();
			   
			   fn_deptMrglist(curpage);
		   } else {
			   alert("실패 했습니다.");
		   }
	   
	   callAjax("/system/savedeptMrg.do", "post", "json", true, param, savedeptMrgcallback);
   }
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myform" action="" method="">
	
	<input type="hidden" id="curpage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="swriter"  name="swriter"  value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
    <input type="hidden" id="dept_cdhidden"  name="dept_cdhidden"  value="">
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
								<span class="btn_nav bold">부서관리</span> 
								<a onclick="window.location.reload()" style="crusor:pointer;" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>부서관리 </span> <span class="fr"> 
							</span>
						</p>
						
					<!--검색창  --> 
					<table width="50%" cellpadding="10" cellspacing="5" border="1" align="right"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>

                           <td width="50" height="25" style="font-size: 100%" >부서명</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="title" name="title"></td>                     
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td>
                           <td width="110" height="60" style="font-size: 120%"> 
                           <a href=""  class="btnType blue" id="insertBtn" name="btn"><span >등  록</span></a></td> 
                           
                        </tr>
                     </table>    
						
						
						<div class="divDeptMrgList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="30%">
						                   <col width="30%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">부서코드</th>
							              <th scope="col">부서명</th>
									</tr>
								</thead>
								<tbody id="deptMrgList"></tbody>
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
	<div id="deptMrg" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="dept_cdh" name="dept_cdh" value="${dept_cd}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>부서관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">부서코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="dept_cd" id="dept_cd" oninput="this.value = this.value.replace(/[^0-9]/g, '');" /></td>
						</tr>
						<tr>
							<th scope="row">부서명<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="dept_name" id="dept_name" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnInsert" name="btn" style="display:none"><span>등록</span></a> 
					<a href="" class="btnType blue" id="btnUpdate" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업  --> 


</form>

</body>
</html>
