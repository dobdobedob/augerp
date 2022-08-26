<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
	
		
	<dl>
	<input type="hidden" id="esNum" value="">
		<dt>
			<strong>견적서 작성</strong>
		</dt>
			<dd>

				<!-- s : 여기에 내용입력 -->				
			<div style="overflow-y:scroll; height: 300px;" id="apinsertlist">
				<table class="col" >
					
					<colgroup>
					   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   <col width="12%">
	                   
               		  </colgroup>
               		    <thead>
							<tr style="text-align:center;">
								<td scope="col">거래처번호</td>
								<td scope="col">거래처</td>
								<td scope="col">제품</td>
								<td scope="col">제조업체</td>
								<td scope="col">제품명</td>
								<td scope="col">개수</td>
								<td scope="col">판매금액</td>
								<td scope="col">남기일</td>
							</tr>
						</thead>
						
							<tbody id="listEm"></tbody>
						
						
					</table>
				</div>
				 
				 	<table width="100%"  height="100%" cellpadding="5" cellspacing="0" border="1"
				                     align="left" style="border-collapse: collapse;border: 1px solid black;
				                     margin-top:10%;margin-bottom:20px;">
				     
				 <!------------------- 제품분류  ------------------------------------------------------------------>
						 <tr>
							<td width="5%" height="44" style="font-size: 100%;"></td>
							<td width="10%" height="44" style="font-size: 16px">거래처</td>
							<td width="10%" height="44" style="font-size: 100%;">                          
								<select id = "cilallis" name ="cilallis" style="width: 120px"></select>	
							</td>

						 </tr>
						 
						 <tr>
						 	<td width="5%" height="44" style="font-size: 100%;"></td>
						
						 	
							<td width="10%" height="44" style="font-size: 16px">제품</td>
							<td width="10%" height="44" style="font-size: 100%;">                          
								<select id = "prolall" name ="prolall" style="width: 120px">
								</select>
							</td>
							
							<td width="10%" height="44" style="font-size: 16px">제조업체</td>
							<td width="10%" height="44" style="font-size: 100%;">                          
								<select id = "promall" name ="promall" style="width: 120px">
								</select>
							</td>
							
					 		<td width="10%" height="44" style="font-size: 16px">제품명</td>
							<td width="10%" height="44" style="font-size: 100%;">                          
								<select id = "prodall" name ="prodall" style="width: 120px">
								</select>
							</td>
						 </tr>
						 
						 <tr>
						 <td width="5%" height="44" style="font-size: 100%;"></td>
							<td width="10%" height=44 style="font-size:16px">납품갯수</td>
						    <td><input type="number" style="width:120px" id="de_nmt" name="de_nmt"></td>
											
					 		<td width="5%" height=44 style="font-size:16px">판매금액</td>
						    <td><input type="number" style="width:120px" id="de_price" name="de_price"></td>
				         
				         	<td width="50" height="25" style="font-size: 100%">납기일</td>
                            <td width="50" height="25" style="font-size: 120%">
                            <input type="date" style="width: 120px" id="de_due" name="de_due"></td>
						 </tr>
			<!-- ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ -->
						<tr>

				 </table>    	
			 
			
				<div style="text-align:center;">
					<div>
						<a href="javascript:fn_estisave();"  class="btnType blue"  id="btnSaveEmt" name="btn"><span>저장</span></a>
						<a href="javascript:gfCloseModal();"	class="btnType gray"  id="btnClosednEMt" name="btn"><span>닫기</span></a>
						
					</div>
				</div>

			</dd>	
	</dl>
	<a href="" class="closePop"><span class=""></span></a>