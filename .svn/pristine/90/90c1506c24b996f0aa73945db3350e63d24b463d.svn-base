<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!-- 갯수가 0인 경우  -->
		<c:if test="${totBizPartnerModel eq 0 }">
			<tr>
				<td colspan="8">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totBizPartnerModel > 0 }">
			<c:forEach items="${listBizPartnerModel}" var="list">	
				
				<tr onclick="javascript:fn_PartnerModal(${list.cop_no});">
				    <td>${list.cop_date}</td>
					<td>${list.cop_nm}</td>
					<td>${list.cop_addr} ${list.cop_daddr}</td>
					<td>${list.cop_memo}</td>
					<td>${list.cop_ee}</td>
					<td>${list.cop_tel}</td>
					<td>${list.cop_phn}</td>
					<td>${list.cop_email}</td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${totBizPartnerModel}"/>










