 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<dl>
			<dt>
				<strong>수주 상세조회</strong>
			</dt>
			
			<dd>
				<!-- s : 여기에 내용입력 -->
				<!-- 세로 두개분할 -->
			
				<div class="sel_emp_left" style = "height: 100%; width: 100%">
					
					
						
					<div style="padding-left:10px;
									font-weight: bold;
									width:100%;">
							공급받는자 scm회사
					</div>
		
					<table style=" width:98%;
									margin-bottom:8px;">
									<tr>
						 <colgroup>
		                   <col width="50%">
		                   <col width="50%">
		                </colgroup>
							<tr  style="height:10px;">
							<th id="ttg">사업자등록번호</th>
							<th id="ttg">${DtlListInfo.cop_cno}</th>	
							<tr>
							
							<tr>
							<td id="ttg">회사명</td>
							<td id="ttg">${DtlListInfo.cop_nm}</td>
							</tr>
							<tr>
							<td id="ttg">주소</td>
							<td id="ttg">${DtlListInfo.cop_addr}</td>
							</tr>
							<tr>
							<td id="ttg">담당영업사원</td>
							<td id="ttg">${DtlListInfo.cop_ee}</td>
							</tr>
							<tr>
							<td id="ttg">TEL</td>
							<td id="ttg">${DtlListInfo.cop_phn}</td>
							</tr>
					</table>
					<div class="sel_emp_right">
					
						<table style=" width:100%;
									margin-bottom:8px;">
									
						<colgroup >
	                   		<col width="100%">
		                 
		                </colgroup>
									
						
							<table style="margin-bottom:10px">
							<div style="border:1px solid #000000;
										background-color:white;">
							
							<div style="padding-left :12%;
										width:100%;
										height:60px;">
							주문공급자 emp
							
							<div style="font-size:32px;
										font-weight: bold;
										margin-left:28%;
										">
										해피잡
										</div>
							</div>
							</div>
							</table>
							
						</table>
						<table style="padding-left:10px;
									  width:100%;">
						  <colgroup>
		                   <col width="30%">
		                   <col width="70%">
		                </colgroup>
							<tr>
							<th id="ttg">사업자등록번호</th>
							<th id="ttg">123-45-6789</th>	
							<tr>
							
							<tr>
							<td id="ttg">회사명</td>
							<td id="ttg">해피잡</td>
							</tr>
							<tr>
							<td id="ttg">주소</td>
							<td id="ttg">서울</td>
							</tr>
							<tr>
							<td id="ttg">담당영업사원</td>
							<td id="ttg">${DtlListInfo.name}</td>
							</tr>
							<tr>
							<td id="ttg">TEL</td>
							<td id="ttg">${DtlListInfo.tel}</td>
							</tr>
						</table>
				</div>
					<table>
					 <th id="tth">결재</th>
							
							<tr>
							
							<td id="tth">담당</td>
						
							</tr>
							
							<tr>
							<td id="tth">ㅁ</td>
							
					</tr> 
					</table>
						
					<div style="padding-left:10px;">
					1. 귀사의 일의 번창하심을 기원합니다.						
					</div>
					<div style="padding-left:10px;">
					2. 하기와 같이 견적드리오니 검토하기 바랍니다.
					</div>
				</div>
				<!-- ----------------------------------------------------------------------------------------------- -->
				
				<!-- 세로 두개분할 끛 -->
				
				<%-- <div>
				<c:forEach items="${DtlListModal}" var="list">	
				<div style="padding:0;margin:0;font-weight:bold;font-size:16px">
				유효기간(납기일)${DtlListModal.do_due}
				</div>
				<div style="width:90%; border:2px solid black ; margin-bottom:10px; padding-left:10%;font-weight:bold;font-size:20px;" >
				금액 : ${DtlListModal.ord_tot}
				</c:forEach>
				</div>
				</div> --%>
				
				
				<!-- 리스트 -->
				<div >
					<table class="col" style = "word-break:break-all">
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
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>
									
										  <th scope="col">견적서 번호</th>
							              <th scope="col">수주일</th>
							              <th scope="col">납기일</th>
							              <th scope="col">납품개수</th>
							              <th scope="col">공급가액</th>
							              <th scope="col">세액</th>
							              <th scope="col">제품단가</th>
							              <th scope="col">제품이름</th>
							               <th scope="col">수주직원사번</th>
							               <th scope="col">취소</th>
							             <!--  <th scope="col">수주직원이름</th>-->
							        </tr>
								</thead>
								<tbody>
								
								<c:if test="${totalCntModalOeManagement eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
								
								<c:if test="${totalCntModalOeManagement > 0 }">
								<c:set var="nRow" value="${pageSize*(curPageOeManagement-1)}" />
										<c:forEach items="${DtlListModal}" var="list">
											
									 <tr>
										<input type="hidden" id="ord_no_del" name ="ord_no_del" value="${list.ord_no}">
											<td>${list.est_no}</td>
											<td>${list.do_date}</td>
											<td>${list.do_due}</td>
											<td>${list.do_nmt}</td>
											<td>${list.supply_price}</td>
											<td>${list.tax_amount}</td>
											<td>${list.do_price}</td>
											<td>${list.si_nm}</td>
											<td>${list.loginID}</td>
											<td><a class = "btnType3 color1" href="javascript:fn_oneProDel(${list.ord_no},${list.si_cd},'${list.si_nm}');">삭제</a></td>	
											
									</tr> 
									</c:forEach>
								</c:if>
									
								</tbody>
							</table>
							
							<div class="paging_area" id="oeModalPagination"></div>
				<!-- e : 여기에 내용입력 -->
				
					<div class="btn_areaC mt30">
<!-- 				<a href="" class="btnType blue" id="btnInsertEmpDv" name="btn"><span>신청</span></a>
					<a href="" class="btnType blue" id="btnUpdateEmpDv" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDeleteEmpDv" name="btn"><span>삭제</span></a>   --> 
					<a href="javascript:modalRevert();" class="btnType gray" id="modalRevert" name="btn"><span>취소</span></a>
				</div>
					<div >
						<a href="" class="closePop"><span class=""></span></a>
					</div>
			</div> 
			
			<!-- 리스트 --> 
			
				<input type="hidden" id="totalCntModalOeManagement" name="totalCntModalOeManagement" value ="${totalCntModalOeManagement}"/>
				
			</dd>
		</dl> 