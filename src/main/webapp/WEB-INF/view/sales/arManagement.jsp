<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 미수금 관리 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		
		fn_init();
		
		fn_armlist();
		
		fRegisterButtonClickEvent();
	});
	
	
	function fn_init() {
		//selectComCombo("cli", "copcd", "all", "", "");
		
		$("#codenum").change(function() {
			selectComCombo("accd", "ptype", "all", $("#codenum").val(), "");
		});
		
		selectComCombo("acc", "codenum", "all", $("#codenum").val(), "");
	}
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_armlist();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSaveincome' :
					fn_incomesave();
					break;	
				case 'dtlManagement':
					fn_dtlManagementPop();
					break;
					
			}
		});
	}
	
	function fn_incomesave(){
		
		var param = {
				inc_cost :  $("#inc_cost").val()
			  , ord_no : $("#ordinput").val()
				
		  }
		var saveincomecallback = function(savereturn) {
			   console.log("saveincomecallback : " + JSON.stringify(savereturn) );
			   
			   if(savereturn.result = "SUCCESS") {
				   alert("입금 처리 되었습니다.");
				   gfCloseModal();
				   
				   fn_armlist();
			   }
			   
		}
		callAjax("/sales/incomeinsert.do", "post", "json", true, param, saveincomecallback);
		   
		
	}
	
	
	
	
	
	
	function fn_armlist(curpage) {
					      
	     curpage = curpage || 1;
		
	     var param ={	   from_date : $("#from_date").val()
						  ,to_date : $("#to_date").val()
						  ,supply : $("#supply").val()
						  ,paydue : $("#paydue").val()
						  ,copcd : $("#copcd").val()
						  ,curpage : curpage
						  ,pageSize : pageSize
				};
						   
		   var armlistcallback = function(returndata) {
			    fn_armlistcallback(returndata,curpage) ;  
		   }
		   
		   callAjax("/sales/listARM.do", "post", "text", true, param, armlistcallback);
			   
			         
    }
						
   function fn_armlistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#arManagementList").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_armlist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }
   
   function openpopup(ord_no) {
	   gfModalPop("#accpopup");
	   /* 
	   var param = {
			   ann_no : ann_no
	   };
	   
	   var selectnoticecallback = function(selectresult) {
		    console.log("selectnoticecallback : " + JSON.stringify(selectresult) );
		    
		    fn_forminit(selectresult.noticeModel);
		    
		    gfModalPop("#notice");
	   }
	   
	   callAjax("/system/selectnotice.do", "post", "json", true, param, selectnoticecallback);
	    */
	   
   }
					   
					   /* function fn_AccountModal(ant_no) {
						   
						   if (ant_no == null || ant_no=="") {   // 신규
							   fn_forminit();
							   
							   gfModalPop("#account");
						   } else {
							   //alert(ann_no);
							   fn_selectaccount(ant_no);
						   }
					   } */
// =============================================================================================================
	//클릭시 모달테두리 만들고 그안에 들어갈 내용을 함수를이용해 컨트롤러로 맵핑을하여 jsp파일덩어리를 넣는다.
	function fn_dtlManagementPop(ord_no){
		var param = {
				ord_no : ord_no
		};
		
		var fn_dtlManagementajcallback = function(data){
			$('#dtlManagement').empty().append(data);
			gfModalPop("#dtlManagement");
		}
		
		callAjax("/sales/detailarManagement.do","post","text",true,param,fn_dtlManagementajcallback)
   }
			

</script>

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">

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
							<a href="#" class="btn_nav bold">매출</a> 
								<span class="btn_nav bold">미수금 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>미수금 관리 </span> 
						</p>
						
					<!--검색창  -->

			
					<style> 
							table#either {border-collapse: separate;border-spacing: 15px 15px;}
					</style>
					<div style="height: auto; width: 100%; border:1px solid black;">
					<table id="either">
                          <colgroup>
		                   <col width="15%">
		                   <col width="20%">
		                   <col width="20%">
		                   <col width="15%">
		                   <col width="10%">
		                   <col width="10%">
		                   <col width="10%">
	                 </colgroup>					
					  <tbody>
					    <tr>
							<td style="font-size: 80%">일자</td>
                           <td style="font-size: 90%" >
                            <input type="date" style="width: 100px" id="from_date" name="from_date"> ~ 
                            <input type="date" style="width: 100px" id="to_date" name="to_date">
                            </td>
                           <td style="font-size: 80%">수금상태</td>
                           <td style="font-size: 60%">
                                 <select id="paydue" name="paydue">
                                     <option value="">전체</option>
                                     <option value="Y">입금완료</option>
                                     <option value="N">미수</option>
                                  
                                 </select>
                           </td>
                        </tr>
                         
                         <tr>
                           <td style="font-size: 80%">거래처명</td>
                           <td style="font-size: 80%">
                                 <input type="text" id="copcd" name="copcd" style="width: 250px; height: 25px;" />
                           </td>
                           <td><a href="" class="btnType blue" id="searchBtn" name="btn"><span>조 회</span></a></td> 
                         </tr>
                        </tbody>
                     </table>
                     </div>    
						
						
						<div class="divSalesList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="7%">
						                   <col width="7%">
						                   <col width="9%">
						                   <col width="7%">
						                   <col width="22%">
						                   <col width="9%">
						                   <col width="17%">
						                   <col width="9%">
						                   <col width="13%">
					                 </colgroup>
								<thead>
									<tr>
										  <th scope="col">수주번호</th>
							              <th scope="col">전표번호</th>
							              <th scope="col">처리주체</th>
							              <th scope="col">수금번호</th>
							              <th scope="col">거래처명</th>
							              <th scope="col">납입금액</th>
							              <th scope="col">수주일자</th>
										  <th scope="col">수금상태</th>
										  <th scope="col">처리자</th>							          
									</tr>
								</thead>
								<tbody id="arManagementList"></tbody>
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


	<!-- 모달팝업  1.-->
	<div id="dtlManagement" class="layerPop layerType2" style="width: 800px; height:800px;">

	</div>
	
	


</body>
</html>
