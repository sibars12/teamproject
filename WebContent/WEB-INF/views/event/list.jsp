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

	<h2>이벤트</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 이벤트가 진행중입니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr>
				
				<th style="width: 40%">이벤트 목록</th>
				<th style="width: 20%">시작일</th>
				<th style="width: 20%">마감일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					
					<td>
					
						<a href="/event/view?num=${obj.NUM}&page=${param.page}">${fn:substring(obj.TITLE, 0, 12) } </a>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.STARTDATE }" /></p>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.ENDDATE }" /></p>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
		<a href="/event/add"><button type="button">공지글작성</button></a>
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page ne 1 }"><a  class="w3-button" href="/event/list?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/event/list?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page ne size }"><a class="w3-button" href="/event/list?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
