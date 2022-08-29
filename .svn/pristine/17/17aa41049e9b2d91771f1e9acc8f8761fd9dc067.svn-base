<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntEmpDv eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntEmpDv > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageEmpDv-1)}" />
								<c:forEach items="${listEmpDv}" var="list">
									<tr onclick="fn_empDvDtlModal(${list.exp_no}, '${list.exp_stat}');">
										<td>${list.exp_no}</td>
										<td>${list.exp_date}</td>
										<td>${list.exp_sdate}</td>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.acc_nm}</td>
										<td>${list.dac_nm}</td>
										<td>${list.dept_name}</td>
										<td>${list.exp_cost}</td>
										<td>${list.exp_stat}</td>
									</tr>
									
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntEmpDv" name="totalCntEmpDv" value ="${totalCntEmpDv}"/>