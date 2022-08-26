<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 

		<!-- 갯수가 0인 경우  -->

		<c:if test="${totpayAccMngModeldtl eq 0 }">

			<tr>

				<td colspan="14">데이터가 존재하지 않습니다.</td>

			</tr>

		</c:if>

		<!-- 갯수가 있는 경우  -->

		<c:if test="${totpayAccMngModeldtl > 0 }">

			<c:forEach items="${listpayAccMngModeldtl}" var="list">			

				<tr>

						<td>${list.sal_date}</td>
						<td>${list.dep_cd}</td>
						<td>${list.job_cd}</td>
						<td>${list.loginID}</td>
						<td>${list.name}</td>
						<td>${list.sal_ad}</td>
						<td>${list.sal_bt}</td>
						<td>${list.sal_kuk}</td>
						<td>${list.sal_kun}</td>
						<td>${list.sal_san}</td>
						<td>${list.sal_ko}</td>
						<td>${list.exp_cost}</td>
						<td>${list.sal_price}</td>
						<td>${list.exh_date}</td>
						


					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !! -->

				</tr>

			</c:forEach>
			

		</c:if>
		
		

		<!--   이거 중간에 있으면 table 안먹힘 -->

        <input type="hidden" id="totcntdtl" name="totcntdtl" value="${totpayAccMngModeldtl}"/>
 