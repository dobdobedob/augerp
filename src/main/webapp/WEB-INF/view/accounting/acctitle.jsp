<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 계정과목관리  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		fn_AccTitlelist();		
		fn_init();
		fRegisterButtonClickEvent();
	});
	
	function fn_init(){
		
		//main
      //계정대분류코드 
      selectComCombo("acc", "acc_noT", "all", $("#acc_noT").val(), "");
      $("#acc_noT").change(function(){
    	  //계정소분류코드
         selectComCombo("accd", "dac_noT", "all", $("#acc_noT").val(), "");

      });
		$("#acc_no").change(function() {

			if( $("#acc_no").val() != ''){
				 $("#acc_no_up").val($("#acc_no").val());
				 $("#acc_no_up").attr("readonly", true);
				$("#acc_nm_tr").hide();
		//되는것	if($("#acc_no").val() == null || $("#acc_no").val() == ''){
			 }else{
				 $("#acc_no_up").val(''); 
				 $("#acc_no_up").attr("readonly", false);
				 $("#acc_nm_tr").show();
			 }	
			
			 
	      });
		
		$("#dac_no").change(function() {
			$("#dac_nm").val();
	      });
	      
	      
	    	  /*
		    //대분류를 바꾸면 중,제,부서가 지워져야지 새로운 조건이 보이기 때문에 remove를 사용한다.
		    $('#dac_noT').children('option').remove();
	    	  */
	      
	     
	      //모달창
	      //계정대분류코드 
	      selectComCombo("acc", "acc_no", "sel", $("#acc_no").val(), "");
		  //계정소분류코드
	      selectComCombo("accd", "dac_no", "sel", $("#dac_no").val(), "");
	}
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' : //검색
					fn_AccTitlelist();
					break;
				case 'btnClose' : //닫기
					gfCloseModal();
					break;
				case 'btnUpdate' : //수정
					fn_AccTitlesave();
					break;
				case 'btnInsert' : //등록
					fn_AccTitlesave();
					break;	
				case 'insertBtn' :
					fn_AccTitle();
					break;
			}
		});
	}
	/*계정과목관리 조회 - 검색조건*/
   function 	fn_AccTitlelist(curpage) {
	      
	   curpage = curpage || 1;
	   
	   var param = {
			   acc_noT : $("#acc_noT").val() //계정대분류항목
		   ,dac_noT : $("#dac_noT").val() //계정소분류항목
		   ,I_S : $("#I_S").val() //구분
		   ,S_expendT : $("#S_expendT").val() //사용여부
	       ,curpage : curpage
	       ,pageSize : pageSize
	   };
	   
	   
	   var AccTitlelistcallback = function(returndata) {
		    fn_AccTitlelistcallback(returndata,curpage) ;  
	   }
	   
	   callAjax("/accounting/listAccTitle.do", "post", "text", true, param, AccTitlelistcallback);
	   
	         
   }

   function fn_AccTitlelistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#AccTitlelist").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_AccTitlelist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#curpage").val(curpage);
   }
   
	//모달실행-설아
	function fn_AccTitle(dac_no) {
		   
		   if (dac_no == null || dac_no == "") {   // 신규
			   fn_forminit();		   
			   gfModalPop("#AccTitle");
		   } else {
			   //alert(acc_no);
			   fn_selectAccTitle(dac_no);
		   }
	   }
	
   
   function fn_forminit(AccTitleModel) {
	   
	   if( AccTitleModel == "" || AccTitleModel == null || AccTitleModel == undefined) {   // 신규
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);
		   $("#acc_no_up").attr("readonly",false);
		   $("#acc_nm").val(''); //계정대분류항목
		   $("#dac_nm").val(''); //계정소분류항목
		   $("#AccTitleContent").val(''); //상세내용
		  // $("#S_expend").val(''); //사용여부
		  // $("#dac_cate").val(''); //구분
		   $("#btnInsert").show();	
		   $("#dac_no").val('');
		   $("#acc_no_tr").show();
		   $("#btnUpdate").hide();
		   $("#action").val("I");
		   $("#acc_no_up").val('');
		   $("#dac_no").attr("disabled", false);
		   
	   } else {
		   $("#loginId").val( $("#swriter").val());
		   $("#loginId").attr("readonly", true);
		   $("#acc_no_up").attr("readonly",true);
		   $("#acc_no_up").val(AccTitleModel.acc_no); //계정대분류항목
		   $("#acc_nm").val(AccTitleModel.acc_nm);
		   $("#dac_nm").val(AccTitleModel.dac_nm); //계정소분류항목
		   $("#dac_no").val(AccTitleModel.dac_no); //계정소분류코드
		   $("#AccTitleContent").val(AccTitleModel.dac_con); //상세내용
		   $("#S_expend").val(AccTitleModel.dac_stat).prop("selected",true);
		   $("#dac_cate").val(AccTitleModel.dac_cate).prop("selected",true);
		   $("#acc_nm_ori").val(AccTitleModel.acc_nm);//변경되기 전 계정 대분류명
		   //$("#S_expend option:selected").val(AccTitleModel.dac_stat); //사용여부 S_expend option:selected
		   //$("#dac_cate option:selected").val(AccTitleModel.dac_cate); //구분(선택)
		   $("#btnInsert").hide();	
		   $("#btnUpdate").show();	
		   $("#acc_no_tr").hide();
		   $("#acc_nm_tr").show();
		   $("#action").val("U");
		   
	   }
   }
   
   $(document).ready(function(){
	   $("#acc_nm").click(function (){
		   if($("#action").val() == "U"){
			  	 $("#acc_nm").attr("readonly", false);
		 }
	   })
	   $("#acc_no_up").click(function(){
		   if($("#action").val() == "U"){
			  	 $("#acc_no_up").attr("readonly", true);
		 }
		 })
	   
   })

  

   function fn_selectAccTitle(dac_no) {
	   var param = {
			   dac_no : dac_no
	   };
	   
	   var selectAccTitlecallback = function(selectresult) {
		    console.log("selectAccTitlecallback : " + JSON.stringify(selectresult) );
		    
		    fn_forminit(selectresult.AccTitleModel);
		    $("#acc_nm").attr("readonly", true); //계정대분류명 선택불가
		    $("#dac_no").attr("disabled", true); //계정코드 선택불가
		    //$("#dac_nm").attr("disabled", true); //계정세부명 선택불가
		    gfModalPop("#AccTitle");
	   }
	   
	   callAjax("/accounting/selectAccTitle.do", "post", "json", true, param, selectAccTitlecallback);
   }	
   
   
   /*계정과목관리 등록 모달 실행-설아*/
   function dept_insert(acc_no){
	// 신규 저장
		if (acc_no == null || acc_no == "") {
			// 모달 팝업
			gfModalPop("#AccTitle");
			
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
			fSelectDtlCod(acc_no, acc_name);
		}
   }
 
 
   
   function fn_AccTitlesave() {
	   var param = {
			   acc_no : $("#acc_no").val()	
			 , acc_nm : $("#acc_nm").val()
			 , dac_no : $("#dac_no").val()
			 , dac_nm : $("#dac_nm").val()
			 , dac_con : $("#AccTitleContent").val()
			 , dac_stat : $("#S_expend").val() 
			 , dac_cate : $("#dac_cate").val()
			 , action : $("#action").val()	
			 , acc_nm_ori : $("#acc_nm_ori").val()
			 , acc_no_up : $("#acc_no_up").val()
	   }
	   var resultCallback = function(data) {
		   gfCloseModal();	
		   fn_AccTitlelist();		
	   }	
			//fn_AccTitlesaveResult(data);
		
		
		callAjax("/accounting/saveAccTitle.do", "post", "json", true, param, resultCallback);
	}
	 
	  //모달창 등록버튼 이벤트 - 필수값 확인
	  /*
	function register(){
		if (acc_nm == null || acc_nm == "");  // 계정대분류명
			   alert("계정대분류명을 입력하세요.")
		if (dac_nm == null || dac_nm == "");   // 계정세부명
			   alert("계정세부명을 입력하세요.")
	}	
	  */
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myform" action="" method="">
	
	<input type="hidden" id="curpage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="selectaccno" id="selectaccno" value=""> 
	<input type="hidden" id="swriter"  name="swriter"  value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
    <input type="hidden" id="acc_noh"  name="acc_noh"  value="${acc_no}">
    <input type="hidden" id = "acc_nm_ori" name = "acc_nm_ori" value="">
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
							<a href="" class="btn_set home">메인으로</a> 
							<a href="" class="btn_nav bold">회계</a> 
								<span class="btn_nav bold">계정과목관리</span> 
								<a href="" onclick="window.location.reload()" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>계정과목관리</span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="" name="btn" id="insertBtn">
								<span>등록</span></a>
								
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 10px; border-color: blue" align="center">
						                           <td width="100" height="25" style="font-size: 100%">계정대분류항목</td>
						                           		<td><select id="acc_noT" name="acc_noT" style="width:130px">	</select></td>
						                           <td width="100" height="25" style="font-size: 100%">계정소분류항목</td>
						                          		 <td><select id="dac_noT" name="dac_noT" style="width:130px">	</select></td>   
						                           <td width="100" height="25" style="font-size: 100%">구분</td>
						                          		 <td><select id="I_S" name="I_S" style="width:100px">
						                          		 	<option value="" >전체</option>
						                          		 	<option value="1" >수익</option>
															<option value="2" >비용</option>
						                          		 	</select></td>          
						                           <td width="100" height="25" style="font-size: 100%">사용여부</td>
						                           		<td><select id="S_expendT" name="S_expendT"  style="width:100px">
						                           			<option value="" >전체</option>
						                          		 	<option value="Y" >Y</option>
															<option value="N" >N</option>
						                           			</select></td>        
						                       	   <td width="110" height="60" style="font-size: 120%">
                         						   <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조회</span></a></td>
						                        </tr>
						                        
                     </table>    
						
						
						<div class="divAccTitleList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="35%">
						                   <col width="8%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">계정대분류코드</th>
							              <th scope="col">계정대분류명</th>
							              <th scope="col">계정세부코드</th>
							              <th scope="col">계정세부명</th>
							              <th scope="col">구분</th>
							              <th scope="col">상세내용</th>
							              <th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="AccTitlelist"></tbody>
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
	<div id="AccTitle" class="layerPop layerType2" style="width: 400px;">
		<input type="hidden" id="acc_no_insert" name="acc_no_insert" value="${acc_nm}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>계정과목관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr id="acc_no_tr">
							<th scope="row" style="width:100px;">계정대분류 선택 <span class="font_red">*</span></th>
							<td><select id="acc_no" name="acc_no" style="width:200px;" >
								</select></td>
						</tr>
						<tr>
						<tr >
							<th scope="row">계정대분류코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="acc_no_up" id="acc_no_up"  required oninput="this.value = this.value.replace(/[^0-9]/g, '');"  />
							</td>
						</tr>
						<tr id="acc_nm_tr">
							<th scope="row">계정대분류명<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="acc_nm" id="acc_nm"  required  />
							</td>
						</tr>
						<tr>
							<th scope="row">계정과목코드 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="dac_no" id="dac_no"  oninput="this.value = this.value.replace(/[^0-9]/g, '');" value=""  /></td>
						</tr>
						<tr>
							<th scope="row">계정세부명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="dac_nm" id="dac_nm" required /></td>
						</tr>
						<tr>
							<th scope="row">상세내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="AccTitleContent" id="AccTitleContent" style="height:155px">
								</textarea>
							</td>
						</tr>

						<tr>
							<th scope="row">사용여부</th>
							<td>
								<select id="S_expend" name="S_expend" style="width: 200px;" >
									<option value="Y" selected="selected" >Y</option>
									<option value="N" >N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">수익/비용구분</th> 
							<td>
								<select id="dac_cate" name="dac_cate" style="width: 200px;" >
									<option value="1" selected="selected" >수익</option>
									<option value="2" >비용</option>
							</select>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnInsert" name="btn" style="display:none"><span>등록</span></a> 
					<a href="" class="btnType blue" id="btnUpdate" name="btn" style="display:none"><span>수정</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
	
	
	
</form>

</body>
</html>
