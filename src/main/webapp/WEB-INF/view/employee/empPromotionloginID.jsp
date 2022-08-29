<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!-- 갯수가 0인 경우  -->
		<c:if test="${totEmpPromotionModellogin eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totEmpPromotionModellogin > 0 }">
			<c:forEach items="${listEmpPromotionModellogin}" var="list">	
				
				<tr>
					<td>${list.hr_date}</td>
					<td>${list.dept_cd}</td>
					<td>${list.dept_name}</td>
					<td>${list.job_cd}</td>
					<td>${list.detail_name}</td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt_loginID" name="totcnt_loginID" value="${totEmpPromotionModellogin}"/>










