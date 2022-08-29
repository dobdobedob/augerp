<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					
		<dl>
			<dt>
				<strong>회계 전표</strong>
			</dt>
			<dd class="content">
	                <table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
	
						<tbody>
							<tr>
								<th scope="row">거래처명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="pop_cop_nm" id="pop_cop_nm" value="${accountModel.cop_nm}" /></td>
								<th scope="row">담당자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="pop_cop_ee" id="pop_cop_ee" value="${accountModel.cop_ee}" /></td>
							</tr>
						</tbody>
					</table>


				<!-- s : 여기에 내용입력 -->
				     <style>
 							 table {
 								width: 100%;
   								border-top: 1px solid #444444;
    							border-collapse: collapse;
  									}
  							th, td {
    							border-bottom: 1px solid #444444;
    							border-left: 1px solid #444444;
    							padding: 10px;
  									}
  								th:first-child, td:first-child {
 							   border-left: none;
  									}
					</style>
                     <table id="either" >
                          <colgroup>
		                   <col width="50%">
		                   <col width="25%">
		                   <col width="25%">
	                     </colgroup>
	                     <thead>
								<tr>
									  <th scope="col">계정과목</th>
						              <th scope="col">지출</th>
						              <th scope="col">수입</th>						          
								</tr>
						</thead>					
					     <tbody>
							<c:forEach items="${listAccountModel}" var="list">			
								<tr>
									    <td>${list.dac_no}</td>
										<td>${list.ant_spd}</td>
										<td>${list.ant_inc}</td>
								</tr>
							</c:forEach>
								<tr>
									    <td>합계</td>
										<td>${accountModel.ant_spd}</td>
										<td>${accountModel.ant_inc}</td>
								</tr>							
					     </tbody>
					</table>  
				<!-- e : 여기에 내용입력 -->

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>					
					