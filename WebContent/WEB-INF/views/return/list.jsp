<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div align="center" style="line-height: 35px">

	<h2>반품 신청 목록</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 반품 신청이  등록되어있습니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr class="gavan">
				
				<th class="gaven" style="width: 30%">글제목</th>
				<th class="gaven" style="width: 10%">작성자</th>
				<th class="gaven" style="width: 10%">작성일</th>
				<th class="gaven" style="width: 10%">상품명</th>
				<th class="gaven" style="width: 10%">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
			
				<tr class="gavan">
					<td class="gaven">
						<c:if test="${obj.WRITER eq auth }">
						<a href="/return/view?num=${obj.NUM}&page=${param.page}">${fn:substring(obj.TITLE, 0, 12) } </a>
						</c:if>
						<c:if test="${obj.WRITER ne auth }">
						<a>비밀글 입니다.<span class="glyphicon glyphicon-lock"></span></a>
						</c:if>
					</td>
					<td class="gaven">${obj.WRITER }</td>
					<td class="gaven">${obj.WRITEDATE }</td>
					<td class="gaven">${obj.NAME }</td>
					<td class="gaven">${obj.RETURN }</td>
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
 <c:if test="${param.page gt 1 }"><a  class="w3-button" href="/return/list?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/return/list?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page lt size }"><a class="w3-button" href="/return/list?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
