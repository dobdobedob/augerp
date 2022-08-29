<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 회계전표 조회 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 2;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		
		fn_init();
		
		fn_accountlist();
		
		fRegisterButtonClickEvent();
		
	});
	
	function fn_init() {
		selectComCombo("cli", "copcd", "all", "", "");
		
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
					fn_accountlist();
					break;
				case 'accpopBtn' :
					fn_accpopup();
					break;	
				case 'btnClose' :
					gfCloseModal();
					break;				
			}
		});
	}
	function fn_accountlist(curpage) {
					      
	     curpage = curpage || 1;
		
	     var param ={	   from_date : $("#from_date").val()
						  ,to_date : $("#to_date").val()
						  ,copcd : $("#copcd").val()
						  ,codenum : $("#codenum").val()
						  ,ptype : $("#ptype").val()						  
						  ,curpage : curpage
						  ,pageSize : pageSize
				};
						   
		   var accountlistcallback = function(returndata) {
			    fn_accountlistcallback(returndata,curpage) ; 
		   }
		   
		   callAjax("/accounting/listaccount.do", "post", "text", true, param, accountlistcallback);
			   
			         
    }
	
	function fn_dtlAccountPop(){
		
		//alert(ant_no);
		
		//gfModalPop("#dtlAccount");/
		
	     var param ={	   from_date : $("#from_date").val()
						  ,to_date : $("#to_date").val()
						  ,copcd : $("#copcd").val()
						  ,codenum : $("#codenum").val()
						  ,ptype : $("#ptype").val()						  
						  ,curpage : 1
						  ,pageSize : 99999999999
				};
		
		var fn_dtlAccountcallback = function(data){
			$('#dtlAccount').empty().append(data);
			gfModalPop("#dtlAccount");
		}
		
		callAjax("/accounting/detailAccount.do","post","text",true,param,fn_dtlAccountcallback); 
   }
   //지금 안쓰는코드
	
						
    function fn_accountlistcallback(returndata,curpage) {	   
	   console.log(returndata);
	   
	   $("#accountSlipllist").empty().append(returndata);	   
	   var totcnt = $("#totcnt").val();
				
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_accountlist');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
   }
   
   function fn_accpopup() {
	   
	   var conm = $("#copcd").val();
	   
	   if(conm == "") {
		   alert("거래처를 선택하고 조회 해주세요.");
		   return;
	   }
	   
	   fn_dtlAccountPop();
	   
   }
   
  // function openpopup(ant_no) {
	  // gfModalPop("#accpopup");
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
	   
   //}
					   
					   /* function fn_AccountModal(ant_no) {
						   
						   if (ant_no == null || ant_no=="") {   // 신규
							   fn_forminit();
							   
							   gfModalPop("#account");
						   } else {
							   //alert(ann_no);
							   fn_selectaccount(ant_no);
						   }
					   } */
		
					   
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
							<a href="#" class="btn_nav bold">회계</a> 
								<span class="btn_nav bold">회계전표 조회</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>회계전표 조회 </span> 
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
		                   <col width="10%">
		                   <col width="15%">
		                   <col width="10%">
		                   <col width="10%">
	                 </colgroup>					
					  <tbody>
					    <tr>
							<td style="font-size: 100%">일자</td>
                           <td style="font-size: 100%" colspan=6>
                            <input type="date" style="width: 120px" id="from_date" name="from_date"> ~ 
                            <input type="date" style="width: 120px" id="to_date" name="to_date">
                            </td>
                        </tr>
                         
                         <tr>
                           <td style="font-size: 85%">거래처명</td>
                           <td style="font-size: 85%">
<!--                                  <input type="text" id="copcd" name="copcd" style="width: 300px; height: 25px;" /> -->
                                 <select id="copcd" name="copcd" >	</select>
                                 
                           </td>
                           <td style="font-size: 85%">계정코드</td>
                           <td style="font-size: 85%">
                                 <select id="codenum" name="codenum">
                                   
                                 </select>
                           </td>
                           <td style="font-size: 85%">계정과목</td>
                           <td style="font-size: 85%">
                               <select id="ptype" name="ptype">
                                   
                                </select>
                           </td>      
                           <td>
                               <a href="" class="btnType blue" id="accpopBtn" name="btn"><span>전표팝업</span></a>
                               <a href="" class="btnType blue" id="searchBtn" name="btn"><span>조 회</span></a>
                           </td> 
                           
                         </tr>
                        </tbody>
                     </table>
                     </div>    
						
						
						<div class="divAccountingList">
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
					                 </colgroup>
								<thead>
									<tr>
										  <th scope="col">전표번호</th>
							              <th scope="col">전표일자</th>
							              <th scope="col">계정과목</th>
							              <th scope="col">계정코드</th>
							              <th scope="col">담당자</th>
							              <th scope="col">거래처명</th>
							              <th scope="col">지출</th>
							              <th scope="col">수입</th>
										  <th scope="col">금액</th>							          
									</tr>
								</thead>
								<tbody id="accountSlipllist"></tbody>
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
	<div id="dtlAccount" class="layerPop layerType2" style="width: 600px;">
		
	</div>
	