<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totIncManageiModel eq 0 }">
			<tr>
				<td colspan="6">데이터가 존재하지 않습니다.</td>	
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totIncManageiModel > 0 }">
			<c:set var="nRow" value="${ipageiSize*(currentiPage-1)}" /> 
			<c:forEach items="${listIncManageiModel}" var="list">
				<tr>
				        
						<td>${list.ict_no}</td>
						<td>${list.name}</td>						
						<td>${list.loginID}</a></td>   
					    <td>${list.ict_bo}</a></td>
						<td>${list.ict_price}</td>
						<td>${list.ict_date}</td>
	
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if>
		
		<input type="hidden" id=toticnt value="${totIncManageiModel}">
		<!-- 이거 중간에 있으면 table 안먹힘  -->
