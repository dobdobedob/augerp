<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 사원 관리  </title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
	.btnTypeEMP{
		min-width:80px;height:31px;line-height:31px;font-family: '나눔바른고딕',NanumBarunGothic;font-size:15px;color:#fff;text-align: center;font-weight:400;background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	}
	.blue{
		background-position: 100% -41px;
	}
</style>
<!-- 우편번호 조회 -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		 let dateElement = document.getElementById('birth');
		 var date = new Date().toISOString().substring(0, 10);
		 console.log(date)
	     dateElement.setAttribute("max", date);
		 $("#user_date").val(date);
		
	});
	
	$(document).ready(function() {

		fn_empManagementList();//사원 리스트 출력
		
		fn_init(); //직급 리스트 출력
		fn_initDegree();//학력
		fn_initBank();//은행 리스트 출력
		fn_initType();//직책리스트 출력
		fn_initDE();
		
		fRegisterButtonClickEvent();
		
		fRegisterButtonClickEventButton();
	});
	//학력 리스트 출력
	function fn_initDegree(){
		comcombo("EDUcd", "degree", "sel", "");
	}
	
	//직급 리스트 출력
	function fn_init() {
		comcombo("POScd", "sampleconcode1", "sel", "");
	}
	//은행 리스트 출력
	function fn_initBank() {
		comcombo("BKcd", "bank", "sel", "");
	}
	//직책 리스트 출력
	function fn_initType() {
		comcombo("USERcd", "user_type", "sel", "");
		comcombo("POScd", "detail_name", "sel", "");
	}
	function fn_initDE() {
		comcombo("POScd", "detail_name", "sel", "");
	}
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_empManagementList();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnRetireClose' :
					gfCloseModal();
					break;
				case 'btnRetireSave' :
					fn_userRetireSave();
					break;	
				case 'btnCloseEmpManagement' :
					gfCloseModal();
					break;
				case 'btnSaveEmpManagement' :
					fValidateEmpDv();
					break;
				case 'btnUpdateEmpManagement' :
					fValidateEmpDv22();
					break;
			}
		});
		
		var upfile = document.getElementById('upfile');
		upfile.addEventListener('change', 
	                                    function(event){    
                                                                    var image = event.target;
	                          		                             var imgpath = "";
	                          		                             if(image.files[0])
	                          		                             {		  
	                          		                               alert(window.URL.createObjectURL(image.files[0]));		
	                          			                           imgpath =  window.URL.createObjectURL(image.files[0]);
	                          		                             }	   
	                          	                                 
	                          		                             //var action = $("#action").val();
	                          		                             var filearr = $("#upfile").val().split(".");
	                          		                             
	                          		                             var previewhtml = "";
	                          		                             
	                          		                             if(filearr[1] == "jpg" || filearr[1] == "png"  || filearr[1] == "jpeg" || filearr[1] == "gif") {
	                          		                            	previewhtml = "<img src='" + imgpath + "' style='width: 100px; height: 100px;' />";
	                          		                             }
	                          		                             /* 
	                          		                             if(action == "U") {
	                          		                            	previewhtml = "<a href='javascript:download()'>" + previewhtml + "</a>";
	                          		                             } */
	                          		                             
	                          		                             $("#fileinfo").empty().append(previewhtml);
	                          		                             //alert(previewhtml);
	                                                         }
                              );

	}	
	function fRegisterButtonClickEventButton() {
		$('input[name=retire]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'no_retire' :
					$("#retireYN").val('Y');
					$("#action").val('Y');
					$("#yes_retire").removeClass("blue");
					$("#no_retire").removeClass("blue");
					fn_empManagementList();
					break;
				case 'yes_retire' :
					$("#retireYN").val('N');
					$("#action").val('Y');
					fn_empManagementList();
					break;
			}
		});
	}	
	function fn_empManagementList(curpage){
		curpage = curpage || 1;
		
		var param = {
				selectDepart : $("#selectDepart").val()
			   ,sampleconcode1 : $("#sampleconcode1").val()
			   ,selectOP : $("#selectOP").val()
			   ,searchinfo : $("#searchinfo").val()
			   ,from_date : $("#from_date").val()
			   ,to_date : $("#to_date").val()  
			   ,retireYN : $("#retireYN").val()
			   ,action : $("#action").val()
		       ,curpage : curpage
		       ,pageSize : pageSize
		};
		
		var EmpManagementlistcallback = function(returndata){
			fn_EmpManagementlistcallback(returndata, curpage);
		}
		
		callAjax("/employee/listEmpManagement.do", "post", "text", true, param, EmpManagementlistcallback);
	}
		
	
	function fn_EmpManagementlistcallback(returndata, curpage){
		console.log(returndata);
		
		 $("#empManagementList").empty().append(returndata);	   
		 var totcnt = $("#totcnt").val();
		 
		 //재직자 퇴직자 분류
		 if($("#retireYN").val() == 'Y'){//재직자
			$("#no_retire").addClass("blue");
			$("#yes_retire").removeClass("blue");
		 }else if($("#retireYN").val() == 'N'){//퇴직자
			$("#yes_retire").addClass("blue");
			$("#no_retire").removeClass("blue");
		 }else if($("#retireYN").val() == ''){//평상시
			$("#retireYN").val('');
			$("#action").val('');
			$("#yes_retire").removeClass("blue");
			$("#no_retire").removeClass("blue");
		 }
		 
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_empManagementList');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
	}
	
	function fn_retire(e, loginID){
		e.preventDefault();
		e.stopPropagation();
		fn_retirefn(loginID);
	}
	
	function fn_retirefn(loginID){
		
		var param = {
				loginID : loginID
		};
		
		var userRetirecallback = function(resultdata){
			console.log("userRetirecallback : " + JSON.stringify(resultdata));
			
			fn_formRetireinit(resultdata.empManagementModel);//데이터 값 넣기
			
			gfModalPop("#retireModal");
		}
		
		callAjax("/employee/selectUserRetire.do", "post", "json", true, param, userRetirecallback);
	}
	
	function fn_formRetireinit(data){
		$("#loginId").val(data.loginID);
		$("#namere").val(data.name);
		$("#hire_date").val(data.user_date);
		$("#sal_btre").val(data.sal_bt);
		$("#loginId").attr("readonly", true);	 
		$("#name").attr("readonly", true);	 
		$("#hire_date").attr("readonly", true);	
		//최소 입사일 이후로 되도록 설젇
		let dateElement = document.getElementById('retire_date');
		dateElement.setAttribute("min",data.user_date);
		
		if(data.user_du  == 'N' ){
			$("#retire_date").hide();
			$("#retire_dateY").show();
			$("#retire_dateY").val(data.user_redate);
			$("#retire_r").val(data.user_rere);
			$("#retire_dateY").attr("readonly", true);	 
			$("#retire_r").attr("readonly", true);	
			$("#btnRetireSave").hide();
		}else{
			$("#retire_dateY").hide();
			$("#retire_date").show();
			$("#retire_date").val('');
			$("#retire_r").val('');
			
		}
	}
	
	function fn_userRetireSave(){
		
		var check = confirm("퇴사처리를 하겠습니까?");
		if(check){
			fn_saveRetire();
		}else{
			return;
		}

	}
	
	function fn_saveRetire(){
		var param = {
				loginId : $("#loginId").val()
			   ,retire_date : $("#retire_date").val()
			   ,retire_r : $("#retire_r").val()
			   ,sal_btre : $("#sal_btre").val()
			   ,hire_date : $("#hire_date").val()
		}
		
		var saveUserRetirecallback = function (savereturn){
			  console.log("saveUserRetirecallback : " + JSON.stringify(savereturn) );
			  if(savereturn.saveR == "SUCCESS"){
				  alert("퇴사처리 되었습니다.");
				  gfCloseModal();
				  fn_empManagementList();
			  }
		}
		
		 callAjax("/employee/saveUserRetire.do", "post", "json", true, param, saveUserRetirecallback);
	}
	
	function fn_empManagementInfoModal(loginID){
		if(loginID == null || loginID == ""){//신규
			//로그인 아이디 가지고 오기
			fn_empManagementID();
			
			//모달창 내용 지우기 및 입력
			fn_empManagementforminit();
			
			//모달창 팝업
			gfModalPop("#empManage");
		}else{//있는거 하나 가져오기 
			fn_empManagementInfoSelect(loginID);
		}
	}
	
	function fn_empManagementID(){

		var selectempManagementIDcallback = function (savereturn){
			  console.log("selectempManagementIDcallback : " + JSON.stringify(savereturn) );
			  $("#loginID").val(savereturn.loginID); 
			  $("#loginID").attr("readonly",true);
		}
		
		 callAjax("/employee/selectempManagementID.do", "post", "json", true, null, selectempManagementIDcallback);
	}
	
	function fn_empManagementforminit(empManagementModal){
		if( empManagementModal == "" || empManagementModal == null || empManagementModal == undefined) {   // 신규
			$("#retireth").css("display","none");
			$("#retiretd").css("display","none");
			$("#name").val('');
			$("#Con1").val('');
			$("#Con2").val('');
			$('#genderM').prop('checked', true);//성별 코드 초기화
			$("#birth").val('');
			$("#degree option:eq(0)").prop('selected', true);//최종학력 초기화
			$("#mail").val('');
			$("#tel2").val('');
			$("#tel3").val('');
			$("#zip_code").val('');
			$("#bank option:eq(0)").prop('selected', true);//은행  초기화
			$("#account").val('');
			$("#addr").val('');
			$("#addr_detail").val('');
			$("#dept_cd").val('');//부서  초기화
			$("#user_type option:eq(0)").prop('selected', true);//직책  초기화
			$("#detail_name").val('');
			$("#dept_name").val('');
			$("#job_cd").val('');//직급  초기화
			$('#work').prop('checked', true);//재직 구분 초기화
			$("#user_date").val('');
			$("#user_redate").val('');
			$("#workTot").val('');
			$("#sal_ad").val('');
			$("#retireMc").val('');
			$("#retire").attr("disabled", false);	 
			$("#dept_cd").attr("readonly", true);	
			$("#job_cd").attr("readonly", true);	
			$("#retireMc").attr("readonly", true);	
			$("#workTot").attr("readonly", true);	
			
			$("#upfile").val("");
			$("#fileinfo").empty();
			
			$("#action").val("I");
			
			//저장버튼 
			$("#btnSaveEmpManagement").show();
			$("#btnUpdateEmpManagement").hide();
			$('input').prop('readonly', false);//모든 input 박스 readonly처리
			$('select').attr('disabled', false);//모든 옵션 선택 가능 
			$("#genderF").attr("disabled", false);
			$("#genderM").attr("disabled", false);
		}else{
			//저장버튼 
			$("#btnSaveEmpManagement").hide();
			$("#btnUpdateEmpManagement").show();
			
			
			$("#loginID").val(empManagementModal.loginID);
			$("#loginID").attr("readonly", true);	 
			$("#name").val(empManagementModal.name);
			//주민번호 자르기
			let [a,b] = empManagementModal.user_con.split('-');
			$("#Con1").val(a);
			$("#Con2").val(b);
			if(empManagementModal.sex == '1'){
				$('#genderM').prop('checked', true);//성별 코드 초기화(남)
			}else{
				$('#genderF').prop('checked', true);//성별 코드 초기화(여)
			}
			$("#birth").val(empManagementModal.birth);
			comcombo("EDUcd", "degree", "sel", empManagementModal.degree);//최종학력
			$("#mail").val(empManagementModal.mail);
			//연락처 잘라서 넣기 
			let [c,d,e] = empManagementModal.tel.split('-');
			$("#tel1").val(c);
			$("#tel2").val(d);
			$("#tel3").val(e);
			$("#zip_code").val(empManagementModal.zip_code);
			comcombo("BKcd", "bank", "sel", empManagementModal.bank);
			$("#account").val(empManagementModal.account);
			$("#addr").val(empManagementModal.addr);
			$("#addr_detail").val(empManagementModal.addr_detail);
			$("#dept_name").val(empManagementModal.dept_cd).prop("selected", true);
			$("#dept_cd").val(empManagementModal.dept_cd);
			comcombo("USERcd", "user_type", "sel",empManagementModal.user_type);
			comcombo("POScd", "job_cd", "sel", empManagementModal.job_cd);
			if(empManagementModal.user_du == 'Y'){//재직 구분 초기화
				$('#work').prop('checked', true);
				$("#retire").attr("disabled", true);	 
			}else if(empManagementModal.user_du == 'B'){
				$('#break').prop('checked', true);
				$("#retire").attr("disabled", true);	 
			}else if(empManagementModal.user_du == 'N'){
				$('#retire').prop('checked', true);
			}
			$("#user_date").val(empManagementModal.user_date);
			$("#user_redate").val(empManagementModal.user_redate);
			$("#workTot").val(empManagementModal.workDue);
			$("#sal_ad").val(comma(empManagementModal.sal_ad));
			$("#retireMc").val(comma(empManagementModal.user_reprice));
			$("#job_cd").val(empManagementModal.job_cd);
			//비교하기 위해서 저장을 미리 해놔줘야 한다. 
			$("#job_cdBefore").val(empManagementModal.job_cd);
			$("#dept_cdBefore").val(empManagementModal.dept_cd);
			$("#salaryBefore").val(comma(empManagementModal.sal_ad));
			
			comcombo("POScd", "detail_name", "sel", empManagementModal.job_cd);
			$("#upfile").attr("disabled",true);
			if( empManagementModal.att_ori == "" || empManagementModal.att_ori == null || empManagementModal.att_ori == undefined) { 	 
           	 $("#fileinfo").empty();
	          } else {
	                var filearr = empManagementModal.att_ori.split(".");
	                var previewhtml = "";
	                if(filearr[1] == "jpg" || filearr[1] == "png" || filearr[1] == "jpeg" || filearr[1] == "gif") {
	                  	previewhtml =  "<img src='" + empManagementModal.att_nli + "' style='width: 100px; height: 100px;' />";
	                } else {
	               	previewhtml =  empManagementModal.att_ori  ;
	                }
	                   
	                $("#fileinfo").empty().append(previewhtml);
	           }
          
			
			$("#action").val("U");
			
			if(empManagementModal.user_du == 'N'){
				//퇴직이면 아무것도 못만지게 만들어놨다 
				//재직 구분도 변경안되고 다 안됨
			    $('input').prop('readonly', true);//모든 input 박스 readonly처리
			    $('select').attr('disabled', true);//모든 옵션 선택 불가
				$("#retire").attr("disabled", true);	 
				$("#work").attr("disabled", true);	 
				$("#break").attr("disabled", true);	 
				$("#btnUpdateEmpManagement").hide();
				$("#zipFind").attr("disabled", true);
				$("#upfile").attr("disabled", true);
				$("#genderF").attr("disabled", true);
				$("#genderM").attr("disabled", true);
			}else{
				$('input').prop('readonly', false);//모든 input 박스 readonly처리
				 $('select').attr('disabled', false);//모든 옵션 선택 가능 
				$("#work").attr("disabled", false);	 
				$("#break").attr("disabled", false);	 
				$("#zipFind").attr("disabled", false);
				$("#upfile").attr("disabled", false);
				$("#genderF").attr("disabled", false);
				$("#genderM").attr("disabled", false);
				$("#retireth").css("display","none");
				$("#retiretd").css("display","none");
			}
		}

	}
	
	function fn_empManagementfileSave(){
		
	  	var frm = document.getElementById("empManagement");
	  	frm.enctype = 'multipart/form-data';
	   	var dataWithFile = new FormData(frm);	
	   	
	    var saveEmpManagementcallback = function(savereturn) {
		   console.log("saveEmpManagementcallback : " + JSON.stringify(savereturn) );
		   
		   var curpage = 1;
		   if(savereturn.result == "SUCCESS") {
				alert("저장되었습니다.");
			   
			   	gfCloseModal();
			   
			   	fn_empManagementList(curpage);
		   } else {
			   alert("실패 했습니다.");
		   }
	   }	   	   
	   
		callAjaxFileUploadSetFormData("/employee/saveEmpManagementfile.do", "post", "json", true, dataWithFile, saveEmpManagementcallback);
	   
	}
	
	function fn_empManagementInfoSelect(loginID){
		var param = {
				loginID : loginID
		};
		
		var selectEmpManagementcallback = function(selectresult){
			console.log("selectEmpManagementcallback" + JSON.stringify(selectresult));
			fn_empManagementforminit(selectresult.empManagement);
			gfModalPop("#empManage");
		}
		
		callAjax("/employee/selectempManagementInfo.do", "post", "json", true, param, selectEmpManagementcallback);
	}
	
	//div클릭시에 사진 첨푸 열리게 하기
	$(function(){
		
		$("#fileinfo").click(function(e){
			e.preventDefault();
				if($("#action").val() == "U"){
					$("#upfile").attr("disabled", true);
				}else if($("#action").val() == "I"){
					
					$("#upfile").attr("disabled", false);
					$("#upfile").click();
				}
		})
		
	})
	
	//이메일 정규화 체크
	function fn_emailcheck(){
		var email = $("#mail").val();
		console.log(email)
		
		var regExp = "^[A-z|0-9]([A-z|0-9]*)(@)([A-z]*)(\\.)([A-z]*)$";
		if(email.match(regExp) == null){
			alert("이메일 형식이 아닙니다.");
			$("#cop_email").val('');//초기화
			$("#cop_email").focus();
		}
	}
	
	// 우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zip_code').value = data.zonecode;
				document.getElementById("addr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("addr_detail").focus();
			}
		}).open({
			q : q
		});
	}
	
	//부서 클릭시 부서코드 부분 값 즉시변경
	$(document).ready(function(){
		$("#dept_name").change(function(){
			$("#dept_cd").val($(this).val());
		})
	})
	
	//직급 클릭시 직급코드 부분 값 즉시변경
	$(document).ready(function(){
		$("#detail_name").change(function(){
			$("#job_cd").val($(this).val());
		})
	})
	

	function fValidateEmpDv() {

		  
	      var chk = checkNotEmpty(
	            [
					  [ "upfile", "파일을 첨부해주세요" ]
	             	 ,[ "name", "이름을 입력해주세요" ]
	                 ,[ "Con1", "주민번호 앞자리를 입력해주세요" ]
		             ,[ "Con2", "주민번호 뒷자리를 입력해주세요" ]
	                 ,[ "birth", "생일을 입력해주세요" ]
	                 ,[ "degree", "학력을 선택해주세요" ]
	                 ,[ "mail", "이메일을 입력해주세요" ]
	                 ,[ "tel2", "휴대전화 중간 번호를 입력해주세요" ]
	                 ,[ "tel3", "휴대전화 끝 번호를 입력해주세요" ]
	                 ,[ "zip_code", "우편번호를 입력해주세요" ]
	                 ,[ "bank", "은행을 선택해주세요" ]
	                 ,[ "account", "계좌를 입력해주세요" ]
	                 ,[ "addr", "주소를 입력해주세요 " ]
	                 ,[ "addr_detail", "상세주소를 입력해주세요" ]
	                 ,[ "dept_name", "부서를 선택해주세요" ]
	                 ,[ "user_type", "직책을 선택해주세요" ]
	                 ,[ "detail_name", "직급을 선택해주세요" ]
	                 ,[ "user_date", "입사일을 입력해주세요" ]
	                 ,[ "sal_ad", "연봉을 입력해주세요" ]
	            ]
	      );

	      if (!chk) {
	         	return;
	      }
	    	  fn_empManagementfileSave();
	   } 
	function fValidateEmpDv22() {

		  
	      var chk = checkNotEmpty(
	            [
					  [ "name", "이름을 입력해주세요" ]
	                 ,[ "Con1", "주민번호 앞자리를 입력해주세요" ]
		             ,[ "Con2", "주민번호 뒷자리를 입력해주세요" ]
	                 ,[ "birth", "생일을 입력해주세요" ]
	                 ,[ "degree", "학력을 선택해주세요" ]
	                 ,[ "mail", "이메일을 입력해주세요" ]
	                 ,[ "tel2", "휴대전화 중간 번호를 입력해주세요" ]
	                 ,[ "tel3", "휴대전화 끝 번호를 입력해주세요" ]
	                 ,[ "zip_code", "우편번호를 입력해주세요" ]
	                 ,[ "bank", "은행을 선택해주세요" ]
	                 ,[ "account", "계좌를 입력해주세요" ]
	                 ,[ "addr", "주소를 입력해주세요 " ]
	                 ,[ "addr_detail", "상세주소를 입력해주세요" ]
	                 ,[ "dept_name", "부서를 선택해주세요" ]
	                 ,[ "user_type", "직책을 선택해주세요" ]
	                 ,[ "detail_name", "직급을 선택해주세요" ]
	                 ,[ "user_date", "입사일을 입력해주세요" ]
	                 ,[ "sal_ad", "연봉을 입력해주세요" ]
	            ]
	      );

	      if (!chk) {
	         	return;
	      }
	    	  fn_empManagementfileSave();
	   } 
	
	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="empManagement" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="selectanno" id="selectanno" value=""> 
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" name="retireYN" id="retireYN" value=""> 

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
								<span class="btn_nav bold">사원 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>사원 기본정보 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fn_empManagementInfoModal(${nullNum});" name="modal">
								<span>사원 등록</span></a>
							</span>
						</p>
					<!--검색창  -->
					<table width="100%"  cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="30" height="25" style="font-size: 100%">부서</td>
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
                                 <select id="sampleconcode1" name="sampleconcode1" style="width: 100px;">
                                 
                                 </select>
                           </td> 
                           <td width="15" height="25" style="font-size: 100%">&nbsp;</td>
                           <td width="10" height="25" style="font-size: 120%" >
                                 <select id="selectOP" name="selectOP" style="width: 100px;">
                                 	<option value="" selected="selected">선택</option>
                                 	<option value="No">사번</option>
                                 	<option value="Nm">사원명</option>
                                 </select>
                           </td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px; height: 30px;" id="searchinfo" name="searchinfo"></td>                                
                           <td width="50" height="25" style="font-size: 100%">입사일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px; height: 30px;" id="from_date" name="from_date"></td>
                           <td width="10" height="60" style="font-size: 100%">
                            <input type="date" style="width: 120px; height: 30px;" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
					<div style="margin-bottom: 10px;">
						<input type="button" class="btnTypeEMP" id="no_retire" name="retire" value="재직자">
						<input type="button" class="btnTypeEMP"  id="yes_retire" name="retire"  value="퇴직자">
					</div>	
						<div class="divBizPartnerList">
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
						                   <col width="11%">
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">사번</th>
							              <th scope="col">사원명</th>
							              <th scope="col">부서코드</th>
							              <th scope="col">부서명</th>
							              <th scope="col">직급</th>
							              <th scope="col">입사일자</th>
							              <th scope="col">재직/퇴직</th>
							              <th scope="col">퇴사일자</th>
							              <th scope="col">퇴직처리</th>
									</tr>
								</thead>
								<tbody id="empManagementList"></tbody>
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
	<div id="empManage" class="layerPop layerType2" style="width: 1000px;">
		<input type="hidden" id="empManageNo" name="empManageNo" value=""> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<!-- 연봉, 부서, 직급 변경시 값을 변경해야 하기 때문에 미리 넣어놔야 한다. -->
		<input type="hidden" id = "salaryBefore" name="salaryBefore" value="">
		<input type="hidden" id = "dept_cdBefore" name="dept_cdBefore" value="">
		<input type="hidden" id = "job_cdBefore" name="job_cdBefore" value="">
		
		<dl>
			<dt>
				<strong>사원 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<td rowspan="3" >
								<input type="file" id="upfile"  name="upfile" style="display: none;" accept="image/gif, image/jpeg, image/png"/>
								<div id="fileinfo" style="width: 100px; height: 100px; margin: 0 auto;" title="클릭시 사진 첨부 됩니다."></div>
						    </td>
						    <th scope="row">사번 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" style="width: 151px !important;" name="loginID" id="loginID" required="required"/></td>
							<th scope="row">성명<span class="font_red">*</span></th>
							<td scope="row" colspan="2">
								<input type="text" class="inputTxt" name="name" id="name" required="required"/>
							</td>
						</tr>
						<tr>
							<th scope="row" >주민번호 <span class="font_red">*</span></th>
							<td>
								<input type="text" maxlength="6" style="width: 65px !important;" class="inputTxt" name="Con1" id="Con1" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required="required"/> -
								<input type="text" maxlength="7" style="width: 69px !important;" class="inputTxt" name="Con2" id="Con2" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required="required"/>
							</td>
							<th scope="row">성별 <span class="font_red">*</span></th>
							<td colspan="2">
								<input type="radio" name="gender" id="genderM" value="1" checked="checked"> 남
								<input type="radio" name="gender" id="genderF" value="2"> 여
							</td>
						</tr>
						<tr>
							<th scope="row">생년월일<span class="font_red">*</span></th>
							<td><input type="date" name="birth" id="birth" style="width: 150px; height: 27px;" required="required"></td>
							<th scope="row">최종학력<span class="font_red">*</span></th>
							<td colspan="2">
								<select id ="degree" name="degree" style="width: 95px !important;" required="required">
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td colspan="2"><input type="email" class="inputTxt p100"
								name="mail" id="mail" onchange="fn_emailcheck()" required="required"/></td>
							<th scope="row">휴대 전화 <span class="font_red">*</span></th>
							<td colspan="2">
								<input type="text" maxlength="3" style="width: 45px !important;" class="inputTxt" name="tel1" id="tel1" value="010" readonly="readonly" required="required"/> -
								<input type="text" maxlength="4" style="width: 50px !important;" class="inputTxt" name="tel2" id="tel2"  oninput="this.value = this.value.replace(/[^0-9]/g, '');" required="required"/> -
								<input type="text" maxlength="4" style="width: 50px !important;" class="inputTxt" name="tel3" id="tel3" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required="required"/>
							</td>
						</tr>
						<tr>
							<th scope="row" rowspan="2">우편번호<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100"
								name="zip_code" id="zip_code" style="width: 108px !important;" required="required"/></td>

							<td><input type="button" value="우편번호 검색" id = "zipFind"
								onclick="execDaumPostcode()" style="width: 110px;height: 24px;"/></td>
								<th scope="row">은행 계좌<span class="font_red">*</span></th>
							<td >
								<select id="bank" name="bank" style="width: 95px !important;" required="required">
								</select>
							</td>
							<td><input type="text" class="inputTxt p100"
								name="account" id="account" oninput="this.value = this.value.replace(/[^0-9]/g, '');"  maxlength="20" required="required"/></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="addr" id="addr" placeholder="주소" required="required"/></td>
							<td colspan="3"><input type="text" class="inputTxt p100"
							name="addr_detail" id="addr_detail" placeholder="상세 주소" required="required"/></td>
						</tr>
						<tr>
							<th scope="row">부서<span class="font_red">*</span></th>
							<td>
								<select id="dept_name" name="dept_name"  style="width: 143px !important;" required="required">
	                               	<option value="" selected="selected">선택</option>
	                               	<c:forEach items="${departmentList}" var = "list">
	                               		<option value="${list.dept_cd}">${list.dept_name}</option>
	                               	</c:forEach>
	                            </select>
							</td>
							<th scope="row">부서코드<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" name="dept_cd" id ="dept_cd" readonly="readonly" required="required"/></td>
							<th scope="row">직책<span class="font_red">*</span></th>
							<td ><select id="user_type" name="user_type" style="width: 143px;" required="required">
                                 
                           	</select></td>
						</tr>
						<tr>
						 	<th scope="row">직급<span class="font_red">*</span></th>
                            <td><select id="detail_name" name="detail_name" style="width: 143px !important;" required="required">
                                 
                                 </select></td>
							<th scope="row">직급코드<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" name="job_cd" id ="job_cd" readonly="readonly"/></td>
							<th scope="row">재직구분 <span class="font_red">*</span></th>
							<td>
								<input type="radio" name="user_du" id="work" value="Y" checked="checked"> 재직
								<input type="radio" name="user_du" id="break" value="B"> 휴직
								<input type="radio" name="user_du" id="retire" value="N"> 퇴직
							</td>
						</tr>
						<tr>
							<th scope="row">입사일</th>
							<td>
								<input type="date" id="user_date" name="user_date" style="width: 140px; height: 27px;" required="required"> 
							</td>
							<th scope="row" id="retireth">퇴사일</th>
							<td id="retiretd">
								<input type="date" id="user_redate" name="user_redate" style="width: 140px; height: 27px;" readonly="readonly"> 
							</td>
							<th scope="row">근무연차</th>
							<td>
								<input type="text" class="inputTxt" name="workTot" id ="workTot" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="row">연봉</th>
							<td>
								<input type="text" class="inputTxt" name="sal_ad" id ="sal_ad" onkeyup="inputNumberFormat(this);" style="width: 140px !important;" required="required"/>
							</td>
							<th scope="row">퇴직금</th>
							<td>
								<input type="text" class="inputTxt" name="retireMc" id ="retireMc" style="width: 160px !important;" readonly="readonly"/>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveEmpManagement" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateEmpManagement" name="btn" style="display:none"><span>수정</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseEmpManagement" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 퇴사처리 모달팝업 -->
	<div id="retireModal" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="loginIdre" name="loginIdre" value=""> <!-- 수정시 필요한 num 값을 넘김  -->
		<input type="hidden" id="sal_btre" name="sal_btre" value="">
		<dl>
			<dt>
				<strong>퇴사처리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="loginId" id="loginId" />
							</td>
							<th scope="row">사원명 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="namere" id="namere" />
							</td>
						</tr>
						<tr>
							<th scope="row">입사일</th>
							<td>
								<input type="text" class="inputTxt p100" name="hire_date" id="hire_date" />
							</td>
							<th scope="row" >퇴사일</th>
							<td >
                            	<input type="date" style="width: 120px; height: 30px;" id="retire_date" name="retire_date">
                            	<input type="text" class="inputTxt p100"  style="width: 120px;" name="retire_dateY" id="retire_dateY" />
                           	</td>
								
						</tr>
						<tr>
							<th scope="row"  colspan="4" style="text-align: center;">퇴사 사유</th>
						</tr>
						<tr>
							<td colspan="4">
								<textarea class="inputTxt p100" name="retire_r" id="retire_r" style="resize: none;">
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnRetireSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnRetireClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>

</body>
</html>
