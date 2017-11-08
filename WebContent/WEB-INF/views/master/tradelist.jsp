<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div align="center" style="line-height: 35px">

	<h2>유저 거래 목록</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 거래 내역이  있습니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr class="gavan">
				
				<th class="gaven" style="width: 20%">주문번호</th>
				<th class="gaven" style="width: 20%">주문일자</th>
				<th class="gaven" style="width: 10%">이미지</th>
				<th class="gaven" style="width: 20%">상품명</th>
				<th class="gaven" style="width: 5%">수량</th>
				<th class="gaven" style="width: 10%">금액</th>
				<th class="gaven" style="width: 15%">상태</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr class="gavan">
							<td class="gaven">${obj.NUM}</td>
							<td class="gaven">${obj.ORDERDATE}</td>
							<td class="gaven"><img width="80" src="/images/product/${obj.IMAG}"></td>
							<td class="gaven">${obj.NAME}</td>
							<td class="gaven">${obj.CNT}</td>
							<td class="gaven">${obj.PRICE}</td>
							<td class="gaven">${obj.RETURN}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${!empty auth }">
	</c:if>
	<p align="right" style="margin-right: 30px;">
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar" align="center">
 <c:if test="${param.page gt 1 }"><a  class="w3-button" href="/master/tradelist?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/master/tradelist?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page lt size }"><a class="w3-button" href="/master/tradelist?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
