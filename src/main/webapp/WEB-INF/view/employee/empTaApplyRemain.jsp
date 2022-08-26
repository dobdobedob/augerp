<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<c:forEach items="${listLoginVac}" var="list">
	 <tr>
	    <td style = "text-align:center">${list.dva_tot}</td>
        <td style = "text-align:center">${list.dva_rest}</td>
        <td style = "text-align:center">${list.dva_use}</td>
    </tr>
</c:forEach>
					
							
							