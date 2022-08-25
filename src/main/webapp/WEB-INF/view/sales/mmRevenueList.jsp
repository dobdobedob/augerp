<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totMmRevenueModel eq 0 }">
			<tr>
				<td colspan="10">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totMmRevenueModel > 0 }">
			<c:forEach items="${listMmRevenueModel}" var="list">			
				<tr style="table-layout: fixed; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;" >
						
						<td>${list.do_date}</td>
						<td>${list.cop_no}</td>
						<td>${list.cop_nm}</td>
						<td>${list.loginID}</td>
						<td>${list.bi_nm}</td>
						<td>${list.si_nm}</td>
						<td>${list.si_price}</td>
						<td>${list.do_nmt}</td>
						<td>${list.total}</td>
							
				</tr>
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${totMmRevenueModel}"/>    
