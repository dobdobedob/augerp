<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totBmSalePlanModel eq 0 }">
			<tr>
				<td colspan="10">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totBmSalePlanModel > 0 }">
			<c:forEach items="${listBmSalePlaneModel}" var="list">			
				<tr>
						<%-- 이거 뭐가져오는건지? 파일이랑 모달창 띄우는건가 지워도 될거같다
					    <td><a href="javascript:fn_NoticeModalfile(${list.ann_no});">${list.ann_no}</a></td>
						<td><a href="javascript:fn_NoticeModal(${list.ann_no});">${list.ann_title}</a></td> --%> 
						<td>${list.loginID}</td>
						<td>${list.dept_name}</td>
						<td>${list.name}</td>
						<td>${list.pln_ddate}</td>
						<td>${list.si_cd}</td>
						<td>${list.si_nm}</td>
						<td>${list.pln_nmt}</td>
						<td>${"야옹"}</td>
						<td>${list.pln_ar}</td>
						<td>${list.pln_etc}</td>
						
						
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${totBmSalePlanModel}"/>











