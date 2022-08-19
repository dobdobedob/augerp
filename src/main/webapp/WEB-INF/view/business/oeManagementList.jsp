<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntOeManagement eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntOeManagement > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageOeManagement-1)}" />
								<c:forEach items="${listOeManagement}" var="list">
									<tr>
										<td>${list.name}</td>
										<td>${list.do_date}</td>
										<td>${list.cop_nm}</td>
										<td>${list.si_cd}</td>
										<td>${list.do_due}</td>
										<td>${list.do_nmt}</td>
										<td>${list.ord_tot}</td>
										<td>${list.tax_amount}</td>
										<td>${list.do_price}</td>
			
										<td>
											<a class="btnType3 color1" href="javascript:fPopModalComnGrpCod('');"><span>수주서</span></a>
										</td>
									</tr>
									
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntOeManagement" name="totalCntOeManagement" value ="${totalCntOeManagement}"/>