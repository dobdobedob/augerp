<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntEmpTaApply eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntEmpTaApply > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageEmpTaApply-1)}" />
								<c:forEach items="${listEmpTaApply}" var="list">
									<tr>
										<td>${list.row_num}</td>
										<td>${list.vac_type}</td>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.vac_sdate}</td>
										<td>${list.vac_edate}</td>
										<td>${list.vac_bo}</td>
										<td>${list.vac_stat}</td>
									</tr>
									
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntEmpTaApply" name="totalCntEmpTaApply" value ="${totalCntEmpTaApply}"/>