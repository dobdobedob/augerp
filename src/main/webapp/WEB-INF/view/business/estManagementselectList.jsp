<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



	
	
	<dl>
			<dt>
				<strong>견적서 상세조회</strong>
			</dt>
			
			<dd>
				<!-- s : 여기에 내용입력 -->
				<!-- 세로 두개분할 -->
			
				<div class="sel_emp_left">
		
					<div style="padding-left:10px;
									font-weight: bold;
									width:100%;">
							공급받는자 scm회사
					</div>
		
					<table style=" width:98%;
									margin-bottom:8px;">
						<colgroup>
		                   <col width="30%">
		                   <col width="70%">
		                </colgroup>
							<tr  style="height:10px;">
							<th id="ttg">사업자등록번호</th>
							<th id="ttg">${cardTot.cop_cno}</th>	
							<tr>
							
							<tr>
							<td id="ttg">회사명</td>
							<td id="ttg">${cardTot.cop_nm}</td>
							</tr>
							<tr>
							<td id="ttg">주소</td>
							<td id="ttg">${cardTot.cop_addr}</td>
							</tr>
							<tr>
							<td id="ttg">담당영업사원</td>
							<td id="ttg">${cardTot.cop_ee}</td>
							</tr>
							<tr>
							<td id="ttg">TEL</td>
							<td id="ttg">${cardTot.cop_phn}</td>
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
				<div class="sel_emp_right">
					
						<table style=" width:30%;
									margin-bottom:8px;
									margin-left:70%;
									 ">
									
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
										margin-left:28%;	">
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
							<td id="ttg">${cardTot.writer}</td>
							</tr>
							<tr>
							<td id="ttg">TEL</td>
							<td id="ttg">${cardTot.tel}</td>
							</tr>
						</table>
				</div>

				
				<!-- 세로 두개분할 끛 -->
				
				
				
				
				<div>
				
				<div style="padding:0;margin:0;font-weight:bold;font-size:16px">
				유효기간(납기일)${cardTot.de_due}
				</div>
				<div style="width:90%; border:2px solid black ; margin-bottom:10px; padding-left:10%;font-weight:bold;font-size:20px;" >
				금액 : ${cardTot.est_tot}
				</div>
				</div>
				
				
				<!-- 리스트 -->
				<div style="overflow-y:scroll; height: 300px;">
					<table class="col" id="estimatelist">
				<input type="hidden" id="esdNum" value="">
				<input type="hidden" id="si_nm" value="">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="18%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="11%">
						                   <col width="5%">
					                 </colgroup>
								<thead>
									<tr style=" margin:0; display: table; position: absolute;">
																
										  <th scope="col">제품</th>
							              <th scope="col">제조업체</th>
							              <th scope="col">제품이름</th>
							              <th scope="col">납품갯수</th>
							              <th scope="col">판매금액</th>
							              <th scope="col">공급가액</th>
							              <th scope="col">세액</th>
							              <th scope="col">제품단가</th>
							              <th scope="col">ㅡ</th>
						              </tr>
								</thead>
								<tbody>
									<c:forEach items="${selectestmanagement}" var="list">	
										<tr>
											<td>${list.bi_nm}</td>
											<td>${list.mi_nm}</td>
											<td>${list.si_nm}</td>
											<td>${list.de_nmt}</td>
											<td>${list.de_price}</td>
											<td>${list.de_ten}</td>
											<td>${list.dtax}</td>
											<td>${list.dprice}</td>
											<td><a href="javascript:fn_estidelete(${list.est_no},${list.si_cd}  );"	class="btnType gray"  id="deltebtn" name="btn"><span>삭제</span></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
				<!-- e : 여기에 내용입력 -->
				
			
			
			<!-- 리스트 -->
			<div class="btn_areaC mt30">
			<a href=""	class="btnType gray"  id="updateBtn" name="btn"><span>수정하기</span></a>
				<a href="javascript:gfCloseModal();"	class="btnType gray"  id="btnClosedn" name="btn"><span>닫기</span></a>
			</div>
					<div >
						<a href="" class="closePop"><span class=""></span></a>
					</div>
			</dd>
		</dl>