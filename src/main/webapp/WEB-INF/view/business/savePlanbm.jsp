<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<dl>
		<dt>
			<strong>계획 등록하기</strong>
		</dt>
			<dd>

				 	<table width="100%"  height="100%" cellpadding="5" cellspacing="0" border="1"
				                     align="left" style="border-collapse: collapse;border: 1px solid black;
				                     margin-top:1%;margin-bottom:20px;">
				     
 <!------------------- 제품분류  ------------------------------------------------------------------>
						 <tr style="border:2px solid #000000">
							<td width="10%" height="44" style="font-size: 80%;"></td>>
							<td width="5%" height="44" style="font-size: 16px">사번</td>
							<td width="10%" height="44" style="font-size: 80%;">
							<input type="text" style="width:120px" id="loginID" name="loginID"  value="${loginId}">
							</td>
							
							<td width="10%" height="44" style="font-size: 80%;"></td>
							<td width="10%" height="44" style="font-size: 16px">직원명</td>
							<td>
							<input type="text" style="width:120px" id="name" name="name" value="${userNm}">
							</td>
							
							<td width="10%" height="44" style="font-size: 16px">부서명</td>
							<td width="5%" height="44" style="font-size: 100%;">                          
								<select id = "deptallin" name ="deptallin" style="width: 120px">
								</select>
							</td>
						 </tr>
						 
						 <tr style="border:2px solid #000000">
							<td width="10%" height="44" style="font-size: 80%;"></td>
							<td width="5%" height="66" style="font-size: 16px">목표날짜</td>
								<td><input type="date" style="width:120px" id="pln_ddate" name="pln_ddate"></td>
						 </tr>
						 
						    <tr style="border:2px solid #000000">
					 			<td width="3%" height="66" style="font-size: 80%;"></td>
								<td width="7%" height="66" style="font-size: 16px">제품</td>
								<td width="3%" height="66" style="font-size: 100%;">                          
									<select id = "prolallin" name ="prolallin" style="width: 120px">
									</select>
								</td>
								<td width="3%" height="66" style="font-size: 80%;"></td>
						 		<td width="10%" height="66" style="font-size: 16px">제조업체</td>
								<td width="3%" height="66" style="font-size: 100%;">                          
									<select id = "promallin" name ="promallin" style="width: 120px">
									</select>
								</td>
								
								<td width="7%" height="66" style="font-size: 16px">품명</td>
								<td width="3%" height="66" style="font-size: 100%;">                          
									<select id = "prodallin" name ="prodallin" style="width: 120px">
									</select>
								</td>
						
						 <tr style="border:2px solid #000000">
								<td width="3%" height="66" style="font-size: 80%;"></td>
								<td width="10%" height="66" style="font-size:16px">수량</td>
							    <td><input type="number" style="width:120px" id="pln_nmt" name="pln_nmt"></td>
						 </tr>
						
						<tr style="border:2px solid #000000">
							<td width="3%" height="66" style="font-size: 80%;"></td>
							<td width="10%" height="66" style="font-size:16px">비고</td>
						    <td><input type="text" style="width:400px" id="pln_etc" name="pln_etc"></td>
						</tr>
				 </table>    	
			 
				<div style="text-align:center;">
					<div>
						<a href="javascript:fn_savembi();" class="btnType blue"  id="btnSaveBm" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray"  id="btnClosedn" name="btn"><span>닫기</span></a>
					</div>
				</div>

		   </dd>	
	</dl>
	<a href="" class="closePop"><span class=""></span></a>