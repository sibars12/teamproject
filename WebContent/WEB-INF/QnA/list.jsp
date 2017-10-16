<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div align="center" style="line-height: 35px">
	<h2>Q&A</h2>
	<input type="text" style="font-size: 20pt; padding: 8px"
				placeholder="Q&A 검색어 입력.." name="word" id="wd" value="" />
	<table style="width: 30%">
		<thead>
			<tr>
				<th style="width: 10%">글번호</th>
				<th style="width: 60%">글제목</th>
				<th style="width: 20%">작성자</th>
				<th style="width: 10%">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					<td>${obj.NUM }</td>
					<td>
					
						<a href="/notice/view?num=${obj.NUM}">${fn:substring(obj.TITLE, 0, 12) } </a>
					</td>
					<td>${obj.WRITER }</td>
					<td><fmt:formatNumber value="${obj.CNT }" pattern="#,###"/>  </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
		<a href="/notice/add"><button type="button">공지글작성</button></a>
	</p>
</div>
<script>
	document.getElementById("wd").onchange=function(){
	
	}
</script>