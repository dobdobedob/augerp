<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totDdRevenueModel eq 0 }">
			<tr>
				<td colspan="10">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totDdRevenueModel > 0 }">
			<c:forEach items="${listDdRevenueModel}" var="list">			
				<tr>
						
						<td>${list.do_date}</td>
						<td>${list.cop_no}</td>
						<td>${list.cop_nm}</td>
						<td>${list.loginID}</td>
						<td>${list.bi_nm}</td>
						<td>${list.si_nm}</td>
						<td>${list.ord_tot}</td>
						<td>${list.ord_ar}</td>
						
				</tr>
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${totDdRevenueModel}"/>











