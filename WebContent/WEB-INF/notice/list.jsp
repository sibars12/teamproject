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
				<th style="width: 10%">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					
					<td>
					
						<a href="/notice/view?num=${obj.NUM}">${fn:substring(obj.TITLE, 0, 12) } </a>
					</td>
					<td>${obj.MASTER }</td>
					<td><fmt:formatNumber value="${obj.CNT }" pattern="#,###"/>  </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
		<a href="/notice/add"><button type="button">공지글작성</button></a>
	</p>
</div>