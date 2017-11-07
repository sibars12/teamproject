<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
th {
	border-bottom: 1px solid;
	text-align: left;
}
th, td {
	padding: 10px;
}
</style>
<div align="center" style="line-height: 35px">

	<h2>공지사항</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 공지사항이 등록되어있습니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr>
				
				<th style="width: 40%">글제목</th>
				<th style="width: 20%">작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					
					<td>
					
						<a href="/notice/view?num=${obj.NUM}&page=${param.page}">${fn:substring(obj.TITLE, 0, 20) } </a>
					</td>
					<td>${obj.MASTER }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar" align="center">
 <c:if test="${param.page gt 1 }"><a  class="w3-button" href="/notice/list?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/notice/list?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page lt size }"><a class="w3-button" href="/notice/list?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
