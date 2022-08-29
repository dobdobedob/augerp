<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 		<!-- 갯수가 0인 경우  -->
		<c:if test="${totaccountModel eq 0 }">
			<tr>"src/main/java/kr/happyjob/study/system/controller/NoticeController.java"
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totaccountModel > 0 }"> --%>
			<c:forEach items="${listAccountModel}" var="list">			
				<tr>
					    <td>${list.ant_no}</td>
						<td>${list.ant_date}</td>
						<td>${list.acc_no}</td>
						<td>${list.dac_no}</td>
						<td>${list.loginname}</td>
						<td>${list.cop_nm}</td>
						<td>${list.ant_spd}</td>
						<td>${list.ant_inc}</td>
						<td>${list.totamt}</td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
			</c:forEach>
		<%-- </c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${totAccontModel}"/>


 --%>