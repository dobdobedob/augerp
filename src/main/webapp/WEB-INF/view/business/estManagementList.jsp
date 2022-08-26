<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<!-- 갯수가 0인 경우  -->
			<c:if test="${totEstmanagementModel eq 0 }">
				<tr>
					<td colspan="4">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			
		<!-- 갯수가 있는 경우  -->
			<c:if test="${totEstmanagementModel > 0}">
			
				<c:forEach items="${listEstmanagementModel}" var="list">			
					<tr>
							<td>${list.est_no}</td>
							<td>${list.cop_nm}</td>
							<td>${list.cop_ee}</td>
							<td>${list.cop_phn}</td>
							<td>${list.de_date}</td>
							<td>${list.de_due}</td>
							
							<td>
							<a class="btnType blue" href="javascript:fn_estManagementModal(${list.est_no});" name="modal">
								<span>견적서 조회</span></a>
							</td>
	

							<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
						</tr>
				</c:forEach>
		</c:if>
				
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${ totEstmanagementModel }" />





