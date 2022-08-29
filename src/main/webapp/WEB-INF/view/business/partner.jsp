<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 거래처 관리  </title>

<!-- 우편번호 조회 -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(document).ready(function() {
		//리스트 출력
		fn_bizPartnerList();	
		
		fn_init(); //은행 리스트 출력
		
		fRegisterButtonClickEvent();
	});
	
	//은행 리스트 출력
	function fn_init() {
		comcombo("BKcd", "sampleconcode", "sel", "");
	}
	
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'searchBtn' :
					fn_bizPartnerList();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSaveBizPartner' :
					fn_bizPartnersave();
					break;
				case 'btnUpdateBizPartner' :
					fn_bizPartnersave();
					break;
					
			}
		});
	}	
	
	function fn_bizPartnerList(curpage){
		curpage = curpage || 1;
		
		var param = {
				copNM : $("#copNM").val()
			   ,copNO : $("#copNO").val()
		       ,from_date : $("#from_date").val()  
		       ,to_date : $("#to_date").val()  	
		       ,curpage : curpage
		       ,pageSize : pageSize
	   };
		
		var BizPartnerlistcallback = function(returndata) {
			    fn_BizPartnerlistcallback(returndata,curpage) ;  
		   }
		   
		callAjax("/business/listBizPartner.do", "post", "text", true, param, BizPartnerlistcallback);
	}
	
	function fn_BizPartnerlistcallback(returndata,curpage){
		 console.log(returndata);
		 
		 $("#partnerList").empty().append(returndata);	   
		 var totcnt = $("#totcnt").val();
		 
		// 페이지 네비게이션 생성		
		var paginationHtml = getPaginationHtml(curpage, totcnt, pageSize, pageBlock, 'fn_bizPartnerList');
		console.log("paginationHtml : " + paginationHtml);
		$("#pagingnavi").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(curpage);
	}
	
	function fn_PartnerModal(cop_no){
		if(cop_no == null || cop_no == ""){ //신규
			//모달창 내용 지우기 및 입력
			fn_forminit();
			
			// 모달 팝업
			gfModalPop("#partner");
		}else{	
			fn_selectBizPartner(cop_no);
		}
	}
	
	function fn_forminit(partnerModal){
		if( partnerModal == "" || partnerModal == null || partnerModal == undefined) {   // 신규

			 $("#userNm").val( $("#swriterNM").val());//우리 담당자
			 $("#userNm").attr("readonly", true);//읽기만 가능
			 $("#cop_nm").val('');//업체명
			 $('#Tel1 option:eq(0)').prop('selected', true);//전화번호 앞에 
			 $("#Tel2").val('');//회사 전화 2
			 $("#Tel3").val('');//회사 전화 3
			 $("#Phone2").val('');//휴대전화2
			 $("#Phone3").val('');//휴대전화3
			 $("#cop_ee").val('');//상대 담당자명
			 $("#cop_bm").val('');//대표자명
			 $("#cop_zip").val('');//우편번호
			 $("#cop_addr").val('');//주소
			 $("#cop_daddr").val('');//상세 주소
			 $("#cop_email").val('');//이메일
			 $('#sampleconcode option:eq(0)').prop('selected', true);//은행 코드 초기화
			 $("#ComNo1").val('');//사업자 번호 1
			 $("#ComNo2").val('');//사업자 번호 2
			 $("#ComNo3").val('');//사업자 번호 3
			 $("#cop_ano").val('');//계좌번호 
			 $("#cop_memo").val('');//메모
			 $("#cop_anm").val('');//예금주명
			 
			 $("#btnDeleteBizPartner").hide();
			 $("#action").val("I");
		}else{
			 $("#userNm").val(partnerModal.loginNM);//우리 담당자
			 $("#userNm").attr("readonly", true);//읽기만 가능
			 $("#cop_nm").val(partnerModal.cop_nm);//업체명
			 comcombo("BKcd", "sampleconcode", "sel", partnerModal.cop_bcd);//은행 코드 초기화
			 let [a,b,c] = partnerModal.cop_tel.split('-');
			 $("#Tel1").val(a).prop("selected", true);
			 $("#Tel2").val(b);//회사 전화 2
			 $("#Tel3").val(c);//회사 전화 3
			 let [d,e,f] = partnerModal.cop_phn.split('-');
			 $("#Phone2").val(e);//휴대전화2
			 $("#Phone3").val(f);//휴대전화3
			 $("#cop_ee").val(partnerModal.cop_ee);//상대 담당자명
			 $("#cop_bm").val(partnerModal.cop_bm);//대표자명
			 $("#cop_zip").val(partnerModal.cop_zip);//우편번호
			 $("#cop_addr").val(partnerModal.cop_addr);//주소
			 $("#cop_daddr").val(partnerModal.cop_daddr);//상세 주소
			 $("#cop_email").val(partnerModal.cop_email);//이메일
			 $("#ComNo1").val(partnerModal.cop_cno.substr(0,3));//사업자 번호 1
			 $("#ComNo2").val(partnerModal.cop_cno.substr(4,2));//사업자 번호 2
			 $("#ComNo3").val(partnerModal.cop_cno.substr(7,5)); //사업자 번호 3
			 $("#cop_ano").val(partnerModal.cop_ano);//계좌번호 
			 $("#cop_memo").val(partnerModal.cop_memo);//메모
			 $("#cop_anm").val(partnerModal.cop_anm);//예금주명
			 $("#selectanno").val(partnerModal.cop_no);
			 
			 $("#btnSaveBizPartner").hide();
			 $("#btnUpdateBizPartner").show();

			 $("#action").val("U");
		}
	}
	
	function fn_selectBizPartner(cop_no){
		var param = {
				cop_no : cop_no
		   };
		
		var selectBizPartnercallback = function(selectresult) {
		    console.log("selectBizPartnercallback : " + JSON.stringify(selectresult) );
		    
		    fn_forminit(selectresult.BizPartnerModel);
		    
		    gfModalPop("#partner");
	   }
	   
	   callAjax("/business/selectBizPartner.do", "post", "json", true, param, selectBizPartnercallback);
	}
	
	function fn_bizPartnersave(){
		
		var param = {
				cop_nm : $("#cop_nm").val()
			   ,Tel1 : $("#Tel1").val()
			   ,Tel2 : $("#Tel2").val()
			   ,Tel3 : $("#Tel3").val()
			   ,loginID : $("#swriter").val()
			   ,Phone1 : $("#Phone1").val()
			   ,Phone2 : $("#Phone2").val()
			   ,Phone3 : $("#Phone3").val()
			   ,cop_ee : $("#cop_ee").val()
			   ,cop_bm : $("#cop_bm").val()
			   ,cop_zip : $("#cop_zip").val()
			   ,cop_addr : $("#cop_addr").val()
			   ,cop_daddr : $("#cop_daddr").val()
			   ,cop_email : $("#cop_email").val()
			   ,cop_bcd : $("#sampleconcode").val()
			   ,ComNo1 : $("#ComNo1").val()
			   ,ComNo2 : $("#ComNo2").val()
			   ,ComNo3 : $("#ComNo3").val()
			   ,cop_ano : $("#cop_ano").val()
			   ,cop_memo : $("#cop_memo").val()
			   ,action : $("#action").val()	
			   ,cop_anm : $("#cop_anm").val()
			   ,cop_no : $("#selectanno").val()
		}
		
		var saveBizPartnercallback = function(savereturn){
			console.log("saveBizPartnercallback : " + JSON.stringify(savereturn));
			
			var curpage = 1;
			
			if(savereturn.result == "SUCCESS") {
				alert("저장 되었습니다.");
				gfCloseModal();
				fn_bizPartnerList(curpage);
			}else{
				alert("실패 했습니다.");
			}

		}
		 callAjax("/business/saveBizPartner.do", "post", "json", true, param, saveBizPartnercallback);
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
				document.getElementById('cop_zip').value = data.zonecode;
				document.getElementById("cop_addr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("cop_daddr").focus();
			}
		}).open({
			q : q
		});
	}

	//이메일 정규화 체크
	function fn_emailcheck(){
		var email = $("#cop_email").val();
		console.log(email)
		
		var regExp = "^[A-z|0-9]([A-z|0-9]*)(@)([A-z]*)(\\.)([A-z]*)$";
		if(email.match(regExp) == null){
			alert("이메일 형식이 아닙니다.");
			$("#cop_email").val('');//초기화
			$("#cop_email").focus();
		}
	}
	
	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="BizPartner" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="selectanno" id="selectanno" value=""> 
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="swriter" name="swriter" value="${loginId}">
	<input type="hidden" id="swriterNM" name="swriterNM" value="${userNm}"> <!-- 작성자 session에서 java에서 넘어온값 -->

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
							<a href="#" class="btn_nav bold">영업</a> 
								<span class="btn_nav bold">거래처 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>거래처 관리 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fn_PartnerModal(${nullNum});" name="modal">
								<span>거래처 추가</span></a>
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 100%">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%">업체명</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="copNM" name="copNM"></td>   
                           <td width="55" height="25" style="font-size: 100%">사업자번호</td>
                           <td width="50" height="25" style="font-size: 100%">
                               <input type="text" style="width: 120px" id="copNO" name="copNO"></td>                               
                           <td width="50" height="25" style="font-size: 100%">작성일</td>
                           <td width="50" height="25" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="from_date" name="from_date"></td>
                           <td width="10" height="60" style="font-size: 100%">
                            <input type="date" style="width: 120px" id="to_date" name="to_date"></td>
                           <td width="110" height="60" style="font-size: 120%">
                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a></td> 
                            <!-- <input type="button" value="검  색  " id="searchBtn" name="btn" class="test_btn1" 
                              style="border-collapse: collapse; border: 0px gray solid; background-color: #50bcdf; width: 70px; color: white"/> -->
                        </tr>
                     </table>    
						
						
						<div class="divBizPartnerList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="11%">
						                   <col width="10%">
						                   <col width="20%">
						                   <col width="15%">
						                   <col width="8%">
						                   <col width="13%">
						                   <col width="15%">
						                   <col width="8%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">날짜</th>
							              <th scope="col">거래처</th>
							              <th scope="col">주소</th>
							              <th scope="col">메모</th>
							              <th scope="col">담당자</th>
							              <th scope="col">전화번호</th>
							              <th scope="col">휴대전화</th>
							              <th scope="col">이메일</th>
									</tr>
								</thead>
								<tbody id="partnerList"></tbody>
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
	<div id="partner" class="layerPop layerType2" style="width: 780px;">
		<input type="hidden" id="partenerNo" name="partenerNo" value="${partenerNo}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>거래처 추가하기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">업체명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="cop_nm" id="cop_nm" /></td>
							<th scope="row">회사 전화 <span class="font_red">*</span></th>
							<td>
								<select name="partnerTel1" id="Tel1" style="width: 49px; height: 28px;">
										<option value="02" selected="selected">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
								</select> -
								<input type="text" maxlength="4" style="width: 50px" class="inputTxt" name="partnerTel2" id="Tel2" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/> -
								<input type="text" maxlength="4" style="width: 50px" class="inputTxt" name="partnerTel3" id="Tel3" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
							</td>
						</tr>
						<tr>
							<th scope="row">담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" name="userNm" id="userNm" /></td>
							<th scope="row">휴대 전화 <span class="font_red">*</span></th>
							<td>
								<input type="text" maxlength="3" style="width: 45px" class="inputTxt" name="partnerPh1" id="Phone1" value="010" readonly="readonly"/> -
								<input type="text" maxlength="4" style="width: 50px" class="inputTxt" name="partnerPh2" id="Phone2"  oninput="this.value = this.value.replace(/[^0-9]/g, '');"/> -
								<input type="text" maxlength="4" style="width: 50px" class="inputTxt" name="partnerPh3" id="Phone3" oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
							</td>
						</tr>
						<tr>
							<th scope="row" >상대담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" name="cop_ee" id="cop_ee" placeholder="거래처 담당자를 입력해주세요"/></td>
							<th scope="row">대표자명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" name="cop_bm" id="cop_bm" placeholder="거래처 대표자명를 입력해주세요"/></td>
						</tr>
						<tr>
							<th scope="row">우편번호<span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="cop_zip" id="cop_zip" /></td>

							<td><input type="button" value="우편번호 찾기"
								onclick="execDaumPostcode()"
								style="width: 130px; height: 20px;" /></td>
						</tr>
						<tr>
							<th scope="row">주소<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="cop_addr" id="cop_addr" /></td>
						</tr>
						<tr>
							<th scope="row">상세주소</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="cop_daddr" id="cop_daddr" /></td>
						</tr>
						<tr>
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td><input type="email" class="inputTxt p100" style="width: 200px"
								name="cop_email" id="cop_email" onchange="fn_emailcheck()" /></td>
							<th scope="row">사업자 번호 <span class="font_red">*</span></th>
							<td>
								<input type="text" maxlength="3" style="width: 80px" class="inputTxt" name="partnerCn1" id="ComNo1" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/> -
								<input type="text" maxlength="2" style="width: 90px" class="inputTxt" name="partnerCn2" id="ComNo2" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/> -
								<input type="text" maxlength="5" style="width: 90px" class="inputTxt" name="partnerCn3" id="ComNo3" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
							</td>
						</tr>
						<tr>
							<th scope="row">은행<span class="font_red">*</span></th>
							<td ><select id="sampleconcode" name="sampleconcode">
                                 
                                 </select></td>
							<th scope="row">계좌번호<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100"
								name="cop_ano" id="cop_ano" oninput="this.value = this.value.replace(/[^0-9]/g, '');"  maxlength="20"/></td>
						</tr>
						<tr>
							<th scope="row">예금주명<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt" style="width: 150px" name="cop_anm" id ="cop_anm"/>
						</tr>
						<tr>
							<th scope="row">메모</th>
							<td colspan="3">
								<textarea class="inputTxt " name="cop_memo" id="cop_memo" style="resize: none;">
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveBizPartner" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateBizPartner" name="btn" style="display:none"><span>수정</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
</form>

</body>
</html>
