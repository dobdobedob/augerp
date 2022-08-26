<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



						
					<c:forEach items="${selectEstNo}" var="list">
								<tr>
									<td>${list.est_no}</td>
									<td>${list.cop_nm}</td>
									<td>${list.bi_nm}</td>
									<td>${list.mi_nm}</td>
									<td>${list.si_nm}</td>
									<td>${list.de_nmt}</td>
									<td>${list.de_price}</td>
									<td>${list.de_due}</td>
								</tr>
							</c:forEach>	

	



