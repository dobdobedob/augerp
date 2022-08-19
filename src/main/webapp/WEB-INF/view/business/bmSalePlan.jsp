<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 영업 실적 조회  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;		// 화면에 뿌려질 데이터 수
	var pageBlock = 10;		// 블럭으로 잡히는 페이징 수 < 사실 무슨소린지 잘 모르겠 그러니까 블럭? 데이터 들어올 칸을 10칸 만들겠다는 소리?
	console.log("bmsal eplan 작동함");
	// fn(fuction) 이거이거 쓸꺼니까 대기시켜놔라
	$(document).ready(function () {
		
		// 영업실적 리스트 불러오기
		fn_bmsaleplanlist();
		
		/* // 넣기 실패
		// 품목별 콤보박스에 넣을거
		fn_bi_cd_init();
		// 제품 이름 콤보박스에 넣을거 
		fn_si_nm_init();
		 */
		
		// 버튼 누를때 작동하는것들
		fRegisterButtonClickEvent();
	});

	
/*  	
 * 콤보박스들기 실패
 // 품목별 콤보박스에 넣을거
	function fn_bi_cd_init() {
		console.log("fn_bi_cd_init 작동함");
		sitemcombo("BKcd", "bi_cd_box", "all", "")
	}
	
	// 제품 이름 콤보박스에 넣을거
	function fn_si_nm_init() {
		console.log("fn_si_nm_init 작동함");
		sitemcombo("BKcd", "si_nm_box", "all", "")
	} 
	
	function sitemcombo(group_code, combo_name, type, selvalue){
		
		console.log("comcombo Start !!!!!!!!!!!!!! ");
		
		var selectbox = document.getElementById(combo_name);

		var data = {
				"group_code" : group_code
			};	
		
		$(selectbox).find("option").remove();
	  	
		//private String dtl_cod;	
		//private String dtl_cod_nm;
		
		$.ajax({ 
		     type: "POST",  
		     url: "/business/sitemcombo.do", 
		     dataType: "json",  
		     data : data,
		     success: function(data)
		     { 				
		    	 
			     var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON 
			     var jsonstr = json_obj.list;
			     console.log("jsonstr : " + jsonstr);
			     
			     var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON 
			     var listLen = jsonstr_obj.length;

		    	 if(type == "all") {
		    	    $(selectbox).append("<option value=''>전체</option>");
		    	 }		     
			     
		    	 if(type == "sel") {
			    	$(selectbox).append("<option value=''>선택</option>");
			     }
		    	 console.log(" selvalue : " + selvalue);
		         for(var i=0; i<listLen; i++)
		         { 		
		        	 var eleString = JSON.stringify(jsonstr_obj[i]);
		        	 var item_obj = $.parseJSON(eleString);//parse JSON
	            
		        	 if(selvalue != null && selvalue != null && selvalue != "") {
		        		 if(selvalue == item_obj.dtl_cod) {
		        			 console.log(" item_obj.dtl_cod : " + item_obj.dtl_cod);
		        			 
		        			 $(selectbox).append("<option value='"+ item_obj.dtl_cod + "' selected>" + item_obj.dtl_cod_nm + "</option>");
		        		 } else {
		        			 $(selectbox).append("<option value='"+ item_obj.dtl_cod + "'>" + item_obj.dtl_cod_nm + "</option>");
		        		 }
		        	 } else {
		        		 $(selectbox).append("<option value='"+ item_obj.dtl_cod + "'>" + item_obj.dtl_cod_nm + "</option>");
		        	 }
		        	 
		        	 
		         } 
		     },
		     error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
		});  
	};	 */
	
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_bmsaleplanlist();
					console.log("searchBtn 작동함");
					break;
			}
		});
	}
	
	function fn_bmsaleplanlist(curpage) {
		
		console.log("bmsaleplanlist 작동함");
		curpage = curpage || 1;
			
		var param = {
			searchitem : $("#searchitem").val()
		   ,search : $("#search").val()
	       ,to_month : $("#to_month").val()  
	       ,curpage : curpage
	       ,pageSize : pageSize
			};
		   
	    var bmsaleplanListcallback = function(returndata) {
	        fn_bmsaleplanListcallback(returndata,curpage) ;  
	        }

	    callAjax("/business/listBmSalePlaneModel.do", "post", "text", true, param, bmsaleplanListcallback);
	    
	}
	
	function fn_bmsaleplanListcallback(returndata,curpage) {	   
	    console.log("fn_bmsaleplanlistcallback 작동함");
	   
	    $("#bmsaleplanList").empty().append(returndata);	   
	    var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_bmsaleplanlist');
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
							<span>영업 실적 조회 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue" items="${listBmSalePlaneModel}" var="list">
                        	<!-- 사번, 달성률, 부서명, 사원명, 실적수량 확인 박스 -->
                           <td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='searchitem'>
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
                           
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="search" name="search"></td>

                           <td width="50" height="25" style="font-size: 100%">월 조회</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="month" style="width: 120px" id="to_month" name="to_month"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조  회</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                        <tr style="border: 0px; border-color: blue">
                           <td align="center" width="50" height="25" style="font-size: 100%">품목별</td>
							
							<td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='searchitem'>
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
							
                           <td width="50" height="25" style="font-size: 100%">제품 이름</td>
                           <td width="100" height="50" align="center" style="font-size: 100%">
                                 <select name='si_nm'>
                                  
                                 
								  <option value='' selected>-- 선택 --</option>
								  <option value=${list.loginID}>사번</option>
								  <option value=${list.pln_ar}>달성률</option>
								  <option value=${list.dept_name}>부서명</option>
								  <option value=${list.name}>사원명</option>
								  <option value=${list.pln_nmt}>목표수량</option>
								 </select>
                           </td>
                        </tr>
                     </table>    
						
						
						<div class="divbmsaleplanList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="8%">
						                   <col width="9%">
						                   <col width="6%">
						                   <col width="11%">
						                   <col width="8%">
						                   <col width="18%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>

							              <th scope="col">사번</th>
							              <th scope="col">부서명</th>
							              <th scope="col">이름</th>
							              <th scope="col">월 목표</th>
							              <th scope="col">제품 코드</th>
							              <th scope="col">제품 이름</th>
							              <th scope="col">목표 수량</th>
							              <th scope="col">실적 수량</th>
							              <th scope="col">달성률</th>
							              <th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="bmsaleplanList"></tbody>
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



</form>

</body>
</html>